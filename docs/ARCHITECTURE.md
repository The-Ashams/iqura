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

**Orientation du MVP (décision du 20 octobre 2026).** La priorité est l'apprentissage de la **langue arabe elle-même**, plus précisément l'arabe littéraire tel qu'il est employé dans le Coran : lire, comprendre la grammaire de base, conjuguer, reconnaître les racines et acquérir le vocabulaire le plus fréquent. Le Coran sert de **référence et de source d'exemples authentiques**, et les fréquences du Quranic Arabic Corpus guident le choix du vocabulaire. Le **lecteur coranique complet** (114 sourates, analyse mot par mot de chaque verset, audio des versets, % de vocabulaire reconnu par sourate) est **reporté après le MVP**. La base de contenu coranique déjà construite (§12) sert dès maintenant aux exemples, aux fréquences et aux racines.

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

Chaque mécanique de RPG classique est branchée sur une activité d'apprentissage réelle. Le joueur ne voit pas de « cours » ni de « quiz » ; il voit des donjons, des monstres et du stuff. Les monstres incarnent les obstacles de l'apprentissage, jamais ce qu'on apprend : la règle ci-dessous prime sur toutes les mécaniques de cette section.

### Respect du Coran dans le jeu (règle absolue)

Cette règle prime sur toute autre mécanique de jeu. Elle s'applique au code, aux données, aux visuels, aux animations, aux sons et aux textes.

#### Principe

- **Le Coran est la connaissance étudiée, jamais l'ennemi combattu.**
- **Tout ce qui vient du Coran** (versets, mots, racines, lemmes) **est objet d'étude, jamais cible de combat.**
- Un monstre représente une **difficulté de mémorisation** (l'Oubli, la Confusion, la Distraction…), **jamais un mot**.
- Pour le vaincre, le joueur **retrouve une connaissance** : par exemple le sens de « رَحْمَة », miséricorde.
- **Aucun mot coranique** n'est affiché sur un monstre, frappé, détruit ou « tué » : ni dans les visuels, ni dans les animations, ni dans les textes.
- Le mot apparaît **uniquement dans un panneau de question séparé et neutre**.
- Les **versets n'apparaissent jamais en combat**.
- Noms divins, noms de prophètes et formules sacrées sont **exclus des questions de combat**.
- Le Coran se lit et s'étudie dans le Sanctuaire, zone sans combat.

#### Exigences pour le code (phase 6 et suivantes)

| Élément | Exigence |
| --- | --- |
| Données des monstres (`monster_def`) | Décrivent une difficulté (nom, apparence, comportement). Aucun champ ne référence un mot, un lemme, une racine, un verset ou une carte FSRS. |
| Lien question ↔ combat | La question est produite par le générateur d'exercices et passée au **panneau de question**, jamais au monstre ni à la scène Flame. Le moteur de combat ne reçoit que le résultat (juste/faux, temps de réponse). |
| Scène de jeu (Flame) | Ne dessine jamais de texte arabe issu du contenu. Les sprites, effets de coup, de dégâts et de disparition ne portent sur aucun mot. |
| Panneau de question | Widget Flutter distinct, posé au-dessus de la scène, au style neutre (pas d'effet de coup, de flammes, de tremblement ni de disparition sur le mot). Il affiche la question, les réponses et l'explication après une erreur. |
| Textes et animations | Les verbes de combat (frapper, détruire, vaincre, « tuer »…) ne s'appliquent qu'aux difficultés, jamais à un mot. On écrit « Vous avez vaincu la Confusion », jamais « Vous avez détruit رَحْمَة ». |
| Questions de combat | Jamais de verset ni d'extrait de verset. Les mots exclus (noms divins, noms de prophètes, formules sacrées) sont filtrés par le générateur **avant** toute question de combat. En cas de doute sur un mot, il est exclu. |
| Liste d'exclusion | Issue de sources citées (étiquettes du corpus, par exemple les noms propres, et listes publiées), jamais inventée ; sa provenance est documentée. Les mots exclus restent étudiables au Sanctuaire et dans le Grimoire, hors combat. |
| Tests | Tests automatiques obligatoires : aucune question de combat ne contient un mot exclu ni un verset ; le modèle de monstre n'a aucun champ lié au contenu ; la scène de combat ne reçoit jamais le texte d'une question. |

### Mécaniques de jeu


| Mécanique de jeu | Activité d'apprentissage derrière |
| --- | --- |
| **Carte du monde à étapes** | Lieux reliés par des chemins, on clique pour s'y rendre. Chaque région = un chapitre du cursus (ex. « Désert des Lettres » = alphabet, « Oasis des Pronoms » = niveau 1). La région suivante s'ouvre quand le boss est vaincu. |
| **Mini-donjon** | Une leçon. Salles de dialogue avec un PNJ (explication de la règle), salles d'entraînement (exercices), mini-boss (contrôle de compréhension). |
| **Boss de région** | L'examen du chapitre, incarné par une grande difficulté (ex. « le Grand Oubli ») : plusieurs phases, questions mélangées (vocabulaire, racines, grammaire). |
| **Combat au tour par tour** | Chaque action = retrouver une connaissance, posée dans un panneau de question séparé et neutre. Attaque = sens d'un mot ; Sort de racine = retrouver la racine (effet de zone) ; Bouclier = question de grammaire ; Ultime = reconstruire un mot. Bonne réponse = le héros affaiblit la difficulté (l'oubli, la confusion…), réponse rapide = critique ; erreur = la difficulté riposte et le panneau explique la bonne réponse. Le mot n'est jamais la cible : il reste dans le panneau. |
| **Monstres** | Des difficultés de mémorisation personnifiées : l'Oubli, la Confusion, la Distraction… Jamais un mot. La « Faille des Oubliés », donjon quotidien, propose exactement les révisions FSRS du jour : chaque carte à réviser devient une question posée par l'Oubli, pas un monstre. La note FSRS est déduite automatiquement de la justesse et du temps de réponse : aucun bouton « facile / difficile ». |
| **Expérience** | Combats gagnés, leçons, mots qui progressent d'état. Rendement décroissant sur les cartes déjà très faciles (anti-farming). |
| **Or (dinars)** | Combats, coffres, quêtes. Achat d'équipement et de consommables. |
| **Pierres de savoir** | Ressource d'enchantement. 1 pierre quand un mot passe à « reconnu », 3 quand il passe à « maîtrisé », 5 par racine maîtrisée. Impossible à farmer. |
| **Encre de scribe** | Leçons et donjons terminés ; débloque de nouvelles compétences de combat (nouveaux types de questions). |
| **Fragments de boss** | Butin de boss ; fabrication de l'équipement légendaire de la région. |
| **Grimoire** | Dictionnaire, bibliothèque de mots et explorateur de racines, présentés comme le livre de connaissances du héros. |
| **Sanctuaire (Bibliothèque du Coran)** | Zone sans aucun combat : lecture des sourates, analyse mot par mot, quêtes d'étude. Les versets n'apparaissent jamais en combat ; noms divins, noms de prophètes et formules sacrées sont exclus des questions de combat (§2 bis, respect du Coran). |

**Enchantement de +1 à +15 (valeurs initiales à équilibrer).** Coût : or + pierres de savoir, croissant avec le niveau. Un échec consomme les ressources mais ne fait jamais perdre de niveau ni détruire l'objet. Chaque échec ajoute +5 points au taux suivant ; la pity garantit la réussite après un nombre d'échecs fixe. Les taux sont affichés avant chaque tentative.

| Paliers | Taux de base | Pity (échecs avant réussite garantie) | Bonus de stats | Effet visuel au palier |
| --- | --- | --- | --- | --- |
| +1 à +5 | 95 % → 75 % | 3 | +4 % des stats de l'objet par niveau | +5 : lueur |
| +6 à +10 | 60 % → 40 % | 5 | +6 % par niveau | +10 : aura colorée |
| +11 à +15 | 30 % → 10 % | 8 | +9 % par niveau | +15 : aura légendaire et titre |

**Statistiques du héros.** PV, Attaque, Défense, Critique, Concentration (bonus de temps de réponse). Elles influencent uniquement les combats, jamais les notes FSRS ni les statuts de maîtrise. Chronomètre désactivable.

**Ce qui reste visible.** Le Grimoire montre honnêtement ce qui est appris (mots, racines, % de vocabulaire reconnu par sourate).

## 2 ter. Apprentissage des racines (priorité majeure)

**Objectif.** Reconnaître les liens entre les mots d'une même famille **sans supposer qu'ils ont tous le même sens**. Connaître une racine aide à repérer et à retenir les mots ; elle ne permet pas de deviner le sens précis de chaque dérivé.

### Fiche racine

Exemple à partir de رَحْمَةٌ (miséricorde) :

- **Racine** ر ح م (r-ḥ-m) et son ou ses sens généraux.
- **Mots de la famille** : رَحِيمٌ (Miséricordieux), رَحْمَٰنُ (Tout Miséricordieux), رَحِمَ (faire miséricorde)…
- **Relation de sens** : une étiquette par dérivé, parmi *proche*, *intensif*, *spécialisé*, *figuré* et *éloigné*.
- **Nuances** entre mots proches (ex. رَحْمَٰن et رَحِيم), avec les sources citées et le statut « rédigé par IA — non vérifié » quand c'est le cas.
- **Occurrences** : nombre d'occurrences coraniques par mot, avec accès aux versets (dans le Sanctuaire, hors combat).

### Arbre des racines interactif

Chemin de lecture : racine → formes verbales attestées (I à X, plus les rares XI et XII du Corpus) → noms dérivés regroupés par type → sens de chaque mot → occurrences coraniques. Chaque nœud est cliquable.

Les noms dérivés sont regroupés en participes, noms d'action, noms de lieu, intensifs, etc.

**Provenance de chaque élément.**

| Élément | Provenance |
| --- | --- |
| Racine, lemmes, catégorie grammaticale | Quranic Arabic Corpus |
| Forme verbale (I à XII) | Quranic Arabic Corpus. Un verbe sans marque est de forme I : convention du Corpus, qui l'affiche « Verb (form I) » dans son dictionnaire. |
| Participe actif, participe passif, nom d'action | Quranic Arabic Corpus (traits `ACT PCPL`, `PASS PCPL`, `VN`) |
| Schème (wazn), nom de lieu, intensif | **Aucune source ouverte identifiée** : le Corpus 0.4 ne les fournit pas. Rien n'est inventé ; ces groupes restent vides tant qu'une source citée ou une méthode vérifiable n'est pas validée. |
| Occurrences | Calculées depuis le Corpus aligné sur Tanzil |
| Sens français, étiquette de relation, nuances | Rédigés (IA), toujours marqués « rédigé par IA — non vérifié » |

### Avertissement pédagogique

Une **leçon dédiée** et un **encart sur chaque fiche de racine** rappellent, exemples à l'appui, que la racine ne suffit pas à déduire le sens exact d'un dérivé.

### Exercices sur les racines

| Exercice | Principe | Arrivée |
| --- | --- | --- |
| Détective des racines | Trouver la racine d'un mot | MVP |
| Famille de mots | Regrouper des mots par racine | MVP |
| L'intrus | Repérer le mot hors de la famille, y compris les faux amis aux lettres proches | MVP |
| Relation de sens | Dire si un dérivé a un sens proche, spécialisé ou éloigné | Phase 5 |
| Deviner puis vérifier | Proposer un sens à partir de la racine et du schème, puis comparer avec le vrai sens | Phase 5 |
| Forge des mots | Construire un dérivé à partir d'une racine et d'un schème | Phase 5 |

Les exercices qui demandent le schème (Deviner puis vérifier, Forge des mots) dépendent de la source de schèmes encore manquante.

En combat, ces exercices respectent la règle du §2 bis :
- le mot n'apparaît que dans le panneau de question ;
- noms divins, noms de prophètes et formules sacrées sont exclus ;
- رَحْمَٰن et رَحِيم, noms divins dans la basmala, ne servent donc jamais de question de combat ; ils s'étudient sur la fiche de leur racine.

### Maîtrise

Chaque racine a sa propre carte de révision FSRS, indépendante de ses dérivés : la maîtrise d'une racine n'est jamais déduite de celle de ses mots, ni l'inverse.

### Données nécessaires (pipeline coranique)

Pour chaque lemme, la base de contenu conserve :
- la racine ;
- la forme verbale (I à XII) ;
- le type de dérivé (participe actif, participe passif, nom d'action) ;
- le schème (colonne prévue, vide faute de source) ;
- la catégorie grammaticale principale et toutes celles attestées.

Les tables rédigées (sens des racines, étiquettes de relation, nuances) portent un statut de vérification et une source.

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
| `root_note` | `root_id`, `n` | encart, nuance ou exemple rédigé, statut, source | → root |
| `pattern` | `id` | schème, valeur sémantique typique, explication | — |
| `lemma` | `id` | forme arabe, catégorie principale et catégories attestées, forme verbale (I–XII), type de dérivé (participe actif / passif, nom d'action), schème, sens lexical français, relation de sens à la racine (proche, intensif, spécialisé, figuré, éloigné) avec statut, fréquence coranique | → root, pattern |
| `word_form` | `id` | forme vocalisée unique, translittération | → lemma |
| `token` | `id` (`s:a:w`) | position, texte affiché, sens contextuel français, début/fin audio (ms) | → verse, word_form |
| `segment` | `token_id`, `n` | préfixe/radical/suffixe, catégorie, traits | → token |
| `course`, `chapter`, `lesson` | `id` | titre, ordre, niveau, contenu (JSON), prérequis | lesson → chapter → course |
| `lesson_item` | `lesson_id`, `item` | lettre, lemme, racine ou règle enseignée | → lesson |
| `exercise`, `question`, `answer` | `id` | type, consigne, réponses acceptées, explication | → lesson |
| `letter` | `id` | 4 formes, nom, translittération, articulation, illustration | → audio |
| `audio_asset` | `id` | chemin/URL, récitateur/locuteur, durée, licence | — |
| `item_def`, `quest_def`, `skill_node`, `monster_def`, `region`, `map_node` | `id` | équipements, quêtes, compétences, monstres (difficultés de mémorisation, sans aucun champ de mot : §2 bis), carte | — |
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
| Mot coranique traité comme un ennemi (visuel, animation, texte) | Critique | Règle du §2 bis : monstres sans champ de contenu, panneau de question séparé, tests automatiques |
| Sens d'un dérivé déduit à tort de sa racine | Élevée | Avertissement sur chaque fiche et leçon dédiée ; étiquette de relation de sens ; sens toujours propres au mot |
| Contenu IA non relu (aucun relecteur) | Élevée | Statut visible ; données linguistiques uniquement issues de sources citées |
| Volume du projet | Élevée | Phases closes par critères d'acceptation testés ; aucun bouton sans fonction |

## 8. Phases et dépendances

1. **Socle technique** : architecture, interface principale, bases SQLite, profil, sauvegardes, export/import, premières compilations APK et Windows. *Terminé.*
2. **Académie de l'arabe** (dépend de 1) : parcours en cinq étapes (Lire, Bases de la grammaire, Verbes, Racines et schèmes, Vocabulaire), leçons, exemples, exercices, prérequis entre leçons. *MVP : les cinq étapes (voir §9).*
3. **Données coraniques** (dépend de 1, en parallèle de 2) : pipeline du corpus (fait, §12), fréquences des lemmes, racines, extraits cités dans les leçons. *MVP : données et extraits ; le lecteur complet est reporté (phase 8).*
4. **Mémorisation** (dépend de 2) : FSRS sur les lettres, règles, mots et racines du parcours ; bibliothèque, listes, statistiques. *MVP : tout sauf recommandations avancées.*
5. **Mini-jeux** (dépend de 4). *MVP : voir §9.*
6. **RPG** (dépend de 4) : une région par étape du parcours. *MVP : carte, combats, donjons, boss, enchantement +15.*
7. **Améliorations avancées** : analyse vocale, voix de synthèse hors Coran, contenus avancés, accessibilité, tests complets, distribution finale.
8. **Lecteur coranique complet** (après le MVP) : 114 sourates, analyse mot par mot de chaque verset, audio des versets et des mots, % de vocabulaire reconnu par sourate, recherche, signets.

Chaque phase se termine par une compilation testée et ses critères d'acceptation cochés.

## 9. Définition du MVP (version 0.1)

Un débutant apprend à **lire** un mot entièrement vocalisé, acquiert les **bases de la grammaire** et de la **conjugaison**, **reconnaît les racines** et retient le **vocabulaire le plus fréquent du Coran**. Il révise avec FSRS, joue au RPG et transfère sa progression du PC au téléphone.

### Parcours (une région du RPG par étape)

| Étape | Contenu | Objectif |
| --- | --- | --- |
| 1. **Lire** | Alphabet : 28 lettres et la hamza, 4 formes, nom, prononciation, point d'articulation, exemples. Voyelles courtes et longues, sukūn, shadda, tanwīn, article « al ». | Lire un mot entièrement vocalisé. |
| 2. **Bases de la grammaire** | Nom / verbe / particule ; pronoms personnels et démonstratifs ; genre ; nombre (singulier, duel, pluriel) ; défini / indéfini ; phrase nominale ; prépositions ; iḍāfa. | Comprendre la structure d'une phrase simple. |
| 3. **Verbes** | Passé (accompli), inaccompli, impératif ; conjugaison des verbes réguliers. | Reconnaître et conjuguer un verbe régulier. |
| 4. **Racines et schèmes** | §2 ter : arbre des racines, étiquettes de relation de sens, leçon d'avertissement, exercices Détective des racines, Famille de mots, L'intrus. | Relier les mots d'une même famille sans en déduire le sens. |
| 5. **Vocabulaire** | Lemmes les plus fréquents du Coran, avec fréquence, racine, catégorie (et schème quand une source le permet). | Reconnaître les mots qui couvrent la plus grande part du texte. |

**Données du vocabulaire.**
- Fréquences, racines et catégories : calculées à partir du Quranic Arabic Corpus, source citée, rien d'inventé.
- Schèmes : seulement quand une source ouverte vérifiée existe (aucune trouvée à ce jour, §2 ter).
- Sens français : rédigés et marqués « rédigé par IA — non vérifié ».

### Exemples dans les leçons

Chaque leçon mélange deux sortes d'exemples, et chaque exemple affiche sa source.

| Sorte | Rôle | Règles |
| --- | --- | --- |
| **Phrase ou mot construit** | Découvrir une règle sur un cas simple. | Entièrement vocalisé, marqué « rédigé par IA — non vérifié ». |
| **Court extrait coranique** | Illustrer la règle en contexte authentique. | Texte Tanzil sans modification, vérifié par SHA-256, traduction Hamidullah, référence sourate:verset. |

Pour les extraits coraniques :
- Le contenu des leçons ne contient **jamais** le texte d'un extrait : il ne stocke qu'une **référence** (verset, ou plage de mots `sourate:verset:mot`).
- Le texte est lu dans la base de contenu, dont l'empreinte est vérifiée au démarrage.
- Un test vérifie que toutes les références existent.

Les extraits n'apparaissent que dans les salles d'étude des mini-donjons, dans le Grimoire et dans le Sanctuaire, **jamais en combat** (§2 bis).

### Inclus

- **Socle** : APK et exécutable Windows compilés et testés ; profil ; clair/sombre ; réglages police et translittération ; export, import (restauration complète et fusion) avec sauvegarde automatique avant import. *Fait.*
- **Parcours en cinq étapes** (ci-dessus), avec prérequis entre leçons.
- **Racines (§2 ter)** :
  - toutes les racines coraniques (1 642) avec lemmes et occurrences ;
  - arbre complet pour toutes les racines ;
  - fiches enrichies pour les 100 racines les plus fréquentes ;
  - leçon d'avertissement ;
  - exercices Détective des racines, Famille de mots et L'intrus ;
  - une carte de révision par racine.
- **Mémorisation** : FSRS sur les lettres, règles, mots et racines du parcours ; révision du jour ; 5 états de mot ; bibliothèque et listes personnelles.
- **Mini-jeux** : A Reconstruction, B Arabe → français, D Quiz sur une liste, F Association. Le jeu E (reconnaissance audio) attend l'audio.
- **Sanctuaire minimal** : consultation des extraits cités dans les leçons (texte Tanzil, traduction, référence), zone sans combat.
- **Jeu RPG 2D** :
  - carte à 5 régions, une par étape du parcours, et le Sanctuaire ;
  - combats au tour par tour ;
  - 5 à 8 types de monstres (difficultés de mémorisation, §2 bis) ;
  - mini-donjons, un boss par région, Faille des Oubliés ;
  - XP, or, pierres de savoir, encre ;
  - boutique, inventaire, équipement visible ;
  - enchantement +1 à +15 avec pity ;
  - quêtes quotidiennes et hebdomadaires ;
  - mode « apprentissage seul ».
- **Statistiques** : calendrier d'activité, mots et racines par état, temps d'étude.
- **Documentation** : installation, sauvegarde et restauration, format d'export, sources et licences.

### Exclus du MVP

- **Lecteur coranique complet** (phase 8) : 114 sourates, analyse mot par mot de chaque verset, audio des versets et des mots, % de vocabulaire reconnu par sourate, navigation sourate / juzʾ, recherche, signets.
- **Audio** : audio hors Coran (voix de synthèse, phase 7), donc pas d'écoute des lettres ni de jeu E ; labo de prononciation.
- **Racines et contenus** : exercices de racines Relation de sens, Deviner puis vérifier et Forge des mots (phase 5) ; niveaux au-delà du parcours ; sens contextuels mot par mot des versets.
- **Divers** : test de positionnement complet, jeu C et jeux supplémentaires, arbre de compétences, analyse vocale.

## 10. Décisions validées

| N° | Sujet | Décision |
| --- | --- | --- |
| 1 | Licence | Open source GPL-3.0 ; chaque dépendance auditée et listée ; tout point douteux signalé |
| 2 | Audio hors Coran | Reporté : voix de synthèse après le MVP ; emplacements prévus dès le départ |
| 3 | Relecture | Aucun relecteur : données linguistiques uniquement sourcées ; texte IA marqué « non vérifié » |
| 4 | Compilation | Claude Code cloud + GitHub Actions (dépôt public `The-Ashams/iqura`) |
| 5 | Place du RPG | Vrai RPG 2D dès le MVP |
| 6 | Récitateur par défaut | al-Ḥuṣarī |
| 7 | Traduction | Hamidullah (diffusion Tanzil, usage non commercial ; l'édition révisée de 2000 n'est pas confirmée), créditée, remplaçable |
| 8 | Translittération | Savante par défaut, simplifiée au choix |
| 9 | Style de l'avatar | Illustré plat / sprites libres, sans figures sacrées |
| 10 | Carte du monde | Carte à étapes (nœuds cliquables) |
| 11 | Respect du Coran dans le jeu | Le Coran est la connaissance étudiée, jamais l'ennemi : monstres = difficultés de mémorisation, mot seulement dans un panneau de question neutre, ni versets ni noms sacrés en combat (§2 bis) |
| 12 | Racines | Priorité majeure : fiches, arbre interactif, avertissement « la racine ne suffit pas », exercices, carte de révision par racine (§2 ter) |

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
| Base de contenu | Générée par `tools/build_content/build_content.py`, non versionnée dans Git (ses sources le sont), copiée au démarrage si sa version change | Voir §12. |
| Sélection de fichiers | `file_picker` (enregistrer / ouvrir) | Fonctionne sur Android (sélecteur système, aucune permission) et Windows. |
| Identifiant de l'application | `io.github.theashams.iqura` | Lié au compte GitHub du projet plutôt qu'à un nom de domaine non détenu. Ne plus le changer après la première diffusion (sinon Android le voit comme une autre application). |
| Signature | APK signé avec la clé de débogage, exécutable Windows non signé | Une clé de publication (secret GitHub) sera nécessaire avant toute diffusion publique. |
| Compilation | GitHub Actions sans action tierce ; Flutter téléchargé depuis l'archive officielle et vérifié par SHA-256 | Limiter la chaîne d'approvisionnement. |

## 12. Pipeline de contenu coranique (phase 3)

`tools/build_content/build_content.py` produit `iqura_content.db` (schéma 3) à partir des fichiers de `tools/build_content/sources/`, versionnés dans Git et vérifiés par SHA-256 avant toute lecture. Python 3 seul, sans dépendance.

**Sources retenues.**

- **Texte** : Tanzil Uthmani 1.1, format XML (la basmala y est séparée du verset 1, alors que le format texte la colle au verset). Options de téléchargement figées : celles par défaut du site (signes de pause, signe de prosternation, alif suscrit, tatwîl ; sans rub el-hizb), car elles changent le texte.
- **Recherche** : Tanzil « simple-clean » (sans voyelles), téléchargé tel quel plutôt que calculé.
- **Traduction** : Hamidullah via Tanzil (usage non commercial). La version de QUL demande un compte.
- **Morphologie** : Quranic Arabic Corpus 0.4. Le téléchargement exige une adresse e-mail ; celle du porteur du projet a été utilisée avec son accord.

**Intégrité du texte.**

- L'empreinte est le SHA-256 des lignes `sourate|0|basmala` puis `sourate|verset|texte`.
- Elle est vérifiée trois fois :
  - par les tests Python, contre une valeur figée ;
  - par les tests Dart ;
  - à chaque démarrage de l'application, contre une constante de `lib/data/content_db/quran_integrity.dart`.
- Si la copie locale de la base est altérée, elle est recopiée une fois depuis l'application ; si le contrôle échoue encore, l'application refuse de démarrer.

**Mots et segments.**

- Un *mot* (`token`, identifiant `sourate:verset:position`) est un mot du texte Tanzil, découpé sur les espaces, sans les signes de pause isolés : c'est une sous-chaîne exacte du verset.
- Un *segment* (identifiant = emplacement dans le Corpus `s:v:mot:segment`) est un préfixe, un radical ou un suffixe du Corpus, avec son étiquette, ses traits bruts, son lemme et sa racine.
- `token_segment` relie les deux.

**Alignement Tanzil ↔ Corpus.**

- Les deux sources ne découpent pas toujours les mots de la même façon. Par exemple, « بَعْدَ مَا » fait deux mots chez Tanzil et un seul dans le Corpus ; « إِلْ يَاسِينَ » est un seul segment du Corpus.
- Elles n'écrivent pas toujours les supports de hamza de la même façon.
- L'alignement compare donc un squelette de lettres :
  - supports de hamza ramenés à la lettre de base, hamza isolée et tatwîl ignorées ;
  - « ى + alif suscrit » équivalent à l'alif suscrit seul.
- Ce squelette sert uniquement à comparer : aucun texte n'est modifié.
- Résultat : **100 % des 6 236 versets alignés**. Seuls 4 versets ont un nombre de mots différent entre les deux sources (2:181, 8:6, 13:37, 37:130) ; ils sont listés dans `content_meta` et testés.

**Contenu de la base (schéma 3).**

| Table | Contenu |
| --- | --- |
| `source` | Sources citées : titre, attribution, licence, lien, empreinte |
| `surah` | 114 sourates : nom arabe, translittéré et anglais (Tanzil), lieu et ordre de révélation, basmala |
| `verse` | 6 236 versets : texte Uthmani, texte de recherche, juzʾ, quart de hizb, page, prosternation |
| `translation`, `verse_translation` | Traduction Hamidullah |
| `root` | 1 642 racines (forme Buckwalter et arabe, nombre de segments) |
| `lemma` | 4 832 lemmes : forme arabe (sans le chiffre de désambiguïsation du Corpus), racine, catégorie principale et catégories attestées, forme verbale (I à XII), type de dérivé (participe actif / passif, nom d'action), schème (vide : pas de source), nombre de segments |
| `token`, `segment`, `token_segment` | 77 433 mots Tanzil, 128 219 segments du Corpus et leurs liens |

**Particularité du Corpus.** Certains lemmes gardent la shadda de l'article assimilé (ex. `r~aHiym` → رَّحِيم). La donnée est conservée telle quelle ; l'affichage d'un lemme sous sa forme de dictionnaire sera traité à l'écran, avec une règle documentée et testée.

**Pas encore fait.**

- Noms français des sourates : aucune source ouverte trouvée pour l'instant, donc rien n'est inventé.
- Schèmes (`pattern`), noms de lieu et intensifs : absents du Corpus 0.4, aucune autre source ouverte identifiée (§2 ter).
- Formes uniques (`word_form`).
- Sens des racines, étiquettes de relation de sens, nuances et encarts (rédigés, statut « non vérifié »).
- Sens français mot par mot (rédigés par IA, à marquer « non vérifié »).
- Index de recherche plein texte.
- Liste d'exclusion des questions de combat (§2 bis, respect du Coran).

La base pèse 35 Mo et l'APK passe de 60 à 71 Mo. Découper l'APK par architecture le ramènerait à environ un tiers.
