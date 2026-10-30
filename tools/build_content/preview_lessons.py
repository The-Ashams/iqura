#!/usr/bin/env python3
"""Page HTML d'aperçu des leçons, pour relecture.

Tout est lu dans la base de contenu générée (assets/content/iqura_content.db) :
leçons, fiches des lettres, salles de lecture (exemples construits ; aucun
verset, avenant n° 1). Rien n'est recopié à la main.

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
import unicodedata

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
    # Zone sans position dans cet aperçu : schéma sans point (l'application
    # a son propre schéma).
    x, y = ZONE_POS.get(zone, (-50, -50))
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


SCREEN_LABEL = {
    "entree": "Entrée", "echauffement": "Échauffement", "decouverte": "Découverte",
    "element": "La lettre", "regle": "La règle", "entrainement": "Salle d'entraînement",
    "lecture": "Salle de lecture (sans combat)", "mini_boss": "Mini-boss",
    "fin": "Fin",
}
QUESTION_LABEL = {
    "qcm": "Question", "points": "Les points", "formes": "Les formes",
    "reconnaitre": "Reconnaître", "ecouter": "Écouter et choisir",
    "paires": "Paires proches", "lire": "Lire (choisir le bon son)",
    "reconstruire": "Reconstruire", "tracer": "Tracer", "repeter": "Répéter à voix haute",
    "reperer_mot": "Repérer", "compter": "Compter",
    "ecouter_lettre": "Écouter le nom d'une lettre",
}


def question_html(q: dict, inscription: list[str] | None = None) -> str:
    kind = q["type"]
    head = (f'<p class="qk">{e(QUESTION_LABEL[kind])}'
            + (' · <span class="rev">révision</span>' if q.get("revision") else "")
            + f'</p><p class="qc">{fr(q["consigne"])}</p>')
    body = ""
    if q.get("audio"):
        body += f'<p class="heard">Son joué : {snd(q["audio"]) or ar(q["audio"])}</p>'
    if q.get("ar") and kind != "repeter":
        body += f'<p>{ar(q["ar"], cls="xl")}</p>'
    if kind == "lire":
        opts = "".join(
            f'<li{" class=ok" if i == q["reponse"] else ""}>Son {i + 1} {snd(c)}'
            f'{" ✔ " + ar(c) if i == q["reponse"] else ""}</li>'
            for i, c in enumerate(q["choix_audio"]))
        body += f'<ol class="opts">{opts}</ol>'
    elif "choix_ar" in q or "choix" in q:
        choices = q.get("choix_ar") or q["choix"]
        fmt = ar if "choix_ar" in q else fr
        opts = "".join(f'<li{" class=ok" if i == q["reponse"] else ""}>{fmt(c)}'
                       f'{" ✔" if i == q["reponse"] else ""}</li>' for i, c in enumerate(choices))
        body += f'<ul class="opts row">{opts}</ul>'
    elif kind == "reconstruire":
        body += ('<p>Tuiles : ' + " ".join(ar(t) for t in q["tuiles"])
                 + ' — solution : ' + " + ".join(ar(t) for t in q["solution"]) + "</p>")
    elif kind == "tracer":
        body += f'<p>Lettre à tracer : {ar(q["lettre"], cls="xl")}</p>'
    elif kind == "repeter":
        body += f'<p>{ar(q["ar"], cls="xl")} {snd(q["ar"])}</p>'
    elif kind in ("compter", "reperer_mot") and inscription is not None:
        word = inscription[q["mot"]]
        body += f'<p>Mot : {ar(word)}'
        if kind == "compter":
            lettre = q["lettre"]
            form = "NFD" if unicodedata.combining(lettre[:1]) and len(lettre) == 1 else "NFC"
            body += f' — réponse (calculée) : {unicodedata.normalize(form, word).count(lettre)}'
        body += "</p>"
    if q.get("explication"):
        body += f'<p class="expl">Après une erreur : {fr(q["explication"])}</p>'
    return f'<div class="question">{head}{body}</div>'


def screens_html(con, lesson: dict, cards: dict, zones: dict, names: dict) -> str:
    out = []
    for n, s in enumerate(lesson["ecrans"], 1):
        t = s["type"]
        inner = ""
        if t == "entree":
            inner += "".join(f'<p class="line"><b>{e(names[r["qui"]])}</b> : {fr(r["texte"])}</p>'
                             for r in s["repliques"])
            inner += f'<p class="goal">Objectif : {fr(s["objectif"])}</p>'
        elif t == "decouverte":
            inner += '<p class="support">' + " ".join(
                f'{ar(a, cls="xl")}{snd(a)}' for a in s["support"]) + "</p>"
            inner += question_html(s["question"])
        elif t == "element":
            inner += '<div class="cards">' + letter_card(
                cards[s["lettre"]], zones[cards[s["lettre"]]["zone_id"]]) + "</div>"
            inner += question_html(s["question"])
        elif t == "regle":
            inner += f'<p class="rulet"><b>{fr(s["titre"])}</b> — {fr(s["texte"])}</p>'
            inner += '<div class="syls">' + "".join(
                f'<div class="syl">{ar(a)}{snd(a)}</div>' for a in s.get("exemples", [])) + "</div>"
            inner += question_html(s["question"])
        elif t == "entrainement":
            inner += "".join(question_html(q) for q in s["exercices"])
        elif t == "lecture":
            inner += f'<p><b>{fr(s.get("titre", ""))}</b> — {fr(s["texte"])}</p>'
            inner += (f'<p class="support" dir="rtl">{"  ".join(ar(w, cls="xl") for w in s["inscription"])}</p>'
                      '<p class="ia">Exemple construit — rédigé par IA</p>')
            inner += "".join(question_html(q, s["inscription"]) for q in s["questions"])
        elif t == "mini_boss":
            qs = s["questions"]
            rev = sum(1 for q in qs if q.get("revision"))
            inner += (f'<p class="goal">Combat contre une brume d\'oubli : {len(qs)} questions dans un panneau '
                      f'neutre, sans translittération ; réussite à {round(s["seuil"] * 100)} % ; '
                      f'{rev} question(s) de révision.</p>')
            inner += "".join(question_html(q) for q in qs)
        elif t == "fin":
            inner += f'<p class="goal">Ce que tu sais maintenant : {fr(s["acquis"])}</p>'
            if s.get("suite"):
                inner += f'<p>{fr(s["suite"])}</p>'
        out.append(f'<section class="screen"><p class="sn">Écran {n} · {e(SCREEN_LABEL[t])}</p>{inner}</section>')
    return "".join(out)


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
mark{background:var(--mark);color:inherit;border-radius:4px;padding:0 2px}
figcaption{display:flex;flex-direction:column;gap:2px;margin-top:6px}
.tr{font-style:italic}.ref{font-size:.8rem;color:var(--muted)}
.hunt{margin-top:6px}.hunt .ar{font-size:1.4rem;margin-left:6px}
.ex ul{margin:0;padding-left:1.2rem;display:flex;flex-direction:column;gap:6px}
.ex .ar{font-size:1.3rem}.qcm{margin-top:6px;display:flex;flex-direction:column;gap:6px}
.choices{color:var(--muted)}.expl{font-size:.88rem;color:var(--muted)}
.screen{border:1px solid var(--line);border-radius:8px;padding:12px 14px;display:flex;flex-direction:column;gap:8px}
.sn{font-family:var(--f-head);color:var(--accent);font-size:.9rem;letter-spacing:.03em;text-transform:uppercase;margin:0}
.line{margin:0}.goal{font-weight:600}.support{display:flex;flex-wrap:wrap;gap:16px;align-items:center}
.question{border-top:1px dashed var(--line);padding-top:8px}
.qk{margin:0;font-size:.8rem;color:var(--muted);text-transform:uppercase;letter-spacing:.04em}
.qc{margin:0 0 4px;font-weight:600}.rev{color:var(--ia)}
.opts{margin:4px 0;padding-left:1.2rem}.opts.row{display:flex;flex-wrap:wrap;gap:6px 18px;list-style:none;padding:0}
.opts .ok{font-weight:700;color:var(--accent)}.opts .ar{font-size:1.4rem}
.heard .snd{display:inline-block;vertical-align:middle}
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
    names = {r["id"]: r["name"] for r in con.execute("SELECT id, name FROM character")}
    toc = "".join(f'<a href="#{e(l["id"])}">{l["ordre"]}. {fr(l["titre"])}</a>' for l in lessons)
    body = []
    for l in lessons:
        place = con.execute("SELECT name FROM place WHERE id = ?", (l["lieu"],)).fetchone()[0]
        secs = (f'<p class="obj">Lieu : {e(place)} · maître : {e(names[l["maitre"]])}</p>'
                + screens_html(con, l, cards, zones, names))
        ex = ""
        body.append(f"""<article class="lesson" id="{e(l['id'])}">
  <header><div class="lh"><span class="num">Leçon {l['ordre']}</span><h2>{fr(l['titre'])}</h2></div>
  <p class="obj">{fr(l['objectif'])}</p><span class="ia">Leçon rédigée par IA</span></header>
  {secs}{ex}
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
Aucun verset ni extrait coranique (avenant n° 1) : les salles de lecture n'utilisent que des exemples construits.
Chaque lettre, syllabe et mot a son enregistrement : <b>voix de synthèse</b> (Chatterbox Multilingual), coupée automatiquement après le mot.</p>
<nav class="toc">{toc}</nav>
{''.join(body)}
<footer>Translittération : norme Arabica (table dans docs/TRANSLITTERATION.md). Polices Amiri et Amiri Quran (SIL OFL 1.1).</footer>
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
