# État du projet IQURA

Mis à jour le 23 octobre 2026. **À lire en début de session, à mettre à jour à chaque étape importante et avant la fin d'une session.**
Référence : `docs/CAHIER_DES_CHARGES.md` (**v3 du 22 octobre 2026**, référence unique). Règles : `CLAUDE.md`. Anciennes versions : `docs/archive/`.

Branche de travail : `claude/laughing-ramanujan-axcixk` (repartie de `main` après la fusion de la pull request n° 3).

**Organisation par niveaux depuis le 23/10/2026** (cahier §13.0) : on construit un niveau entier, on le fait relire, on le teste, puis on publie une version. **Niveau en cours : Débutant 1 (leçons 0 à 4), construit, en attente du test de l'utilisateur.** Niveau suivant : Débutant 2 (leçons 5 à 9). Étapes 1 à 3 du jalon J1a faites (cahier v3 appliqué, région 1 validée, coquille du jeu).

## 1. Ce qui existe déjà (gardé, cahier §0.1 point 4)

| Élément | Preuve |
| --- | --- |
| **Socle J0** : app Windows et Android, profil, base utilisateur, sauvegardes, export, import, fusion, CI | Pull request n° 1 fusionnée ; transfert PC → Android validé par l'utilisateur |
| **Pipeline coranique** : Tanzil Uthmani 1.1 vérifié par SHA-256 (tests et démarrage), Quranic Arabic Corpus 0.4 aligné sur 100 % des 6 236 versets, traduction Hamidullah via Tanzil, notice du Corpus affichée dans l'application | Tests Python et Dart |
| **Polices** Amiri et Amiri Quran (OFL) | Couverture du texte Tanzil contrôlée par test |
| **Translittération** Arabica et simplifiée, masquable | Tests du moteur |
| **Outil audio** Chatterbox avec coupure automatique et contrôle de durée selon la longueur des voyelles | Coupure validée à l'écoute ; 8 tests |
| **Audio des leçons 0 à 3** : 44 MP3, dont تَ, يَ et نَابَ corrigés et validés à l'écoute le 22/10/2026 | Empreintes SHA-256 vérifiées par le pipeline |
| **Leçons 0 à 3** (ancien format, fiches de cours) | Tests Python ; à refaire au format mini-donjon (voir §2) |
| **Maquettes** « Histoire — La porte de la bibliothèque » et « Expédition — Combat contre l'Oubli » | Base de référence du style (cahier §8.1) ; [page des maquettes](https://claude.ai/artifact/9CuoZib7eH4rfxH7eBNLFd), hors dépôt |

Derniers résultats : tests locaux du 22/10/2026 (Python : contenu et audio OK ; Flutter : 83 tests OK ; `flutter analyze` sans remarque) ; compilations GitHub Actions réussies (tests, APK, Windows) sur `80f8d48`, dernier commit de la pull request n° 3.

## 1 bis. Coquille du jeu (étape 3, 23/10/2026)

| Élément | Détail |
| --- | --- |
| Graphismes | Pixel art créé pour le projet : `tools/build_art/` (rectangles JSON → PNG, bibliothèque standard), 13 images dans `assets/art/` (7 scènes, 6 personnages). Vérifiées par tests et en CI |
| Police | DotGothic16 (OFL) pour les textes du jeu, choisie par l'utilisateur le 23/10/2026 (chiffres plus lisibles que Pixelify Sans) ; Amiri en secours pour la translittération |
| Monde | `tools/build_content/world/region1.json` → tables `region`, `place`, `character` (schéma de contenu 6, contenu 0.5.0-j1a) |
| Carte | Désert des Lettres : 12 lieux reliés ; les 4 lieux de la tranche (Puits, Porte, Marché, Faille) s'ouvrent, les 8 autres sont indiqués « À venir (jalon J1b) » |
| Lieux | Scène, personnages, fenêtre de dialogue (« Rédigé par IA ») ; leçons de l'étape avec leur état (nouvelle, en cours, terminée, fermée, ou « Jouable à l'étape 5 » pour les leçons 2 et 3) |
| Combat | Faille des Oubliés : scène Flame (brume animée), panneau de question neutre (syllabes et mots construits des leçons 0 à 3, jamais de verset), 3 ou 4 choix, critique si réponse en moins de 3 s, explication après une erreur. Entraînement : rien n'est enregistré avant l'étape 6. Seule l'Attaque est active ; les autres commandes sont grisées avec leur raison |
| Grimoire | Alphabet (9 lettres) et fiches (formes, nom avec audio « synthèse », articulation « Rédigé par IA », « Signaler une erreur ») |
| Signalements | Gardés sur l'appareil (`signalements.jsonl`), envoi par mail prérempli à contact@edelwa.com |
| Sanctuaire | Al-Fātiḥa : texte Tanzil vérifié et traduction Hamidullah ; récitation et part des mots reconnus indiquées « pas encore disponibles » |
| Cité | Vue de la cité, 5 bâtiments « À reconstruire » ; boutique, équipement, enchantement à l'étape 6 |
| Paquets ajoutés | flame 1.38.2 (MIT), audioplayers 6.8.1 (MIT), url_launcher 6.3.3 (BSD) : audités, `THIRD_PARTY_LICENSES.md` |

## 1 ter. Lecteur de leçons (étape 4, 23/10/2026)

| Élément | Détail |
| --- | --- |
| Code | `lib/game/lesson/lesson.dart` (modèle du format 2), `lib/ui/game/lesson/` (écran de leçon, questions, mini-boss), `lib/features/progress/lesson_progress.dart` |
| Écrans | Entrée (scène du lieu, répliques du maître, objectif) ; découverte, élément, règle (explication puis sa question) ; salle d'entraînement (une erreur revient en fin de salle) ; salle d'étude (verset Tanzil mot à mot, mots cités surlignés, traduction créditée ; « toucher le mot », « compter la lettre » calculé sur le texte Tanzil) ; mini-boss ; fin |
| Questions | qcm, points, formes, reconnaître, écouter, paires, écouter la lettre (nom joué), lire (choix de sons), reconstruire (tuiles), tracer, répéter ; choix puis « Valider » ; son joué à l'affichage, mention « synthèse » ; « exemple construit » sous les mots hors Coran ; aucune translittération dans les questions |
| Mini-boss | Scène Flame contre l'Oubli ; PV réglés sur le seuil : la difficulté tombe à 80 % de bonnes réponses, le voyageur se replie à la première erreur de trop ; « rapide ! » sous 3 s sans effet sur le score ; pas d'explication pendant le combat, revue des erreurs expliquées à la fin ; retenter (mêmes questions, autre ordre) ou revoir la salle d'entraînement, conseillée après deux échecs |
| Progression | Table `lesson_progress` (schéma utilisateur 2) : écran sauvegardé à chaque changement et repris, réussite du mini-boss, meilleur score, échecs ; leçon suivante ouverte après la réussite. Exportée et fusionnée ; une sauvegarde du schéma 1 reste importable |
| Fiche « élément » | Nom de la lettre joué automatiquement ; nom arabe écrit masqué (hamza pas encore enseignée, relecture du 23/10) |
| Simplifications provisoires, à valider | Tracer : tracé libre au doigt sur la lettre, sans points numérotés ni vérification (cahier §6.4). Répéter : écouter puis « Je l'ai répété », sans enregistrement de la voix (paquet `record` à auditer). Mini-boss : pas d'autres questions en réserve pour un nouvel essai. Salle d'étude : pas de récitation d'al-Ḥuṣarī. Récompenses et cartes : étape 6 |

Tests locaux du 23/10/2026 : Flutter 99 tests OK, `flutter analyze` sans remarque ; Python : contenu (31) et graphismes (5) OK.

## 1 quater. Niveau Débutant 1 (leçons 0 à 4, 23/10/2026)

| Élément | Détail |
| --- | --- |
| Leçons | 0 Puits, 1 Porte, 2 et 3 Marché (Laylā, Samīr), 4 Caravansérail (Rāšid, scène et personnage créés) ; échauffement exigé dès la leçon 2 ; 55 enregistrements |
| Relectures | `docs/relectures/2026-10-23-*.md` : leçons 0-1 validé avec doutes ; 2 validé avec doutes ; 3, 4 validé ; tracés validé. Décisions du conseiller : `docs/relectures/decisions-debutant-1.md` |
| Révisions | FSRS-6 (paquet `fsrs`) ; cartes créées à la première réussite d'une leçon (reconnaître, écouter, signe, lire) ; note par justesse et temps (§6.3) ; états reconnu (stabilité ≥ 7 j) et maîtrisé (≥ 21 j) |
| Expédition | Faille des Oubliés : vagues de brumes puis un gardien, nourris par les révisions dues (20 au plus) ; entraînement libre sans enregistrement quand rien n'est dû |
| Économie | XP et niveau, dinars, pierres de savoir (à « reconnu » 1, « maîtrisé » 3), encre ; séries (un jour de repos permis) ; boutique (8 objets, `world/objets.json`), équipement, ensemble à 3 pièces, enchantement +1 à +15 (taux, +5 points par échec, pity) |
| Parole, écriture | Répéter : s'enregistrer, réécouter (paquet `record`), sur l'appareil seulement ; tracé guidé par points numérotés (`lessons/traces.json`) |
| Modes et réglages | Apprentissage seul (liste de leçons, sans scènes ni combats) ; chronomètre ; bruitages |
| Technique | Schéma utilisateur 3 (cartes, ressources, inventaire, jours d'activité) ; schéma de contenu 7 (objets, tracés) ; version de contenu avec empreinte ; APK signé avec une clé fixe (secrets `IQURA_KEYSTORE_B64`, `IQURA_KEYSTORE_PASSWORD`) |
| Retours du 1er test (24/10) | Police de translittération corrigée (copie « DotGothic16 IQURA » sans accents séparés : ḥ, ḫ, ǧ lisibles) ; thème clair appliqué aux écrans du jeu ; réponses déplacées quand une question revient ; interface agrandie sur grand écran ; ordre « بَ : بَاب » corrigé dans les phrases françaises ; sons ثَا et تَاج en cours de refonte |
| Tests | 132 tests Flutter (dont les 5 leçons jouées de bout en bout, l'Expédition, l'économie, l'enchantement sur 20 000 tirages), tests Python du contenu |

## 2. Ce qui doit changer pour suivre le cahier v3 (cahier §0.1 point 5)

### A. Modifications fortes ou suppressions — **acceptées par l'utilisateur le 22/10/2026**

| N° | Existant | Changement prévu | Raison (cahier) |
| --- | --- | --- | --- |
| A1 | Leçons 0 à 3 : fiches de cours (sections de texte, puis exercices) | Réécriture complète au format mini-donjon : écrans d'entrée, échauffement, découverte, éléments, règle, entraînement, salle d'étude, mini-boss, fin. Nouveau format de données, nouveaux contrôles du pipeline, nouveaux tests. Les textes utiles sont repris. | §6, §5.5 point 9 |
| A2 | Leçon 0 : texte suivi de questions à **2 choix**, contrôle final à **75 %** | Énigme de déchiffrage ; questions à 3 ou 4 choix ; 80 % | §5.5 points 5, 6, 8 |
| A3 | Contenu des leçons 0 à 3 | Corrections : alif (retirer « ou à une voyelle »), نَجَا (« il s'est sauvé, il a échappé »), ح (le « ahh » soufflé), décomposition de la leçon 0 de droite à gauche, nouveaux mots بَاب, بَنَات, نَبَات, ثَابِت, تَاج, جَنَاح, حَبِيب | §5.5 points 1 à 4 et 7 |
| A4 | 44 enregistrements audio | Ceux des éléments retirés sont supprimés ; ceux des nouveaux mots sont générés puis soumis à l'écoute | Conséquence de A1 à A3 |
| A5 | Coquille actuelle : 5 espaces « Pas encore disponible » (Carte, Cité, Grimoire, Sanctuaire, Paramètres) | Remplacée par la coquille du jeu en pixel art (carte à étapes, dialogue, combat, Cité, Grimoire, Sanctuaire). Profil, Paramètres, sauvegarde, export et import sont gardés. | §8, §13.1 point 3 |
| A6 | Page d'aperçu des leçons (`preview_lessons.py`) | Adaptée au nouveau format, ou remplacée par le jeu lui-même | Conséquence de A1 |
| A7 | `docs/HISTOIRE.md` : *La Bibliothèque oubliée*, Madīnat al-Ḥikma, l'archiviste, l'apprenti copiste | Gardé comme proposition ; noms définitifs et lieux de la région 1 (« Le Désert des Lettres ») à revalider à l'étape 2 | §8.2, §13.1 point 2 |

### B. Ajouts (rien n'est supprimé)

| N° | Ajout | Cahier |
| --- | --- | --- |
| B1 | Base utilisateur, nouvelle version avec migration : cartes et états FSRS (passif et actif séparés), progression par écran, ressources, équipement, enchantement, séries, enregistrements (sur l'appareil, exclus de l'export par défaut) ; export, import et fusion étendus | §4, §6.3, §8.6, §10 |
| B2 | Base de contenu : fréquences des lemmes (calculées à partir du Corpus), lieux, dialogues, monstres, objets ; liste d'environ 100 mots de la région 1 (choisis par script, soumise à l'utilisateur) | §5.5, §12 |
| B3 | Paquets Flutter, chacun audité avant ajout : Flame, FSRS, lecture audio, enregistrement micro | §3.3, §12 |
| B4 | Réglages : vitesse audio, nouveaux mots par jour (5 à 30, 15 par défaut), chronomètre, mode « apprentissage seul » | §4, §6.2, §8.3 |
| B5 | Bouton « Signaler une erreur » sur chaque fiche | §3.2 |
| B6 | Graphismes pixel art : packs libres audités ou créations | §8.1 |

## 3. Points ambigus ou contradictoires (à poser un par un, cahier §0.2)

1. **Mention des contenus IA** : le v3 écrit « rédigé par IA — non vérifié » (§3.2, §10, §11, §14, §15), alors que l'utilisateur a demandé « rédigé par IA » le 21/10/2026. **Tranché le 22/10/2026 : « rédigé par IA »** ; cahier corrigé.
2. **Licence du Quranic Arabic Corpus** : le v3 indique « licence GNU, non commercial » et un mail à envoyer ; la notice du fichier (relevée par l'utilisateur le 21/10/2026) dit GNU GPL et autorise l'usage « dans tout site web ou application », sans mention « non commercial ». **Tranché le 22/10/2026 : cahier corrigé d'après la notice, mail facultatif.**
3. **Schèmes** : le v3 les attribue au Corpus (« via QUL si besoin ») ; la version 0.4 n'en contient pas. QUL est à examiner (contenu et licence) avant de s'y fier. **Tranché le 22/10/2026 : QUL sera examiné avant la région 3 ; rien n'est inventé d'ici là.**
4. **Traduction** : « révision du Complexe Roi Fahd (2000) » n'est pas confirmée par Tanzil. **Tranché le 22/10/2026 : « édition non précisée » ; cahier corrigé.**
5. **Police du Mushaf** : le v3 cite KFGQPC Hafs ; IQURA utilise Amiri Quran ; la licence de KFGQPC est à auditer avant tout changement. **Tranché le 22/10/2026 : Amiri Quran pour J1a ; audit de KFGQPC avant la leçon 14.**
6. **« Signaler une erreur »** dans une application hors ligne : par quel moyen (fichier exporté, mail préparé, autre) ? **Tranché le 22/10/2026 : mail prérempli envoyé par le joueur depuis sa messagerie ; adresse : contact@edelwa.com.**
7. **Sort de racine** : « débloqué en région 3 ; familles simples avant » (§8.5) : la commande existe-t-elle dès la région 1 sous une forme simple ? **Tranché le 22/10/2026 : forme simple dès la leçon 7, forme complète en région 3.**

Changements du v3 notés sans question, car le v3 fait foi : option IA décidée « à partir de J4, désactivée par défaut » (l'utilisateur avait dit « décider à J4 » le 21/10) ; noms de l'Histoire à revalider en J1a.

## 4. Prochaine étape

1. Fait : accord sur la liste du §2 et réponses aux points du §3.
2. Fait : noms des lieux et personnages de la région 1 et découpage en 12 lieux, validés.
3. Fait (23/10/2026) : coquille du jeu en pixel art (voir §1 bis) ; retours de l'utilisateur attendus.
4. En cours, cahier §13.1 point 4 :
   - fait : leçons 0 (« L'énigme du puits ») et 1 (« L'étiquette de la porte ») réécrites au format mini-donjon (format 2), contrôlées par `tools/build_content/mini_donjon.py` (ordre des écrans, 40 mots et 2 phrases au plus, 3 ou 4 choix, mini-boss de 10 à 12 questions à 80 % avec 20 à 30 % de révision, aucun texte coranique recopié, lettres déjà enseignées seulement) ; aperçu : `preview_lessons.py` ;
   - fait : voyelle finale avalée par la synthèse (« baḥaṯ » au lieu de « baḥaṯa ») mesurée automatiquement (régularité du son sur les 70 dernières millisecondes) ; aucune astuce d'écriture ne la corrige à coup sûr, on génère donc plusieurs tirages et on garde les meilleurs ;
   - fait : relecture par l'agent relecteur-arabe, verdict « Validé avec doutes », 4 doutes transmis à l'utilisateur (`docs/relectures/2026-10-23-lecons-0-1.md`) ; 2e passage sur la leçon 1 après les décisions de l'utilisateur : « Validé avec doutes » (`docs/relectures/2026-10-23-lecon-1-passage-2.md`) ; mineurs simples corrigés ; à faire avec le lecteur de leçons : nom arabe des lettres (hamza non enseignée) et mention « exemple construit » ;
   - fait : sons choisis (بَاب B ; تَابَ, ثَبَتَ inchangés ; ثَ, بَا, تَا, بَاتَ nouvelles versions) ; leçons 0 et 1 validées par l'utilisateur le 23/10/2026 ; réponses aux 4 doutes de la relecture appliquées (cahier §16) ;
   - à ne pas oublier : expliquer la forme complète بَابٌ aux leçons 4 (sukūn) et 12 (tanwīn) ;
   - fait : lecteur de leçons dans l'application (§1 ter), leçons 0 et 1 jouées de bout en bout par les tests ;
   - retours du 1er test de l'APK (23/10) : son de ثَبَتَ refait (version B, virgule finale), « margelle » remplacé, affichage PC centré et scène limitée en hauteur ; bruitages rétro créés (`tools/build_sfx/`), validés à l'écoute et branchés (menus, choix, juste/faux, coups, victoire, repli, sceau), désactivables dans les réglages ;
   - remplacé le 23/10/2026 par l'organisation par niveaux : voir §1 quater.
5. Débutant 1 construit (§1 quater), testé une première fois par l'utilisateur le 24/10/2026 ; retours intégrés (§1 quater), nouvelle version à publier.
6. Ensuite : Débutant 2 (leçons 5 à 9, lieux 5 à 7), commencé pendant le test.

## 5. Problèmes connus

- **Chatterbox** : données d'entraînement et origine de la voix par défaut non publiées ; une voyelle brève isolée peut être allongée, la voyelle brève finale d'un mot est souvent avalée (on génère plusieurs tirages et on garde le meilleur ; خَابَ et حُجِبَ de la leçon 3 sont à écouter en priorité), et un mot tronqué n'est pas détecté automatiquement : l'écoute de l'utilisateur reste nécessaire.
- **Synthèse non reproductible en CI** (modèle trop lourd) : les MP3 sont versionnés et la CI vérifie leur empreinte.
- **Réseau de la session cloud** : `download-r2.pytorch.org`, `github.com` et quelques sites de référence bloqués.
- **Compilation Windows** : uniquement via GitHub Actions.
- **Maven Central** refuse parfois les téléchargements (erreur 429) pendant la compilation de l'APK ; une nouvelle compilation passe.

- **Simplifications restantes (Débutant 1)** : récitation d'al-Ḥuṣarī absente (téléchargement non autorisé dans la session) ; objets non dessinés sur le personnage ; enregistrements de la voix jamais exportés (pas encore d'option pour les inclure).
