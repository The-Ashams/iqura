# IQURA — instructions pour Claude

**Référence unique : `docs/CAHIER_DES_CHARGES.md` (v3, 22 octobre 2026).** Il remplace tous les documents précédents (archivés dans `docs/archive/`) et fait foi en cas de contradiction. Le détail est là-bas ; ce fichier n'en garde que l'essentiel.
**État courant, travail en cours, prochaine étape : `docs/ETAT_DU_PROJET.md`** (à lire en début de session, à mettre à jour à chaque étape importante et avant la fin d'une session).

## Vision (cahier §1)

RPG d'aventure narrative en pixel art dont la mécanique centrale est de comprendre l'arabe littéraire classique (fuṣḥā), jusqu'à comprendre directement le Coran. Un vrai cursus (≈ 130 leçons, 5 régions, inspiré de la méthode de Médine) intégré à un vrai jeu : le joueur ne doit pas avoir l'impression de suivre un cours. Les racines comme signature, le Coran à chaque région, toujours avec respect. Gratuit, sans publicité ni achat, GPL-3.0, en français, Windows 10/11 et Android, hors ligne.

## Règles de travail (cahier §0.2)

- **Ne jamais deviner.** Point ambigu, contradictoire ou impossible : s'arrêter et demander, avec une recommandation et une alternative. Une question à la fois. Questions de langue arabe : à l'agent `conseiller-arabe` ; le reste (jeu, technique, organisation) : à l'utilisateur.
- **Tester par niveau** (voir plus bas) : l'utilisateur teste un niveau entier, pas chaque leçon.
- **Ne jamais annoncer** une compilation, un test ou une vérification non exécutés ; donner les preuves (lire les résultats de GitHub Actions).
- Avant de supprimer ou de modifier fortement du code ou du contenu existant : présenter la liste et attendre l'accord.
- Parler à l'utilisateur en français simple, sans jargon ; lui dire clairement ce qu'il doit faire lui-même (tester, valider, fusionner une pull request).
- Toute décision nouvelle est ajoutée au cahier (§16), avec sa date.

## Règles absolues (cahier §3, résumé)

1. **Coran** : connaissance étudiée, jamais l'ennemi. Monstres = difficultés (l'Oubli, la Confusion, la Précipitation, la Distraction, l'Impatience), jamais des mots. Aucun mot coranique sur un monstre, frappé ou détruit. En combat, un mot du vocabulaire seul, sous forme de dictionnaire, dans un panneau neutre ; **aucun verset ni extrait en combat** (extraits : salles d'étude et Sanctuaire seulement). Noms divins, de prophètes et formules sacrées exclus du combat. Aucune représentation ni parole de prophète ou de figure sacrée. Quand la langue ne suffit pas, le dire et renvoyer vers les savants.
2. **Texte coranique** jamais généré, reconstitué ni modifié : Tanzil, stocké une fois, vérifié par SHA-256 (tests et démarrage) ; les leçons le référencent sans le recopier.
3. **Aucune donnée inventée** (racine, lemme, occurrence, schème, traduction, analyse présentée comme certaine) ; sources citées.
4. **Contenu rédigé par IA** : mention visible **« rédigé par IA »** (décision du 22/10/2026, cahier §16). Chaque exemple affiche sa source ; tout audio de synthèse est signalé « synthèse » ; bouton « Signaler une erreur » sur chaque fiche.
5. **Honnêteté** : aucun bouton décoratif ni fausse fonctionnalité ; aucune note automatique de prononciation ; les statistiques de jeu ne modifient jamais les révisions ni la maîtrise.
6. **Licences** : chaque dépendance et ressource auditée et listée dans `THIRD_PARTY_LICENSES.md` ; tout point douteux signalé.
7. **Racines** : la racine ne suffit pas à déduire le sens d'un dérivé (avertissement visible).

## Relecture obligatoire (agent `relecteur-arabe`, décision du 23/10/2026)

- **Quand** : après avoir écrit ou modifié tout contenu en arabe ou sur l'arabe (leçon, fiche de lettre ou de racine, exercice, dialogue, récit gradué, quête, vocabulaire, texte de combat), **avant** de le montrer à l'utilisateur ou de le fusionner dans `main`. Gros lot : par paquets (une leçon ou cinq récits à la fois).
- **Ce qu'on lui donne** : les fichiers à relire, la région et la leçon, les lettres et notions déjà enseignées.
- **Son rapport** : tout point **Bloquant** est corrigé avant de continuer ; tout point **Important** est corrigé, ou soumis à `conseiller-arabe` ; les **Mineurs** sont corrigés quand c'est simple ; les **Doutes** sont tranchés par `conseiller-arabe` (décision du 23/10/2026), puis listés dans les décisions de fin de niveau.
- Après corrections, le relancer sur les fichiers modifiés jusqu'au verdict « Validé » ou « Validé avec doutes » ; trois allers-retours au plus, sinon expliquer le blocage à l'utilisateur.
- Chaque rapport est enregistré dans `docs/relectures/AAAA-MM-JJ-<sujet>.md` et cité dans `docs/ETAT_DU_PROJET.md`.
- En présentant un niveau : « Relu par l'agent relecteur : verdict X, N doutes tranchés par le conseiller ». Jamais présenté comme une validation humaine ou religieuse.
- Réponses de `conseiller-arabe` enregistrées dans `docs/relectures/decisions-<niveau>.md`.

## Décisions techniques (cahier §12)

| Sujet | Décision |
| --- | --- |
| Framework | Flutter (Dart), Windows et Android ; Flame (MIT) pour le 2D ; menus, questions, Grimoire en widgets |
| Données | SQLite : `iqura_content.db` en lecture seule, générée par `tools/build_content/` ; `iqura_user.db`, seule base exportée |
| Contenu | Leçons, dialogues, récits, quêtes, monstres, objets, régions, lieux : fichiers JSON, pas de code |
| Révision | FSRS (notes : cahier §6.3) |
| Audio | Leçons : Chatterbox Multilingual, généré une fois (`tools/build_audio/`), coupure automatique, « synthèse ». Coran : EveryAyah, al-Ḥuṣarī, jamais de synthèse |
| Graphismes | Pixel art type RPG japonais classique (§8.1), packs libres audités ou créations ; référence : les deux maquettes du 22/10/2026 |
| Affichage | Arabe RTL, polices Amiri / Amiri Quran (OFL) ; translittération Arabica par défaut, simplifiée au choix (règles d'affichage : §6.2) ; clair/sombre ; animations désactivables |
| Sauvegarde | ZIP versionnée et vérifiée, restauration ou fusion (en place) |
| Compilation | Claude Code + GitHub Actions (APK et .exe) sur `The-Ashams/iqura` ; Windows uniquement via Actions |

## Organisation par niveaux (cahier §13.0, décision du 23/10/2026)

On ne teste plus leçon par leçon, mais **niveau par niveau** (14 niveaux) :

| Niveau | Leçons | Niveau | Leçons |
| --- | --- | --- | --- |
| Débutant 1 | 0 à 4 | Intermédiaire 2 | 3.11 à 3.21 |
| Débutant 2 | 5 à 9 | Intermédiaire 3 | 3.22 à 3.32 + boss région 3 |
| Débutant 3 | 10 à 14 + boss région 1 | Avancé 1 | 4.1 à 4.14 |
| Élémentaire 1 | 2.1 à 2.10 | Avancé 2 | 4.15 à 4.28 + boss région 4 |
| Élémentaire 2 | 2.11 à 2.20 | Coran 1 | 5.1 à 5.12 |
| Élémentaire 3 | 2.21 à 2.30 + boss région 2 | Coran 2 | 5.13 à 5.20 |
| Intermédiaire 1 | 3.1 à 3.10 | Coran 3 | 5.21 à 5.24 |

1. Construire un niveau entier (leçons, révisions, récits, parties du jeu nécessaires), le faire relire par `relecteur-arabe`, le tester soi-même, puis publier **une** version et demander à l'utilisateur de le tester. Pas avant.
2. Questions de langue et doutes du relecteur : réglés avec l'agent `conseiller-arabe`, sans l'utilisateur. À la fin de chaque niveau, présenter seulement la liste des décisions prises (10 points au plus).
3. Pendant que l'utilisateur teste un niveau, commencer le suivant ; intégrer ses retours dès qu'ils arrivent.
4. La progression de l'utilisateur est conservée d'une version à l'autre (migrations de la base utilisateur, identifiants de leçons stables, APK signé avec la même clé).

**Niveau en cours : Débutant 1 (leçons 0 à 4), construit et en attente du test de l'utilisateur** (détail : `docs/ETAT_DU_PROJET.md` §1 quater). Niveau suivant : Débutant 2 (leçons 5 à 9).

## Commandes

- Session cloud : `tools/setup_cloud.sh` (Flutter + SDK Android, lancé par `.claude/hooks/session-start.sh`).
- Base de contenu (avant `flutter test` et `flutter build`) : `python3 tools/build_content/build_content.py` ; sources vérifiées par SHA-256 dans `tools/build_content/sources/`.
- Vérifications : `dart format lib test`, `flutter analyze`, `flutter test`, `python3 -m unittest discover -s tools/build_content`.
- Compilation : `flutter build apk --release` ; Windows : `.github/workflows/build.yml`.
- Licences des paquets Dart : `python3 tools/third_party/list_dart_packages.py`.
- Graphismes pixel art : sources `tools/build_art/art/*.json` ; `python3 tools/build_art/build_art.py` (écrit `assets/art/*.png`), `--verifier` en CI ; tests : `python3 -m unittest discover -s tools/build_art`.
- Bruitages : sources `tools/build_sfx/sons.json` ; `python3 tools/build_sfx/build_sfx.py` (écrit `assets/sfx/*.wav`), `--verifier` en CI ; tests : `python3 -m unittest discover -s tools/build_sfx`.
- Monde du jeu : `tools/build_content/world/region*.json` (lieux, personnages), contrôlé par le pipeline de contenu.
- Leçons : données dans `tools/build_content/lessons/` ; aperçu : `python3 tools/build_content/preview_lessons.py SORTIE.html --etape 1 --jusqua N`.
- Audio (hors CI, modèle de plusieurs Go) : environnement Python à part (`torch` depuis PyPI, `chatterbox-tts` 0.1.7 en `--no-deps` et ses dépendances, `setuptools<81`, `soundfile`, `ffmpeg`).
  - `python tools/build_audio/generate.py --lecons DOSSIER [--seulement TEXTE…] [--premiere-graine N] [--brut]` ;
  - `python tools/build_audio/package.py DOSSIER` (MP3 dans `assets/audio/lecons/`, manifeste `tools/build_audio/clips.json`) ;
  - tests : `python -m unittest discover -s tools/build_audio`.
- Réseau de la session cloud : `huggingface.co`, `us.aws.cdn.hf.co`, `download.pytorch.org` autorisés ; `download-r2.pytorch.org` bloqué (PyTorch depuis PyPI).
