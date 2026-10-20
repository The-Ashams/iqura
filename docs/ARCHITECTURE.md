# IQURA — Dossier d'analyse et d'architecture

Version du 20 octobre 2026. Source : dossier validé avec le porteur du projet (Edel).

## 1. Analyse du projet

IQURA est faisable en une seule base de code Flutter. Mais le cahier des charges complet représente plusieurs mois de travail : le seul moyen de livrer quelque chose de fiable est d'avancer par phases testables, en commençant par un MVP solide plutôt que par toutes les fonctionnalités à moitié.

**Ce qui rend le projet réaliste.** Le cœur linguistique existe déjà sous forme de données ouvertes et vérifiées : texte coranique (Tanzil), segmentation et morphologie de chaque mot avec racine et lemme (Quranic Arabic Corpus), récitations audio verset par verset et mot par mot. L'app n'a donc pas à « inventer » le Coran ni ses racines : elle doit les intégrer proprement et construire la pédagogie autour.

**Ce qui demande un vrai travail de contenu.** Les cours (alphabet, niveaux 1 à 4), les explications grammaticales, les exercices et surtout les sens français mot par mot ne se téléchargent pas : il faut les écrire. Ces contenus doivent être marqués « rédigé par IA — non vérifié » tant qu'une personne compétente ne les a pas validés (exigence du §16 du cahier des charges).

**Les trois zones de risque principales.**

- **Licences** : plusieurs sources clés sont libres seulement pour un usage non commercial ou sous GPL. L'app étant gratuite et open source, elles sont utilisables.
- **Audio hors Coran** : il n'existe pas de banque libre et de qualité pour les lettres, syllabes et phrases d'exemple. Décision : voix de synthèse, ajoutée après le MVP.
- **Reconnaissance vocale** : techniquement possible, mais pas assez fiable sur l'arabe vocalisé et les lettres emphatiques pour être plus qu'un indice. Elle n'arrive qu'en phase 7.

**Positionnement du RPG (choix validé).** IQURA est un vrai RPG 2D classique dans lequel on apprend l'arabe : carte du monde, donjons, boss, équipement améliorable jusqu'à +15 avec pity. L'apprentissage est réel et structuré (FSRS, leçons, racines), mais il prend la forme du jeu : combattre, explorer, forger. La section 2 bis décrit ce pont.

## 2. Méthodes pédagogiques retenues

Le moteur pédagogique repose sur la répétition espacée FSRS et le rappel actif, les deux techniques dont l'efficacité sur la mémorisation à long terme est la mieux établie.

| Méthode | Mise en œuvre dans IQURA | Pourquoi |
| --- | --- | --- |
| Répétition espacée (FSRS) | Chaque mot, racine, lettre et règle est une « carte » planifiée par FSRS (package Dart [fsrs](https://pub.dev/packages/fsrs), licence MIT, 21 paramètres). Objectif de rétention réglable (90 % par défaut). | L'effet d'espacement est l'un des résultats les plus robustes de la psychologie cognitive. FSRS planifie mieux que l'algorithme SM-2 d'Anki. |
| Rappel actif | Toujours demander avant de montrer : saisie, choix, écoute puis identification. | L'effet de test : récupérer une information la consolide davantage que la relire. |
| Entrelacement | Les séances mélangent vocabulaire, racines, grammaire et compréhension de versets. | Oblige à discriminer entre types de problèmes, ce qui améliore le transfert. |
| Apprentissage contextualisé | Chaque mot est montré dans au moins un verset réel (occurrence du corpus) ou une phrase d'exemple. | Le contexte fournit des indices de récupération et le sens réel du mot. |
| Progression adaptative | Prérequis entre leçons, test de positionnement, nombre de nouvelles cartes par jour ajusté selon la charge de révision et le taux d'erreur. | Rester dans la zone où l'effort est utile sans décourager. |
| Feedback immédiat explicatif | Chaque correction dit pourquoi, avec lien vers la règle ou la racine. | Un feedback qui explique corrige le modèle mental, pas seulement la réponse. |
| Double modalité | Texte arabe + audio ; exercices dans les deux sens. | Deux canaux d'encodage renforcent la trace mémorielle. |
| Racines et schèmes | Chaque mot est rattaché à sa racine et à son schème ; la maîtrise de la racine est suivie séparément. | Comprendre un schème rend des centaines de mots prévisibles. |
| Fréquence d'abord | Le parcours coranique introduit les lemmes par fréquence décroissante dans le corpus. | Quelques centaines de lemmes couvrent une grande part des occurrences du Coran. |

**États d'un mot.** Découvert (vu une fois) → en apprentissage (dans FSRS, stabilité faible) → reconnu (stabilité ≥ 7 jours) → maîtrisé (stabilité ≥ 60 jours et au moins 3 révisions réussies espacées). « À réviser » est un statut transversal : la date de révision est dépassée. Un quiz réussi ne donne jamais « maîtrisé » directement. Seuils initiaux à ajuster.

**Mesure de compréhension.** Le pourcentage affiché pour une sourate est la part des occurrences de mots dont le lemme est au moins « reconnu ». L'écran le libelle « vocabulaire reconnu », jamais « compréhension ».

## 2 bis. Conception du jeu : apprendre sans s'en rendre compte

Chaque mécanique de RPG classique est branchée sur une activité d'apprentissage réelle. Le joueur ne voit pas de « cours » ni de « quiz » ; il voit des donjons, des monstres et du stuff.

| Mécanique de jeu | Activité d'apprentissage derrière |
| --- | --- |
| **Carte du monde à étapes** | Lieux reliés par des chemins, on clique pour s'y rendre. Chaque région = un chapitre du cursus (ex. « Désert des Lettres » = alphabet, « Oasis des Pronoms » = niveau 1). La région suivante s'ouvre quand le boss est vaincu. |
| **Mini-donjon** | Une leçon. Salles de dialogue avec un PNJ (explication de la règle), salles d'entraînement (exercices), mini-boss (contrôle de compréhension). |
| **Boss de région** | L'examen du chapitre : plusieurs phases, questions mélangées (vocabulaire, racines, grammaire). |
| **Combat au tour par tour** | Chaque action = une question. Attaque = vocabulaire ; Sort de racine = trouver la racine (dégâts de zone) ; Bouclier = question de grammaire ; Ultime = reconstruire un mot. Bonne réponse = coup porté, réponse rapide = critique ; erreur = le monstre frappe et un court message explique la bonne réponse. |
| **Monstres « Oubliés »** | Les cartes FSRS arrivées à échéance. La « Faille des Oubliés », donjon quotidien, contient exactement les révisions du jour. La note FSRS est déduite automatiquement de la justesse et du temps de réponse : aucun bouton « facile / difficile ». |
| **Expérience** | Combats gagnés, leçons, mots qui progressent d'état. Rendement décroissant sur les cartes déjà très faciles (anti-farming). |
| **Or (dinars)** | Combats, coffres, quêtes. Achat d'équipement et de consommables. |
| **Pierres de savoir** | Ressource d'enchantement. 1 pierre quand un mot passe à « reconnu », 3 quand il passe à « maîtrisé », 5 par racine maîtrisée. Impossible à farmer. |
| **Encre de scribe** | Leçons et donjons terminés ; débloque de nouvelles compétences de combat (nouveaux types de questions). |
| **Fragments de boss** | Butin de boss ; fabrication de l'équipement légendaire de la région. |
| **Grimoire** | Dictionnaire, bibliothèque de mots et explorateur de racines, présentés comme le livre de connaissances du héros. |
| **Sanctuaire (Bibliothèque du Coran)** | Zone sans aucun combat : lecture des sourates, analyse mot par mot, quêtes d'étude. Les versets n'apparaissent jamais en combat ; noms divins, noms de prophètes et formules sacrées sont exclus des questions de combat. |

**Enchantement de +1 à +15 (valeurs initiales à équilibrer).** Coût : or + pierres de savoir, croissant avec le niveau. Un échec consomme les ressources mais ne fait jamais perdre de niveau ni détruire l'objet. Chaque échec ajoute +5 points au taux suivant ; la pity garantit la réussite après un nombre d'échecs fixe. Les taux sont affichés avant chaque tentative.

| Paliers | Taux de base | Pity (échecs avant réussite garantie) | Bonus de stats | Effet visuel au palier |
| --- | --- | --- | --- | --- |
| +1 à +5 | 95 % → 75 % | 3 | +4 % des stats de l'objet par niveau | +5 : lueur |
| +6 à +10 | 60 % → 40 % | 5 | +6 % par niveau | +10 : aura colorée |
| +11 à +15 | 30 % → 10 % | 8 | +9 % par niveau | +15 : aura légendaire et titre |

**Statistiques du héros.** PV, Attaque, Défense, Critique, Concentration (bonus de temps de réponse). Elles influencent uniquement les combats, jamais les notes FSRS ni les statuts de maîtrise. Chronomètre désactivable.

**Ce qui reste visible.** Le Grimoire montre honnêtement ce qui est appris (mots, racines, % de vocabulaire reconnu par sourate).

## 3. Ressources linguistiques et coraniques

| Ressource | Éditeur | Licence et conditions | Données | Verdict |
| --- | --- | --- | --- | --- |
| [Texte coranique Tanzil](https://tanzil.net/docs/text_license) | Tanzil Project | CC BY 3.0 ; copie verbatim autorisée, modification interdite ; citer Tanzil avec lien | XML, SQL, texte ; uthmani et simple | **Source de référence du texte.** Vérifiée par empreinte à chaque version. |
| [Quranic Arabic Corpus](https://Corpus.Quran.com/faq.jsp) | Université de Leeds (K. Dukes) | Licence GNU ; usage non commercial ; citation obligatoire | Segments, catégorie, racine, lemme, traits | **Utilisable** (app gratuite + attribution). Confirmation écrite des auteurs souhaitable (la FAQ parle d'usage « de recherche »). |
| [QUL — Quranic Universal Library](https://qul.tarteel.ai/resources) | Tarteel AI | Code MIT ; chaque ressource garde les droits de sa source ; conçue pour être intégrée aux apps | Morphologie, 205 traductions, 22 traductions mot par mot, 58 récitations segmentées (horodatage par mot), polices, métadonnées | **Source principale de données complémentaires.** Vérification ressource par ressource. |
| [Traduction Hamidullah (rév. Complexe Roi Fahd, 2000)](https://qul.tarteel.ai/resources/translation/227) | Complexe Roi Fahd (révision) | Aucune licence affichée ; [historique éditorial complexe](https://gloqur.de/quran-translation-of-the-week-07-le-saint-coran-and-its-convoluted-publication-history/) | JSON ou SQLite par verset (QUL) | **Utilisable avec attribution, risque modéré.** Remplaçable sans toucher au reste. |
| Récitations EveryAyah | Équipe quran.com selon [Islamic Network](https://community.islamic.network/d/257-commercial-use-of-quran-audio-text-via-your-cdnapi-educational-app) | Aucune condition publiée ; droits aux récitateurs | MP3 par verset | **Téléchargement à la demande** (packs par sourate), récitateur crédité. Défaut : al-Ḥuṣarī. |
| Audio mot par mot | Dérivé | Lecture du segment du verset via horodatages QUL | Horodatages (QUL) | **Solution retenue.** |
| [API Quran Foundation](https://api-docs.quran.foundation/legal/developer-terms/) | Quran Foundation | Cache limité à 1 semaine, base pré-empaquetée interdite | API REST | **Non retenue** comme source embarquée. |
| Polices KFGQPC Hafs, Amiri, Scheherazade New | Complexe Roi Fahd ; SIL / K. Hosny | KFGQPC : usage gratuit, licence à joindre ; Amiri et Scheherazade : SIL OFL | TTF | **Retenues.** |
| [FSRS (Dart)](https://pub.dev/packages/fsrs) | Open Spaced Repetition | MIT | Package 2.0.1 | **Retenu.** |
| [coran-seul.com](https://coran-seul.com/) | Non identifié | Aucune licence ; orientation « Coran seul » | HTML | **Inspiration fonctionnelle uniquement.** |
| Audio lettres, syllabes, exemples | — | Aucune banque libre de qualité | — | **Reporté** : voix de synthèse après le MVP. |

**Contenus rédigés par IA.** Cours, explications, exercices, sens français mot par mot et significations des racines portent le statut « rédigé par IA — non vérifié ». Racines, lemmes et occurrences viennent toujours du corpus.

**Correction des données.** Bouton « Signaler une erreur » sur chaque fiche ; corrections publiées dans les mises à jour de la base linguistique.

## 4. Architecture technique

Flutter (Dart) + SQLite : une seule base de code pour Android et Windows ; le moteur de rendu (HarfBuzz) gère les ligatures et diacritiques arabes.

**Moteur de jeu 2D : Flame** ([pub.dev/packages/flame](https://pub.dev/packages/flame), MIT). La scène de jeu est dessinée par Flame ; fenêtres de questions, Grimoire et menus restent des widgets Flutter superposés. Graphismes : sprites libres superposables (LPC, CC BY-SA / GPL ; Kenney, CC0), licences vérifiées pack par pack et créditées.

**Deux bases SQLite.**

- `iqura_content.db` (lecture seule, livrée avec l'app) : Coran, traduction, morphologie, racines, lemmes, cours, exercices. Remplacée entièrement à chaque mise à jour de contenu.
- `iqura_user.db` (lecture-écriture) : profil, progression, SRS, listes, RPG, journal des modifications. Seule base sauvegardée et exportée.

**Couches du code** (`lib/`) :

1. `ui/` : écrans et widgets, sans logique métier.
2. `features/` : logique de chaque module.
3. `engines/` : moteurs indépendants testés séparément — révision (FSRS), RPG (XP, quêtes, anti-farming, enchantement), générateur d'exercices (distracteurs vérifiés), synchronisation (export, import, fusion).
4. `data/` : accès aux deux bases, service audio, fichiers.
5. Bus d'événements pédagogiques (`LessonCompleted`, `CardReviewed`, `WordAdded`…) : le RPG écoute sans que la pédagogie dépende de lui.

**Bibliothèques envisagées** (chacune à auditer) : Riverpod, go_router, Drift ou sqlite3, just_audio, record, archive + crypto, fsrs, flame, fl_chart.

**Pipeline de données.** Script Python (`tools/build_content/`) : télécharge les sources, vérifie Tanzil par empreinte, aligne Tanzil et la morphologie mot par mot, génère `iqura_content.db`. Rejouable et documenté ; aucune donnée coranique saisie à la main.

**Compilation.** Session Claude Code cloud (Flutter + SDK Android) et GitHub Actions pour les tests, l'APK et l'exécutable Windows (Windows se compile uniquement sous Windows).

**Hors ligne / en ligne.**

| Fonction | Hors ligne | Internet requis |
| --- | --- | --- |
| Cours, exercices, mini-jeux, révisions, RPG | Oui | Non |
| Coran (texte, traduction, mot par mot, racines, recherche) | Oui | Non |
| Récitation des versets | Après téléchargement du pack | Pour télécharger ou streamer |
| Enregistrement et comparaison de sa voix | Oui | Non |
| Export / import de progression | Oui (fichier) | Non |
| Mises à jour de contenu | Non | Oui |
| Analyse vocale automatique (phase 7) | À déterminer | Probablement |

## 5. Schéma initial de la base de données

Racine, lemme, forme de mot et occurrence ont chacun leur identifiant. Identifiants de contenu déterministes (`ktb`, `1:2:3` = sourate:verset:mot) ; lignes utilisateur en UUID v7.

**Base de contenu (`iqura_content.db`)**

| Table | Clé | Champs principaux | Relations |
| --- | --- | --- | --- |
| `surah` | `id` (1–114) | noms arabe/translittéré/français, lieu de révélation, nb de versets | — |
| `verse` | `surah_id`, `ayah` | texte uthmani, texte simple, juzʾ, hizb, page | → surah |
| `verse_translation` | `verse`, `translation_id` | texte français | → verse, translation |
| `translation` | `id` | auteur, édition, licence, source | — |
| `root` | `id` | lettres arabes, sens généraux, statut de vérification | — |
| `pattern` | `id` | schème, valeur sémantique typique, explication | — |
| `lemma` | `id` | forme arabe, catégorie, sens lexical français, fréquence coranique | → root, pattern |
| `word_form` | `id` | forme vocalisée unique, translittération | → lemma |
| `token` | `id` (`s:a:w`) | position, texte affiché, sens contextuel français, début/fin audio (ms) | → verse, word_form |
| `segment` | `token_id`, `n` | préfixe/radical/suffixe, catégorie, traits | → token |
| `course`, `chapter`, `lesson` | `id` | titre, ordre, niveau, contenu (JSON), prérequis | lesson → chapter → course |
| `lesson_item` | `lesson_id`, `item` | lettre, lemme, racine ou règle enseignée | → lesson |
| `exercise`, `question`, `answer` | `id` | type, consigne, réponses acceptées, explication | → lesson |
| `letter` | `id` | 4 formes, nom, translittération, articulation, illustration | → audio |
| `audio_asset` | `id` | chemin/URL, récitateur/locuteur, durée, licence | — |
| `item_def`, `quest_def`, `skill_node`, `monster_def`, `region`, `map_node` | `id` | équipements, quêtes, compétences, monstres, carte | — |
| `content_meta` | clé | version du contenu, empreintes SHA-256 du texte coranique | — |

**Base utilisateur (`iqura_user.db`)**

| Table | Clé | Champs principaux |
| --- | --- | --- |
| `profile` | UUID | pseudo, avatar, création, test de positionnement |
| `rpg_state` | profile | niveau, monnaies, RPG activé (XP recalculée depuis `xp_ledger`) |
| `xp_ledger` | UUID | source, montant, date, clé d'unicité (anti double comptage) |
| `inventory`, `equipment` | UUID | objet, niveau d'enchantement, compteur de pity, emplacement |
| `quest_progress` | UUID | quête, période, avancement |
| `lesson_progress` | lesson | statut, score, date |
| `srs_card` | UUID | type, cible, stabilité, difficulté, échéance, état, répétitions, oublis |
| `review_log` | UUID | carte, note 1–4, date, durée, activité d'origine |
| `vocab_entry` | UUID | mot ou racine, découverte, note personnelle |
| `user_list`, `user_list_item` | UUID | listes personnelles |
| `game_result` | UUID | jeu, niveau, score, date |
| `bookmark`, `verse_studied` | UUID | signets, versets étudiés |
| `daily_stat` | date | temps d'étude, cartes révisées, XP |
| `error_report` | UUID | fiche, message |
| `change_log` | UUID | table, ligne, opération, HLC, appareil (base de la fusion) |
| `settings`, `backup_meta` | clé | paramètres, versions, sauvegardes |

**Maîtrise des racines.** Une racine a sa propre carte SRS ; jamais déduite de la maîtrise de ses dérivés.

**Fusion.** `review_log` et `xp_ledger` sont en ajout seul : union par UUID puis recalcul de l'état FSRS et de l'XP. Autres tables : la dernière modification (HLC) l'emporte ; suppressions conservées comme marqueurs.

## 6. Structure des écrans

Cinq espaces : barre en bas sur Android, rail latéral sur Windows.

| Espace | Contenu |
| --- | --- |
| **Carte du monde** (accueil) | Régions et lieux, bouton « Continuer », Faille des Oubliés du jour, quêtes |
| **Grimoire** | Dictionnaire, racines et arbre morphologique, bibliothèque et listes personnelles, alphabet |
| **Sanctuaire** | Sourates / juzʾ → lecteur (texte, traduction, audio, % de vocabulaire reconnu) → fiche mot ; recherche ; signets |
| **Héros** | Avatar et équipement, inventaire, forge (enchantement), boutique, quêtes, succès, statistiques |
| **Paramètres** | Affichage, SRS, mode « apprentissage seul », sauvegarde, export/import, sources et licences |

**Fiche mot.** Blocs séparés « Sens dans ce verset » et « Sens général du lemme », puis catégorie, racine, schème, segments, audio, occurrences, mots apparentés, « Ajouter à mon vocabulaire », « Étudier cette racine ».

**Confort.** Taille de police arabe réglable, translittération masquable, animations désactivables, modes clair et sombre, raccourcis clavier sur Windows.

## 7. Principaux risques techniques

| Risque | Gravité | Parade |
| --- | --- | --- |
| Texte coranique altéré | Critique | Jamais édité à la main ; SHA-256 de chaque verset comparé à Tanzil dans les tests et au démarrage |
| Décalage segmentation morphologique / mots Tanzil | Élevée | Alignement automatisé, rapport des écarts, test : 100 % alignés ou signalés |
| Affichage arabe (diacritiques, signes coraniques) | Élevée | Polices dédiées, tests visuels ; jeu « Reconstruction » fondé sur les graphèmes |
| Distracteurs aussi corrects | Élevée | Exclusion même lemme / même forme sans voyelles / traduction proche ; tests sur tout le corpus |
| Perte de progression à l'import ou à la fusion | Critique | Sauvegarde avant import, transactions, journaux en ajout seul, tests multi-appareils |
| Archives malveillantes | Moyenne | Taille décompressée plafonnée, liste blanche, chemins normalisés, schéma JSON validé |
| Droits flous (Hamidullah, récitations) | Moyenne | Attribution, écran « Sources et licences », éléments interchangeables |
| Contenu IA non relu (aucun relecteur) | Élevée | Statut visible ; données linguistiques uniquement issues de sources citées |
| Volume du projet | Élevée | Phases closes par critères d'acceptation testés ; aucun bouton sans fonction |

## 8. Phases et dépendances

1. **Socle technique** : architecture, interface principale, bases SQLite, profil, sauvegardes, export/import, premières compilations APK et Windows. *MVP : phase complète.*
2. **Académie de l'arabe** (dépend de 1) : alphabet, leçons, exercices, audio, prérequis. *MVP : alphabet + environ 10 leçons du niveau 1.*
3. **Arabe coranique** (dépend de 1, en parallèle de 2) : pipeline du corpus, lecteur, mot par mot, racines. *MVP : 114 sourates, sens FR du juzʾ ʿAmma.*
4. **Mémorisation** (dépend de 2 et 3) : FSRS, bibliothèque, listes, statistiques. *MVP : tout sauf recommandations avancées.*
5. **Mini-jeux** (dépend de 4). *MVP : jeux A, B, D, E, F.*
6. **RPG** (dépend de 4). *MVP : carte, combats, donjons, boss, enchantement +15.*
7. **Améliorations avancées** : analyse vocale, contenus avancés, accessibilité, tests complets, distribution finale.

Chaque phase se termine par une compilation testée et ses critères d'acceptation cochés.

## 9. Définition du MVP (version 0.1)

Un débutant apprend l'alphabet, lit et comprend une part mesurable d'Al-Fātiḥa et du juzʾ ʿAmma, révise avec FSRS et transfère sa progression du PC au téléphone. Critères d'acceptation 1 à 12, 14 et 15 du cahier des charges.

**Inclus**

- **Socle** : APK et exécutable Windows compilés et testés ; profil ; clair/sombre ; réglages police et translittération ; export, import (restauration complète et fusion) avec sauvegarde automatique avant import.
- **Alphabet** : 28 lettres et la hamza, 4 formes, nom, translittération, point d'articulation, 3 exemples par lettre, schémas d'articulation ; voyelles courtes et longues, sukūn, shadda, tanwīn, alif lam ; reconnaissance visuelle (et auditive quand l'audio sera disponible).
- **Niveau 1 (début)** : environ 10 leçons (lecture de mots vocalisés, pronoms personnels, démonstratifs, genre, article défini et indéfinition).
- **Coran** : 114 sourates (6 236 versets), texte Tanzil, traduction française, navigation sourate / juzʾ, recherche par mot et racine, signets ; analyse mot par mot pour tout le Coran ; sens contextuel français pour Al-Fātiḥa et le juzʾ ʿAmma ; audio verset et mot (un récitateur, par packs) ; % de vocabulaire reconnu.
- **Racines** : toutes les racines coraniques (environ 1 600) avec lemmes et occurrences ; arbre morphologique ; significations françaises pour les 100 racines les plus fréquentes.
- **Mémorisation** : FSRS, révision du jour, 5 états de mot, bibliothèque et listes personnelles.
- **Mini-jeux** : A Reconstruction, B Arabe → français, D Quiz sur une liste, E Reconnaissance audio, F Association.
- **Labo de prononciation (base)** : écouter, s'enregistrer, réécouter, comparer, recommencer ; sans score.
- **Jeu RPG 2D** : carte à 2 régions (alphabet, niveau 1) + Sanctuaire ; combats au tour par tour ; 5 à 8 types de monstres ; mini-donjons, un boss par région, Faille des Oubliés ; XP, or, pierres de savoir, encre ; boutique, inventaire, équipement visible ; enchantement +1 à +15 avec pity ; quêtes quotidiennes et hebdomadaires ; mode « apprentissage seul ».
- **Statistiques** : calendrier d'activité, mots et racines par état, temps d'étude.
- **Documentation** : installation, sauvegarde et restauration, format d'export, sources et licences.

**Exclus du MVP** : niveaux 2 à 4, test de positionnement complet, jeu C et jeux supplémentaires, arbre de compétences, régions au-delà du niveau 1, analyse vocale, audio hors Coran (voix de synthèse), sens contextuels au-delà du juzʾ ʿAmma.

## 10. Décisions validées

| N° | Sujet | Décision |
| --- | --- | --- |
| 1 | Licence | Open source GPL-3.0 ; chaque dépendance auditée et listée ; tout point douteux signalé |
| 2 | Audio hors Coran | Reporté : voix de synthèse après le MVP ; emplacements prévus dès le départ |
| 3 | Relecture | Aucun relecteur : données linguistiques uniquement sourcées ; texte IA marqué « non vérifié » |
| 4 | Compilation | Claude Code cloud + GitHub Actions (dépôt public `The-Ashams/iqura`) |
| 5 | Place du RPG | Vrai RPG 2D dès le MVP |
| 6 | Récitateur par défaut | al-Ḥuṣarī |
| 7 | Traduction | Hamidullah révisée (2000), créditée, remplaçable |
| 8 | Translittération | Savante par défaut, simplifiée au choix |
| 9 | Style de l'avatar | Illustré plat / sprites libres, sans figures sacrées |
| 10 | Carte du monde | Carte à étapes (nœuds cliquables) |

## 11. Choix techniques de la phase 1

Précisions et écarts par rapport aux sections précédentes, décidés en
construisant le socle (octobre 2026).

| Sujet | Choix | Raison |
| --- | --- | --- |
| Accès SQLite | Paquet `sqlite3` (3.x) directement, sans Drift | Moins de dépendances, pas de génération de code ; SQLite est embarqué par le paquet sur Android et Windows. Drift reste possible plus tard. |
| Navigation | Pile Flutter standard, sans go_router | Cinq espaces fixes ; go_router sera réévalué si besoin. |
| État | Riverpod 3 | Prévu au §4. |
| Profil | Une seule ligne d'identifiant fixe `main` (au lieu d'un UUID) | Sinon chaque appareil créerait son propre profil et la fusion en produirait deux. |
| Journal `change_log` | Remplacé par deux colonnes sur chaque table modifiable : `updated_hlc` et `deleted` | Même information pour la règle « la dernière modification l'emporte », sans table à maintenir en parallèle. |
| Tables utilisateur créées | `profile`, `settings`, `review_log`, `xp_ledger`, `local_meta` | Les autres tables du §5 seront ajoutées par migration dans leur phase. `review_log` et `xp_ledger` existent déjà pour tester la fusion des journaux. |
| Migrations | `PRAGMA user_version` + liste de migrations figées | Une migration publiée ne se modifie jamais ; un test vérifie que la base obtenue correspond au schéma déclaré. |
| Archives d'une version antérieure | À traiter au premier changement de schéma | Le format 1 ne connaît que le schéma 1 ; une archive plus récente que l'application est refusée. |
| Base de contenu | Générée par `tools/build_content/build_content.py`, non versionnée dans Git, copiée au démarrage si sa version change | En phase 1 elle ne contient que `content_meta`. |
| Sélection de fichiers | `file_picker` (enregistrer / ouvrir) | Fonctionne sur Android (sélecteur système, aucune permission) et Windows. |
| Identifiant de l'application | `io.github.theashams.iqura` | Lié au compte GitHub du projet plutôt qu'à un nom de domaine non détenu. Ne plus le changer après la première diffusion (sinon Android le voit comme une autre application). |
| Signature | APK signé avec la clé de débogage, exécutable Windows non signé | Une clé de publication (secret GitHub) sera nécessaire avant toute diffusion publique. |
| Compilation | GitHub Actions sans action tierce ; Flutter téléchargé depuis l'archive officielle et vérifié par SHA-256 | Limiter la chaîne d'approvisionnement. |
