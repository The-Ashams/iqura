"""Page d'écoute d'une région, hors dépôt (phase audio J6).

Utilisation, depuis la racine : python3 tools/build_audio/ecoute.py REGION mot,syllabe SORTIE.html TITRE
"""
import sys, os, json, base64, html
sys.path.insert(0, 'tools/build_audio'); sys.path.insert(0, 'tools/build_content')
import manquants, lessons, mini_donjon
region, genres, out, title = int(sys.argv[1]), sys.argv[2].split(','), sys.argv[3], sys.argv[4]
data = lessons.load()
clips = lessons.audio_clips(data); man = lessons.load_audio_manifest()['clips']
where = manquants.regions_of_texts(data)
order = sorted(data.lessons, key=lambda l: (l['etape'], l['ordre']))
first, titles = {}, {}
for l in order:
    titles[l['id']] = f"Leçon {l['etape']}.{l['ordre']} — {l['titre']}"
    for t in mini_donjon.arabic_strings(l): first.setdefault(t, l['id'])
for w in data.words: first.setdefault(w['ar'], w['lecon'])
rank = {l['id']: i for i, l in enumerate(order)}
rows = []
for k, (kind, t) in clips.items():
    if where.get(t, 5) != region or k not in man or kind not in genres: continue
    lid = first.get(t)
    grp = titles.get(lid, f"Examen de la région {region}")
    rows.append(dict(k=k, g=kind, t=t, s=grp, o=rank.get(lid, 10**6), f=man[k]['a_ecouter'],
                     a=base64.b64encode(open(man[k]['fichier'], 'rb').read()).decode()))
rows.sort(key=lambda r: (not r['f'], r['o'], r['g'] != 'mot', r['k']))
for r in rows:
    if r['f']: r['s'] = "À écouter en priorité (coupure automatique incertaine)"
payload = json.dumps([{x: r[x] for x in 'kgtsfa'} for r in rows], ensure_ascii=False)
tpl = open(os.path.join(os.path.dirname(__file__), 'ecoute_modele.html'), encoding='utf-8').read()
s = tpl.replace('%TITLE%', html.escape(title)).replace('%N%', str(len(rows))).replace('%DATA%', payload)
open(out, 'w', encoding='utf-8').write(s)
print(len(rows), sum(r['f'] for r in rows), round(os.path.getsize(out)/1e6, 2), 'Mo')
