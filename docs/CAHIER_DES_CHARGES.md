# IQURA — Cahier des charges v2

Version du 21 octobre 2026. Remplace le cahier des charges initial et `docs/ARCHITECTURE.md`.

> **Instructions pour Claude Code (à exécuter à la réception de ce fichier)**
>
> 1. Enregistre ce fichier dans le dépôt sous `docs/CAHIER_DES_CHARGES.md`. C'est désormais la référence unique du projet.
> 2. Déplace `docs/ARCHITECTURE.md` dans `docs/archive/` (ne le supprime pas).
> 3. **Garde tout le socle de la phase 1** (profil, bases SQLite, sauvegarde, export, import, fusion, CI GitHub Actions, tests) : il fonctionne et il est validé.
> 4. Réécris `CLAUDE.md` à partir de ce document : vision, règles absolues (respect du Coran section 6, aucune donnée inventée, statut « rédigé par IA — non vérifié », ne jamais prétendre avoir compilé ou testé sans l'avoir fait, audit des licences), décisions techniques (section 9), jalons (section 10). Mets à jour `THIRD_PARTY_LICENSES.md` si besoin.
> 5. Adapte le code existant à ce document. Pour tout ce qui doit être supprimé ou fortement modifié, présente d'abord la liste à l'utilisateur et attends son accord.
> 6. Commence ensuite le jalon J1 par la décision ouverte n° 1 (audio) : compare 2 ou 3 solutions de synthèse vocale arabe sur du texte entièrement vocalisé (qualité, licence, coût, hors ligne) et fournis des échantillons à écouter (lettres, syllabes, mots, une phrase). Ne choisis rien sans l'accord de l'utilisateur.
> 7. Pour toutes les décisions ouvertes (section 12), pose les questions directement à l'utilisateur, une à la fois, avec ta recommandation.

## Vision

IQURA est un RPG d'aventure narrative dont la mécanique centrale est de comprendre l'arabe : plus le joueur comprend, plus le monde s'ouvre. Il mène un francophone débutant jusqu'à lire couramment l'arabe littéraire, le comprendre, le parler et, surtout, comprendre directement le Coran.

- **Un vrai cursus**, inspiré de la méthode de Médine, rendu interactif.
- **Un vrai jeu**, sur le modèle des jeux où déchiffrer une langue est le gameplay (*Heaven's Vault*, *Chants of Sennaar*), avec les codes du RPG classique : équipement, enchantement, donjons, boss.
- **Les racines comme signature** : aucune application francophone ne les enseigne vraiment.
- **Le respect du Coran** : il est la connaissance étudiée, jamais l'ennemi.

Application gratuite, open source (GPL-3.0), en français, pour Windows et Android, utilisable hors ligne.

## 1. Objectif, public et périmètre

L'objectif final est l'arabe littéraire comme seconde langue : lire de façon fluide, comprendre ce qu'on lit et entend, s'exprimer, et comprendre le Coran dans sa langue. C'est un objectif de plusieurs centaines d'heures : l'application doit avant tout donner envie de revenir chaque jour pendant des mois.

| Sujet | Décision |
| --- | --- |
| Public | Francophones, adultes et adolescents, débutants complets (ne savent pas lire l'alphabet). Test de positionnement pour les plus avancés. |
| Profil type | N'aime pas apprendre de façon scolaire ; joue volontiers ; 15 à 30 minutes par jour. |
| Langue enseignée | Arabe littéraire (fuṣḥā) tel qu'employé dans le Coran et les textes classiques, avec l'arabe standard moderne pour la conversation. Pas de dialecte. |
| Langue de l'interface | Français. Les dialogues du jeu passent progressivement du français à l'arabe. |
| Plateformes | Windows 10/11 et Android. |
| Modèle | Gratuit, sans publicité, sans achat, open source GPL-3.0. |

**Hors périmètre.** Dialectes ; certification de prononciation ou de tajwīd ; tafsīr au-delà du sens des mots ; remplacement d'un professeur humain.

## 2. Principes pédagogiques

Chaque session quotidienne travaille quatre compétences, par ordre d'importance :

| Compétence | Pourquoi | Comment dans IQURA |
| --- | --- | --- |
| Comprendre (lire et écouter) | La fluidité vient d'une grande quantité de textes compris | Dialogues et récits gradués du mode Histoire |
| Mémoriser | Sans révision, on oublie en quelques jours | Révision espacée FSRS dans l'Expédition quotidienne |
| Comprendre la mécanique | Grammaire, schèmes et racines rendent l'arabe prévisible | Leçons courtes données par des personnages, Forge des mots |
| Produire (parler, écrire) | On ne parle qu'en parlant | Répétition à voix haute, réponses aux personnages, écriture |

**Méthodes obligatoires.**

- **Textes gradués** : tout texte à lire contient au moins 95 % de mots déjà connus du joueur (calcul automatique).
- **Le mot inconnu devient une carte** : un appui sur un mot affiche son sens et l'ajoute aux révisions.
- **Révision espacée (FSRS)** pour les mots, racines, conjugaisons et règles ; note déduite de la justesse et du temps de réponse.
- **Rappel actif** : toujours demander avant de montrer.
- **Feedback immédiat qui explique** pourquoi une réponse est juste ou fausse.
- **Entrelacement** : les révisions mélangent vocabulaire, racines, grammaire et compréhension.
- **Bascule progressive** : dialogues d'abord en français avec quelques mots arabes, puis de plus en plus d'arabe, jusqu'à des dialogues entièrement en arabe.
- **Fréquence d'abord** : vocabulaire introduit selon sa fréquence dans le Coran et en arabe littéraire.
- **Répétition à voix haute** (écouter, répéter, s'enregistrer, comparer), sans note de prononciation automatique.

**États d'un mot.** Découvert → en apprentissage → reconnu → maîtrisé, plus « à réviser » quand l'échéance est passée. Jamais « maîtrisé » après un seul exercice réussi.

## 3. Le cursus en cinq étapes

Progression de la méthode de Médine. Chaque étape est une région du jeu et se termine par un examen (boss de la région).

| Étape (région) | Objectif mesurable | Contenu principal | Vocabulaire cumulé visé |
| --- | --- | --- | --- |
| 1. Déchiffrer | Lire à voix haute n'importe quel mot entièrement vocalisé | 28 lettres et hamza, 4 formes, articulation ; voyelles brèves et longues, sukūn, shadda, tanwīn, tāʾ marbūṭa, alif maqṣūra, article et lettres solaires ; reconnaissance des signes du Mushaf ; lecture chronométrée | ≈ 100 mots |
| 2. Fondations | Comprendre des phrases simples et de courts récits | Nom, verbe, particule ; pronoms personnels, démonstratifs et suffixes ; genre et nombre (duel, pluriels) ; défini et indéfini ; phrase nominale ; prépositions ; iḍāfa ; interrogation et négation ; verbes au passé et à l'inaccompli | ≈ 1 000 mots |
| 3. Le moteur de la langue | Deviner la forme et la famille d'un mot ; lire des textes simples | Racines et schèmes ; formes verbales I à X ; impératif ; verbes faibles ; passif ; participes et noms dérivés ; cas grammaticaux (iʿrāb) | ≈ 2 000 mots |
| 4. Lire et parler | Lire couramment un texte vocalisé ; tenir une conversation simple | Phrases complexes, subordonnées, particules (inna, kāna…) ; récits longs ; dialogues ; rédaction courte | ≈ 3 500 mots |
| 5. Le Coran | Comprendre directement des sourates entières | Particularités du Coran, structures et expressions propres, nuances de sens, étude de sourates complètes | Vocabulaire coranique fréquent maîtrisé |

Le Coran est présent dès l'étape 1 : on reconnaît des mots d'Al-Fātiḥa et des sourates de la prière ; à chaque étape, de nouvelles sourates s'ouvrent dans le Sanctuaire. Les volumes de vocabulaire sont indicatifs, à ajuster une fois les fréquences calculées.

**Chaque leçon (mini-donjon)** : découverte par l'exemple, règle courte en français, pratique corrigée, un ou deux exemples authentiques (extraits coraniques référencés), contrôle final, création des cartes de révision.

### Les racines (signature d'IQURA, surtout à l'étape 3)

Objectif : reconnaître les liens entre les mots d'une même famille sans supposer qu'ils ont tous le même sens. Connaître une racine aide à repérer et retenir les mots, mais ne permet pas de deviner le sens précis de chaque dérivé.

- **Fiche racine** (ex. ر ح م : رَحْمَةٌ miséricorde, رَحِيمٌ Miséricordieux, رَحْمَٰنُ Tout Miséricordieux, رَحِمَ faire miséricorde) : sens généraux, mots de la famille, occurrences coraniques, nuances entre mots proches.
- **Étiquette de relation de sens** par dérivé : proche, intensif, spécialisé, figuré, éloigné.
- **Arbre des racines** : racine → formes verbales attestées (I à X) → noms dérivés par schème → sens → occurrences. Structure issue du Quranic Arabic Corpus.
- **Avertissement visible** (leçon dédiée + encart sur chaque fiche) : la racine ne suffit pas à déduire le sens exact.
- **Exercices** : Détective des racines, Famille de mots, L'intrus, Relation de sens, Deviner puis vérifier, Forge des mots.
- **Maîtrise** : chaque racine a sa propre carte de révision, indépendante de ses dérivés.

## 4. Le jeu : univers et quatre boucles

Le joueur incarne un voyageur qui arrive dans un monde où l'on parle arabe et où une grande bibliothèque a été oubliée. Pour progresser, il doit comprendre ce qu'on lui dit, déchiffrer des écrits et reconstruire la cité du savoir.

**Carte du monde à étapes** : une région par étape du cursus ; des lieux reliés par des chemins ; on clique pour s'y rendre ; le boss d'une région ouvre la suivante.

| Boucle | Ce que fait le joueur | Ce qu'il apprend | Rythme |
| --- | --- | --- | --- |
| L'Histoire (cœur du jeu) | Voyager, parler aux personnages, mener des enquêtes, déchiffrer inscriptions et lettres, faire des choix | Comprendre des dialogues et textes gradués ; leçons de grammaire données par des personnages maîtres | Un chapitre = quelques sessions |
| L'Expédition | Partir chaque jour dans la Faille des Oubliés, combattre au tour par tour, affronter les boss | Révisions FSRS du jour, contrôles de chapitre | Quotidien, 5 à 15 min |
| La Forge | Combiner racine et schème pour créer des mots ; remplir le Grimoire | Racines, schèmes, morphologie | Libre |
| La Cité | Reconstruire la cité (bibliothèque, école, marché, forge, sanctuaire) ; s'équiper ; enchanter | Motivation à long terme ; ressources issues de la mémorisation réelle | Libre |

- Dans l'Histoire, une mauvaise compréhension n'est jamais punitive : impasse, indice ou autre piste ; on peut relire, toucher les mots inconnus, demander de l'aide.
- **Grimoire** : dictionnaire personnel, racines et arbre, règles apprises, listes personnelles, alphabet.
- **Mode « apprentissage seul »** : mêmes activités sans habillage de jeu.
- **Sessions courtes et séries quotidiennes**, avec un jour de repos possible sans perdre sa série.

## 5. Combats, ressources, équipement et enchantement

Chaque action de combat est une question. Aucune statistique de jeu ne modifie les notes de révision ni les statuts de maîtrise.

**Combat au tour par tour.** Attaque = vocabulaire ; Sort de racine = trouver la racine ou la famille ; Bouclier = grammaire ; Ultime = reconstruire un mot. Bonne réponse : coup porté ; rapide : critique ; erreur : le monstre frappe et un court message explique. Chronomètre désactivable. Les monstres représentent des difficultés (l'Oubli, la Confusion, la Distraction), jamais des mots.

| Ressource | Obtention | Usage |
| --- | --- | --- |
| XP | Combats, chapitres, leçons, mots qui changent d'état ; rendement décroissant sur les questions trop faciles | Niveau du héros |
| Or (dinars) | Combats, coffres, quêtes | Boutique |
| Pierres de savoir | 1 quand un mot devient « reconnu », 3 « maîtrisé », 5 par racine maîtrisée ; impossible à farmer | Enchantement |
| Encre de scribe | Chapitres et donjons terminés | Nouvelles compétences (nouveaux types de questions) |
| Fragments de boss | Butin des boss | Équipement légendaire |
| Matériaux de construction | Quêtes de l'Histoire | Reconstruction de la cité |

**Équipement** : armes, armures, casques, capes, boucliers, accessoires ; raretés Commun, Rare, Épique, Légendaire ; visibles sur le personnage. Stats : PV, Attaque, Défense, Critique, Concentration.

**Enchantement +1 à +15** (valeurs initiales). Coût : or + pierres de savoir. Un échec ne détruit jamais l'objet et ne fait jamais perdre de niveau ; chaque échec ajoute +5 points au taux suivant ; pity garantie ; taux affichés avant chaque tentative.

| Paliers | Taux de base | Pity | Bonus de stats | Effet visuel |
| --- | --- | --- | --- | --- |
| +1 à +5 | 95 % → 75 % | 3 échecs | +4 % par niveau | +5 : lueur |
| +6 à +10 | 60 % → 40 % | 5 échecs | +6 % par niveau | +10 : aura colorée |
| +11 à +15 | 30 % → 10 % | 8 échecs | +9 % par niveau | +15 : aura légendaire et titre |

**Quêtes** : quotidiennes, hebdomadaires et principales (étapes du cursus).

## 6. Le Sanctuaire et le respect du Coran

Le Coran est la connaissance étudiée, jamais l'ennemi combattu. Il se lit et s'étudie dans le Sanctuaire, lieu calme de la cité, sans aucun combat.

- Chaque sourate affiche la part de ses mots que le joueur reconnaît, libellée comme reconnaissance de vocabulaire, pas comme compréhension.
- Une sourate devient « prête à étudier » au-delà d'un seuil de mots reconnus ; ordre conseillé : Al-Fātiḥa puis sourates courtes de la prière.
- Étude : lecture, écoute, sens de chaque mot dans son verset et sens général, racine, construction, méditation libre ; ajout des mots inconnus aux révisions.
- Récompenses discrètes (XP, avancement de la cité), jamais de butin ni de combat lié au texte.

**Règles de respect (non négociables).**

1. Aucun mot coranique affiché sur un monstre, frappé, détruit ou « tué », ni dans les visuels, ni dans les animations, ni dans les textes.
2. En combat, un mot du vocabulaire peut apparaître seul, sous forme de dictionnaire, dans un panneau de question neutre, sans verset ni référence.
3. Aucun verset ni extrait coranique en combat.
4. Noms divins, noms de prophètes et formules sacrées exclus de toute question de combat.
5. Texte coranique jamais généré, reconstitué ni modifié : il vient de Tanzil, stocké une seule fois, vérifié par SHA-256 ; les leçons le référencent (sourate:verset) sans le recopier.
6. Aucune représentation de prophètes ni de figures sacrées.

## 7. Parole et écoute

L'audio est obligatoire dès le MVP.

| Besoin | Source envisagée | Statut |
| --- | --- | --- |
| Versets et mots coraniques | Récitations publiques (EveryAyah, al-Ḥuṣarī par défaut) ; mots isolés par découpage horodaté (QUL) | Retenu ; packs téléchargeables par sourate |
| Lettres, syllabes, mots, phrases des leçons et dialogues | Synthèse vocale **Chatterbox Multilingual** (Resemble AI, MIT) sur texte entièrement vocalisé, générée une fois par `tools/build_audio/` et livrée avec l'app ; coupure automatique des sons parasites après le mot | **Décidé le 21/10/2026** (décision n° 1) |

- Tout audio de synthèse est signalé comme tel. Sons difficiles : description écrite + schéma d'articulation.
- **Répétition à voix haute** : écouter, répéter, s'enregistrer, réécouter en alternance, recommencer ; vitesse réglable, boucle. Aucune note automatique de prononciation.
- **Répondre aux personnages** : hors ligne, choix ou reconstitution ; plus tard, option en ligne avec une IA, présentée comme entraînement et non comme correction.
- **Écrire** : tracé des lettres (étape 1), puis saisie au clavier arabe.
- **Des humains** : à partir de l'étape 4, IQURA recommande de pratiquer avec des locuteurs ou un professeur.

## 8. Contenus et sources

Toute donnée linguistique vient d'une source citée ; tout texte rédigé par IA est marqué « rédigé par IA — non vérifié ». Pas de relecteur humain : rien n'est inventé (ni racine, ni occurrence, ni traduction attribuée).

| Contenu | Source | Statut |
| --- | --- | --- |
| Texte coranique | Tanzil (CC BY 3.0, modification interdite) | Vérifié par empreinte |
| Racines, lemmes, catégories, formes verbales, schèmes, fréquences | Quranic Arabic Corpus (licence GNU, non commercial), via QUL si besoin | Sourcé |
| Traduction des versets | Hamidullah, rév. Complexe Roi Fahd (2000) ; droits flous, remplaçable | Créditée |
| Sens français des mots, explications, nuances | Rédigés à partir des données sourcées | « Rédigé par IA — non vérifié » |
| Dialogues, récits gradués, exemples | Rédigés en arabe entièrement vocalisé, vocabulaire contrôlé (≥ 95 % de mots connus) | « Rédigé par IA — non vérifié » |
| Polices | Amiri ou Scheherazade New (SIL OFL) ; KFGQPC Hafs pour le Mushaf | Licences jointes |
| Récitations | EveryAyah ; droits aux récitateurs | Créditées |
| Graphismes | Packs libres (ex. LPC, Kenney) | À auditer pack par pack |

- Chaque exemple affiche sa source (« exemple construit » ou référence coranique).
- Récits profanes ou neutres ; aucune parole attribuée à un prophète ou à une figure religieuse.
- Bouton « Signaler une erreur » sur chaque fiche.
- Toute dépendance et ressource auditée et listée dans `THIRD_PARTY_LICENSES.md` ; tout point douteux signalé.

**Points douteux connus** : traduction Hamidullah (aucune licence publiée) ; EveryAyah (aucune condition publiée) ; Quranic Arabic Corpus (FAQ « usage de recherche » : confirmation écrite souhaitable).

## 9. Technique

Le socle de la phase 1 est **conservé** (compilé, testé, export Windows → import Android validé).

| Sujet | Décision |
| --- | --- |
| Framework | Flutter (Dart), Windows et Android |
| Moteur 2D | Flame (MIT) ; menus, questions et Grimoire en widgets Flutter |
| Données | SQLite : base de contenu en lecture seule générée par `tools/build_content/` ; base utilisateur, seule exportée |
| Révision | FSRS |
| Hors ligne | Tout, sauf téléchargement des récitations, mises à jour de contenu et option IA |
| Sauvegarde | Archive ZIP versionnée et vérifiée (en place), restauration complète ou fusion |
| Compilation | Claude Code + GitHub Actions (APK et exe) sur `The-Ashams/iqura` |
| Affichage | Arabe RTL, diacritiques corrects, taille réglable ; translittération Arabica par défaut, simplifiée au choix, masquable ; clair/sombre ; animations désactivables |
| Ergonomie | Souris et clavier (Windows), tactile (Android), plusieurs tailles d'écran |

- **Contenu piloté par les données** : leçons, dialogues, récits, quêtes, monstres, objets et régions dans des fichiers de contenu (ex. JSON), pas dans le code.
- **Calcul de lisibilité** : pour chaque texte, part de mots connus du joueur (règle des 95 %, pourcentage du Sanctuaire).

## 10. Jalons et MVP

Le MVP est un prototype jouable de bout en bout sur la première région, qui prouve que les quatre boucles fonctionnent ensemble et donnent envie de revenir.

| Jalon | Contenu | Condition pour passer au suivant |
| --- | --- | --- |
| J0 — Socle (fait) | App Windows et Android, profil, sauvegarde, export, import, fusion | Transfert PC → Android validé ✅ |
| J1 — MVP : région 1 « Déchiffrer » | Toute l'étape 1 avec audio ; chapitre 1 de l'Histoire (bascule amorcée) ; Expédition et boss ; Grimoire (alphabet, premiers mots) ; Cité minimale avec boutique, équipement, enchantement +1 à +15 ; Sanctuaire avec Al-Fātiḥa ; séries ; mode « apprentissage seul » | Un débutant lit des mots vocalisés seul ; il revient plusieurs jours ; aucun bug bloquant |
| J2 — Région 2 « Fondations » | Étape 2, récits gradués, Forge (racines simples), sourates courtes de la prière | Compréhension de courts récits ; ≈ 1 000 mots |
| J3 — Région 3 « Le moteur de la langue » | Étape 3, arbre des racines complet, tous les exercices de racines, équipement légendaire | Le joueur devine forme et famille d'un mot |
| J4 — Région 4 « Lire et parler » | Étape 4, récits longs, dialogues, écriture, option IA | Lecture courante d'un texte vocalisé |
| J5 — Région 5 « Le Coran » | Étape 5, sourates complètes, lecteur coranique complet | Compréhension directe de sourates |

**Ordre de travail pour J1.**

1. Choisir la solution audio (décision ouverte n° 1).
2. Pipeline de données : Tanzil vérifié, morphologie et fréquences du Quranic Arabic Corpus.
3. Contenus de l'étape 1 (leçons, fiches lettres, audio), validés par l'utilisateur leçon par leçon.
4. Coquille du jeu : carte à étapes, dialogues, combat, Cité.
5. Chapitre 1 de l'Histoire, Expédition, Sanctuaire (Al-Fātiḥa).
6. Tests et compilation Windows et Android.

On avance désormais région par région, chaque région complète et jouable. Le découpage en 7 phases techniques et le MVP « large mais mince » du premier projet sont abandonnés.

## 11. Critères d'acceptation

Démontrés sur Windows et Android, compilations et tests réellement exécutés.

- [ ] Texte coranique identique octet pour octet à Tanzil (test d'empreinte).
- [ ] Aucun mot ni extrait coranique sur un monstre ou dans une attaque ; aucun verset en combat (test automatisé).
- [ ] Chaque texte à lire respecte la règle des 95 % au moment où il est proposé.
- [ ] Chaque fiche affiche sa source ou « rédigé par IA — non vérifié ».
- [ ] Chaque mot, lettre et phrase des leçons du jalon a son audio (signalé « synthèse » si c'est le cas).
- [ ] Révisions planifiées par FSRS ; jamais « maîtrisé » après une seule réussite.
- [ ] Jamais deux réponses justes par erreur (test des distracteurs).
- [ ] Pierres de savoir uniquement via un changement d'état réel.
- [ ] Enchantement conforme aux taux affichés et à la pity (tests sur de nombreux tirages).
- [ ] Progression intacte après fermeture, export, import et fusion, sans double comptage d'XP.
- [ ] Tout fonctionne hors ligne, hors téléchargements.
- [ ] Aucun bouton sans fonction réelle ; ce qui n'est pas fait est indiqué.
- [ ] Licences de toutes les dépendances et ressources listées.

## 12. Décisions ouvertes

| N° | Question | Valeur par défaut |
| --- | --- | --- |
| 1 | Audio des leçons et dialogues | **Décidé le 21/10/2026 : Chatterbox Multilingual** (voir section 13) |
| 2 | Univers et style graphique | **Décidé le 21/10/2026 : pixel art libre**, monde inspiré des cités de savoir historiques, sans figures sacrées (voir section 13) |
| 3 | Nom et scénario de l'Histoire | **Décidé le 21/10/2026** : *La Bibliothèque oubliée*, cité Madīnat al-Ḥikma ; synopsis du chapitre 1 dans `docs/HISTOIRE.md` (voir section 13) |
| 4 | Seuil « sourate prête à étudier » | **Décidé le 21/10/2026 : 80 %** de mots reconnus ; Al-Fātiḥa ouverte d'office (voir section 13) |
| 5 | Récitateur par défaut | **Décidé le 21/10/2026 : al-Ḥuṣarī, murattal** (EveryAyah `Husary_128kbps`) (voir section 13) |
| 6 | Conversation avec une IA (J4) | **Reportée à J4** par l'utilisateur le 21/10/2026 (voir section 13) |
| 7 | Licence du Quranic Arabic Corpus | Mail aux auteurs à envoyer par l'utilisateur |

## 13. Journal des décisions

Décisions prises par l'utilisateur, consignées par Claude Code. Les détails techniques sont dans `CLAUDE.md` et `docs/ETAT_DU_PROJET.md`.

### Décision n° 1 : audio des leçons (21 octobre 2026)

- **Retenu : Chatterbox Multilingual** (Resemble AI), poids et code sous licence MIT. La voix par défaut est utilisée.
- **Coupure automatique** : le modèle ajoute souvent des sons parasites après le mot. L'outil `tools/build_audio/trim.py` ne garde que la première prise de parole :
  - les pauses de moins de 0,25 s restent (entre les mots d'une phrase) ;
  - la fin des voyelles est suivie jusqu'au silence ;
  - marges de 0,05 s avant et 0,12 s après, puis fondu final ;
  - nouvel essai avec une autre graine si la durée est invraisemblable.
  Résultat validé à l'écoute par l'utilisateur sur 17 échantillons : « on entend très bien le son, pas de coupure brute ni de bruit de fond ».
- Chaque fichier porte le filigrane inaudible Perth de Chatterbox et la mention « synthèse » dans l'application.
- Format livré : MP3 mono 64 kbit/s, dans `assets/audio/lecons/`, vérifié par SHA-256 (`tools/build_audio/clips.json`).
- **Refusés** par l'utilisateur : eSpeak NG, eSpeak NG avec les voix MBROLA ar1/ar2, Azure Neural TTS (service payant avec compte).
- **Comparés, non retenus** : VoxCPM2 (Apache-2.0), Piper « kareem » (licence des données de la voix inconnue), MMS-TTS de Meta (non commercial, supprime les voyelles). MOSS-TTS n'a pas pu être testé (17 Go).
- Point douteux : Resemble AI ne publie ni ses données d'entraînement ni l'origine exacte de la voix par défaut.

### Décision n° 2 : univers et style graphique (21 octobre 2026)

- **Retenu : pixel art à partir de packs libres** (valeur par défaut du cahier, recommandée).
- Univers : monde inspiré des cités de savoir historiques (bibliothèques, observatoires, caravansérails), sans aucune figure sacrée ni représentation de prophète.
- Chaque pack graphique est audité avant intégration (licence CC0 de préférence) et listé dans `THIRD_PARTY_LICENSES.md`.
- Écartés : illustration 2D vectorielle (peu de packs libres cohérents) et style minimaliste ou abstrait (moins « jeu »).

### Décision n° 3 : nom et scénario de l'Histoire (21 octobre 2026)

- **Retenu : la base du cahier**. Un voyageur arrive dans une cité de savoir où l'on parle arabe et où une grande bibliothèque a été oubliée ; en comprenant la langue, il reconstruit la cité.
- Méthode : Claude propose un synopsis du chapitre 1 et quelques noms ; l'utilisateur valide ou corrige **avant** toute écriture des dialogues. Les dialogues sont marqués « rédigé par IA — non vérifié ».
- Aucun prophète ni aucune figure religieuse n'est représenté ni ne prend la parole.
- **Validé par l'utilisateur** : synopsis du chapitre 1 (`docs/HISTOIRE.md`), titre *La Bibliothèque oubliée*, cité Madīnat al-Ḥikma (مَدِينَةُ الْحِكْمَةِ, « la cité de la sagesse », traduction rédigée par IA, non vérifiée).

### Décision n° 4 : seuil « sourate prête à étudier » (21 octobre 2026)

- **Retenu : 80 % de mots reconnus** (valeur par défaut du cahier, recommandée) ; **Al-Fātiḥa ouverte d'office**.
- Le texte coranique ne peut pas être simplifié : ce seuil est donc distinct des 95 % exigés pour les textes gradués. L'appui sur un mot inconnu affiche son sens et crée une carte de révision.
- Écartés : 90 % (sourates ouvertes trop tard) ; toutes les sourates ouvertes sans seuil.

### Décision n° 5 : récitateur par défaut (21 octobre 2026)

- **Retenu : al-Ḥuṣarī en récitation murattal** (valeur par défaut du cahier, recommandée) : EveryAyah, dossier `Husary_128kbps` (présence vérifiée le 21/10/2026). Le joueur pourra en changer plus tard.
- Écartés comme valeur par défaut : al-Ḥuṣarī *muʿallim* (contenu non vérifié à l'écoute) et *mujawwad* (plus orné, moins adapté au mot à mot).
- **À vérifier** : disponibilité des horodatages mot par mot de QUL pour cette récitation (nécessaires pour écouter un mot isolé).

### Décision n° 6 : conversation avec une IA (21 octobre 2026)

- **Reportée à J4** par l'utilisateur : la décision reste entièrement ouverte jusqu'à l'étape 4. Rien n'est prévu ni développé d'ici là.
- Pistes présentées, non retenues pour l'instant : option en ligne désactivée par défaut (valeur du cahier) ; aucune IA.
- D'ici J4, « Répondre aux personnages » se fait hors ligne (choix ou reconstitution).

### Environnement de développement (session cloud)

Domaines ajoutés par l'utilisateur aux domaines autorisés, pour installer et faire tourner les modèles de synthèse :
- `huggingface.co` (fiches et petits fichiers des modèles) ;
- `us.aws.cdn.hf.co` (fichiers lourds des modèles) ;
- `download.pytorch.org` (index de PyTorch).

Toujours bloqués à ce jour : `download-r2.pytorch.org` (PyTorch installé depuis PyPI à la place) et les autres sous-domaines de `hf.co` (non nécessaires). Ces domaines ne servent qu'à générer l'audio ; l'application n'en a pas besoin.

### Autres décisions de l'utilisateur (20 et 21 octobre 2026)

- **J0 validé** : profil créé sur PC, importé sur Android sans problème. Pull request n° 1 fusionnée.
- **Respect du Coran** : tout ce qui vient du Coran est étudié, jamais combattu. En combat, un mot du vocabulaire (lemme coranique compris) peut apparaître seul, sous forme de dictionnaire, dans le panneau de question neutre ; la règle est « aucun extrait ni verset coranique en combat ». Noms divins, noms de prophètes et formules sacrées exclus du combat.
- **Racines** : la racine ne suffit pas à déduire le sens d'un dérivé (avertissement visible). Pour les schèmes, absents du Quranic Arabic Corpus 0.4 : chercher une autre source ouverte ; rien n'est inventé en attendant.
- **Quranic Arabic Corpus** : téléchargé avec l'adresse e-mail de l'utilisateur, exigée par le site.
- **Polices** : Amiri et Amiri Quran (SIL OFL).
- **Translittération** : norme *Arabica* (ḫ, ǧ, ṯ, ḏ, ġ…) par défaut, style simplifié (kh, j, th, dh, gh…) au choix, masquable.
- **Schémas d'articulation** : dessins simples, marqués « IA — non vérifié ».
- **Plan de l'étape 1** accepté ; leçons 0 à 3 rédigées, **en attente de validation** par l'utilisateur.
- **Adaptation au cahier v2** acceptée en entier : navigation (Carte du monde, Cité, Grimoire, Sanctuaire, Paramètres), étape renommée « Déchiffrer », contrôle final obligatoire, translittération masquable, animations désactivables.

