#!/usr/bin/env python3
"""Page HTML d'aperçu des leçons, pour relecture.

Tout est lu dans la base de contenu générée (assets/content/iqura_content.db) :
leçons, fiches des lettres et, pour les extraits coraniques, le texte Tanzil
et la traduction Hamidullah par référence. Rien n'est recopié à la main.

Usage : python3 tools/build_content/preview_lessons.py SORTIE.html [--etape 1] [--jusqua N]
"""

from __future__ import annotations

import argparse
import base64
import html
import json
import os
import re
import sqlite3
import sys

DB = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..",
                  "assets", "content", "iqura_content.db")
ASSETS = os.path.join(os.path.dirname(DB), "..")

# Texte arabe → enregistrement (data URI), rempli par render().
AUDIO: dict[str, str] = {}


def snd(text: str) -> str:
    """Lecteur de l'enregistrement de synthèse du texte, s'il existe."""
    src = AUDIO.get(text)
    if not src:
        return ""
    return f'<audio class="snd" controls preload="none" src="{src}" title="Synthèse vocale"></audio>'


def load_audio(con: sqlite3.Connection) -> None:
    AUDIO.clear()
    for text, f in con.execute("SELECT text, file FROM audio_clip WHERE file IS NOT NULL"):
        with open(os.path.join(ASSETS, f), "rb") as fh:
            AUDIO[text] = "data:audio/mpeg;base64," + base64.b64encode(fh.read()).decode()
ZWJ = "‍"

# Positions des zones sur le schéma (coordonnées du viewBox 0 0 220 170).
ZONE_POS = {
    "levres": (190, 82),
    "langue_bout_dents": (176, 72),
    "langue_bout_racine": (168, 64),
    "langue_bout_gencive": (160, 58),
    "langue_milieu": (128, 50),
    "gorge_haut": (88, 70),
    "gorge_milieu": (80, 104),
    "gorge_fond": (78, 140),
    "cavite": (118, 92),
}

EXERCISE_TEXT = {
    "reconnaitre_lettre": "Reconnaître : une lettre s'affiche, choisir son nom.",
    "formes": "Formes : une forme (début, milieu, fin) s'affiche, choisir la lettre.",
    "points": "Les points : distinguer des lettres de même silhouette.",
    "lire": "Lire : un mot ou une syllabe vocalisés s'affichent, choisir la bonne translittération.",
    "reconstruire": "Reconstruire (jeu A) : assembler lettres et voyelles pour écrire un mot donné en translittération.",
    "reperer": "Repérer (salle d'étude, jamais en combat) : toucher la lettre demandée dans un mot du Coran.",
    "qcm": "Questions de compréhension.",
    "controle_final": "Contrôle final : questions tirées de la leçon ; seuil de réussite",
}
SOURCE_TEXT = {"syllabes": "syllabes de la leçon", "exemples": "mots de la leçon",
               "coran": "mots coraniques cités"}


_ARABIC_RUN = re.compile("([\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\u200d]+)")


def e(s: str) -> str:
    return html.escape(s, quote=True)


def fr(s: str) -> str:
    """Texte français pouvant contenir de l'arabe : chaque passage arabe est
    isolé (<bdi>) pour que l'ordre de lecture reste celui du texte source."""
    return _ARABIC_RUN.sub(r'<bdi class="ai" lang="ar">\1</bdi>', e(s))


def ar(s: str, quran: bool = False, cls: str = "") -> str:
    family = "q" if quran else "a"
    return f'<span class="ar {family} {cls}" lang="ar" dir="rtl">{e(s)}</span>'


def articulation_svg(zone: str, label: str) -> str:
    x, y = ZONE_POS[zone]
    hl = (f'<ellipse cx="118" cy="95" rx="62" ry="40" class="zone"/>' if zone == "cavite"
          else f'<circle cx="{x}" cy="{y}" r="9" class="zone"/>')
    return f"""<svg viewBox="0 0 220 170" role="img" aria-label="{e(label)}" class="svg">
  <path class="wall" d="M196 74 Q186 62 172 60 Q150 34 118 36 Q92 38 84 56 L76 166"/>
  <path class="wall" d="M196 90 Q184 104 166 108 Q134 116 104 108 L94 166"/>
  <path class="tongue" d="M170 82 Q150 58 120 64 Q100 70 98 96 Q96 120 100 150"/>
  <rect class="tooth" x="174" y="60" width="7" height="12" rx="2"/>
  <path class="nose" d="M172 56 Q160 40 150 34"/>
  {hl}
</svg>"""


def letter_card(card: sqlite3.Row, zone_label: str) -> str:
    c = card["letter"]
    if card["joins_left"]:
        forms = [("isolée", c), ("début", c + ZWJ), ("milieu", ZWJ + c + ZWJ), ("fin", ZWJ + c)]
    else:
        forms = [("isolée", c), ("fin", ZWJ + c)]
    forms_html = "".join(
        f'<div class="form"><div class="glyph">{ar(f)}</div><div class="cap">{e(n)}</div></div>'
        for n, f in forms
    )
    liaison = "" if card["joins_left"] else '<p class="note">Ne se lie pas à la lettre suivante.</p>'
    return f"""<article class="card">
  <header class="card-h"><div class="big">{ar(c)}</div>
    <div><div class="lname">{e(card["name"])}</div><div class="arname">{ar(card["name_ar"])}</div>{snd(card["name_ar"])}</div></header>
  <div class="forms">{forms_html}</div>
  {liaison}
  <div class="artic">{articulation_svg(card["zone_id"], zone_label)}
    <div><p class="zone-l">{e(zone_label)}</p><p>{fr(card["pronunciation"])}</p>
    <p class="ia">Description et schéma rédigés par IA</p></div></div>
</article>"""


def highlight_verse(text: str, tokens: list[str]) -> str:
    out, pos = [], 0
    for t in tokens:
        i = text.find(t, pos)
        if i < 0:
            continue
        out.append(e(text[pos:i]))
        out.append(f"<mark>{e(t)}</mark>")
        pos = i + len(t)
    out.append(e(text[pos:]))
    return "".join(out)


def quran_extract(con: sqlite3.Connection, ex: dict) -> str:
    s, a = (int(x) for x in ex["verset"].split(":"))
    text, tr, surah = con.execute(
        "SELECT v.text_uthmani, vt.text, su.name_translit FROM verse v "
        "JOIN verse_translation vt ON vt.verse_id = v.id "
        "JOIN surah su ON su.id = v.surah_id WHERE v.surah_id = ? AND v.ayah = ?",
        (s, a),
    ).fetchone()
    tokens = [con.execute("SELECT text FROM token WHERE id = ?", (t,)).fetchone()[0]
              for t in ex.get("mots", [])]
    letters = ex.get("lettres", [])
    hunt = (f'<p class="hunt">À repérer : {" ".join(ar(l) for l in letters)}</p>' if letters else "")
    return f"""<figure class="quran">
  <blockquote lang="ar" dir="rtl" class="ar q verse">{highlight_verse(text, tokens)}</blockquote>
  <figcaption><span class="tr">« {e(tr)} »</span>
  <span class="ref">Coran {s}:{a} ({e(surah)}) — texte Tanzil (vérifié par SHA-256), traduction Hamidullah</span></figcaption>
  {hunt}
</figure>"""


def section_html(con, sec: dict, cards: dict, zones: dict) -> str:
    t = sec["type"]
    title = f'<h3>{fr(sec["titre"])}</h3>' if sec.get("titre") else ""
    if t in ("texte", "regle"):
        cls = "rule" if t == "regle" else "prose"
        return f'<section class="{cls}">{title}<p>{fr(sec["corps"])}</p></section>'
    if t == "encadre":
        return f'<aside class="box"><p>{fr(sec["corps"])}</p></aside>'
    if t == "lettres":
        return '<div class="cards">' + "".join(
            letter_card(cards[c], zones[cards[c]["zone_id"]]) for c in sec["lettres"]) + "</div>"
    if t == "syllabes":
        cells = "".join(f'<div class="syl">{ar(i["ar"])}<span>{e(i["translit"])}</span>{snd(i["ar"])}</div>'
                        for i in sec["items"])
        return f'<section><h3>Syllabes</h3><div class="syls">{cells}</div></section>'
    if t == "exemples":
        rows = "".join(
            f'<tr><td class="w">{ar(i["ar"])}{snd(i["ar"])}</td><td class="tl">{e(i["translit"])}</td><td>{e(i["fr"])}</td></tr>'
            for i in sec["items"])
        return (f'<section>{title}<div class="tbl"><table><thead><tr><th>Mot</th><th>Translittération</th>'
                f'<th>Sens</th></tr></thead><tbody>{rows}</tbody></table></div>'
                f'<p class="ia">Exemples construits — rédigés par IA</p></section>')
    if t == "decomposition":
        parts = " + ".join(ar(c) for c in sec["lettres"])
        return (f'<section class="decomp"><div class="eq">{parts} → {ar(sec["ar"], cls="xl")}</div>{snd(sec["ar"])}'
                f'<p><span class="tl">{e(sec["translit"])}</span> — {e(sec["fr"])}</p>'
                f'<p class="note">{fr(sec["note"])}</p></section>')
    if t == "coran":
        body = f'<p>{fr(sec["corps"])}</p>' if sec.get("corps") else ""
        return (f'<section class="qsec">{title}{body}'
                + "".join(quran_extract(con, x) for x in sec["extraits"]) + "</section>")
    return ""


def exercises_html(exs: list[dict]) -> str:
    items = []
    for ex in exs:
        if ex["type"] == "qcm":
            qs = "".join(
                f'<li><strong>{fr(q["question"])}</strong> '
                f'<span class="choices">{" / ".join(("✔ " if k == q["reponse"] else "") + fr(c) for k, c in enumerate(q["choix"]))}</span>'
                f'<br><span class="expl">{fr(q["explication"])}</span></li>'
                for q in ex["items"])
            items.append(f"<li>{e(EXERCISE_TEXT['qcm'])}<ol class='qcm'>{qs}</ol></li>")
        else:
            extra = ""
            if ex.get("lettres"):
                extra = " Lettres : " + " ".join(ar(c) for c in ex["lettres"])
            if ex.get("source"):
                extra = f" Sur : {e(SOURCE_TEXT[ex['source']])}."
            if ex["type"] == "controle_final":
                extra = f" {round(ex['seuil'] * 100)} %."
            items.append(f"<li>{e(EXERCISE_TEXT[ex['type']])}{extra}</li>")
    return "<section class='ex'><h3>Exercices</h3><ul>" + "".join(items) + "</ul></section>"


CSS = """
:root{--bg:#f6f5f1;--surface:#fffdf8;--ink:#1d2433;--muted:#5d6475;--line:#dcd8cc;--accent:#8a5a00;--accent-soft:#f3e6c9;--mark:#ffe59a;--ia:#6b4fa0;--ia-bg:#efe9f8;
--f-body:"Source Sans 3",system-ui,sans-serif;--f-head:"Source Serif 4",Georgia,serif;--f-ar:"Amiri","Noto Naskh Arabic",serif;--f-q:"Amiri Quran","Amiri",serif}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){--bg:#15181f;--surface:#1d212b;--ink:#e8e6df;--muted:#a3a8b5;--line:#343a47;--accent:#e2b55c;--accent-soft:#3a3122;--mark:#6b5615;--ia:#c4b0ec;--ia-bg:#2c2540;color-scheme:dark}}
:root[data-theme="dark"]{--bg:#15181f;--surface:#1d212b;--ink:#e8e6df;--muted:#a3a8b5;--line:#343a47;--accent:#e2b55c;--accent-soft:#3a3122;--mark:#6b5615;--ia:#c4b0ec;--ia-bg:#2c2540;color-scheme:dark}
body{background:var(--bg);color:var(--ink);font-family:var(--f-body);font-size:16px;line-height:1.55}
.wrap{max-width:860px;margin:0 auto;padding-block:24px 64px;padding-left:max(16px,env(safe-area-inset-left,0px));padding-right:max(16px,env(safe-area-inset-right,0px))}
h1,h2,h3{font-family:var(--f-head);text-wrap:balance;line-height:1.2}
h1{font-size:2rem;margin:0 0 .25rem}h2{font-size:1.55rem;margin:0}h3{font-size:1.1rem;margin:0 0 .4rem}
.lead{color:var(--muted);max-width:65ch}
nav.toc{display:flex;flex-wrap:wrap;gap:8px;margin:16px 0 8px}
nav.toc a{color:var(--accent);text-decoration:none;border:1px solid var(--line);padding:4px 10px;border-radius:999px;font-size:.9rem}
.lesson{background:var(--surface);border:1px solid var(--line);border-radius:10px;padding:20px;margin-top:28px;display:flex;flex-direction:column;gap:18px}
.lh{display:flex;flex-wrap:wrap;align-items:baseline;gap:8px 14px}
.num{font-family:var(--f-head);color:var(--accent);font-size:.95rem;letter-spacing:.04em;text-transform:uppercase}
.obj{margin:0;color:var(--muted)}
.ia{display:inline-block;background:var(--ia-bg);color:var(--ia);font-size:.78rem;padding:2px 8px;border-radius:4px;margin:4px 0 0}
p{margin:0 0 .4rem;max-width:68ch}
.ar{font-family:var(--f-ar);font-size:1.6em;line-height:1.7}
.ar.q{font-family:var(--f-q)}
.ai{font-family:var(--f-ar);font-size:1.25em;line-height:1}
.ar.xl{font-size:2.2em}
.rule{border-left:3px solid var(--accent);padding-left:12px}
.box{background:var(--accent-soft);border-radius:8px;padding:10px 14px}
.box p{margin:0}
.cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,370px),1fr));gap:14px}
.card{border:1px solid var(--line);border-radius:8px;padding:14px;min-width:0;display:flex;flex-direction:column;gap:10px}
.card-h{display:flex;align-items:center;gap:14px}
.big .ar{font-size:3.2rem;line-height:1.2}
.lname{font-family:var(--f-head);font-size:1.2rem}.arname .ar{font-size:1.3rem}
.forms{display:flex;flex-wrap:wrap;gap:8px;direction:rtl}
.form{border:1px solid var(--line);border-radius:6px;padding:4px 10px;text-align:center;min-width:64px;direction:ltr}
.form .ar{font-size:2rem}.cap{font-size:.75rem;color:var(--muted);letter-spacing:.03em;text-transform:uppercase}
.note{font-size:.9rem;color:var(--muted)}
.artic{display:grid;grid-template-columns:120px 1fr;gap:12px;align-items:start}
.artic p{font-size:.92rem}.zone-l{font-weight:600;margin-bottom:2px}
.svg{width:120px;height:auto}
.svg .wall,.svg .tongue,.svg .nose{fill:none;stroke:var(--muted);stroke-width:2.2;stroke-linecap:round}
.svg .tongue{stroke:var(--ink)}
.svg .tooth{fill:var(--surface);stroke:var(--muted);stroke-width:1.5}
.svg .zone{fill:var(--accent);fill-opacity:.55;stroke:var(--accent);stroke-width:1.5}
.syls{display:flex;flex-wrap:wrap;gap:8px}
.syl{border:1px solid var(--line);border-radius:6px;padding:4px 12px;display:flex;flex-direction:column;align-items:center}
.syl span{font-size:.9rem;color:var(--muted)}
.tbl{overflow-x:auto}table{border-collapse:collapse;width:100%}
th,td{text-align:left;padding:6px 10px;border-bottom:1px solid var(--line);vertical-align:middle}
th{font-size:.8rem;color:var(--muted);text-transform:uppercase;letter-spacing:.04em;font-weight:600}
td.w{text-align:right}.tl{font-style:italic}
.decomp .eq{display:flex;flex-wrap:wrap;align-items:center;gap:10px;justify-content:flex-start}
.quran{margin:10px 0 0;border:1px solid var(--line);border-radius:8px;padding:12px 16px;background:var(--bg)}
.verse{margin:0;font-size:1.9rem;line-height:2.2;text-align:right}
mark{background:var(--mark);color:inherit;border-radius:4px;padding:0 2px}
figcaption{display:flex;flex-direction:column;gap:2px;margin-top:6px}
.tr{font-style:italic}.ref{font-size:.8rem;color:var(--muted)}
.hunt{margin-top:6px}.hunt .ar{font-size:1.4rem;margin-left:6px}
.ex ul{margin:0;padding-left:1.2rem;display:flex;flex-direction:column;gap:6px}
.ex .ar{font-size:1.3rem}.qcm{margin-top:6px;display:flex;flex-direction:column;gap:6px}
.choices{color:var(--muted)}.expl{font-size:.88rem;color:var(--muted)}
footer{margin-top:32px;font-size:.85rem;color:var(--muted)}
@media (max-width:520px){.artic{grid-template-columns:1fr}.svg{width:140px}}
"""


def render(stage: int, upto: int | None) -> str:
    con = sqlite3.connect(f"file:{DB}?mode=ro", uri=True)
    con.row_factory = sqlite3.Row
    load_audio(con)
    cards = {r["letter"]: r for r in con.execute("SELECT * FROM letter")}
    zones = dict(con.execute("SELECT id, description FROM articulation_zone"))
    version = con.execute("SELECT value FROM content_meta WHERE key='content_version'").fetchone()[0]
    lessons = [json.loads(r["content"]) for r in con.execute(
        "SELECT content FROM lesson WHERE stage = ? ORDER BY ordinal", (stage,))]
    if upto is not None:
        lessons = [l for l in lessons if l["ordre"] <= upto]
    toc = "".join(f'<a href="#{e(l["id"])}">{l["ordre"]}. {fr(l["titre"])}</a>' for l in lessons)
    body = []
    for l in lessons:
        secs = "".join(section_html(con, s, cards, zones) for s in l["sections"])
        body.append(f"""<article class="lesson" id="{e(l['id'])}">
  <header><div class="lh"><span class="num">Leçon {l['ordre']}</span><h2>{fr(l['titre'])}</h2></div>
  <p class="obj">{fr(l['objectif'])}</p><span class="ia">Leçon rédigée par IA</span></header>
  {secs}{exercises_html(l['exercices'])}
</article>""")
    return f"""<title>Leçons Déchiffrer IQURA</title>
<meta name="claude:viewport-fit-sides" content="cover">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Amiri&family=Amiri+Quran&family=Source+Sans+3:ital,wght@0,400;0,600;1,400&family=Source+Serif+4:wght@600&display=swap">
<style>{CSS}
.snd{{display:block;width:150px;height:30px;margin-top:4px}}</style>
<div class="wrap">
<h1>Étape 1 · Déchiffrer</h1>
<p class="lead">Aperçu pour relecture des leçons {lessons[0]['ordre']} à {lessons[-1]['ordre']}, généré depuis la base de contenu IQURA (version {e(version)}).
Les versets sont lus dans la base vérifiée (texte Tanzil, traduction Hamidullah) ; les mots surlignés sont ceux que la leçon cite.
Chaque lettre, syllabe et mot a son enregistrement : <b>voix de synthèse</b> (Chatterbox Multilingual), coupée automatiquement après le mot. Les extraits coraniques n'ont pas d'audio ici : ils viendront des récitations (al-Ḥuṣarī).</p>
<nav class="toc">{toc}</nav>
{''.join(body)}
<footer>Texte coranique : Tanzil Project (tanzil.net), CC BY 3.0. Traduction : Muhammad Hamidullah, via Tanzil.
Translittération : norme Arabica (table dans docs/TRANSLITTERATION.md). Polices Amiri et Amiri Quran (SIL OFL 1.1).</footer>
</div>"""


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("out")
    ap.add_argument("--etape", type=int, default=1)
    ap.add_argument("--jusqua", type=int)
    a = ap.parse_args()
    with open(a.out, "w", encoding="utf-8") as f:
        f.write(render(a.etape, a.jusqua))
    print(a.out, file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
