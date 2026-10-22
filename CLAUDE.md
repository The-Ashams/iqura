# IQURA — instructions pour Claude

**Référence unique : `docs/CAHIER_DES_CHARGES.md` (v3, 22 octobre 2026).** Il remplace tous les documents précédents (archivés dans `docs/archive/`) et fait foi en cas de contradiction. Le détail est là-bas ; ce fichier n'en garde que l'essentiel.
**État courant, travail en cours, prochaine étape : `docs/ETAT_DU_PROJET.md`** (à lire en début de session, à mettre à jour à chaque étape importante et avant la fin d'une session).

## Vision (cahier §1)

RPG d'aventure narrative en pixel art dont la mécanique centrale est de comprendre l'arabe littéraire classique (fuṣḥā), jusqu'à comprendre directement le Coran. Un vrai cursus (≈ 130 leçons, 5 régions, inspiré de la méthode de Médine) intégré à un vrai jeu : le joueur ne doit pas avoir l'impression de suivre un cours. Les racines comme signature, le Coran à chaque région, toujours avec respect. Gratuit, sans publicité ni achat, GPL-3.0, en français, Windows 10/11 et Android, hors ligne.

## Règles de travail (cahier §0.2)

- **Ne jamais deviner.** Point ambigu, contradictoire ou impossible : s'arrêter et demander à l'utilisateur, avec une recommandation et une alternative. Une question à la fois.
- **Montrer avant de produire en masse** : un ou deux exemples de chaque nouveau type de contenu, validés avant la suite.
- **Prototype avant production** : rien n'est produit en masse avant la validation du prototype jouable (jalon J1a).
- **Ne jamais annoncer** une compilation, un test ou une vérification non exécutés ; donner les preuves (lire les résultats de GitHub Actions).
- Avant de supprimer ou de modifier fortement du code ou du contenu existant : présenter la liste et attendre l'accord.
- Parler à l'utilisateur en français simple, sans jargon ; lui dire clairement ce qu'il doit faire lui-même (tester, valider, fusionner une pull request).
- Toute décision nouvelle est ajoutée au cahier (§16), avec sa date.

## Règles absolues (cahier §3, résumé)

1. **Coran** : connaissance étudiée, jamais l'ennemi. Monstres = difficultés (l'Oubli, la Confusion, la Précipitation, la Distraction, l'Impatience), jamais des mots. Aucun mot coranique sur un monstre, frappé ou détruit. En combat, un mot du vocabulaire seul, sous forme de dictionnaire, dans un panneau neutre ; **aucun verset ni extrait en combat** (extraits : salles d'étude et Sanctuaire seulement). Noms divins, de prophètes et formules sacrées exclus du combat. Aucune représentation ni parole de prophète ou de figure sacrée. Quand la langue ne suffit pas, le dire et renvoyer vers les savants.
2. **Texte coranique** jamais généré, reconstitué ni modifié : Tanzil, stocké une fois, vérifié par SHA-256 (tests et démarrage) ; les leçons le référencent sans le recopier.
3. **Aucune donnée inventée** (racine, lemme, occurrence, schème, traduction, analyse présentée comme certaine) ; sources citées.
4. **Contenu rédigé par IA** : mention visible. ⚠️ Formulation exacte en attente : le cahier v3 écrit « rédigé par IA — non vérifié », l'utilisateur avait demandé « rédigé par IA » le 21/10/2026 (voir `docs/ETAT_DU_PROJET.md`). Chaque exemple affiche sa source ; tout audio de synthèse est signalé « synthèse » ; bouton « Signaler une erreur » sur chaque fiche.
5. **Honnêteté** : aucun bouton décoratif ni fausse fonctionnalité ; aucune note automatique de prononciation ; les statistiques de jeu ne modifient jamais les révisions ni la maîtrise.
6. **Licences** : chaque dépendance et ressource auditée et listée dans `THIRD_PARTY_LICENSES.md` ; tout point douteux signalé.
7. **Racines** : la racine ne suffit pas à déduire le sens d'un dérivé (avertissement visible).

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

## Ordre de travail (cahier §13)

On avance région par région. **Jalon en cours : J1a, tranche verticale** (leçons 0 à 3 au format mini-donjon, jouables de bout en bout). Condition : l'utilisateur joue 30 minutes et valide que c'est amusant et efficace.

1. Liste de ce qui change dans l'existant, accord de l'utilisateur.
2. Noms des lieux et personnages de la région 1, découpage en 8 à 12 lieux, validation.
3. Coquille du jeu en pixel art : carte, dialogue, combat, Cité, Grimoire, Sanctuaire minimal.
4. Leçons 0 et 1 au format mini-donjon, montrées et validées.
5. Leçons 2 et 3 sur le même modèle.
6. FSRS, Expédition, ressources, équipement, enchantement.
7. Tests et compilations ; marche à suivre de test envoyée à l'utilisateur.
8. Retours, corrections, mise à jour du cahier et de l'état.

## Commandes

- Session cloud : `tools/setup_cloud.sh` (Flutter + SDK Android, lancé par `.claude/hooks/session-start.sh`).
- Base de contenu (avant `flutter test` et `flutter build`) : `python3 tools/build_content/build_content.py` ; sources vérifiées par SHA-256 dans `tools/build_content/sources/`.
- Vérifications : `dart format lib test`, `flutter analyze`, `flutter test`, `python3 -m unittest discover -s tools/build_content`.
- Compilation : `flutter build apk --release` ; Windows : `.github/workflows/build.yml`.
- Licences des paquets Dart : `python3 tools/third_party/list_dart_packages.py`.
- Leçons : données dans `tools/build_content/lessons/` ; aperçu : `python3 tools/build_content/preview_lessons.py SORTIE.html --etape 1 --jusqua N`.
- Audio (hors CI, modèle de plusieurs Go) : environnement Python à part (`torch` depuis PyPI, `chatterbox-tts` 0.1.7 en `--no-deps` et ses dépendances, `setuptools<81`, `soundfile`, `ffmpeg`).
  - `python tools/build_audio/generate.py --lecons DOSSIER [--seulement TEXTE…] [--premiere-graine N] [--brut]` ;
  - `python tools/build_audio/package.py DOSSIER` (MP3 dans `assets/audio/lecons/`, manifeste `tools/build_audio/clips.json`) ;
  - tests : `python -m unittest discover -s tools/build_audio`.
- Réseau de la session cloud : `huggingface.co`, `us.aws.cdn.hf.co`, `download.pytorch.org` autorisés ; `download-r2.pytorch.org` bloqué (PyTorch depuis PyPI).
