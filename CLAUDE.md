# IQURA — instructions pour Claude

IQURA est une application **gratuite et open source (GPL-3.0)** pour apprendre l'arabe et l'arabe coranique, sous la forme d'un **vrai RPG 2D**. Interface en français. Plateformes : Android (.apk) et Windows (.exe).

Le dossier complet d'analyse et d'architecture est dans `docs/ARCHITECTURE.md`. Lis-le avant toute tâche importante.

## Règles absolues

1. **Ne jamais générer, reconstituer ni modifier le texte coranique.** Il vient uniquement de Tanzil (CC BY 3.0, modification interdite) et il est vérifié par empreinte SHA-256 dans les tests et au démarrage. Dans les leçons, un extrait coranique n'est **jamais recopié** : le contenu stocke une référence (`sourate:verset` ou plage de mots), et le texte est lu dans la base vérifiée.
2. **Ne rien inventer** : pas de racine, d'occurrence, de traduction attribuée à un auteur, ni d'analyse grammaticale présentée comme certaine. Racines, lemmes et occurrences viennent du corpus (Quranic Arabic Corpus / QUL).
3. **Aucun relecteur humain.** Tout texte rédigé par IA (explications, sens français mot par mot, significations des racines) porte le statut visible « rédigé par IA — non vérifié ». Toujours citer la source des données.
4. **Ne jamais prétendre avoir compilé ou testé** sans l'avoir réellement fait. Lire les résultats de GitHub Actions avant d'annoncer quoi que ce soit.
5. **Open source vérifié** : chaque dépendance est auditée (licence, mainteneur, popularité) et listée dans `THIRD_PARTY_LICENSES.md`. Signaler à l'utilisateur tout point douteux.
6. **Aucun bouton décoratif ni fausse fonctionnalité.** Ce qui n'est pas fait est indiqué comme tel.
7. **Respect du Coran dans le jeu : le Coran est la connaissance étudiée, jamais l'ennemi combattu.**
   - **Tout ce qui vient du Coran** (versets, mots, racines, lemmes) **est objet d'étude, jamais cible de combat**.
   - Un monstre représente une **difficulté de mémorisation** (l'oubli, la confusion, la distraction), **jamais un mot**. Pour le vaincre, le joueur **retrouve une connaissance** (ex. le sens de « رَحْمَة », miséricorde).
   - **Aucun mot coranique** n'est affiché sur un monstre, frappé, détruit ou « tué » : ni dans les visuels, ni dans les animations, ni dans les textes. Le mot apparaît **uniquement dans un panneau de question séparé et neutre**.
   - Les **versets n'apparaissent jamais en combat**. Noms divins, noms de prophètes et formules sacrées sont **exclus des questions de combat**.
   - Le Coran se lit et s'étudie dans le **Sanctuaire**, zone sans combat.
   - Exigences pour le code : `docs/ARCHITECTURE.md` §2 bis.
8. **Racines : la racine ne suffit pas à déduire le sens.** Toute fiche, leçon ou exercice sur les racines montre les liens entre les mots d'une famille sans laisser croire qu'ils ont le même sens. Structure (racine, lemmes, forme verbale, dérivation, catégorie) uniquement depuis le Quranic Arabic Corpus ; sens, relations de sens et nuances rédigés et marqués « rédigé par IA — non vérifié ». Voir `docs/ARCHITECTURE.md` §2 ter.

## Décisions validées

| Sujet | Décision |
| --- | --- |
| Pile technique | Flutter (Dart) + Flame (moteur 2D, MIT) + SQLite |
| Bases | `iqura_content.db` (lecture seule, générée par `tools/build_content/`) et `iqura_user.db` (progression, seule base exportée) |
| Mémorisation | FSRS (package `fsrs`, MIT). Note déduite automatiquement de la justesse et du temps de réponse |
| Jeu | Vrai RPG 2D. Carte du monde **à étapes** (nœuds cliquables). Combats au tour par tour où chaque action consiste à retrouver une connaissance dans un panneau de question neutre. Mini-donjon = leçon. Boss = examen de chapitre. Monstres = difficultés de mémorisation (l'oubli, la confusion, la distraction), jamais des mots ; la Faille des Oubliés propose les révisions FSRS du jour (règle 7) |
| Ressources | XP, or, **pierres de savoir** (gagnées uniquement quand un mot ou une racine progresse réellement dans FSRS ; impossibles à farmer), encre de scribe, fragments de boss |
| Enchantement | +1 à +15, taux décroissants, +5 points par échec, pity (3 / 5 / 8 échecs selon le palier), jamais de destruction ni de perte de niveau, effets visuels à +5 / +10 / +15. Valeurs dans `docs/ARCHITECTURE.md` §2 bis |
| Racines (priorité majeure) | Fiche racine (sens généraux, famille, étiquette de relation de sens par dérivé : proche, intensif, spécialisé, figuré, éloigné ; nuances ; occurrences), arbre interactif racine → formes verbales → dérivés → sens → occurrences, leçon et encart d'avertissement, 6 exercices (Détective des racines, Famille de mots et L'intrus dans le MVP ; Relation de sens, Deviner puis vérifier et Forge des mots en phase 5). Une carte de révision par racine, indépendante des dérivés |
| Statistiques de jeu | Elles n'influencent jamais les notes FSRS ni les statuts de maîtrise |
| Sources | Texte : Tanzil. Morphologie : Quranic Arabic Corpus / QUL. Traduction : Hamidullah (via Tanzil, usage non commercial), créditée et remplaçable. Audio versets : EveryAyah, récitateur par défaut al-Ḥuṣarī, packs téléchargeables. Audio mot : segments horodatés (QUL) |
| Audio hors Coran | **Reporté** : voix de synthèse après le MVP. Prévoir les emplacements audio dès maintenant ; l'app fonctionne sans |
| Translittération | Savante par défaut (ā, ḍ, ʿ), simplifiée au choix |
| Synchronisation | Sans serveur : export/import d'une archive ZIP versionnée (JSON + SHA-256), restauration complète ou fusion (UUID v7, journaux en ajout seul, HLC) |
| Compilation | GitHub Actions : tests, APK Android, exécutable Windows |

## Orientation du MVP

Priorité : **apprendre la langue arabe elle-même**, l'arabe littéraire tel qu'il est employé dans le Coran. Le **lecteur coranique complet** (114 sourates, mot par mot de chaque verset, audio des versets, % par sourate) est **reporté après le MVP** (phase 8).

Parcours du MVP, **une région du RPG par étape** :

1. **Lire** : alphabet (4 formes, nom, prononciation, point d'articulation, exemples), voyelles courtes et longues, sukūn, shadda, tanwīn, article « al ». Objectif : lire un mot entièrement vocalisé.
2. **Bases de la grammaire** : nom / verbe / particule, pronoms personnels et démonstratifs, genre, nombre (singulier, duel, pluriel), défini / indéfini, phrase nominale, prépositions, iḍāfa.
3. **Verbes** : passé, inaccompli, impératif, conjugaison des verbes réguliers.
4. **Racines et schèmes** : `docs/ARCHITECTURE.md` §2 ter.
5. **Vocabulaire** : lemmes les plus fréquents du Coran. Fréquences, racines et catégories calculées depuis le Quranic Arabic Corpus (source citée, rien d'inventé) ; schèmes seulement avec une source vérifiée ; sens français rédigés et marqués « rédigé par IA — non vérifié ».

**Exemples dans les leçons** :
- des phrases simples **construites**, entièrement vocalisées et marquées « rédigé par IA — non vérifié », pour découvrir une règle ;
- de **courts extraits coraniques** pour l'illustrer en contexte authentique : texte Tanzil sans modification, vérifié par SHA-256, traduction Hamidullah, référence sourate:verset.

Chaque exemple affiche sa source. Les extraits ne paraissent jamais en combat (règle 7).

La révision espacée, les mini-jeux et le RPG s'appuient sur ce parcours. Détail : `docs/ARCHITECTURE.md` §9.

## Phases

1. Socle technique (terminé).
2. Académie de l'arabe : parcours en cinq étapes (cœur du MVP).
3. Données coraniques : pipeline fait ; fréquences, racines, extraits pour les leçons.
4. Mémorisation. 5. Mini-jeux. 6. RPG (une région par étape). 7. Améliorations avancées. 8. Lecteur coranique complet (après le MVP).

## Commandes

- Installer Flutter + SDK Android (session cloud) : `tools/setup_cloud.sh` (lancé automatiquement par `.claude/hooks/session-start.sh`).
- Base de contenu : `python3 tools/build_content/build_content.py` (obligatoire avant `flutter build` et `flutter test`). Sources versionnées et vérifiées par SHA-256 dans `tools/build_content/sources/` ; `fetch_sources.py` compare avec les versions en ligne.
- Vérifications : `dart format lib test`, `flutter analyze`, `flutter test`, `python3 -m unittest discover -s tools/build_content`.
- Compilation : `flutter build apk --release` ; Windows uniquement via GitHub Actions (`.github/workflows/build.yml`).
- Inventaire des licences : `python3 tools/third_party/list_dart_packages.py`.

## Doutes de licence à garder en tête

- Traduction Hamidullah : aucune licence publiée ; Tanzil la diffuse pour un usage non commercial, sans préciser l'édition.
- Récitations EveryAyah : aucune condition publiée ; les droits restent aux récitateurs.
- Quranic Arabic Corpus : la FAQ mentionne un usage « de recherche ». Une confirmation écrite des auteurs est souhaitable.
