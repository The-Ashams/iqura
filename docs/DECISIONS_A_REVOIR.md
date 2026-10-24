# Décisions à revoir

Décisions prises par Claude Code seul, comme le demandent les avenants. Elles sont notées ici pour que l'utilisateur puisse les revoir ; chacune peut être changée sans casser l'existant.

## 1. Source du dictionnaire intégré (avenant n° 2, §A.4) — 24/10/2026

**Décision** : le dictionnaire intégré s'appuie sur le **Quranic Arabic Corpus** pour la structure (lemmes, racines, catégories, formes verbales, fréquences ; déjà dans la base). Les **définitions en français sont rédigées**, avec la mention « rédigé par IA », et relues par l'agent relecteur. Chaque définition enregistre sa source.

**Pourquoi le Wiktionnaire n'est pas retenu pour l'instant** :

- **Licence** : le contenu du Wiktionnaire est sous CC BY-SA. La version 4.0 est compatible avec la GPL-3.0, dans un seul sens ([annonce de Creative Commons, 2015](https://creativecommons.org/2015/10/08/cc-by-sa-4-0-now-one-way-compatible-with-gplv3/)). Mais les contributions anciennes ont été publiées sous CC BY-SA 3.0, qui n'a pas cette compatibilité. Il faudrait donc trier entrée par entrée, ce qui n'est pas sûr.
- **Accès** : depuis la session de travail, les copies complètes du Wiktionnaire (dumps.wikimedia.org, kaikki.org) ne sont pas joignables. Les extraits de kaikki.org viennent d'ailleurs surtout du Wiktionary anglais.
- **Qualité** : les entrées arabes sont inégales (vocalisation partielle, conventions variables). Les vérifier une par une coûterait plus que de rédiger des définitions courtes, relues et sourcées.

**À revoir si** : une source arabe-français libre, sous CC BY-SA 4.0 ou sous une licence compatible GPL, entièrement vocalisée, devient accessible. Ses définitions remplaceraient alors celles « rédigé par IA », avec leur source.

## 2. Enregistrements humains des 28 lettres (avenant n° 1, §C.9) — 24/10/2026

**Décision** : on garde les noms des lettres en synthèse Chatterbox (mention « synthèse ») tant qu'aucune source fiable n'est confirmée.

**Pistes examinées** :

- **Wikimedia Commons** : quelques enregistrements de lettres isolées (par exemple « Arabic خ.wav »), mais pas de série complète des 28 noms de lettres par la même voix.
- **Jeu de données « Arabic Letter Utterance »** sur Mendeley Data : sa licence et sa qualité n'ont pas pu être vérifiées, car le site n'est pas joignable depuis la session.

**À revoir si** : une série complète, d'une seule voix, sous licence libre (CC0, CC BY ou CC BY-SA 4.0) est trouvée. Il faudra alors l'écouter, l'auditer dans `THIRD_PARTY_LICENSES.md`, puis remplacer les 28 sons.

## 3. Salles de lecture de la région 1 (avenant n° 1, §C.5) — 24/10/2026

**Décision** : dans la région 1, la « salle de lecture » de chaque leçon est une **inscription d'un lieu du jeu** : l'étiquette de la porte, l'enseigne de l'herboriste, les caisses de la caravane… Elle contient 1 à 6 mots, tous déjà lus dans les leçons. On y compte des lettres ou on repère un mot. Les courts textes gradués viendront en région 2, quand le joueur saura lire des phrases.

À la leçon 14, l'inscription est une « liste du copiste » de mots isolés en écriture du Mushaf (ذَٰلِكَ, لَهُۥ, بِهِۦ, جَآءَ, قَالُوا۟). Ce sont des mots seuls, sans verset.

## 4. Contrôle « aucun verset » (avenant n° 1, §C.11) — 24/10/2026

**Décision** : le test automatique refuse toute suite de **3 mots consécutifs** du Coran dans le contenu. La comparaison se fait sur l'écriture sans voyelles, sur les suites de mots du Quranic Arabic Corpus, au moment de la construction.

**Limites** :

- Deux mots du Coran l'un après l'autre restent permis, car ce sont souvent des tournures ordinaires de la langue.
- Cette vérification est confiée aussi à l'agent relecteur (point A1 de sa liste de contrôle).
