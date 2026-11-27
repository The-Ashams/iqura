# Relecture : Intermédiaire 1 (leçons 3.1 à 3.10), 2e passage

Agent : relecteur-arabe, 06 et 07/11/2026, sur les fichiers corrigés après le 1er passage (`2026-11-05-intermediaire-1-passage-1.md`). Une relecture par leçon.

| Leçon | Verdict |
| --- | --- |
| 3.1 | Validé avec doutes |
| 3.2 | Validé |
| 3.3 | Validé |
| 3.4 | Validé avec doutes |
| 3.5 | Validé |
| 3.6 | Validé |
| 3.7 | Validé avec doutes |
| 3.8 | Validé |
| 3.9 | Validé avec doutes |
| 3.10 | Validé |

Suites données : 3.9, « la fin » remplacé par « la terminaison », et fiche مَدِينَةٌ « ville » ajoutée (leçon 2.23, lemme `madiynap` et racine م د ن vérifiés dans le Corpus). Les doutes sont listés dans `decisions-intermediaire-1.md`.

---

# Rapport de relecture — Leçon 3.1 « La racine » (moteur-01), deuxième passage

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/01-la-racine.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiche saida)
- /home/user/iqura/lib/ui/game/lesson/fondations_views.dart (fiche de mot)

Stade : région 3, leçon 3.1 ; régions 1 et 2 acquises.

## Verdict : Validé avec doutes

Toutes les corrections du premier rapport sont faites et justes. Il reste deux choix d'affichage à faire trancher.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- Aucun.

## Doutes (à soumettre, ne pas trancher)
- [fondations_views.dart · fiche de mot] Ce qui me fait douter : la ligne « Schème (calculé à partir du Corpus) » s'affiche dès 3.1, alors que la notation فعل n'arrive qu'en 3.2. La ligne « Nom d'action » (صُعُودٌ sur la fiche de صَعِدَ) s'affiche aussi avant la leçon 3.4, qui enseigne cette notion. | Pistes : masquer ces deux lignes jusqu'aux leçons 3.2 et 3.4, ou les laisser comme un aperçu. C'est un choix de jeu, pas une erreur de langue. | Confiance : moyenne.

## Points vérifiés sans problème
- **Mini-boss** :
  - الْكُتَّابُ → ك ت ب. Le mot est connu : c'est le pluriel de كَاتِبٌ dans mots.json. Les distracteurs sont ل ك ت et ت ب ك. L'explication sur la shadda est juste.
  - يَحْمِلُونَ → ح م ل, avec les distracteurs ي ح م et م ل ن. Une seule bonne réponse.
  - L'explication de la question 9 cite كِتَابٌ, كَاتِبٌ, يَكْتُبُونَ : ce sont trois mots connus.
- **Règle « Trouver la racine »** : elle cite les préfixes du verbe (يَـ, تَـ, نَـ, سَـ) et la condition « s'il reste plus de trois lettres ». La règle est exacte et s'accorde avec les exercices الْمِفْتَاحُ, الْأَحْمَالُ et يَكْتُبُونَ.
- **Règle 1** : elle ajoute « parfois quatre : دِرْهَمٌ → د ر ه م ». C'est juste : la racine drhm est celle de la fiche.
- **Écran « Attention »** : il renvoie au chapitre C. L'avertissement du §7 est conservé mot pour mot.
- **الطُّلَّابُ** : l'explication sur la shadda (« ل, qu'on ne garde qu'une fois ») est juste.
- **Atelier** : la consigne « Il fait très froid » correspond bien à الْبَرْدُ كَثِيرٌ. Le conseiller a décidé de garder cette tournure.
- **Fiche de صَعِدَ** : le nom d'action صُعُودٌ (ṣuʿūd) est le maṣdar usuel. Il est bien vocalisé.
- **Fiche de mot** : les étiquettes « (appris plus tard) » ont disparu. « Présent » est remplacé par « Inaccompli », qui est le terme de la région 2.
- **Catégorie A** : les corrections n'ajoutent aucune suite marquée ⚠ dans le plan.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas exécuté le garde-fou coranique ni la construction de la base. Leurs résultats font foi.

---

# Rapport de relecture : leçon 3.2 « Le schème » (second passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/02-le-scheme.json
- /home/user/iqura/tools/build_content/vocab/mots.json

Stade : région 3, leçon 3.2. Notions supposées acquises : régions 1 et 2 entières, leçon 3.1.

## Verdict : Validé

Toutes les corrections demandées au premier passage sont faites et justes. Je n'ai rien trouvé de nouveau.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- Aucun.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- Aucun.

## Points vérifiés sans problème
- **Schèmes ajoutés sur les fiches (E)** : tous sont exacts.
  - jabal : فَعَل, pluriel فِعَال (جِبَال)
  - qalam : فَعَل, pluriel أَفْعَال (أَقْلَام)
  - kitab : فِعَال, pluriel فُعُل (كُتُب)
  - jidar : فِعَال, pluriel فُعُل (جُدُر)
  - kalb : فَعْل, pluriel فِعَال (كِلَاب)
  - lahm : فَعْل, pluriel فُعُول (لُحُوم)
  - šams : فَعْل
  - kataba, fataha, jalasa : فَعَلَ
- **Noms d'action** : ceux qui figurent sur ces fiches sont justes : كِتَابَةٌ, فَتْحٌ, جُلُوسٌ.
- **Fiche taraqa** : son nom d'action طَرْقٌ est juste.
- **Les deux forges (E, F)** : قَلَمٌ et جِبَالٌ ont maintenant un schème vérifié à la construction. Cela respecte le principe B4 du conseiller.
- **Règle « Le moule » (F)** : « كِتَاب → فِعَال » s'écrit maintenant sans tanwīn.
- **Nouvel écran « D'autres moules » (C, F)** :
  - l'explication est exacte : فَعِلَ pour شَرِبَ et سَمِعَ, et un second ل pour une racine de quatre lettres (دِرْهَم → فِعْلَل) ;
  - les trois mots sont déjà connus (leçons fondations-22, fondations-28 et fondations-12) ;
  - le QCM sur شَرِبَ a une seule bonne réponse, فَعِلَ ;
  - le texte arabe ne reprend aucune suite du Coran.
- **Traduction (D)** : la consigne dit maintenant « Hilāl a frappé à la porte. »
- **Contrôles du premier passage (A à G)** : ils restent valables pour le reste de la leçon, qui n'a pas changé.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas lancé la construction, ni `quran_guard.py`, ni les tests. Il faut une preuve que la construction passe : `build_content.py` puis `unittest`.
- L'absence du verbe طَرَقَ dans le Corpus, et donc la fiche taraqa sans lemme, reste à confirmer. La construction contrôle que la racine Trq existe.

---

# Rapport de relecture — Leçon 3.3 (moteur-03), second passage

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/03-celui-qui-fait.json et la fiche kharij dans /home/user/iqura/tools/build_content/vocab/mots.json.
Stade : région 3, leçon 3.3 ; acquis : régions 1 et 2, leçons 3.1 et 3.2.

## Verdict : Validé

Les cinq corrections demandées sont faites et justes. Il reste deux petits points du premier passage, sans gravité, qui ne bloquent pas la validation.

## Bloquant
- Aucun.

## Important
- Aucun. Le point du premier passage est corrigé : l'exemple de la fiche kharij est maintenant `الْحَارِسُ خَارِجٌ.` (« Le gardien est dehors. »). Le participe est au nominatif avec tanwīn, en attribut, conforme à la leçon.

## Mineur
Deux points du premier passage restent ouverts, à corriger si c'est simple :
- **[mots.json · catégorie (`nature`)]** Les fiches restent incohérentes : jalis, maktub et maftuh sont des « adjectif » ; hamil, kharij et rakib sont des « nom ».
- **[mots.json · sani, sakin · `scheme_pluriel` فُعَّال]** Ce moule de pluriel est affiché avant la leçon 3.7, où il est exercé. Acceptable en simple affichage.

## Doutes
- Aucun. Le doute du premier passage (مَفْعُول d'un verbe sans complément direct) a été tranché par le conseiller, et la décision est bien reprise dans la leçon.

## Points vérifiés sans problème
- **Explication de `رَاكِبُ الْجَمَلِ`** : « Ici, on emploie l'iḍāfa… (l'autre construction viendra plus tard) ». Elle n'affirme plus de règle fausse.
- **Atelier** : le distracteur `الشَّيْخُ جَالِسَةٌ فِي الْخَيْمَةِ.` est faux uniquement par l'accord (masculin / féminin), une notion déjà vue. Il reste une seule bonne réponse.
- **2e règle** : le titre est « Féminin, et verbes sans complément direct ». Le texte dit « n'a pas de مَفْعُول employé seul : on dit جَالِسٌ, خَارِجٌ », ce qui est exact et conforme à la décision.
- **QCM sur جَلَسَ** : choix « non : pas de مَفْعُول employé seul » et explication cohérents avec la règle, une seule bonne réponse.
- **Écran de fin** : la mise en garde sur مُسَافِرٌ et مُعَلِّمٌ (« un autre moule, vu plus tard ») est conforme au plan du conseiller.
- **Contrôle du Coran** : je n'ai trouvé aucune suite coranique dans les phrases nouvelles (`الْحَارِسُ خَارِجٌ`, `الشَّيْخُ جَالِسَةٌ فِي الْخَيْمَةِ`). Vocalisation complète et juste.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas lancé le garde-fou `quran_guard.py`, faute d'outil d'exécution ici. C'est la construction qui fait foi.

---

# Rapport de relecture (2e passage) : leçon 3.4 « Le nom d'action » et champ nom_action

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/04-le-nom-d-action.json
- /home/user/iqura/tools/build_content/vocab/mots.json : les fiches de moteur-04 et le champ `nom_action` des fiches de verbes

Stade : région 3, leçon 3.4. Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.3.

## Verdict : Validé avec doutes

## Bloquant
- Aucun.

## Important
- Aucun. Les deux points Important du 1er passage sont corrigés :
  - **قَبْلَ** : il est retiré de l'aperçu de la leçon. L'exemple de فَهْمٌ est maintenant « فَهْمُ الدَّرْسِ جَمِيلٌ. », traduit « Comprendre la leçon est une belle chose. » La phrase est juste et ne contient que des mots connus.
  - **Mini-boss** : la consigne est maintenant « La mémorisation des mots, c'est le soir. » Elle appelle un nom, donc حِفْظُ est la seule bonne réponse. حِفْظٌ (tanwīn devant un complément) et حَفِظَ ne conviennent plus.

## Mineur
- Aucun nouveau. Les corrections annoncées sont toutes en place :
  - « L'entrée au marché, c'est le matin » ;
  - « a lieu le matin » (dans la leçon et sur la fiche) ;
  - « une belle chose » ;
  - « كُتُبٌ جَمْعُ كِتَابٍ. » ;
  - la règle « Pour les verbes que tu connais… on l'apprend avec le verbe, sur sa fiche ».

## Doutes (à soumettre au conseiller-arabe)
- **[mots.json · nom_action sur les verbes des régions 1 et 2]** Le champ figure maintenant sur des verbes appris dès fondations-01 (ذَهَبَ, خَرَجَ, دَخَلَ…). Ce qui me fait douter : si l'application l'affiche avant la leçon 3.4, l'apprenant voit des noms d'action pas encore enseignés, ce qui touche les prérequis. Piste : ne l'afficher sur la fiche qu'une fois moteur-04 terminée. Confiance : moyenne. Je n'ai pas lu le code d'affichage.
- **[mots.json · plusieurs formes possibles]** Pour certains verbes, l'arabe classique connaît plusieurs noms d'action. La fiche n'en donne qu'un, ce qui est un choix défendable, pas une erreur :
  - كَتَبَ : كِتَابَةٌ, mais aussi كَتْبٌ ;
  - دَرَسَ : دِرَاسَةٌ, mais aussi دَرْسٌ (la leçon le signale déjà) ;
  - عَرَفَ : مَعْرِفَةٌ, mais aussi عِرْفَانٌ ;
  - لَعِبَ : لَعِبٌ, mais aussi لِعْبٌ ;
  - صَنَعَ : صُنْعٌ, mais aussi صَنْعَةٌ.

  Piste : garder une seule forme, peut-être avec une mention « forme la plus courante ». Confiance : moyenne.

## Points vérifiés sans problème
- **Les 25 formes de nom_action sont correctes et bien vocalisées** :
  - ذَهَابٌ, خُرُوجٌ, دُخُولٌ, كِتَابَةٌ, جُلُوسٌ ;
  - رُجُوعٌ, شُرْبٌ, فَرَحٌ, لَعِبٌ, فَتْحٌ ;
  - حَمْلٌ : bonne distinction avec حِمْلٌ « charge » ;
  - رُكُوبٌ, بُلُوغٌ, تَرْكٌ, طَلَبٌ, جَمْعٌ ;
  - مَعْرِفَةٌ, دِرَاسَةٌ, حِفْظٌ, صُنْعٌ ;
  - لُبْسٌ : bon choix, لَبْسٌ voudrait dire « confusion » ;
  - فَهْمٌ, زَرْعٌ, صُعُودٌ, طَرْقٌ.
- **Verbes sans nom d'action, ce qui est prudent** :
  - سَمِعَ (le plan interdit سَمْع) ;
  - سَكَنَ (la forme est ambiguë) ;
  - قَالَ (racine faible).
- **Les lemmes du Corpus vus au 1er passage sont cohérents avec ces formes** : ذَهَاب, شُرْب, طَلَب, جَمْع, حِفْظ, دِرَاسَت, خُرُوج.
- **A. Respect du Coran** : ce sont des mots isolés sous leur forme de dictionnaire, et aucune nouvelle phrase ne reprend une suite connue du Coran.
- **F. Pédagogie** : à la relecture, chaque exercice de la leçon garde une seule bonne réponse.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas exécuté la construction ni `quran_guard.py`.
- Je n'ai pas vérifié à quel moment l'application affiche le champ `nom_action`.

---

# Rapport de relecture : leçon 3.5 « Lieux et instruments », second passage

Fichier relu : /home/user/iqura/tools/build_content/lessons/etape3/05-lieux-et-instruments.json (seulement les endroits corrigés)
Stade : région 3, leçon 3.5. Acquis : régions 1 et 2, leçons 3.1 à 3.4.

## Verdict : Validé

Les cinq corrections sont faites et sont justes.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- Aucun.

## Doutes
- Aucun. Le doute sur le distracteur « jardin » est levé : il est remplacé par « marché ».

## Points vérifiés sans problème
- **Question « la sortie » (ancien point Important)** : la consigne et l'explication disent maintenant « la sortie (le lieu par où l'on sort) ». Seule الْمَخْرَجُ convient, il n'y a plus deux bonnes réponses.
- **Règle « Le lieu »** :
  - le texte dit maintenant « parfois avec ة (مَدْرَسَةٌ) » ;
  - l'explication de la question donne « Moule مَفْعَلَة » ;
  - c'est cohérent et suffisant pour un débutant.
- **مِيزَانٌ** : « sa racine est و ز ن : le و s'est changé en ي ; tu verras pourquoi plus tard ». C'est exact.
- **Exercice à ordonner « La lampe est sur le mur. »** :
  - la tuile تَحْتَ remplace فِي ; c'est un mot connu (fondations-13, « sous ») ;
  - la solution الْمِصْبَاحُ عَلَى الْجِدَارِ est inchangée et juste ;
  - le rapprochement avec « الْمِصْبَاحُ فِي » a disparu.
- **Question sur مَزْرَعَةٌ** : les choix sont « ferme, champ / marché / école ». Une seule bonne réponse, les distracteurs sont plausibles.
- **مَغْرِبٌ et مِفْعَل non ajoutés** : je l'accepte comme écart volontaire au plan. Il n'y a aucune erreur de langue. À noter dans les décisions de fin de niveau.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas exécuté `quran_guard.py` ni la vérification « schème + racine = mot » de la construction.

---

# Rapport de relecture — Leçon 3.6 « Adjectifs et intensifs » (second passage)

Fichier relu : /home/user/iqura/tools/build_content/lessons/etape3/06-adjectifs-et-intensifs.json
Stade : région 3, leçon 3.6 ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.5

## Verdict : Validé

Les trois corrections sont dans le fichier et sont justes.

## Bloquant
- Aucun.

## Important
- Aucun. Le point du premier passage est corrigé : la consigne de l'exercice à remettre dans l'ordre (écran « atelier ») dit maintenant « Le porteur (de métier) a porté les charges. ». La tuile piège الْحَامِلُ n'est donc plus une deuxième bonne réponse.

## Mineur
- « La corde est faible » sonne un peu raide en français. Le corriger est facultatif.

## Doutes
- Aucun doute ouvert. Les trois points du premier passage sont réglés :
  - le conseiller a tranché pour سَرِيعٌ : autorisé en combat, au sens général, jamais en annexion ;
  - le conseiller a tranché pour le lemme m~ariyD : seul le champ `ar` est affiché ;
  - la phrase à sujet indéfini est remplacée.
- Les exceptions de فَعِيل restent sur l'écran de فَعَّال, comme décidé (règle de deux phrases). Je l'accepte.

## Points vérifiés sans problème
- **C. Forme** :
  - « فِي الْمَجْلِسِ رَحَّالٌ مِنَ الْمَدِينَةِ. » est juste. Le lieu est placé devant le sujet indéfini, ce qui suit la règle de la leçon 2.15.
  - La phrase est entièrement vocalisée, avec les bons cas : génitif après فِي et مِنْ, nominatif avec tanwīn pour le sujet.
- **F. Pédagogie, questions de lecture** :
  - « Comment va le vieil homme aujourd'hui ? » a une seule bonne réponse, « il est malade », et l'explication l'appuie (الشَّيْخُ مَرِيضٌ الْيَوْمَ).
  - « Qui est dans la salle de réunion ? » a une seule bonne réponse, « un grand voyageur de la ville ». L'explication reprend la nouvelle phrase.
- **F. Prérequis** : la nouvelle phrase n'emploie que des mots déjà connus.
- **A. Coran** : je n'ai repéré aucune suite coranique dans la nouvelle phrase. Le Coran a « فِي الْمَجَالِسِ » au pluriel ; ici, c'est le singulier.

## Ce que je n'ai pas pu vérifier
- L'exécution de `quran_guard.py` et de la construction : je n'ai pas pu lancer de commande. Le résultat de la construction fait foi.

---

# Rapport de relecture : leçon 3.7 « Du pluriel au singulier » (second passage)

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/07-les-pluriels-internes.json ; /home/user/iqura/tools/build_content/vocab/mots.json (fiches tifl, sarj, sahn)
Stade : région 3, leçon 3.7 ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.6.

## Verdict : Validé avec doutes

Toutes les corrections du premier passage sont faites. Il ne reste aucun point Bloquant ni Important.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- [07 · écrans « regle »] Il reste un point mineur du premier rapport : la règle « un pluriel de choses s'accorde au féminin singulier (2.18) » n'apparaît toujours que dans les explications d'exercices (طَوِيلَةٌ, جَدِيدَةٌ). Il n'y a pas d'écran de règle. Tu peux l'ajouter si c'est simple, sinon le laisser.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- Aucun nouveau. Les doutes du premier passage ont été tranchés par le conseiller : la remarque de طِفْلٌ est retirée et سَرْجٌ reste sous س ر ج.

## Points vérifiés sans problème
- **D/F4** : le distracteur الرِّجَالُ ne laisse qu'une bonne réponse pour « les enfants ». Pour le distracteur « الطِّفْلَانِ فِي الْحَدِيقَةِ. », la phrase est juste en arabe mais ne veut pas dire « les enfants » ; le duel est déjà vu en région 2 et l'explication est exacte. Pour طِفْلٌ, le distracteur « vieil homme » n'est pas ambigu.
- **F8** : مَائِدَة a disparu de la leçon et de l'aperçu, et مَدَارِسُ a été retiré de l'aperçu. La phrase « … فِي السِّلَالِ. » et l'exemple de la fiche « الصَّحْنُ فِي السَّلَّةِ. » n'emploient que des mots connus. Le génitif après فِي est juste, et les traductions sont fidèles (« Les plats sont dans les paniers », « Le plat est dans le panier »).
- **B3 (racines du Corpus)** : la Forge « ن ج م dans فُعُول → نُجُومٌ » emploie une racine admise. Le pluriel est sur une fiche et les distracteurs sont des mots connus. L'explication de صُحُونٌ ne parle plus de moule. L'écran « fin » donne نُجُومٌ → نَجْمٌ.
- **F5** : les formulations sont corrigées : « ne se prévoit pas à coup sûr » (règle et mini-boss), « celui qui exerce un métier ». Le titre « Du pluriel au singulier » ne fait plus doublon avec la leçon 2.18.
- **C/E** : le sens de صَحْنٌ est maintenant « plat, écuelle ». La remarque est retirée de la fiche tifl ; le lemme Tifol et les schèmes فِعْل → أَفْعَال restent inchangés et justes. La vocalisation est complète partout où il y a eu une modification.
- **A** : les modifications n'introduisent aucun ⚠ du plan ni aucune suite coranique repérée.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas pu lancer le garde-fou `quran_guard.py` ni le validateur de construction, faute d'outil d'exécution : ce sont eux qui font foi. C'est la seule raison du « avec doutes ».

---

# Rapport de relecture : leçon 3.8 « Plus grand, le plus grand » (second passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/08-plus-grand.json
- /home/user/iqura/tools/build_content/vocab/mots.json (les 8 fiches « moteur-08 »)

Stade : région 3, leçon 3.8 ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.7.

## Verdict : Validé

Les corrections demandées sont toutes faites et justes. Il reste seulement un point mineur, facultatif.

## Bloquant
- Aucun. La fiche صَعْبٌ a maintenant pour exemple « دَرْسُ أَمْسِ صَعْبٌ. ». Il n'y a plus de « إِلَى الْجَبَلِ ».

## Important
- Aucun. Chaque correction est en place :
  - **Règle de l'invariabilité, limitée à la tournure avec مِنْ** : dans la règle 1, dans l'explication de أَطْوَلُ et dans la remarque de la fiche أَكْبَرُ.
  - **Aperçu de الْكُبْرَى dans la règle 2** : le mot est déclaré dans `apercu`. C'est un mot isolé, ce qui est admis.
  - **Mini-boss** : la question est maintenant « Dans « الْبِنْتُ أَصْغَرُ مِنَ الْوَلَدِ », أَفْعَلُ au féminin… ». Une seule bonne réponse.
  - **Question du dialogue** : « D'après Bāsim… », avec Salmā comme distracteur. Une seule bonne réponse.
  - **Question de lecture** : « Qui est plus jeune : Salmā ou Bāsim ? », avec le choix « on ne sait pas ». La réponse se déduit du texte.
  - **Exemple de أَكْثَرُ** : il emploie maintenant الْحَمِيرِ, un pluriel déjà affiché. الْخَيْلِ est retiré de `apercu` et n'apparaît plus nulle part.
  - **Explication de دَرْسُ الْيَوْمِ** : elle est ajoutée (« الْيَوْمِ est le nom « le jour », en iḍāfa »).
  - **Autres explications** : أَصْغَرَ (attribut en -u) et بَعِيدٌ مِنَ (« loin de ») sont justes. « le pont le plus long » est corrigé.

## Mineur
- [08 · trois exercices de la Forge] La consigne dit « moule أَفْعَل » et l'explication dit « dans أَفْعَلُ ». La notation n'est toujours pas harmonisée (principe B2). C'est facultatif.
- [mots.json · `sab`] « دَرْسُ أَمْسِ صَعْبٌ. » est traduit par « était difficile » ; la phrase nominale n'a pas de temps. C'est acceptable et cohérent avec la question de lecture. Aucune action nécessaire.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- Aucun. Le conseiller a tranché le seul doute : il garde « أَكْبَرُ est toujours un verbe ». Avec « toujours », ce distracteur est bien faux.

## Points vérifiés sans problème
- **A** :
  - aucune paire ⚠ du plan 3.8, aucun sujet pronom, aucun tamyīz ;
  - aucun mot sans tanwīn après une préposition ;
  - à ma connaissance, « أَكْثَرُ مِنَ الْحَمِيرِ » et « دَرْسُ أَمْسِ صَعْبٌ » ne reproduisent aucune suite coranique.
- **C** : la vocalisation et les cas des phrases modifiées sont corrects.
- **F** :
  - une seule bonne réponse dans chaque QCM modifié ;
  - tous les mots employés sont connus (حَمِيرٌ figure sur la fiche حِمَار).
- **G** : « rédigé par IA » est présent sur les fiches.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas pu exécuter le garde-fou `quran_guard.py` ni la construction. Il faut lancer `python3 tools/build_content/build_content.py` pour confirmer.
- Les fréquences ne sont pas lisibles par une recherche de texte dans la base.
- L'audio est suspendu.

---

# Rapport de relecture — Leçon 3.9 « L'adjectif de relation » (second passage)

Fichier relu : /home/user/iqura/tools/build_content/lessons/etape3/09-l-adjectif-de-relation.json
Stade : région 3, leçon 3.9 (Intermédiaire 1) ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.8.

## Verdict : Validé avec doutes

## Bloquant
- Aucun.

## Important
- Aucun. Le point du premier passage est corrigé : le distracteur `هُوَ تَاجِرٌ الْمِصْرِيُّ.` est nettement fautif (nom indéfini, adjectif défini). Il ne reste donc qu'une seule bonne réponse.

## Mineur
- [écran « La nisba », texte] « après avoir enlevé l'article, ة et la fin » : le mot « la fin » est vague pour un débutant. | Proposition : « …l'article, ة et la terminaison (ـٌ / ـُ) ». | Confiance : haute.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [lecture, phrase 1 `فِي الْمَجْلِسِ تُجَّارٌ مِنَ الْمَدِينَةِ.`] Ce qui me fait douter : la phrase est juste (مِنْ suivi d'un nom ordinaire au génitif, pas un nom de ville sans tanwīn). Le mot مَدِينَة est connu depuis 2.23 (بَلَغَتِ الْقَافِلَةُ الْمَدِينَةَ) et revient souvent dans la région 2, donc la règle des 95 % est respectée. Mais il **n'a pas de fiche** dans /home/user/iqura/tools/build_content/vocab/mots.json : on ne le trouve que dans l'exemple de بَلَغَ. Or l'écran dit « touche un mot pour voir son sens ». Cela peut gêner, et le problème existait déjà avant 3.9. | Pistes : créer une fiche مَدِينَةٌ « ville » (la racine et le lemme sont à vérifier dans la base du Corpus avant de les afficher), ou vérifier que l'application gère un mot sans fiche. | Confiance : haute que la fiche manque ; je ne sais pas si c'est voulu.

## Points vérifiés sans problème
- Corrections bien appliquées :
  - entrée « un nom (de lieu, de peuple…) » ;
  - exemple `الْهِنْدُ → هِنْدِيٌّ` dans la règle, et الْهِنْدُ dans l'aperçu (au nominatif, sans préposition) ;
  - attribut `سَلْمَى دِمَشْقِيَّةٌ` ;
  - « au nominatif » dans les trois explications concernées ;
  - phrase sur كُرْسِيٌّ gardée, comme l'a décidé le conseiller ;
  - كَثِيرُونَ retiré.
- A : aucune suite coranique repérée dans les phrases nouvelles. La phrase est construite sur فِي الْمَجْلِسِ, et non sur فِي الْمَدِينَةِ ni فِي الْمَجَالِسِ, et تُجَّارٌ مِنَ الْمَدِينَةِ n'est pas une suite coranique. Aucune nisba religieuse.
- C : vocalisation et accords justes dans tout le fichier modifié.
- F : une seule bonne réponse dans chaque QCM ; questions de lecture inchangées et toujours justes.

## Ce que je n'ai pas pu vérifier
- Le passage du garde-fou `quran_guard.py` (non exécuté).
- L'affichage d'un mot sans fiche dans la salle de lecture.

---

# Rapport de relecture : leçon 3.10, second passage

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/10-ce-que-la-racine-ne-dit-pas.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiche sukun)

Stade : région 3, leçon 3.10. Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.9.

## Verdict : Validé

## Bloquant
- Aucun.

## Important
- Aucun. Les trois points Importants du premier passage sont corrigés :
  - L'écran de règle présente maintenant les cinq relations, chacune avec un exemple juste : proches (كَتَبَ → كَاتِبٌ), intensifs (حَامِلٌ → حَمَّالٌ), spécialisés (طَالِبٌ), figurés (طَرِيقٌ → طَرِيقَةٌ), éloignés (جَمَلٌ / جَمِيلٌ). La question sur « figurée » arrive donc après la notion.
  - Lecture : le distracteur « dans la rivière » remplace « dans le palais ». Il n'y a plus qu'une bonne réponse.
  - Mini-boss : « الصَّيْفُ » remplace « الْيَوْمَ ». Les trois choix sont au nominatif et il n'y a plus de second sens « le jour ».

## Mineur
- Aucun. Toutes les corrections sont en place :
  - consigne « Que montrent ces phrases ? » ;
  - explication « تَمْرَةٌ (une datte) » ;
  - « الْمَفْتُوحُ » au lieu de « الْفَتْحُ » ;
  - distracteur « porte » ;
  - fiche سُكُونٌ avec « ; calme, immobilité (sens général) ».

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- Aucun nouveau doute. Ceux du premier passage sont réglés :
  - « histoire » et « الْقِصَّةُ » remplacent « chemin » et « الطَّرِيقُ » : il n'y a plus de risque de double bonne réponse.
  - Atelier : « مِطْرَقَةُ » est un bon distracteur, de même racine, au sens différent et sans tanwīn. Il est grammatical mais faux par le sens, comme on l'attend. La nouvelle explication sur le tanwīn perdu dans l'iḍāfa est exacte.
  - L'explication « De « chemin » à « manière de faire » : sens figuré. » suit la décision du conseiller et n'affirme aucune étymologie.

## Points vérifiés sans problème
- A : aucune nouvelle suite de mots susceptible de reprendre le Coran. Les ⚠ du plan sont toujours respectés (pas de نَهَار avec لَيْل).
- C : vocalisation complète et juste de tous les éléments modifiés (الصَّيْفُ, الْمَفْتُوحُ, مِطْرَقَةُ, الْقِصَّةُ, حَامِلٌ → حَمَّالٌ).
- D : sens justes, y compris le sens général ajouté à سُكُونٌ.
- F : 3 choix par QCM, une seule bonne réponse partout. « الصَّيْفُ » est couvert par l'aperçu de la leçon (« الصَّيْفِ »), et les autres mots sont connus.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas lancé la construction (`build_content.py` et `quran_guard.py`). C'est elle qui fait foi pour les suites coraniques et les mots connus ; il faut confirmer qu'elle passe.
