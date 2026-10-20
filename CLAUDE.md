# IQURA — instructions pour Claude

IQURA est une application **gratuite et open source (GPL-3.0)** pour apprendre l'arabe et l'arabe coranique, sous la forme d'un **vrai RPG 2D**. Interface en français. Plateformes : Android (.apk) et Windows (.exe).

Le dossier complet d'analyse et d'architecture est dans `docs/ARCHITECTURE.md`. Lis-le avant toute tâche importante.

## Règles absolues

1. **Ne jamais générer, reconstituer ni modifier le texte coranique.** Il vient uniquement de Tanzil (CC BY 3.0, modification interdite) et il est vérifié par empreinte SHA-256 dans les tests.
2. **Ne rien inventer** : pas de racine, d'occurrence, de traduction attribuée à un auteur, ni d'analyse grammaticale présentée comme certaine. Racines, lemmes et occurrences viennent du corpus (Quranic Arabic Corpus / QUL).
3. **Aucun relecteur humain.** Tout texte rédigé par IA (explications, sens français mot par mot, significations des racines) porte le statut visible « rédigé par IA — non vérifié ». Toujours citer la source des données.
4. **Ne jamais prétendre avoir compilé ou testé** sans l'avoir réellement fait. Lire les résultats de GitHub Actions avant d'annoncer quoi que ce soit.
5. **Open source vérifié** : chaque dépendance est auditée (licence, mainteneur, popularité) et listée dans `THIRD_PARTY_LICENSES.md`. Signaler à l'utilisateur tout point douteux.
6. **Aucun bouton décoratif ni fausse fonctionnalité.** Ce qui n'est pas fait est indiqué comme tel.
7. **Le Coran est la connaissance étudiée, jamais l'ennemi combattu.**
   - Un monstre représente une **difficulté de mémorisation** (l'oubli, la confusion, la distraction), **jamais un mot**.
   - Pour le vaincre, le joueur **retrouve une connaissance** (ex. le sens de « رَحْمَة », miséricorde).
   - **Aucun mot coranique** n'est affiché sur un monstre, frappé, détruit ou « tué » : ni dans les visuels, ni dans les animations, ni dans les textes.
   - Le mot apparaît **uniquement dans un panneau de question séparé et neutre**.
   - Les **versets n'apparaissent jamais en combat**. Noms divins, noms de prophètes et formules sacrées sont **exclus des questions de combat**.
   - Le Coran s'étudie dans le Sanctuaire, une zone sans combat.
   - Détails et exigences pour le code : `docs/ARCHITECTURE.md` §2 ter.

## Décisions validées

| Sujet | Décision |
| --- | --- |
| Pile technique | Flutter (Dart) + Flame (moteur 2D, MIT) + SQLite |
| Bases | `iqura_content.db` (lecture seule, générée par `tools/build_content/`) et `iqura_user.db` (progression, seule base exportée) |
| Mémorisation | FSRS (package `fsrs`, MIT). Note déduite automatiquement de la justesse et du temps de réponse |
| Jeu | Vrai RPG 2D. Carte du monde **à étapes** (nœuds cliquables). Combats au tour par tour où chaque action consiste à retrouver une connaissance dans un panneau de question neutre. Mini-donjon = leçon. Boss = examen de chapitre. Monstres = difficultés de mémorisation (l'oubli, la confusion, la distraction), jamais des mots ; la Faille des Oubliés propose les révisions FSRS du jour (règle 7) |
| Ressources | XP, or, **pierres de savoir** (gagnées uniquement quand un mot ou une racine progresse réellement dans FSRS ; impossibles à farmer), encre de scribe, fragments de boss |
| Enchantement | +1 à +15, taux décroissants, +5 points par échec, pity (3 / 5 / 8 échecs selon le palier), jamais de destruction ni de perte de niveau, effets visuels à +5 / +10 / +15. Valeurs dans `docs/ARCHITECTURE.md` §2 bis |
| Statistiques de jeu | Elles n'influencent jamais les notes FSRS ni les statuts de maîtrise |
| Sources | Texte : Tanzil. Morphologie : Quranic Arabic Corpus / QUL. Traduction : Hamidullah (rév. 2000), créditée et remplaçable. Audio versets : EveryAyah, récitateur par défaut al-Ḥuṣarī, packs téléchargeables. Audio mot : segments horodatés (QUL) |
| Audio hors Coran | **Reporté** : voix de synthèse après le MVP. Prévoir les emplacements audio dès maintenant ; l'app fonctionne sans |
| Translittération | Savante par défaut (ā, ḍ, ʿ), simplifiée au choix |
| Synchronisation | Sans serveur : export/import d'une archive ZIP versionnée (JSON + SHA-256), restauration complète ou fusion (UUID v7, journaux en ajout seul, HLC) |
| Compilation | GitHub Actions : tests, APK Android, exécutable Windows |

## Phases

1. Socle technique (en cours) : architecture, interface principale, bases SQLite, profil, sauvegardes, export/import, première compilation APK et Windows.
2. Académie de l'arabe. 3. Arabe coranique. 4. Mémorisation. 5. Mini-jeux. 6. RPG. 7. Améliorations avancées.

Le MVP (v0.1) prend une première tranche des phases 1 à 6 : voir `docs/ARCHITECTURE.md` §9.

## Commandes

- Installer Flutter + SDK Android (session cloud) : `tools/setup_cloud.sh` (lancé automatiquement par `.claude/hooks/session-start.sh`).
- Base de contenu : `python3 tools/build_content/build_content.py` (obligatoire avant `flutter build`).
- Vérifications : `dart format lib test`, `flutter analyze`, `flutter test`, `python3 -m unittest discover -s tools/build_content`.
- Compilation : `flutter build apk --release` ; Windows uniquement via GitHub Actions (`.github/workflows/build.yml`).
- Inventaire des licences : `python3 tools/third_party/list_dart_packages.py`.

## Doutes de licence à garder en tête

- Traduction Hamidullah : aucune licence publiée.
- Récitations EveryAyah : aucune condition publiée ; les droits restent aux récitateurs.
- Quranic Arabic Corpus : la FAQ mentionne un usage « de recherche ». Une confirmation écrite des auteurs est souhaitable.
