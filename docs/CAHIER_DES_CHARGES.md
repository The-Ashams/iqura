# IQURA — Cahier des charges v3 (document de référence unique)

Version du 22 octobre 2026. **Ce document remplace tous les précédents** : le cahier des charges initial, `docs/ARCHITECTURE.md`, le cahier des charges v2 et le programme pédagogique séparé. En cas de contradiction avec un autre document, c'est celui-ci qui fait foi.

---

## 0. Instructions pour Claude Code (à lire en premier)

### 0.1 À la réception de ce fichier

1. Enregistre ce fichier dans le dépôt sous `docs/CAHIER_DES_CHARGES.md`, en remplaçant la version existante. Déplace les anciennes versions et `docs/ARCHITECTURE.md` dans `docs/archive/` (ne supprime rien).
2. Réécris `CLAUDE.md` à partir de ce document : vision (§1), règles absolues (§3), décisions techniques (§12), ordre de travail (§13), règles de travail (§0.2). `CLAUDE.md` doit rester court et renvoyer à ce document pour le détail.
3. Mets à jour `docs/ETAT_DU_PROJET.md` : ce qui existe déjà, ce qui doit changer pour suivre ce document, la prochaine étape.
4. **Garde tout le socle existant** (profil, bases SQLite, sauvegarde, export, import, fusion, CI GitHub Actions, tests, pipeline de contenu, outil audio Chatterbox et coupure automatique). Il fonctionne et il est validé.
5. Fais la liste de ce qui, dans le code et le contenu existants, ne correspond plus à ce document. Pour tout ce qui doit être supprimé ou fortement modifié, présente la liste à l'utilisateur et attends son accord avant d'agir.
6. Ensuite, suis l'ordre de travail du §13, étape par étape, sans en sauter.

### 0.2 Règles de travail

- **Ne devine jamais.** Si un point de ce document est ambigu, contradictoire ou techniquement impossible, arrête-toi et pose la question à l'utilisateur, avec ta recommandation et une alternative. Une question à la fois.
- **Montre avant de produire en masse.** Pour chaque nouveau type de contenu (leçon, récit, dialogue, quête), montre d'abord un ou deux exemples à l'utilisateur et attends sa validation avant d'en produire d'autres.
- **Prototype avant production** : aucune production de l'ensemble des leçons ou des récits avant la validation du prototype jouable (§13, jalon J1a).
- **N'annonce jamais** une compilation, un test ou une vérification que tu n'as pas réellement exécutés. Donne les preuves (tests passés, compilations réussies).
- **Mets à jour `docs/ETAT_DU_PROJET.md`** à chaque étape importante, et toujours avant la fin d'une session.
- **Parle à l'utilisateur en français simple.** Il n'est pas développeur : explique les choix, évite le jargon, et dis clairement ce qu'il doit faire lui-même (tester, valider, fusionner une pull request).
- **Toute décision nouvelle** prise avec l'utilisateur est ajoutée à ce document (§16), avec sa date.

---

## 1. Vision

IQURA est un **RPG d'aventure narrative en pixel art** dont la mécanique centrale est de comprendre l'arabe : plus le joueur comprend, plus le monde s'ouvre. Il mène un francophone débutant complet jusqu'à lire couramment l'arabe littéraire classique, le comprendre, s'exprimer, et surtout comprendre directement le Coran dans sa langue.

- **Un vrai cursus**, inspiré de la méthode de Médine, rendu interactif : environ 130 leçons en 5 régions.
- **Un vrai jeu** : le joueur passe la majorité de son temps dans l'aventure (explorer, parler, combattre, forger, reconstruire). L'apprentissage est intégré au jeu ; il ne doit pas avoir l'impression de suivre un cours. Modèles : les jeux où déchiffrer une langue est le gameplay (*Heaven's Vault*, *Chants of Sennaar*) et les RPG japonais classiques (équipement, enchantement, donjons, boss).
- **Les racines comme signature**, présentes dès la première région.
- **Le Coran à chaque région**, toujours avec respect : il est la connaissance étudiée, jamais l'ennemi.

Application gratuite, sans publicité ni achat, open source (GPL-3.0), en français, pour Windows 10/11 et Android, utilisable hors ligne.

---

## 2. Objectif, public et périmètre

| Sujet | Décision |
| --- | --- |
| Objectif final | L'arabe littéraire classique comme seconde langue : lire de façon fluide, comprendre, s'exprimer, comprendre le Coran |
| Public | Francophones, adultes et adolescents, débutants complets. Test de positionnement à partir de J2 pour les plus avancés |
| Profil type | N'aime pas apprendre de façon scolaire ; aime jouer ; 15 à 30 minutes par jour |
| Langue enseignée | **Arabe littéraire classique (fuṣḥā)**, celui du Coran et des textes classiques, **y compris pour la conversation et les dialogues**. Pas d'arabe standard moderne comme registre de référence, pas de dialecte. Un mot moderne n'est utilisé que s'il est indispensable à une scène (ex. un objet du quotidien sans équivalent classique simple), et il est alors signalé comme tel |
| Interface | Français. Les dialogues du jeu passent progressivement du français à l'arabe |
| Plateformes | Windows 10/11 (.exe) et Android (.apk) |
| Modèle | Gratuit, sans publicité ni achat, GPL-3.0 |

**Hors périmètre** : dialectes ; arabe standard moderne comme registre de conversation ; certification de prononciation ou de tajwīd ; tafsīr (exégèse) au-delà du sens linguistique des mots et des tournures ; remplacement d'un professeur humain.

---

## 3. Règles absolues (non négociables)

### 3.1 Respect du Coran

1. Le Coran est la connaissance étudiée, **jamais l'ennemi combattu**.
2. Un monstre représente une difficulté d'apprentissage (l'Oubli, la Confusion, la Précipitation, la Distraction, l'Impatience), **jamais un mot**.
3. Aucun mot coranique n'est affiché sur un monstre, frappé, détruit ou « tué », ni dans les visuels, ni dans les animations, ni dans les textes.
4. En combat, un mot du vocabulaire (y compris un mot fréquent du Coran) peut apparaître **seul, sous sa forme de dictionnaire**, dans un panneau de question neutre, sans verset ni référence.
5. **Aucun verset ni extrait coranique en combat.** Les extraits n'apparaissent que dans les salles d'étude et le Sanctuaire.
6. Noms divins, noms de prophètes et formules sacrées sont exclus de toute question de combat.
7. Aucune représentation de prophètes ni de figures sacrées ; aucune parole attribuée à un prophète ou à une figure religieuse dans les récits.
8. Le texte coranique n'est **jamais généré, reconstitué ni modifié** : il vient uniquement de Tanzil, est stocké une seule fois dans la base de contenu et vérifié par empreinte SHA-256. Les leçons le **référencent** (sourate:verset) sans le recopier.
9. Quand la langue seule ne suffit pas à trancher le sens d'un passage, IQURA le dit et renvoie vers les savants et les ouvrages de tafsīr.

### 3.2 Données et contenus

1. **Aucune donnée inventée** : ni racine, ni lemme, ni occurrence, ni traduction attribuée à un auteur, ni analyse grammaticale présentée comme certaine. Racines, lemmes, catégories, formes verbales, schèmes et fréquences viennent du Quranic Arabic Corpus (via QUL si besoin).
2. **Aucun relecteur humain** : tout texte rédigé par IA (explications, sens français, dialogues, récits, exemples construits, descriptions d'articulation) porte le statut visible **« rédigé par IA »**.
3. Chaque exemple affiche sa source : « exemple construit » ou référence coranique.
4. Tout audio de synthèse est signalé « synthèse ».
5. Un bouton « Signaler une erreur » existe sur chaque fiche.

### 3.3 Honnêteté et qualité

1. Aucun bouton décoratif ni fausse fonctionnalité ; ce qui n'est pas fait est indiqué comme tel.
2. Aucune note automatique de prononciation.
3. Les statistiques de jeu ne modifient jamais les notes de révision ni les statuts de maîtrise.
4. Chaque dépendance logicielle et chaque ressource (police, graphisme, audio, donnée) est auditée (licence, auteur, fiabilité) et listée dans `THIRD_PARTY_LICENSES.md` ; tout point douteux est signalé à l'utilisateur.

---

## 4. Principes pédagogiques

Chaque session travaille quatre compétences, par ordre d'importance :

| Compétence | Pourquoi | Comment dans IQURA |
| --- | --- | --- |
| Comprendre (lire et écouter) | La fluidité vient d'une grande quantité de textes compris | Dialogues, récits gradués, Sanctuaire |
| Mémoriser | Sans révision, on oublie en quelques jours | Révision espacée FSRS dans l'Expédition |
| Comprendre la mécanique | Grammaire, schèmes et racines rendent l'arabe prévisible | Leçons courtes données par des personnages, Forge |
| Produire (parler, écrire) | On ne parle qu'en parlant | Répétition à voix haute, réponses aux personnages, écriture |

**Méthodes obligatoires.**

- **Textes gradués** : tout texte à lire contient au moins **95 % de mots déjà connus** du joueur (calcul automatique).
- **Le mot inconnu devient une carte** : un appui sur un mot affiche son sens et l'ajoute aux révisions.
- **Révision espacée FSRS** pour mots, racines, conjugaisons et règles ; note déduite de la justesse et du temps (§6.3).
- **Rappel actif** : toujours demander avant de montrer.
- **Feedback immédiat** qui explique, avec lien vers la fiche.
- **Entrelacement** : les révisions mélangent les types de contenus.
- **Bascule progressive** du français vers l'arabe dans les dialogues.
- **Fréquence d'abord** pour le vocabulaire, pleinement à partir de l'étape 2.
- **Répétition à voix haute** : écouter, répéter, s'enregistrer, comparer.

**Vocabulaire adaptatif.** 5 à 15 nouveaux mots par jour (15 par défaut, réglable de 5 à 30). Si les erreurs sur les mots récents augmentent, ou si les révisions en attente dépassent 100, l'introduction ralentit puis s'arrête automatiquement.

**Deux niveaux de connaissance d'un mot**, suivis séparément : **passif** (reconnaître le mot, son sens, à partir de l'arabe) et **actif** (le retrouver à partir du français, l'utiliser dans une phrase). Les cartes actives d'un mot n'apparaissent qu'une fois le passif « reconnu ».

**États d'un élément** : découvert → en apprentissage → reconnu → maîtrisé, plus « à réviser » quand l'échéance est passée. Une leçon réussie fait passer ses éléments à « en apprentissage », jamais plus. Jamais « maîtrisé » après une seule réussite.

---

## 5. Le programme pédagogique

### 5.1 Ligne directrice

Une seule question guide tout le programme : **« qu'est-ce que le joueur sait faire de plus en arabe à la fin de cette leçon ? »** Chaque leçon ajoute une capacité vérifiable, chaque région une compétence :

1. **Lire** les lettres et les signes (région 1).
2. **Comprendre une phrase** : qui fait quoi, à qui, où (région 2).
3. **Décoder un mot inconnu** grâce à sa racine et à son schème (région 3).
4. **Lire et parler couramment** en arabe classique (région 4).
5. **Comprendre le Coran directement** (région 5).

Trois fils traversent toutes les régions : le vocabulaire par fréquence, la bibliothèque de récits gradués (moteur de la progression à long terme), et le Coran (§5.4).

### 5.2 Vue d'ensemble

Les heures sont un **objectif de conception, pas une garantie** ; elles varient beaucoup selon les personnes. À 30 minutes par jour, 800 heures représentent environ 4 ans et demi : d'où les objectifs intermédiaires (§5.3). Repère : selon le Foreign Service Institute américain, l'arabe demande environ 2 200 heures de cours à un anglophone pour un niveau professionnel ; IQURA vise une compréhension solide de l'arabe classique et du Coran, pas un niveau professionnel.

| Région | Leçons | Heures (cumul) | Vocabulaire cumulé | Récits gradués | À la fin, le joueur sait… |
| --- | --- | --- | --- | --- | --- |
| 1. Le Désert des Lettres — Déchiffrer | 15 + boss | ≈ 20 h | ≈ 100 mots | 15 inscriptions et étiquettes | lire à voix haute n'importe quel mot vocalisé |
| 2. L'Oasis des Fondations | 30 + boss | ≈ 120 h | ≈ 1 000 mots | 60 récits de 50 à 150 mots | comprendre des phrases simples et de courts récits |
| 3. Les Montagnes du Moteur | 32 + boss | ≈ 300 h | ≈ 2 000 mots | 80 récits de 150 à 400 mots | décoder la forme et la famille d'un mot inconnu ; lire des textes simples |
| 4. La Cité des Lecteurs | 28 + boss | ≈ 550 h | ≈ 3 500 mots | 100 récits et dialogues de 400 à 1 000 mots | lire couramment, converser simplement, écrire un court texte |
| 5. Les Jardins du Sens | 24 + sourates étudiées | ≈ 800 h et plus | vocabulaire coranique fréquent maîtrisé | sourates et textes classiques | comprendre directement des sourates entières |

Les volumes de vocabulaire sont indicatifs, à ajuster une fois les fréquences calculées à partir du corpus.

### 5.3 Objectifs intermédiaires

Affichés dans le jeu comme des succès, avec un résultat concret (repères indicatifs à 30 minutes par jour) :

| Repère | Ce que le joueur sait faire |
| --- | --- |
| 1 semaine | Lire ses premières syllabes et ses premiers mots ; reconnaître des lettres d'Al-Fātiḥa |
| 1 mois | Lire n'importe quel mot vocalisé ; lire les mots d'Al-Fātiḥa et en connaître plusieurs |
| 3 mois | Comprendre des phrases simples ; plusieurs centaines de mots ; une première part mesurable des mots du Coran reconnue |
| 6 mois | Comprendre de courts récits ; comprendre mot à mot les sourates courtes de la prière |
| 1 an | Fin de la région 2, début de la région 3 ; décoder les familles de mots |
| 2 ans | Lire des textes simples ; comprendre la construction des mots et des verbes ; analyser des versets |
| 3 ans et plus | Lire couramment, converser simplement, comprendre directement des sourates entières |

### 5.4 Le Coran à chaque région

Toujours dans les salles d'étude et le Sanctuaire, jamais en combat.

| Région | Ce que le joueur fait avec des versets |
| --- | --- |
| 1 | Repérer les lettres apprises, lire des mots, écouter la récitation |
| 2 | Identifier noms, verbes, particules et pronoms ; comprendre des phrases nominales et verbales simples |
| 3 | Analyser racines, schèmes, formes verbales, conjugaisons ; expliquer la fin d'un mot par son cas |
| 4 | Comprendre des phrases et passages complets ; suivre conditions, compléments et liens logiques |
| 5 | Étudier les structures propres au Coran et les nuances ; lire des sourates entières |

### 5.5 Région 1 « Déchiffrer » — 15 leçons

Objectif : lire à voix haute n'importe quel mot entièrement vocalisé, y compris dans l'écriture du Mushaf. Lettres regroupées par famille de forme ; au plus 4 lettres et 1 signe par leçon.

| N° | Titre | Objectif | Contenu |
| --- | --- | --- | --- |
| 0 | Découvrir l'écriture | Savoir comment l'arabe s'écrit | Sens de lecture, consonnes et signes, lettres liées, 4 formes, rôle des points — sous forme d'**énigme de déchiffrage**, pas de paragraphes |
| 1 | ا ب ت ث | Lire ba, ta, ṯa et le ā long | Fatḥa, alif d'allongement |
| 2 | ن ي | Lire bi, ni et le ī long | Kasra, yāʾ d'allongement |
| 3 | ج ح خ | Distinguer ḥ et ḫ, lire bu | Ḍamma (le ū long attend la leçon 8) |
| 4 | د ذ ر ز | Lire une consonne sans voyelle | Sukūn ; lettres qui ne se lient pas à gauche |
| 5 | س ش ص ض | Entendre et dire les premières emphatiques | Opposition s / ṣ, d / ḍ |
| 6 | ط ظ ع غ | Prononcer ʿayn et ġayn, t / ṭ | Emphatiques et pharyngales |
| 7 | ف ق ك ل | Distinguer q et k ; lire lā | Lam-alif لا ; **premières familles de mots** (كَتَبَ, كِتَاب, كَاتِب : « tu vois les mêmes trois lettres ? »), sans analyse |
| 8 | م ه و | Lire le ū long ; w et y consonnes ou voyelles | Récapitulatif des voyelles longues |
| 9 | La hamza | Lire les mots avec hamza | ء et ses supports أ إ ؤ ئ, madda آ |
| 10 | Fins de mots | Reconnaître les terminaisons fréquentes | Tāʾ marbūṭa ة, alif maqṣūra ى |
| 11 | La shadda | Lire une consonne doublée | Shadda seule et avec voyelle |
| 12 | Le tanwīn | Lire -un, -an, -in | Trois tanwīn, alif du tanwīn |
| 13 | L'article | Lire « al- » correctement | Lettres solaires et lunaires, hamzat al-waṣl |
| 14 | L'écriture du Mushaf | Reconnaître les signes du Coran | ٱ, alif suscrit, petits wāw et yāʾ, signes de pause (reconnaissance seulement, pas de règles de tajwīd) |
| Boss | Examen de la région | Voir §5.11 | Mélange de toutes les leçons, lecture chronométrée |

En parallèle : environ 100 mots (noms concrets formés des lettres déjà vues, choisis par script parmi les mots du corpus, classés par fréquence, liste soumise à l'utilisateur) ; familles de mots dès la leçon 7 ; Sanctuaire : lecture et reconnaissance des mots d'Al-Fātiḥa.

**Corrections à appliquer aux leçons 0 à 3 existantes** (relecture du 22 octobre 2026) :

1. Leçon 1, alif : retirer « ou à une voyelle » (en début de mot, l'alif sert de support à la hamza).
2. Leçon 3, نَجَا : « il s'est sauvé, il a échappé » (et non « il a été sauvé »).
3. Leçon 3, ح : remplacer la comparaison des lunettes (qui évoque plutôt ه) par un « ahh » soufflé et serré, comme après avoir bu quelque chose de très chaud.
4. Leçon 0 : la décomposition ث + ب + ت s'affiche de droite à gauche.
5. Seuil du contrôle final : 80 % partout.
6. QCM : 3 ou 4 choix, jamais 2.
7. Ajouter des noms concrets n'utilisant que les lettres déjà vues (vérifier vocalisation et sens) : leçon 1 بَاب ; leçon 2 بَنَات, نَبَات, ثَابِت ; leçon 3 تَاج, جَنَاح, حَبِيب.
8. Leçon 0 sous forme d'énigme de déchiffrage.
9. Reprendre les leçons 0 à 3 au format mini-donjon (§6).

### 5.6 Région 2 « Fondations » — 30 leçons

Objectif : comprendre et produire des phrases simples, lire de courts récits. Ordre de la méthode de Médine : le nom et la phrase nominale, puis la possession, puis le verbe (**ordre validé, ne pas le changer**).

**Chapitre A — La caravane : le nom et la phrase nominale**

| N° | Titre | Objectif | Contenu |
| --- | --- | --- | --- |
| 2.1 | Nom, verbe, particule | Reconnaître la nature d'un mot | Les trois catégories et leurs indices visibles |
| 2.2 | Masculin et féminin | Dire si un nom est masculin ou féminin | Tāʾ marbūṭa, féminins sans marque fréquents |
| 2.3 | Défini et indéfini | Dire « un livre » ou « le livre » | Article al-, tanwīn |
| 2.4 | « Ceci est… » | Désigner un objet proche | هَٰذَا / هَٰذِهِ |
| 2.5 | « Cela est… » | Désigner un objet lointain | ذَٰلِكَ / تِلْكَ |
| 2.6 | La phrase nominale | Dire « la maison est grande » | Sujet et attribut, pas de verbe « être » au présent |
| 2.7 | Je, tu, il, elle | Se présenter, présenter quelqu'un | Pronoms personnels isolés au singulier |
| 2.8 | Nous, vous, ils | Parler d'un groupe | Pronoms au pluriel et au duel |
| 2.9 | L'adjectif | Décrire : « un grand livre » | Accord en genre, nombre et définition |
| 2.10 | Poser une question | Demander qui, quoi, où | هَلْ، مَا، مَنْ، أَيْنَ |

**Chapitre B — Le marché : la possession et les prépositions**

| N° | Titre | Objectif | Contenu |
| --- | --- | --- | --- |
| 2.11 | Où est-il ? | Situer un objet | فِي، عَلَى، مِنْ، إِلَى ; kasra après préposition |
| 2.12 | Les fins de mots | Comprendre pourquoi la dernière voyelle change | Introduction aux trois cas |
| 2.13 | « La porte de la maison » | Exprimer l'appartenance entre deux noms | Iḍāfa |
| 2.14 | Mon livre, ton livre | Dire à qui appartient un objet | Pronoms suffixes sur le nom |
| 2.15 | Avec moi, sur lui | Pronoms après une préposition | لِي، فِيهِ، عَلَيْهِ… |
| 2.16 | Le duel | Parler de deux choses | -āni / -ayni |
| 2.17 | Les pluriels réguliers | Former le pluriel des noms courants | -ūna / -īna, -āt |
| 2.18 | Les pluriels internes | Reconnaître un pluriel qui change la forme du mot | Quelques schèmes très fréquents (introduction) |
| 2.19 | Compter jusqu'à 10 | Dire des quantités simples | Nombres 1 à 10 (accord simplifié) |
| 2.20 | « Il n'est pas… » | Nier une phrase nominale | لَيْسَ |

**Chapitre C — Le caravansérail : le verbe**

| N° | Titre | Objectif | Contenu |
| --- | --- | --- | --- |
| 2.21 | Il a écrit | Comprendre un verbe au passé | Passé, 3e personne du singulier |
| 2.22 | J'ai écrit, nous avons écrit | Conjuguer au passé | Toutes les personnes |
| 2.23 | La phrase verbale | Comprendre qui fait quoi | Verbe, sujet, complément ; accord du verbe |
| 2.24 | Il l'a écrit | Remplacer un complément par un pronom | Pronoms suffixes compléments |
| 2.25 | Il écrit | Comprendre un verbe à l'inaccompli | Inaccompli au singulier |
| 2.26 | J'écris, nous écrivons | Conjuguer à l'inaccompli | Toutes les personnes |
| 2.27 | Il n'a pas écrit | Nier un verbe | مَا (passé), لَا (présent), لَمْ (introduction) |
| 2.28 | Il écrira | Parler du futur | سَـ / سَوْفَ |
| 2.29 | Écris ! | Donner un ordre simple | Impératif (introduction) |
| 2.30 | Celui qui… | Relier deux phrases | الَّذِي، الَّتِي، الَّذِينَ |
| Boss | Examen de la région | Voir §5.11 | Mélange de toute la région |

En parallèle : environ 900 nouveaux mots par fréquence ; chaque nouveau mot montré avec sa **famille** et sa racine surlignée ; une **mini-forge intuitive** à la fin de chaque chapitre (regrouper des mots par racine, sans théorie des schèmes) ; 60 récits gradués ; Sanctuaire : repérer noms, verbes et pronoms dans les sourates courtes de la prière.

### 5.7 Région 3 « Le moteur de la langue » — 32 leçons

Objectif : comprendre comment les mots se fabriquent et s'accordent, pour décoder un mot inconnu et lire des textes simples.

**Chapitre A — La forge : racines et schèmes**

| N° | Titre | Objectif | Contenu |
| --- | --- | --- | --- |
| 3.1 | La racine | Extraire la racine d'un mot | Racines trilitères (et quadrilitères rares) |
| 3.2 | Le schème | Reconnaître le moule d'un mot | Notation ف ع ل |
| 3.3 | Celui qui fait, ce qui est fait | Comprendre فَاعِل et مَفْعُول | Participes de la forme I |
| 3.4 | Le nom d'action | Reconnaître un maṣdar | Maṣdars fréquents de la forme I |
| 3.5 | Lieux et instruments | Comprendre مَفْعَل et مِفْعَال | Noms de lieu, de temps, d'instrument |
| 3.6 | Adjectifs et intensifs | Comprendre فَعِيل et فَعَّال | Qualité durable, intensité |
| 3.7 | Les pluriels internes | Retrouver le singulier | Schèmes de pluriel les plus fréquents |
| 3.8 | Plus grand, le plus grand | Comparer | Élatif أَفْعَل |
| 3.9 | L'adjectif de relation | Dire « arabe », « égyptien » | Nisba en -ī |
| 3.10 | Ce que la racine ne dit pas | Savoir quand la déduction échoue | Leçon d'avertissement, relations de sens |

**Chapitre B — Les ateliers : les formes verbales**

| N° | Titre | Objectif |
| --- | --- | --- |
| 3.11 | La forme I | Reconnaître fa'ala, fa'ila, fa'ula et leurs inaccomplis |
| 3.12 | Forme II فَعَّلَ | Comprendre l'intensif et le factitif |
| 3.13 | Forme III فَاعَلَ | Comprendre l'action faite avec ou envers quelqu'un |
| 3.14 | Forme IV أَفْعَلَ | Comprendre le factitif |
| 3.15 | Forme V تَفَعَّلَ | Comprendre le réfléchi de la forme II |
| 3.16 | Forme VI تَفَاعَلَ | Comprendre la réciprocité |
| 3.17 | Forme VII اِنْفَعَلَ | Comprendre le passif réfléchi |
| 3.18 | Forme VIII اِفْتَعَلَ | Comprendre la forme VIII et les assimilations du tāʾ |
| 3.19 | Forme X اِسْتَفْعَلَ | Comprendre la demande et l'estimation |
| 3.20 | Participes et maṣdars des formes II à X | Reconnaître ces dérivés dans un texte |
| 3.21 | La voix passive | Comprendre le passif au passé et à l'inaccompli |

Les valeurs de sens des formes sont des tendances, pas des règles : chaque leçon le rappelle avec des contre-exemples.

**Chapitre C — Les inscriptions abîmées : les verbes faibles**

| N° | Titre | Objectif |
| --- | --- | --- |
| 3.22 | Verbes à hamza | Lire et conjuguer أَكَلَ, سَأَلَ… |
| 3.23 | Verbes doublés | Conjuguer مَدَّ |
| 3.24 | Verbes assimilés | Conjuguer وَجَدَ / يَجِدُ |
| 3.25 | Verbes concaves | Conjuguer قَالَ / يَقُولُ |
| 3.26 | Verbes défectueux | Conjuguer دَعَا، مَشَى |

**Chapitre D — Le tribunal des scribes : les cas et les modes**

| N° | Titre | Objectif | Contenu |
| --- | --- | --- | --- |
| 3.27 | Les trois cas | Expliquer la fin d'un mot par sa fonction | Nominatif, accusatif, génitif (iʿrāb) |
| 3.28 | Noms particuliers | Reconnaître les exceptions courantes | Diptotes ; les cinq noms |
| 3.29 | Le subjonctif | Comprendre « pour qu'il écrive » | أَنْ، لَنْ، كَيْ |
| 3.30 | Le jussif | Comprendre « il n'a pas écrit », « n'écris pas » | لَمْ, لَا de défense, impératif complet |
| 3.31 | « Certes… » | Comprendre إِنَّ et ses sœurs | إِنَّ، أَنَّ، لَكِنَّ، لَعَلَّ… |
| 3.32 | « Il était… » | Comprendre كَانَ et ses sœurs | كَانَ، صَارَ، لَيْسَ… |
| Boss | Examen de la région | Voir §5.11 | |

En parallèle : 1 000 nouveaux mots, 80 récits, arbre des racines et tous les exercices de racines (§7), Sanctuaire : analyse des mots des sourates déjà rencontrées.

### 5.8 Région 4 « Lire et parler » — 28 leçons

Objectif : lire couramment des textes longs, tenir une conversation simple et écrire un court texte, **en arabe classique**.

**Chapitre A — Les lettres et les récits : la phrase complexe**

| N° | Titre | Contenu |
| --- | --- | --- |
| 4.1 | « Si… » | إِنْ، إِذَا et la réponse avec فَـ |
| 4.2 | « Si seulement… » | لَوْ، لَوْلَا |
| 4.3 | « Il a dit que… » | أَنَّ / أَنْ |
| 4.4 | Quand, avant, après | حِينَ، لَمَّا، قَبْلَ أَنْ، بَعْدَ أَنْ |
| 4.5 | Parce que, pour que | لِأَنَّ، لِـ، حَتَّى |
| 4.6 | « Il est venu en courant » | Le ḥāl |
| 4.7 | La précision | Le tamyīz |
| 4.8 | « Il a frappé un coup » | Le mafʿūl muṭlaq |
| 4.9 | « Il l'a fait par peur » | Le mafʿūl li-aǧlih |
| 4.10 | Sauf, excepté | إِلَّا، غَيْرُ |
| 4.11 | « Ô vous… » | يَا، أَيُّهَا |
| 4.12 | Insister | قَدْ، لَـ d'insistance, nūn d'insistance |
| 4.13 | Relier les idées | فَـ، ثُمَّ، بَلْ، لَٰكِنْ، أَمَّا… فَـ |
| 4.14 | Tous les nombres | Nombres jusqu'à 1 000 et leur accord |

**Chapitre B — La place des débats : parler (registre classique)**

| N° | Titre | Objectif |
| --- | --- | --- |
| 4.15 | Se présenter en détail | Parler de soi pendant une minute |
| 4.16 | Famille et métiers | Décrire ses proches |
| 4.17 | Dans la cité | Demander et donner son chemin |
| 4.18 | Le temps qui passe | Les jours, les mois, les moments de la journée |
| 4.19 | Au marché | Acheter, négocier, politesse |
| 4.20 | Raconter sa journée | Raconter au passé |
| 4.21 | Donner son avis | Exprimer et justifier une opinion |
| 4.22 | Mener une conversation | Relancer, faire répéter, conclure |

**Chapitre C — L'atelier des copistes : lire et écrire seul**

| N° | Titre | Objectif |
| --- | --- | --- |
| 4.23 | Lire sans voyelles (1) | Lire un texte classique simple non vocalisé |
| 4.24 | Lire sans voyelles (2) | Stratégies : racine, schème, contexte |
| 4.25 | Le dictionnaire | Trouver un mot par sa racine dans un dictionnaire classé par racines |
| 4.26 | Écrire un message | Rédiger 5 à 10 phrases |
| 4.27 | Résumer un récit | Reformuler ce qu'on a lu |
| 4.28 | Un texte classique | Lire un texte classique profane vocalisé (ex. fables de Kalīla wa Dimna), source et édition citées |
| Boss | Examen de la région | Voir §5.11 |

En parallèle : 1 500 nouveaux mots, 100 récits et dialogues, option de conversation avec une IA (en arabe classique), recommandation de pratiquer avec un professeur ou des locuteurs.

### 5.9 Région 5 « Le Coran » — 24 leçons et sourates étudiées

Entièrement dans le Sanctuaire, sans combat. Enseigne la langue du Coran, pas son exégèse (§3.1, règle 9).

**Chapitre A — Les tournures propres au Coran**

| N° | Titre | Contenu |
| --- | --- | --- |
| 5.1 | Les serments | وَ et تَ de serment, لَا أُقْسِمُ |
| 5.2 | Les particules fréquentes | إِنَّمَا، كَلَّا، بَلَى، أَلَا |
| 5.3 | La question qui affirme | أَ، أَلَمْ، هَلْ |
| 5.4 | Les négations du Coran | لَنْ، لَمَّا، إِنْ de négation |
| 5.5 | L'ordre des mots | Taqdīm (ex. la tournure de 1:5, par référence) |
| 5.6 | Les mots sous-entendus | Ḥaḏf |
| 5.7 | Le changement de personne | Iltifāt |
| 5.8 | Les récits | وَإِذْ، فَلَمَّا، ثُمَّ ; dialogues rapportés |
| 5.9 | Les formes verbales dans le Coran | Révision appliquée de la région 3 |
| 5.10 | Le vocabulaire thématique | Champs de mots les plus fréquents |
| 5.11 | Un mot, plusieurs sens | Sens lexical général et sens contextuel |
| 5.12 | Mots proches, sens distincts | Nuances entre quasi-synonymes, sourcées |

**Chapitre B — Les méthodes de lecture**

| N° | Titre |
| --- | --- |
| 5.13 | Analyser un verset mot par mot (racine, schème, nature, fonction) |
| 5.14 | Analyser la phrase (iʿrāb appliqué) |
| 5.15 | Suivre le fil d'une sourate (parties, refrains, transitions) |
| 5.16 | Se servir de la traduction (sens littéral et sens traduit) |
| 5.17 | Lire sans traduction |
| 5.18 | Les limites de la langue (rôle de l'exégèse, renvoi vers les savants) |

**Chapitre C — Les sourates étudiées (ordre validé)**

| N° | Parcours |
| --- | --- |
| 5.19 | Al-Fātiḥa en profondeur |
| 5.20 | Les sourates courtes de la prière (Al-Iḫlāṣ, Al-Falaq, An-Nās, Al-Kawṯar, Al-ʿAṣr…) |
| 5.21 | Le juzʾ ʿAmma |
| 5.22 | Le juzʾ Tabārak (ex. Al-Mulk) |
| 5.23 | Un long récit par extraits progressifs (ex. sourate Yūsuf) |
| 5.24 | Parcours libre, guidé par le pourcentage de mots connus |

### 5.10 Les fils continus

| Fil | Ce que c'est | Volume | Où dans le jeu |
| --- | --- | --- | --- |
| Vocabulaire | Mots par fréquence (Coran et arabe classique), chacun rattaché à sa racine et à un exemple ; rythme adaptatif (§4) | ≈ 3 500 mots | Leçons, Histoire, Grimoire, Expédition |
| Récits gradués | Histoires originales en arabe classique entièrement vocalisé (non vocalisé progressivement en région 4), ≥ 95 % de mots connus, audio de synthèse, questions de compréhension, profanes (voyages, marché, métiers, nature, sagesse) | ≈ 255 récits | Quêtes, bibliothèque de la Cité |
| Sanctuaire | Part du Coran reconnue qui grandit, sourates qui s'ouvrent (§5.4, §9) | Toutes régions | Sanctuaire |
| Oral | Répétition à voix haute, réponses aux personnages, conversation | Quotidien | Leçons, Histoire |
| Révision | FSRS | 10 à 20 min/jour | Expédition |
| Forge | Exercices de racines et de schèmes | Toutes les racines rencontrées | Forge |

### 5.11 Mesurer les progrès

**Chaque examen de région comporte trois évaluations distinctes** : lecture ou compréhension (corrigée automatiquement), écoute, production (prononciation par auto-évaluation, puis réponses écrites ou orales). La prononciation n'est jamais notée automatiquement : le joueur compare son enregistrement à la référence et s'auto-évalue ; l'application ne prétend jamais la certifier.

| Région | Ce que l'examen vérifie |
| --- | --- |
| 1 | Lecture visuelle : associer 20 mots vocalisés à leur lecture, ≥ 90 % ; écoute : reconnaître des mots entendus ; prononciation : lire à voix haute, s'enregistrer, comparer et s'auto-évaluer ; temps de lecture affiché (repère indicatif 1 minute, non bloquant) |
| 2 | Comprendre un récit de 150 mots, ≥ 80 % aux questions ; écoute ; répondre à un personnage |
| 3 | Décoder 20 mots inconnus (racine, schème, sens probable) ; lire un texte de 300 mots |
| 4 | Lire un récit de 800 mots, tenir un dialogue avec un personnage, écrire 5 phrases |
| 5 | Comprendre une sourate courte non étudiée en détail (sens des mots et des tournures), dans le Sanctuaire, sans combat |

**Indicateurs du Grimoire** : mots par état (passif et actif séparés) ; part du Coran reconnue (occurrences dont le lemme est au moins « reconnu », libellée « reconnaissance de vocabulaire », jamais « compréhension ») ; racines rencontrées et maîtrisées ; vitesse de lecture (mots par minute et erreurs) ; compréhension des récits ; temps d'étude et série.

**Test de positionnement** (à partir de J2) : il reprend les examens pour faire commencer le joueur à la bonne région ; il crée les cartes correspondantes.

---

## 6. Déroulement d'une leçon (mini-donjon)

Une leçon n'est jamais un texte à lire : c'est **une scène de l'Histoire jouée comme un mini-donjon de 10 à 15 minutes**, dans un lieu de la carte, où le joueur agit environ deux tiers du temps. Un personnage maître (archiviste, apprenti copiste…, jamais une figure religieuse) explique en très courtes répliques ; chaque explication est suivie d'une action dans la minute.

### 6.1 Les écrans (région 1 ; adaptés ensuite)

| Écran | Ce que voit le joueur | Ce qu'il fait |
| --- | --- | --- |
| 1. Entrée | Le maître devant un obstacle de l'Histoire (porte, étiquette, inscription). Objectif en une phrase | Écoute la scène et entre |
| 2. Échauffement (dès la leçon 2) | 3 ou 4 questions mélangées sur les leçons précédentes | Répond ; correction expliquée |
| 3. Découverte | L'obstacle en grand et une question | Cherche avant qu'on lui montre |
| 4. Les éléments | Une fiche par lettre : grande lettre, 4 formes, nom et audio, articulation et schéma si le son est difficile | Écoute, puis mini-question immédiate |
| 5. La règle | Règle courte avec audio | Identifie une syllabe entendue ; distingue brève et longue |
| 6. Salle d'entraînement | Exercices mélangés : reconnaître, points, formes, écouter, lire, reconstruire, tracer, répéter à voix haute | Répond ; chaque erreur est expliquée et la question revient plus tard, réponses déplacées |
| 7. Salle d'étude « Dans le Coran » | Lieu calme, sans combat : extraits référencés (Tanzil + traduction Hamidullah), récitation d'al-Ḥuṣarī | Touche les lettres ou mots de la leçon |
| 8. Mini-boss | Combat contre une difficulté ; questions dans un panneau neutre, jamais de verset | 10 à 12 questions sans translittération, dont 20 à 30 % sur les leçons précédentes ; réussite à 80 % |
| 9. Fin | L'obstacle s'ouvre ; « ce que tu sais lire maintenant » ; récompenses ; nouvelles cartes | Reprend l'Histoire |

À partir de la région 2 : découverte par l'exemple dans un dialogue, règle courte donnée par le maître, pratique, texte gradué à lire, salle d'étude coranique, mini-boss. Le détail des écrans de chaque région est proposé par Claude Code et validé par l'utilisateur avant rédaction.

### 6.2 Règles de conception

- Un écran = une idée, 2 phrases maximum (≈ 40 mots). Jamais deux écrans d'explication à la suite.
- Région 1 : 3 ou 4 lettres et 1 signe au plus ; 4 à 6 syllabes et 3 à 5 mots, uniquement avec ce qui a déjà été vu.
- Audio : chaque nouvel élément est joué automatiquement ; tout mot arabe se touche pour l'entendre ; vitesse réglable ; mention « synthèse ».
- Translittération : région 1, visible dans les explications, masquée dans les questions et au mini-boss ; à partir de la leçon 8, masquée aussi dans les exercices de lecture ; à partir de la région 2, affichée seulement à la demande. Le réglage du joueur reste prioritaire.
- QCM à 3 ou 4 choix, distracteurs plausibles, jamais deux bonnes réponses (test automatisé).
- Échec au mini-boss : rien n'est perdu ; la difficulté « s'échappe » ; le joueur revoit ses erreurs avec explication et la salle concernée lui est proposée ; il peut retenter aussitôt avec d'autres questions ; les cartes sont créées et les éléments ratés reviennent plus vite ; la leçon suivante reste fermée, l'Expédition reste ouverte. Après deux échecs, le jeu propose de rejouer la salle d'entraînement concernée.
- Progression sauvegardée à chaque écran.
- Contenu dans des fichiers de données (JSON), pas codé à la main.

### 6.3 Cartes et notes de révision

- Région 1 : une carte « reconnaître » (forme → nom et son) et une carte « écouter » (son → lettre) par lettre ; une par signe ou règle ; une « lire » par syllabe ou mot d'exemple ; une carte de sens uniquement pour les mots du vocabulaire visé.
- Ensuite : cartes passives et actives par mot (§4), cartes de racine indépendantes de leurs dérivés, cartes de règle et de conjugaison.
- Note : faux = « à revoir » ; juste en plus de 8 s = « difficile » ; entre 3 et 8 s = « bien » ; moins de 3 s = « facile ». Seuils réglables par type d'exercice ; chronomètre désactivé = toute réponse juste vaut « bien ».

### 6.4 Catalogue des exercices

| Exercice | Principe | Régions |
| --- | --- | --- |
| Reconnaître | Une lettre ou un signe, choisir son nom ou son son | 1 |
| Écouter et choisir | Un son, choisir la lettre, la syllabe ou le mot | 1 à 5 |
| Paires proches | Distinguer deux éléments proches (ح / خ, س / ص, ت / ط, brève / longue) | 1 à 2 |
| Formes et points | Associer les formes ; distinguer des lettres de même silhouette | 1 |
| Lire | Un mot vocalisé, choisir sa lecture ou son audio | 1 à 2 |
| Répéter à voix haute | Écouter, répéter, s'enregistrer, comparer (sans note automatique) | 1 à 5 |
| Reconstruire | Assembler lettres et voyelles pour former un mot | 1 à 3 |
| Tracer | Tracer une lettre guidé par des points numérotés et le sens du geste ; vérification tolérante, sans sanction | 1 |
| Dictée | Entendre et écrire au clavier arabe | 1 à 4 |
| Repérer | Toucher une lettre ou un mot dans un extrait coranique (salle d'étude uniquement) | 1 à 5 |
| Lecture chronométrée | Lire une liste de mots vite et sans erreur, contre soi-même | 1 (fin) à 2 |
| Sens du mot | Associer arabe et sens, dans les deux sens | 2 à 5 |
| Compléter ou accorder | Choisir le bon pronom, accord, démonstratif, cas | 2 à 4 |
| Ordonner | Remettre une phrase dans l'ordre | 2 à 4 |
| Comprendre un récit | Questions sur un texte gradué | 2 à 4 |
| Répondre au personnage | Choisir, reconstituer ou écrire une réplique | 2 à 4 |
| Exercices de racines | Détective, Famille, Intrus, Relation de sens, Deviner puis vérifier, Forge (§7) | 1 (familles) à 5 |
| Étude d'un verset | Comprendre mot à mot, Sanctuaire uniquement | 1 (repérage) à 5 |

---

## 7. Les racines (signature d'IQURA)

Objectif : reconnaître les liens entre les mots d'une même famille **sans supposer qu'ils ont tous le même sens**. La racine aide à repérer et retenir les mots ; elle ne permet pas de deviner le sens précis de chaque dérivé.

- **Progression** : région 1, familles montrées sans analyse (dès la leçon 7) ; région 2, famille et racine surlignée pour chaque nouveau mot et mini-forges intuitives ; région 3, étude méthodique (schèmes, formes, dérivés) ; régions 4 et 5, application aux textes et au Coran.
- **Fiche racine** (ex. ر ح م : رَحْمَةٌ miséricorde, رَحِيمٌ Miséricordieux, رَحْمَٰنُ Tout Miséricordieux, رَحِمَ faire miséricorde) : sens généraux, mots de la famille, occurrences coraniques, nuances entre mots proches.
- **Étiquette de relation de sens** par dérivé : proche, intensif, spécialisé, figuré, éloigné.
- **Arbre des racines** : racine → formes verbales attestées (I à X) → noms dérivés par schème → sens → occurrences. Structure issue du Quranic Arabic Corpus ; seuls les sens et explications sont rédigés (« rédigé par IA »).
- **Avertissement visible** : leçon 3.10 et encart sur chaque fiche de racine.
- **Exercices** : Détective des racines (trouver la racine), Famille de mots (regrouper), L'intrus (y compris faux amis), Relation de sens, Deviner puis vérifier, Forge des mots (racine + schème → mot).
- **Maîtrise** : carte de révision propre à chaque racine, indépendante des dérivés.
- Le pipeline de données conserve pour chaque lemme : racine, forme verbale (I à X), schème, catégorie, nombre d'occurrences.

---

## 8. Le jeu

### 8.1 Style graphique (décidé)

**Pixel art dans l'esprit des RPG japonais classiques type Dragon Quest** : fenêtres de dialogue à bord blanc, combats vus de face, menu de commandes, personnages en sprites. Base de référence : les maquettes « Histoire — La porte de la bibliothèque » et « Expédition — Combat contre l'Oubli » déjà produites par Claude Code. **Inspiration de style uniquement** : aucun personnage, monstre, logo, musique ou élément graphique d'un jeu existant n'est repris. Graphismes issus de packs libres (licences auditées) ou créés pour le projet. Monde inspiré des cités de savoir, sans figures sacrées.

### 8.2 L'Histoire (validée)

Le voyageur arrive dans une cité du savoir dont la grande bibliothèque a été fermée, ses livres devenus illisibles. Chaque région rouvre une partie du savoir. Noms définitifs des lieux et personnages : à proposer par Claude Code au début de J1, à valider par l'utilisateur.

| Région | Ce que le voyageur y fait | Adversaire |
| --- | --- | --- |
| 1. Le Désert des Lettres | Rouvre la porte de la bibliothèque en lisant étiquettes et inscriptions | L'Oubli |
| 2. L'Oasis des Fondations | Vit avec une caravane et au marché : se présenter, acheter, comprendre les gens | La Confusion |
| 3. Les Montagnes du Moteur | Apprend chez les forgerons et les copistes comment les mots se fabriquent ; déchiffre d'anciennes inscriptions | La Précipitation |
| 4. La Cité des Lecteurs | Lit des lettres et des récits, débat avec les savants, rédige | La Distraction |
| 5. Les Jardins du Sens | Étudie au Sanctuaire, comprend les sourates dans leur langue | L'Impatience (jamais lié au texte sacré) |

Une leçon est une scène d'un chapitre ; une région = un chapitre. Dans l'Histoire, une mauvaise compréhension n'est jamais punitive : impasse, indice ou autre piste ; on peut relire, toucher les mots inconnus, demander de l'aide.

### 8.3 Les quatre boucles

| Boucle | Ce que fait le joueur | Ce qu'il apprend |
| --- | --- | --- |
| L'Histoire (cœur) | Voyager, parler, enquêter, déchiffrer, choisir | Dialogues et textes gradués ; leçons données par les personnages |
| L'Expédition (quotidienne) | Combats dans la Faille des Oubliés, boss | Révisions FSRS, contrôles |
| La Forge | Racine + schème → mot ; remplir le Grimoire | Racines, schèmes |
| La Cité | Reconstruire la cité (bibliothèque, école, marché, forge, sanctuaire), s'équiper, enchanter | Motivation à long terme |

**Carte du monde à étapes** : lieux reliés par des chemins, on clique pour s'y rendre ; chaque région compte 8 à 12 lieux. Un lieu contient une scène principale (la leçon), des personnages à qui parler (dialogues gradués), des quêtes secondaires, des inscriptions à déchiffrer, parfois une boutique. En revenant, le joueur découvre de nouveaux dialogues, de plus en plus en arabe, et des inscriptions devenues lisibles.

**Grimoire** : dictionnaire personnel, racines et arbre, règles apprises, listes personnelles, alphabet, indicateurs (§5.11).

**Mode « apprentissage seul »** : réglage réversible ; mêmes écrans de leçon sans scènes d'Histoire ; la carte devient une liste de leçons ; les combats deviennent des séries de questions simples ; progression commune aux deux modes.

### 8.4 Une session type de 30 minutes

| Moment | Durée | Ce que fait le joueur |
| --- | --- | --- |
| Arrivée | 1 min | Récompense de série, quêtes du jour, événement du jour |
| Expédition | 8 à 12 min | 3 ou 4 vagues de combats puis un gardien, nourris par les révisions du jour |
| Aventure | 10 à 15 min | Une leçon ou une scène de l'Histoire, et un récit gradué |
| Temps libre | 3 à 5 min | Forge, Sanctuaire, Cité, quêtes secondaires |

Session courte possible (10 minutes) : l'Expédition seule. Séries quotidiennes avec un jour de repos possible sans perdre la série.

### 8.5 Les combats

Tour par tour. À chaque tour, le joueur choisit une commande — **Attaque** (vocabulaire), **Sort de racine** (racines, débloqué en région 3 ; familles simples avant), **Bouclier** (grammaire, une règle), **Objet**, **Ultime** (reconstruire un mot) — et une question du type correspondant est tirée des révisions dues. Bonne réponse : dégâts selon l'Attaque, critique si rapide. Erreur : l'adversaire frappe (réduit par la Défense) et l'explication s'affiche. À 0 PV, le héros se replie sans rien perdre : les révisions faites comptent. Chronomètre désactivable.

| Adversaire | Mécanique | Ce qu'il fait travailler |
| --- | --- | --- |
| L'Oubli | Plus fort quand des révisions sont en retard | Les cartes oubliées |
| La Confusion | Choix très proches | Éléments faciles à confondre |
| La Précipitation | Questions chronométrées (désactivable) | Lecture rapide et automatique |
| La Distraction | Mélange tous les types de questions | L'entrelacement |
| L'Impatience | Longues séries de questions | La lecture suivie |

### 8.6 Ressources, équipement, enchantement

| Ressource | Obtention | Usage |
| --- | --- | --- |
| XP | Combats, leçons (50 à la première réussite, 10 en rejouant), mots qui changent d'état ; rendement décroissant sur les questions trop faciles | Niveau du héros |
| Or (dinars) | Combats, coffres, quêtes ; 20 par leçon réussie la première fois | Boutique |
| Pierres de savoir | **Uniquement** : 1 quand un mot devient « reconnu », 3 « maîtrisé », 5 par racine maîtrisée | Enchantement |
| Encre de scribe | 1 par leçon ou donjon terminé la première fois | Nouvelles compétences de combat |
| Fragments de boss | Butin des boss | Équipement légendaire |
| Matériaux | Quêtes de l'Histoire | Reconstruction de la cité |

**Équipement** : armes, armures, casques, capes, boucliers, accessoires ; raretés Commun, Rare, Épique, Légendaire ; visibles sur le personnage ; un ensemble par région avec bonus à trois pièces. Stats : PV, Attaque, Défense, Critique, Concentration (plus de temps avant le chronomètre). Objets spéciaux de confort (ex. lanterne : un indice par combat). **L'équipement change le combat, jamais l'apprentissage** : aucun objet ne modifie la difficulté des questions, les notes de révision ni les pierres de savoir.

**Enchantement +1 à +15** (valeurs initiales à équilibrer). Coût : or + pierres de savoir. Un échec ne détruit jamais l'objet et ne fait jamais perdre de niveau ; chaque échec ajoute +5 points au taux suivant ; pity garantie ; taux affichés avant chaque tentative.

| Paliers | Taux de base | Pity | Bonus de stats | Effet visuel |
| --- | --- | --- | --- | --- |
| +1 à +5 | 95 % → 75 % | 3 échecs | +4 % par niveau | +5 : lueur |
| +6 à +10 | 60 % → 40 % | 5 échecs | +6 % par niveau | +10 : aura colorée |
| +11 à +15 | 30 % → 10 % | 8 échecs | +9 % par niveau | +15 : aura légendaire et titre |

### 8.7 Quêtes et vie du jeu sur des centaines d'heures

- **Quêtes principales** = les leçons dans l'ordre. **Secondaires** = lire un récit, aider un personnage, forger des mots, étudier une sourate, retrouver un mot dans une inscription. **Quotidiennes** et **hebdomadaires** renouvelées. Chaque quête a un objectif d'apprentissage réel.
- **La Tour du Savoir** (à partir de J2) : donjon sans fin dont les étages se nourrissent de tout ce qui a été appris, avec records personnels.
- **Collections** : Grimoire, bestiaire des difficultés, titres, équipement +15, cité reconstruite.
- Un monde qui change avec le niveau d'arabe du joueur.
- Ni classement ni pression sociale, aucun achat.

---

## 9. Le Sanctuaire

Lieu calme de la cité, sans aucun combat, où le Coran se lit et s'étudie.

- Chaque sourate affiche la part de ses mots que le joueur reconnaît (« reconnaissance de vocabulaire », jamais « compréhension »).
- Une sourate devient « prête à étudier » à **80 % de mots reconnus** ; Al-Fātiḥa est ouverte d'office.
- Étude : lecture, écoute de la récitation (al-Ḥuṣarī), sens de chaque mot dans son verset et sens général, racine, construction, méditation libre ; ajout des mots inconnus aux révisions.
- Récompenses discrètes (XP, avancement de la cité), jamais de butin ni de combat lié au texte.
- Le lecteur coranique complet (114 sourates, navigation par juzʾ) arrive avec la région 5 (J5) ; avant, le Sanctuaire propose les sourates accessibles selon la progression.

---

## 10. Parole et écoute

| Besoin | Source | Statut |
| --- | --- | --- |
| Lettres, syllabes, mots, phrases des leçons, dialogues, récits | **Chatterbox Multilingual** (MIT), généré une fois et livré avec l'app, coupé automatiquement après le mot (outil existant), mention « synthèse » | ✅ Décidé et en place |
| Versets et mots coraniques | Récitations EveryAyah, **al-Ḥuṣarī** par défaut ; mots isolés par découpage horodaté (QUL, à vérifier) ; jamais de synthèse pour le Coran | ✅ Décidé |

- Sons difficiles : description écrite + schéma d'articulation (« rédigé par IA »).
- **Répétition à voix haute** : écouter, répéter, s'enregistrer, réécouter en alternance ; vitesse réglable, boucle. Enregistrements **uniquement sur l'appareil**, jamais envoyés en ligne ; seul le dernier par élément est gardé ; exclus de l'export par défaut (option pour les inclure) ; micro demandé à la première utilisation.
- **Répondre aux personnages** : hors ligne, choix ou reconstitution ; à partir de J4, option en ligne avec une IA en arabe classique, présentée comme entraînement, désactivée par défaut.
- **Écrire** : tracé guidé (région 1), puis clavier arabe.
- À partir de la région 4 : recommandation de pratiquer avec un professeur ou des locuteurs.

---

## 11. Contenus et sources

| Contenu | Source | Statut |
| --- | --- | --- |
| Texte coranique | Tanzil (CC BY 3.0, modification interdite) | Vérifié par SHA-256 |
| Racines, lemmes, catégories, formes, schèmes, fréquences | Quranic Arabic Corpus (GNU GPL ; source citée avec lien et notice reproduite), via QUL si besoin | Sourcé |
| Traduction des versets | Hamidullah, version diffusée par Tanzil (édition non précisée), créditée, remplaçable ; usage non commercial | Crédité |
| Sens français, explications, nuances | Rédigés à partir des données sourcées | « Rédigé par IA » |
| Dialogues, récits, exemples | Rédigés en arabe classique entièrement vocalisé, vocabulaire contrôlé | « Rédigé par IA » |
| Textes classiques (région 4) | Œuvres classiques profanes du domaine public, édition citée | Sourcé |
| Polices | Amiri et Amiri Quran (SIL OFL), en place ; KFGQPC Hafs pour le Mushaf seulement après audit de sa licence (avant la leçon 14) | Licences jointes |
| Audio | Chatterbox (MIT) ; EveryAyah (droits aux récitateurs) | Crédités |
| Graphismes | Packs libres ou créations, licence vérifiée pack par pack | À auditer |

**Points douteux connus** : traduction Hamidullah (aucune licence publiée) ; EveryAyah (aucune condition publiée). Quranic Arabic Corpus : doute levé par la notice du fichier (GNU GPL ; usage autorisé « dans tout site web ou application », à condition de citer la source avec un lien vers corpus.quran.com et de reproduire la notice) ; la FAQ du site parle d'usage « de recherche », mais la notice, plus précise, fait foi ; mail aux auteurs facultatif.

---

## 12. Technique

| Sujet | Décision |
| --- | --- |
| Framework | Flutter (Dart), Windows et Android, une seule base de code |
| Moteur 2D | Flame (MIT) ; menus, questions, Grimoire en widgets Flutter |
| Données | SQLite : base de contenu en lecture seule générée par `tools/build_content/` ; base utilisateur, seule exportée |
| Révision | FSRS |
| Hors ligne | Tout, sauf téléchargement des récitations, mises à jour de contenu, option IA |
| Sauvegarde | Archive ZIP versionnée et vérifiée (en place), restauration complète ou fusion |
| Compilation | Sessions Claude Code + GitHub Actions (APK et .exe) sur `The-Ashams/iqura` |
| Affichage | Arabe RTL, diacritiques corrects, taille réglable ; translittération Arabica par défaut, simplifiée au choix (§6.2) ; clair et sombre ; animations désactivables |
| Ergonomie | Souris et clavier (Windows), tactile (Android), plusieurs tailles d'écran |
| Contenu | Leçons, dialogues, récits, quêtes, monstres, objets, régions, lieux : fichiers de données (JSON), pas de code |
| Lisibilité | Calcul automatique de la part de mots connus pour chaque texte (règle des 95 %, pourcentages du Sanctuaire) |

---

## 13. Jalons et ordre de travail

On avance **région par région**, chaque région complète et jouable. Le MVP est la région 1.

| Jalon | Contenu | Condition pour passer au suivant |
| --- | --- | --- |
| J0 — Socle | App Windows et Android, profil, sauvegarde, export, import, fusion, CI, audio | ✅ Fait |
| **J1a — Tranche verticale** | Leçons 0 à 3 complètes au format mini-donjon (§6) avec les corrections du §5.5, jouables de bout en bout dans le jeu : carte (premiers lieux de la région 1), scène d'Histoire, dialogues, mini-boss en combat, Expédition avec ces révisions, Grimoire minimal, Cité minimale (boutique, équipement, enchantement), Sanctuaire avec Al-Fātiḥa (repérage), audio, tracé, enregistrement, séries, mode « apprentissage seul » | **L'utilisateur joue 30 minutes et valide que c'est amusant et efficace.** Rien d'autre n'est produit en masse avant cette validation |
| J1b — Région 1 complète | Leçons 4 à 14, boss de région (trois évaluations), 100 mots, familles de mots dès la leçon 7, tous les lieux de la région 1 | Un débutant lit des mots vocalisés seul ; il revient plusieurs jours ; aucun bug bloquant |
| J2 — Région 2 | 30 leçons, 60 récits, mini-forges, Tour du Savoir, test de positionnement, sourates courtes au Sanctuaire | Compréhension de courts récits |
| J3 — Région 3 | 32 leçons, 80 récits, arbre des racines complet, tous les exercices de racines, Sort de racine | Décodage des familles de mots |
| J4 — Région 4 | 28 leçons, 100 récits et dialogues, écriture, option IA | Lecture courante |
| J5 — Région 5 | 24 leçons, sourates étudiées, lecteur coranique complet | Compréhension directe de sourates |

### 13.0 Niveaux de test (décision du 23/10/2026)

On ne teste plus leçon par leçon, mais **niveau par niveau**. Le programme est découpé en 14 niveaux :

| Niveau | Leçons |
| --- | --- |
| Débutant 1 | leçons 0 à 4 |
| Débutant 2 | leçons 5 à 9 |
| Débutant 3 | leçons 10 à 14 + boss de la région 1 |
| Élémentaire 1 | leçons 2.1 à 2.10 |
| Élémentaire 2 | leçons 2.11 à 2.20 |
| Élémentaire 3 | leçons 2.21 à 2.30 + boss de la région 2 |
| Intermédiaire 1 | leçons 3.1 à 3.10 |
| Intermédiaire 2 | leçons 3.11 à 3.21 |
| Intermédiaire 3 | leçons 3.22 à 3.32 + boss de la région 3 |
| Avancé 1 | leçons 4.1 à 4.14 |
| Avancé 2 | leçons 4.15 à 4.28 + boss de la région 4 |
| Coran 1 | leçons 5.1 à 5.12 |
| Coran 2 | leçons 5.13 à 5.20 |
| Coran 3 | leçons 5.21 à 5.24 |

Règles :

1. Claude Code construit un niveau entier (leçons, révisions, récits, parties du jeu nécessaires), le fait relire par l'agent `relecteur-arabe`, le teste lui-même, puis publie **une** version et demande à l'utilisateur de le tester. Pas avant.
2. Les questions de langue et les doutes du relecteur se règlent avec l'agent `conseiller-arabe`, sans l'utilisateur. À la fin de chaque niveau, Claude Code présente seulement la liste des décisions prises (10 points au plus).
3. Pendant que l'utilisateur teste un niveau, Claude Code commence le suivant. Les retours de l'utilisateur sont intégrés dès qu'ils arrivent.
4. La progression de l'utilisateur est conservée d'une version à l'autre.

Les jalons J1a à J5 ci-dessus décrivent le contenu de chaque région ; l'unité de construction et de test est désormais le niveau. Débutant 1 remplace la validation de J1a (leçons 0 à 3) et y ajoute la leçon 4.

### 13.1 Ordre de travail détaillé pour J1a

1. Présenter à l'utilisateur la liste de ce qui change dans l'existant (§0.1, point 5) et obtenir son accord.
2. Proposer les noms des lieux et personnages de la région 1 et le découpage de la région 1 en lieux (8 à 12), puis attendre la validation.
3. Construire la coquille du jeu en pixel art (§8.1) : carte à étapes, scène de dialogue, combat, Cité, Grimoire, Sanctuaire minimal — avec les maquettes existantes comme référence.
4. Réécrire les leçons 0 et 1 au format mini-donjon ; les montrer à l'utilisateur ; attendre sa validation.
5. Réécrire les leçons 2 et 3 sur le même modèle.
6. Brancher la révision FSRS, l'Expédition, les ressources, l'équipement et l'enchantement.
7. Tests (§14) et compilation Windows et Android ; envoyer à l'utilisateur la marche à suivre pour tester.
8. Recueillir ses retours, corriger, mettre à jour ce document et `docs/ETAT_DU_PROJET.md`.

---

## 14. Critères d'acceptation

Démontrés sur Windows et Android, compilations et tests réellement exécutés.

- [ ] Texte coranique identique octet pour octet à Tanzil (test d'empreinte).
- [ ] Aucun mot ni extrait coranique sur un monstre ou dans une attaque ; aucun verset en combat (test automatisé sur les contenus de combat).
- [ ] Chaque texte à lire respecte la règle des 95 % au moment où il est proposé.
- [ ] Chaque fiche affiche sa source ou « rédigé par IA ».
- [ ] Chaque mot, lettre et phrase des leçons du jalon a son audio, signalé « synthèse ».
- [ ] Révisions planifiées par FSRS ; jamais « maîtrisé » après une seule réussite ; vocabulaire adaptatif fonctionnel.
- [ ] Jamais deux réponses justes par erreur (test des distracteurs).
- [ ] Pierres de savoir uniquement via un changement d'état réel.
- [ ] Enchantement conforme aux taux affichés et à la pity (tests sur de nombreux tirages).
- [ ] Progression intacte après fermeture, export, import et fusion, sans double comptage.
- [ ] Tout fonctionne hors ligne, hors téléchargements.
- [ ] Aucun bouton sans fonction réelle.
- [ ] Licences de toutes les dépendances et ressources listées.

---

## 15. Décisions (toutes tranchées)

| N° | Sujet | Décision |
| --- | --- | --- |
| 1 | Audio | Chatterbox Multilingual avec coupure automatique ; récitations al-Ḥuṣarī pour le Coran |
| 2 | Style graphique | Pixel art type RPG japonais classique (§8.1) |
| 3 | Histoire | Cité du savoir, bibliothèque oubliée, 5 régions et adversaires (§8.2) ; noms définitifs à proposer en J1a |
| 4 | Seuil « sourate prête » | 80 % ; Al-Fātiḥa ouverte d'office |
| 5 | Récitateur | al-Ḥuṣarī |
| 6 | Conversation IA | Option en ligne à partir de J4, en arabe classique, désactivée par défaut |
| 7 | Registre de langue | Arabe classique partout, y compris la conversation |
| 8 | Ordre grammatical | Celui des §5.6 et §5.7, inchangé |
| 9 | Ordre des sourates | Celui du §5.9 |
| 10 | Carte du monde | Carte à étapes |
| 11 | Licence | GPL-3.0, dépendances auditées |
| 12 | Relecture | Aucun relecteur : sources citées, contenu IA marqué « rédigé par IA » |
| 13 | Compilation | Claude Code + GitHub Actions |

**Reste à faire côté utilisateur** : rien d'obligatoire. Adresse des signalements d'erreur : contact@edelwa.com (communiquée le 22/10/2026). Le mail de confirmation aux auteurs du Quranic Arabic Corpus est facultatif (Claude Code peut le rédiger).

---

## 16. Journal des décisions

| Date | Décision |
| --- | --- |
| 2026-10-20 | Application gratuite, open source GPL-3.0 ; vrai RPG ; enchantement +15 avec pity ; carte à étapes |
| 2026-10-21 | Cahier des charges v2 ; Coran jamais l'ennemi ; racines priorité majeure ; audio Chatterbox |
| 2026-10-22 | Format mini-donjon, précisions des leçons ; corrections des leçons 0 à 3 ; style pixel art type RPG japonais classique ; programme complet des 5 régions ; racines dès la région 1 ; Coran à chaque région ; vocabulaire adaptatif et passif/actif ; trois évaluations par examen ; objectifs intermédiaires ; gameplay détaillé ; prototype avant production ; arabe classique pour la conversation ; ordre des sourates et Histoire validés |
| 2026-10-22 | Cahier v3 appliqué : v2 archivée, `CLAUDE.md` réécrit ; liste des changements A1 à A7 de `docs/ETAT_DU_PROJET.md` acceptée en entier (leçons 0 à 3 réécrites au format mini-donjon avec les corrections du §5.5, sons des éléments retirés supprimés et nouveaux mots générés, coquille actuelle remplacée par le jeu en pixel art, aperçu adapté, noms de l'Histoire à revalider) |
| 2026-10-22 | Mention des contenus écrits par IA : « rédigé par IA » (sans « non vérifié »), comme demandé le 21/10/2026 ; passages du v3 corrigés en ce sens (§3.2, §7, §10, §11, §14, §15) |
| 2026-10-22 | Licence du Quranic Arabic Corpus : cahier corrigé d'après la notice du fichier (GNU GPL, usage dans toute application avec source, lien et notice) ; mail aux auteurs facultatif |
| 2026-10-22 | Schèmes : absents du Quranic Arabic Corpus 0.4 ; QUL (contenu et licence) sera examiné avant la région 3 ; rien n'est inventé d'ici là, la région 1 n'en a pas besoin |
| 2026-10-22 | Traduction : « Hamidullah, version diffusée par Tanzil (édition non précisée) » ; la révision du Complexe Roi Fahd (2000) n'est pas affirmée, faute de confirmation |
| 2026-10-22 | Police du Mushaf : Amiri Quran (OFL) gardée pour J1a ; licence de KFGQPC Hafs auditée avant la leçon 14, résultat présenté à l'utilisateur |
| 2026-10-22 | « Signaler une erreur » : petit formulaire, signalement gardé sur l'appareil, puis bouton « Envoyer » qui ouvre la messagerie du joueur avec un mail prérempli (fiche, version du contenu, description) ; rien n'est envoyé sans son action |
| 2026-10-22 | Adresse des signalements : une adresse dédiée au projet, à créer par l'utilisateur ; en attendant, le bouton garde les signalements sur l'appareil et indique que l'envoi n'est pas encore configuré |
| 2026-10-22 | Adresse des signalements d'erreur : contact@edelwa.com (visible dans le code public) |
| 2026-10-22 | Sort de racine : forme simple dès la leçon 7 (« ces mots sont-ils de la même famille ? ») jusqu'à la région 2, forme complète (racine, schème) en région 3 ; grisé avant la leçon 7 avec « débloqué à la leçon 7 » |
| 2026-10-22 | Région 1 « Le Désert des Lettres » : 12 lieux (Puits de l'arrivée, Porte de la bibliothèque, Marché aux enseignes, Caravansérail, Dunes chantantes, Atelier des copistes, Observatoire, Archives ensablées, Fontaine aux échos, Cour du cadran solaire, Salle des manuscrits, Faille des Oubliés) et Sanctuaire ; personnages Nūra (archiviste), Samīr (apprenti copiste), Laylā, Rāšid, Suhayl ; boss : le Gardien de l'Oubli ; porte fermée par 14 sceaux, un par leçon. Détail : `docs/HISTOIRE.md` |
| 2026-10-23 | Police des textes du jeu : DotGothic16 (OFL), pour la lisibilité des chiffres ; Amiri en secours pour la translittération |
| 2026-10-23 | Combat : on choisit une réponse, puis on la valide (bouton « Valider ») |
| 2026-10-23 | Relecture systématique par l'agent relecteur-arabe (`.claude/agents/relecteur-arabe.md`) |
| 2026-10-23 | Combat : plus de nom de lettre en lettres latines ; question « Écoute et choisis la lettre » (le nom de la lettre est joué, le joueur choisit parmi les lettres arabes). Les noms écrits restent dans les écrans de découverte |
| 2026-10-23 | بَاب gardé sous sa forme de pause en leçon 1 ; la forme complète بَابٌ est expliquée aux leçons 4 (sukūn) et 12 (tanwīn) |
| 2026-10-23 | Salles d'étude : le maître signale que d'autres petits signes, appris plus tard, sont présents dans les mots coraniques |
| 2026-10-23 | Mots présents dans le Coran admis seuls au mini-boss, en dictionnaire, dans un panneau neutre (conforme au §3.1, inchangé) |
| 2026-10-23 | Audio : voyelle finale avalée par la synthèse ; plusieurs tirages, texte donné à la synthèse ajusté si besoin (virgule finale, alif doublé : champ « ecrit » du manifeste), choix à l'écoute par l'utilisateur |
| 2026-10-23 | Bruitages : oui, sans musique pour l'instant (elle gênerait l'écoute des lettres) ; sons rétro créés pour le projet (`tools/build_sfx/`), les banques de sons libres n'étant pas joignables depuis la session ; désactivables dans les réglages ; écoutés par l'utilisateur avant d'être branchés |
| 2026-10-23 | Affichage sur PC : contenu du jeu centré et limité en largeur, scène de combat limitée en hauteur |
| 2026-10-23 | Leçon 0 : « margelle » remplacé par « le bord du puits » (mot trop rare) |
| 2026-10-23 | Tests par niveau (14 niveaux, §13.0) au lieu de leçon par leçon ; un niveau entier construit, relu, testé, puis une seule version publiée ; questions de langue réglées avec l'agent `conseiller-arabe` ; décisions présentées en fin de niveau (10 au plus) ; progression conservée d'une version à l'autre |
| 2026-10-23 | Agent `conseiller-arabe` rédigé par Claude Code à la demande de l'utilisateur (`.claude/agents/conseiller-arabe.md`) : tranche les questions de langue, motive chaque décision, choisit l'option la plus prudente en cas d'incertitude, ne tranche jamais l'exégèse |
| 2026-10-23 | Débutant 1 : tout le jalon J1a inclus (révisions FSRS, Expédition, ressources, boutique, équipement, enchantement, séries, apprentissage seul, tracé guidé, enregistrement de la voix) ; APK signé avec une clé fixe gardée dans les secrets GitHub |
| 2026-10-23 | États des éléments : « reconnu » à partir d'une stabilité FSRS de 7 jours, « maîtrisé » à partir de 21 jours (jamais après une seule réussite) ; cartes créées à la première réussite d'une leçon ; 20 révisions au plus par Expédition |
| 2026-10-23 | Valeurs initiales, à équilibrer : niveau n → n+1 = 100 × n XP ; révision juste 2 XP (1 si la carte est déjà très stable) ; vague 5 XP et 2 dinars, gardien 15 XP et 10 dinars ; série 5 dinars + 1 par jour (7 au plus) ; enchantement 10 × niveau dinars et (niveau + 2) / 3 pierres ; héros 50 PV et 10 d'attaque, +5 et +1 par niveau |
| 2026-10-23 | Combat d'entraînement de la Faille (qui proposait des translittérations) remplacé par l'Expédition et l'entraînement libre ; la translittération reste dans les explications montrées après les combats |
| 2026-10-24 | Retours du test de Débutant 1 : une question qui revient après une erreur (salle d'entraînement, Expédition, nouvelle tentative du mini-boss) affiche ses réponses à d'autres places, la bonne réponse n'étant jamais au même endroit |
| 2026-10-24 | Le thème clair s'applique aussi aux écrans du jeu (palette « parchemin ») ; il suit le réglage clair, sombre ou système |
| 2026-10-24 | Grand écran (PC, tablette) : toute l'interface est agrandie en gardant ses proportions (référence 1000 × 800, ×2,5 au plus) ; scène de combat haute de 30 % de la fenêtre au plus, pour que la question reste visible |
| 2026-10-24 | Translittération : la police du jeu est une copie de DotGothic16 sans ses accents séparés (« DotGothic16 IQURA », OFL, `tools/fonts/build_game_font.py`) ; ā, ḥ, ḫ, ǧ, ṯ viennent alors entiers d'Amiri (avant : « ḥa¯ » pour ḥāʾ et ḫāʾ) |
| 2026-10-24 | Texte français qui cite plusieurs mots arabes : une marque invisible suit chaque passage arabe pour garder l'ordre de la phrase (« بَ : بَاب ») |
| 2026-10-24 | Idées de l'utilisateur retenues pour les niveaux suivants : « reconstruire » décliné en modes (mot français → l'écrire en arabe, l'inverse, définition → retrouver le mot ou la racine) ; un mode consacré à l'écriture, jusqu'à des textes entiers ; le comptage des lettres en salle d'étude est apprécié |
