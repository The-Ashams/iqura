# IQURA — instructions pour Claude

**Référence unique du projet : `docs/CAHIER_DES_CHARGES.md` (v2, 21 octobre 2026).** Lis-le avant toute tâche importante, avec son journal des décisions (§13). **État courant, travail en cours et prochaine étape : `docs/ETAT_DU_PROJET.md`** (à lire en début de session, à tenir à jour en fin de session). L'ancien dossier d'architecture est archivé dans `docs/archive/ARCHITECTURE.md` (historique seulement).

## Vision

IQURA est un **RPG d'aventure narrative** dont la mécanique centrale est de comprendre l'arabe : plus le joueur comprend, plus le monde s'ouvre. Il mène un francophone débutant jusqu'à lire couramment l'arabe littéraire, le comprendre, le parler et surtout **comprendre directement le Coran**.

- Un vrai cursus, inspiré de la méthode de Médine, en cinq étapes (une région du jeu par étape).
- Un vrai jeu : le déchiffrement de la langue est le gameplay (*Heaven's Vault*, *Chants of Sennaar*), avec les codes du RPG (équipement, enchantement, donjons, boss).
- Les racines comme signature.
- Le respect du Coran : il est la connaissance étudiée, jamais l'ennemi.

Gratuit, sans publicité ni achat, open source **GPL-3.0**, en français, pour **Windows et Android**, utilisable hors ligne.

## Règles absolues

1. **Respect du Coran (cahier §6, non négociable).**
   - Le Coran est la connaissance étudiée, jamais l'ennemi combattu. Il se lit et s'étudie dans le **Sanctuaire**, sans aucun combat.
   - Aucun mot coranique affiché sur un monstre, frappé, détruit ou « tué », ni dans les visuels, ni dans les animations, ni dans les textes.
   - En combat, un mot du vocabulaire peut apparaître **seul, sous forme de dictionnaire**, dans un **panneau de question neutre**, sans verset ni référence.
   - **Aucun verset ni extrait coranique en combat.**
   - Noms divins, noms de prophètes et formules sacrées sont **exclus de toute question de combat**.
   - Les monstres représentent des difficultés (l'Oubli, la Confusion, la Distraction), jamais des mots.
   - Aucune représentation de prophètes ni de figures sacrées ; aucune parole attribuée à un prophète ou à une figure religieuse.
   - Récompenses du Sanctuaire discrètes (XP, avancement de la cité), jamais de butin ni de combat liés au texte.
2. **Texte coranique jamais généré, reconstitué ni modifié.**
   - Il vient de Tanzil, stocké une seule fois, et il est vérifié par SHA-256 dans les tests et au démarrage.
   - Les leçons le **référencent** (sourate:verset ou plage de mots) sans le recopier.
3. **Aucune donnée inventée** : pas de racine, d'occurrence, de schème, ni de traduction attribuée à un auteur. Toute donnée linguistique vient d'une **source citée**.
4. **Aucun relecteur humain.** Tout texte rédigé par IA (sens des mots, explications, nuances, dialogues, récits, exemples) porte le statut visible **« rédigé par IA — non vérifié »**. Chaque exemple affiche sa source (« exemple construit » ou référence coranique). Tout audio de synthèse est signalé comme tel.
5. **Ne jamais prétendre avoir compilé ou testé** sans l'avoir réellement fait. Lire les résultats de GitHub Actions avant d'annoncer quoi que ce soit.
6. **Licences** : chaque dépendance et ressource (code, polices, audio, graphismes, données) est auditée et listée dans `THIRD_PARTY_LICENSES.md` ; tout point douteux est signalé à l'utilisateur.
7. **Aucun bouton décoratif ni fausse fonctionnalité** : ce qui n'est pas fait est indiqué comme tel.
8. **Racines** : la racine ne suffit pas à déduire le sens exact d'un dérivé. Toute fiche, leçon ou exercice le montre (avertissement visible) ; structure issue du Quranic Arabic Corpus, sens rédigés et marqués.
9. **Décisions** : ne rien choisir à la place de l'utilisateur sur les décisions ouvertes (cahier §12). Poser les questions une à la fois, avec une recommandation. Avant de supprimer ou de modifier fortement du code existant, présenter la liste et attendre son accord.

## Pédagogie (cahier §2 et §3)

- **Quatre compétences par session** : comprendre (lire, écouter), mémoriser (FSRS), comprendre la mécanique (grammaire, schèmes, racines), produire (parler, écrire).
- **Textes gradués** : tout texte à lire contient **au moins 95 % de mots connus** du joueur (calcul automatique).
- **Révision et rappel** :
  - un appui sur un mot inconnu affiche son sens et crée une carte de révision ;
  - FSRS pour les mots, racines, conjugaisons et règles, avec une note déduite de la justesse et du temps de réponse ;
  - toujours demander avant de montrer (rappel actif), avec un feedback qui explique, et des révisions entrelacées.
- **Progression** : bascule progressive des dialogues du français vers l'arabe ; fréquence d'abord ; répétition à voix haute sans note automatique de prononciation.
- **États d'un mot** : découvert → en apprentissage → reconnu → maîtrisé, plus « à réviser ». Jamais « maîtrisé » après une seule réussite.
- **Cursus** : 1 Déchiffrer, 2 Fondations, 3 Le moteur de la langue, 4 Lire et parler, 5 Le Coran. Chaque étape se termine par un boss-examen. Le Coran est présent dès l'étape 1.
- **Leçon (mini-donjon)** : découverte par l'exemple, règle courte, pratique corrigée, un ou deux extraits coraniques référencés, contrôle final, cartes de révision.

## Décisions techniques (cahier §9)

| Sujet | Décision |
| --- | --- |
| Framework | Flutter (Dart), Windows et Android ; moteur 2D Flame (MIT) ; menus, questions et Grimoire en widgets Flutter |
| Données | SQLite : `iqura_content.db` en lecture seule, générée par `tools/build_content/` ; `iqura_user.db`, seule base exportée |
| Contenu | Piloté par les données : leçons, dialogues, récits, quêtes, monstres, objets, régions dans des fichiers de contenu (JSON), pas dans le code |
| Révision | FSRS |
| Sauvegarde | Archive ZIP versionnée et vérifiée, restauration complète ou fusion (fait, J0) |
| Hors ligne | Tout, sauf téléchargement des récitations, mises à jour de contenu et option IA |
| Affichage | Arabe RTL, diacritiques corrects, taille réglable ; polices Amiri et Amiri Quran (SIL OFL) ; translittération *Arabica* par défaut, simplifiée au choix, masquable (`docs/TRANSLITTERATION.md`) ; clair/sombre ; animations désactivables |
| Ergonomie | Souris et clavier (Windows), tactile (Android), plusieurs tailles d'écran |
| Audio | **Obligatoire dès le MVP.** Coran : EveryAyah (al-Ḥuṣarī par défaut), mots par découpage horodaté (QUL), packs par sourate. Leçons et dialogues : **Chatterbox Multilingual** (MIT, décision n° 1 tranchée le 21/10/2026), généré une fois par `tools/build_audio/`, coupé après la première prise de parole, signalé « synthèse » |
| Graphismes | **Pixel art libre** (décision n° 2, 21/10/2026) : cités de savoir historiques, sans figures sacrées ; chaque pack audité (CC0 de préférence) |
| Compilation | Claude Code + GitHub Actions (APK et exe) sur `The-Ashams/iqura` |

## Jalons (cahier §10)

| Jalon | Contenu | Condition de passage |
| --- | --- | --- |
| J0 — Socle | **Fait** : app Windows et Android, profil, sauvegarde, export, import, fusion | Transfert PC → Android validé ✅ |
| J1 — MVP, région 1 « Déchiffrer » | Toute l'étape 1 avec audio ; chapitre 1 de l'Histoire ; Expédition et boss ; Grimoire ; Cité minimale (boutique, équipement, enchantement +1 à +15) ; Sanctuaire avec Al-Fātiḥa ; séries ; mode « apprentissage seul » | Un débutant lit des mots vocalisés seul ; il revient plusieurs jours ; aucun bug bloquant |
| J2 à J5 | Régions 2 à 5 (Fondations, Moteur de la langue, Lire et parler, Le Coran) | Voir cahier §10 |

**Ordre de travail pour J1** :
1. Solution audio (décision n° 1) : **fait**, Chatterbox Multilingual ; enregistrements des leçons 0 à 3 livrés (44 MP3). Reste : lecteur audio dans l'application, et l'audio des leçons suivantes au fur et à mesure.
2. Pipeline de données (fait en grande partie : Tanzil vérifié, Quranic Arabic Corpus aligné).
3. Contenus de l'étape 1, validés par l'utilisateur leçon par leçon.
4. Coquille du jeu.
5. Chapitre 1, Expédition, Sanctuaire (Al-Fātiḥa).
6. Tests et compilations.

On avance région par région, chaque région complète et jouable.

## État et écarts connus

- **Fait (J0 et pipeline)** :
  - socle de la phase 1 ;
  - pipeline coranique (Tanzil Uthmani vérifié, Quranic Arabic Corpus aligné à 100 %, traduction Hamidullah via Tanzil) ;
  - polices Amiri / Amiri Quran ;
  - moteur de translittération ;
  - leçons 0 à 3 de l'étape 1 sous forme de données, en attente de validation ;
  - décision n° 1 (audio) : Chatterbox Multilingual, outil `tools/build_audio/` (génération, coupure des sons parasites validée à l'écoute, livraison MP3 vérifiée par SHA-256).
- **Audio dans l'application** : les fichiers sont livrés et référencés par la base de contenu, mais aucun lecteur audio n'est encore intégré (choix du paquet Flutter à auditer).
- **Schèmes** : le cahier les attribue au Quranic Arabic Corpus, mais la version 0.4 ne les fournit pas. Aucune source ouverte fiable trouvée à ce jour ; rien n'est inventé.
- **Traduction** : le cahier indique « rév. Complexe Roi Fahd (2000) », mais Tanzil ne précise pas l'édition diffusée.
- **Police du Mushaf** : le cahier cite KFGQPC Hafs ; IQURA utilise aujourd'hui Amiri Quran (OFL, couverture du texte Tanzil vérifiée). La licence de KFGQPC est à auditer avant tout changement.

## Commandes

- Installer Flutter + SDK Android (session cloud) : `tools/setup_cloud.sh` (lancé automatiquement par `.claude/hooks/session-start.sh`).
- Base de contenu : `python3 tools/build_content/build_content.py`, obligatoire avant `flutter build` et `flutter test`.
  - Les sources sont versionnées et vérifiées par SHA-256 dans `tools/build_content/sources/`.
  - `fetch_sources.py` les compare aux versions en ligne.
- Vérifications : `dart format lib test`, `flutter analyze`, `flutter test`, `python3 -m unittest discover -s tools/build_content`.
- Compilation : `flutter build apk --release` ; Windows uniquement via GitHub Actions (`.github/workflows/build.yml`).
- Inventaire des licences : `python3 tools/third_party/list_dart_packages.py`.
- Audio des leçons (hors CI : modèle de plusieurs Go, processeur suffisant) :
  - environnement Python à part avec `torch` (PyPI), `chatterbox-tts` 0.1.7 installé avec `--no-deps` plus ses dépendances, `setuptools<81` (Perth utilise `pkg_resources`), `soundfile` ; `ffmpeg` pour le MP3 ;
  - `python tools/build_audio/generate.py --lecons DOSSIER` génère tous les enregistrements des leçons (rapport JSON, graine retenue, parasites retirés) ;
  - `python tools/build_audio/package.py DOSSIER` convertit en MP3 dans `assets/audio/lecons/` et met à jour `tools/build_audio/clips.json` ;
  - tests de la coupure : `python -m unittest discover -s tools/build_audio` (numpy requis).
- Réseau de la session cloud : `huggingface.co`, `us.aws.cdn.hf.co` et `download.pytorch.org` sont autorisés (ajoutés par l'utilisateur) ; `download-r2.pytorch.org` est bloqué, installer PyTorch depuis PyPI.
- Leçons :
  - données dans `tools/build_content/lessons/`, contrôlées par le pipeline ;
  - aperçu pour relecture : `python3 tools/build_content/preview_lessons.py SORTIE.html --etape 1 --jusqua N`.

## Points de licence douteux

- **Traduction Hamidullah** : aucune licence publiée ; Tanzil la diffuse pour un usage non commercial.
- **EveryAyah** : aucune condition publiée ; les droits restent aux récitateurs.
- **Chatterbox** : poids MIT, mais Resemble AI ne publie ni ses données d'entraînement ni l'origine exacte de la voix par défaut (« prompts sourced from freely available data on the internet »).
- **Quranic Arabic Corpus** : la FAQ parle d'un « usage de recherche » ; un mail aux auteurs est à envoyer par l'utilisateur (décision ouverte n° 7).
