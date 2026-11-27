# Relecture : Intermédiaire 1 (leçons 3.1 à 3.10), 1er passage

Agent : relecteur-arabe, 05/11/2026. Une relecture par leçon. Corrections faites le jour même (voir le second passage).

---

## Rapport de relecture — Leçon 3.1 « La racine » (moteur-01)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/01-la-racine.json
- /home/user/iqura/tools/build_content/vocab/mots.json : fiches dars, bard, thalj, sakhra, fahm_charbon, nuhas, saida

Pour comparer, j'ai aussi lu le plan /home/user/iqura/docs/relectures/decisions-intermediaire-1.md, le contrôle de construction (`fondations.py`, `lessons.py`, `vocab.py`) et l'affichage des fiches (/home/user/iqura/lib/ui/game/lesson/fondations_views.dart). J'ai cherché les lemmes par recherche de texte dans `assets/content/iqura_content.db`.

Stade : région 3, leçon 3.1 ; notions supposées acquises : toute la région 1 et la région 2 (leçons 2.1 à 2.30), dont la phrase verbale avec le verbe en tête au singulier (2.23), le futur (2.28), les relatifs (2.30) et لَمْ suivi du verbe au mode jussif.

## Verdict : À corriger

Il n'y a aucun point de la catégorie A et aucune forme arabe fausse. Restent deux points Importants de prérequis et de règle.

## Bloquant
- Aucun.

## Important
- [01-la-racine.json · mini_boss, questions 5 et 7, et explication de la question 9] **Problème** : مَكْتُوبٌ et حَامِلٌ sont des mots de la leçon 3.3 (`"lecon": "moteur-03"` dans mots.json). Ils sont inconnus en 3.1. Le plan du conseiller fixe pourtant l'objectif « extraire la racine d'un **mot connu** », et ni l'un ni l'autre n'est dans sa liste de mots connus à réutiliser. L'explication de la question 9 (« … كَاتِبٌ, مَكْتُوبٌ ») les utilise aussi. Le contrôle de construction n'a pas arrêté ces mots ; ce point est à vérifier dans `vocab.unknown`. **Correction proposée** : remplacer par des mots connus qui demandent le même travail.
  - Pour مَكْتُوبٌ (on enlève un م ajouté) : مَفَاتِيحُ est déjà utilisé, mais on peut prendre مَطْبَخٌ (ط ب خ, mot connu d'après le plan) ou الْكُتَّابُ (ك ت ب).
  - Pour حَامِلٌ : الْحِمْلُ ou يَحْمِلُونَ (ح م ل).
  - Explication de la question 9 : « ك ت ب reste ك ت ب dans كِتَابٌ, كَاتِبٌ, يَكْتُبُونَ ».
  - **Confiance** : haute (les mots sont inconnus) ; moyenne pour la gravité (l'exercice ne demande pas le sens du mot).
- [01-la-racine.json · écran règle « Trouver la racine », texte] **Problème** : la règle dit « Enlève l'article, la fin du mot et les voyelles longues ا, و, ي ; parfois aussi un م ou un أ ajouté au début ». Elle ne mentionne pas les préfixes du verbe (يَـ, تَـ, أَ, نَـ, سَـ). Or يَكْtُبُونَ figure dans les exemples et dans un exercice « ordonner » dont les tuiles contiennent ي. Le ي de يَكْتُبُونَ est une consonne, pas une voyelle longue : en suivant la règle à la lettre, l'apprenant le garde et se trompe. La règle omet aussi la condition du plan : on n'enlève م ou أ que « s'il reste plus de trois lettres ». **Correction proposée** : « Enlève l'article, la fin du mot (ـُونَ, ـنَا, ـتُ…), les préfixes du verbe (يَـ, تَـ, نَـ, سَـ) et les voyelles longues ا, و, ي ; s'il reste plus de trois lettres, enlève aussi un م ou un أ du début. » Il faut garder cet écran court (un écran = une idée). **Confiance** : haute.

## Mineur
- [01-la-racine.json · atelier, exercice 3] La consigne « Complète : « Le froid est grand. » » ne correspond pas à الْبَرْدُ كَثِيرٌ, traduit ailleurs dans la leçon par « il fait très froid ». كَثِيرٌ veut dire « nombreux, abondant » sur sa fiche, pas « grand ». **Correction** : « Complète : « Il fait très froid. » ». Confiance : haute.
- [01-la-racine.json · entraînement, ordonner الطُّلَّابُ] L'écran « Attention » dit que, avec une lettre doublée, la racine peut se cacher. Ici, la shadda vient du moule et non de la racine. **Correction** : compléter l'explication : « On enlève الـ, le ا long et la fin ; la shadda double ل, qu'on ne garde qu'une fois : ط ل ب. » Confiance : haute.
- [01-la-racine.json · écrans règle] Deux points du plan B3 et D 3.1 ne sont pas couverts :
  - **Quadrilitères** : la définition « trois lettres (parfois quatre) » manque. L'aperçu avec دِرْهَمٌ (racine drhm, déjà sur sa fiche) et قِرْطَاسٌ n'est pas fait, alors que دِرْهَمٌ sert de distracteur au mini-boss.
  - **Racines faibles** : l'écran d'aperçu prévu est réduit à une phrase, sans les exemples بَيْتٌ (ب ي ت) et حَارٌّ (ح ر ر) ni le renvoi aux leçons 3.22 à 3.26. « (plus tard) » est vague.
  - **Correction** : ajouter « (parfois quatre : دِرْهَمٌ → د ر ه م) » à la première règle, et préciser « tu les étudieras aux leçons 3.22 à 3.26 ». Confiance : haute (écart au plan).
- [fondations_views.dart, l. 148 à 159 · fiche de mot, hors fichiers de la leçon mais visible dès 3.1]
  - Le champ « Schème (calculé à partir du Corpus) » s'affiche sur les fiches de 3.1 (دَرْسٌ فَعْل, صَعِدَ فَعِلَ…), alors que la notation فعل n'est enseignée qu'en 3.2.
  - Les étiquettes « Pluriel (appris plus tard) » et « Présent (appris plus tard) » sont périmées en région 3 : les pluriels et l'inaccompli sont acquis. Le terme de la région 2 est aussi « inaccompli », pas « présent ».
  - **Correction** : masquer le schème avant 3.2, ou expliquer qu'il sera lu à la leçon suivante. Retirer « (appris plus tard) » à partir de la région 3. Confiance : haute sur le constat, la solution est un choix de jeu.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [01-la-racine.json et fiche bard · الْبَرْدُ كَثِيرٌ, « il fait très froid »] **Ce qui me fait douter** : en arabe classique, la tournure attendue pour le froid est الْبَرْدُ شَدِيدٌ (ou اشْتَدَّ الْبَرْدُ). كَثِيرٌ avec بَرْدٌ se comprend, et l'on trouve كَثِيرُ الْبَرْدِ pour une contrée, mais en attribut c'est moins naturel. شَدِيدٌ n'est pas dans mots.json, et la tournure vient du plan du conseiller. **Pistes** : garder كَثِيرٌ, ou introduire شَدِيدٌ plus tard. **Confiance** : moyenne-basse que ce soit une faute ; plutôt une question d'usage.
- [01-la-racine.json · échauffement, question 1, et lecture] Le ⚠ du plan sur les verbes de mouvement vise الْجِبَالُ suivi d'un verbe et إِلَى / عَلَى جَبَلٍ, pas صَعِدَ … الْجَبَلَ. Je ne connais aucune suite coranique ici, mais je cite de mémoire : le garde-fou de construction fait foi. **Confiance** : haute qu'il n'y a pas de problème.

## Points vérifiés sans problème
- **A (respect du Coran)** :
  - aucune suite ⚠ du plan : pas de بَرْدًا, ni de إِلَى الصَّخْرَةِ / فِي صَخْرَةٍ / الصَّخْرَ (seulement عِنْدَ صَخْرَةٍ), ni de نُحَاس près de نَار, ni de صَعِدَ avec السَّمَاء, ni de يَصْعَدُ avec إِلَيْهِ, ni de الذَّهَبُ وَالْفِضَّةُ, ni de دَرَسُوا مَا, ni de scène de muraille ou de métal fondu ;
  - aucun nom divin ; pas de mot sur un monstre ; récit profane ;
  - aucun sens religieux affirmé.
- **B** : aucune fréquence affichée ; les sens donnés sont des sens généraux.
- **C (forme)** :
  - la vocalisation est complète et correcte partout : الْمُسَافِرُونَ, صَعِدْنَا, الْأَحْمَالُ, يَكْتُبُونَ, الطُّلَّابُ, دُرُوسٌ, الْمَفَاتِيحُ (sans tanwīn, au nominatif), كَتَبْتُهَا, سَيَخْرُجُ, لَمْ أَفْهَمْ, عِنْدَ صَخْرَةٍ كَبِيرَةٍ ;
  - accords justes : صَعِدَ هِلَالٌ وَبَاسِمٌ et صَعِدَ الْمُسَافِرُونَ (verbe en tête au singulier) ; الرِّسَالَةُ الَّتِي كَتَبْتُهَا (pronom de rappel ـهَا) ; فِي الْجَبَلِ ثَلْجٌ كَثِيرٌ (attribut en tête, sujet indéfini) ;
  - orthographe et Unicode corrects (ة, أ, هَٰذِهِ).
- **D (sens)** : traductions fidèles, à l'exception de la consigne de l'atelier 3 ; sens des fiches justes (صَعِدَ « il est monté, il a gravi », يَصْعَدُ en a ; فَحْمٌ, nom collectif).
- **E (données)**, vérifiées dans la base :
  - lemmes du Corpus : barod (brd, NN), Saxorap (Sxr, NN), nuHaAs (nHs, NN), yaSoEadu (SEd, verbe forme I) ;
  - ثَلْجٌ et فَحْمٌ sont sans lemme ni schème (absents du Corpus), ce qui est cohérent ;
  - دَرْسٌ porte la racine seule, drs ;
  - schèmes justes : فَعْل (دَرْس, بَرْد), فَعْلَة (صَخْرَة), فُعَال (نُحَاس), فَعِلَ (صَعِدَ) ;
  - toutes les racines demandées sont justes : ك ت ب, ف ت ح, ح م ل, ط ل ب, ص ع د, د ر س ; قَلَمٌ = ق ل م.
- **F (pédagogie)** :
  - chaque QCM a une seule bonne réponse et des distracteurs plausibles (د و ر, ك ا ت, م ك ت…) ;
  - les tuiles « ordonner » ont une solution unique ;
  - le distracteur صَعِدُوا est bien fautif devant un sujet exprimé ;
  - les renvois 2.23, 2.28 et 2.30 sont exacts ;
  - l'avertissement du §7 apparaît mot pour mot (B9), avec l'exemple ذَهَبَ / ذَهَبٌ ;
  - lecture : tous les mots sont connus (هِلَالٌ en aperçu) ;
  - aucun exercice d'écoute ;
  - translittérations Arabica conformes : ṯalǧun, ṣaḫratun, faḥmun, nuḥāsun, ṣaʿida, darsun, bardun.
- **G** : `source_sens` « rédigé par IA » sur les 7 fiches.

## Ce que je n'ai pas pu vérifier
- **Fréquences du Corpus** : elles sont stockées sous forme binaire, et je n'ai pas d'outil SQL.
- **Garde-fou coranique** : je ne l'ai pas exécuté (pas de shell) ; son résultat fait foi.
- **Source des exemples** : je n'ai pas vérifié que l'application affiche « exemple construit » sous les exemples des fiches.
- **Contrôle des mots inconnus** : je n'ai pas compris pourquoi `vocab.unknown` laisse passer مَكْتُوبٌ et حَامِلٌ en 3.1. Il faut vérifier `vocab.candidates`.

---

## Rapport de relecture : leçon 3.2 « Le schème »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/02-le-scheme.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches safar, habl, kanz, bisat, taraqa ; j'ai aussi consulté les fiches des mots déjà connus qu'emploie la leçon)
- Référence : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (§ A, B, C et D 3.2)

Stade : région 3, leçon 3.2. Notions supposées acquises : régions 1 et 2 entières, leçon 3.1 (la racine, sa notation, sa méthode d'extraction).

## Verdict : À corriger
Il y a un seul point Important. C'est un point de méthode : aucune forme arabe n'est fausse.

## Bloquant
- Aucun.

## Important
- **[02-le-scheme.json · Forges, et questions « Quel est le moule / quel mot a le moule »]**
  - **Problème** : le principe B4 du conseiller veut que la Forge ne propose que des couples racine + moule dont le résultat figure dans la liste de mots vérifiée. Or les deux forges donnent des mots dont la fiche n'a ni `scheme` ni `scheme_pluriel`. Ces mots n'ont donc pas été vérifiés à la construction :
    - قَلَمٌ (fiche qalam, mots.json l. 523, sans `scheme`) ;
    - جِبَالٌ (fiche jabal, l. 170, sans `scheme_pluriel`).
  - Même chose pour les mots dont la leçon demande le moule : كِتَابٌ, جَبَلٌ, جِدَارٌ, لَحْمٌ, كَلْبٌ, شَمْسٌ, كَتَبَ, فَتَحَ, جَلَسَ, كَنْزٌ (celui-ci a son schème), سَفَرٌ, بِسَاطٌ (ces deux-là aussi).
  - Les moules donnés sont justes : قَلَم = فَعَل, جِبَال = فِعَال, كِتَاب = فِعَال, جِدَار = فِعَال, جَبَل = فَعَل, لَحْم / كَلْب / شَمْس = فَعْل, كَتَبَ / فَتَحَ / جَلَسَ = فَعَلَ. Mais ils ne sont contrôlés que par moi, pas par le Corpus.
  - **Correction proposée** : ajouter les schèmes suivants sur les fiches existantes, ce qui les fera vérifier à la construction :
    - `"scheme": "فَعَل"` sur qalam et jabal, et `"scheme_pluriel": "فِعَال"` sur jabal ;
    - `"scheme": "فِعَال"` sur kitab et jidar ;
    - `"scheme": "فَعْل"` sur kalb, lahm et šams ;
    - `"scheme": "فَعَلَ"` sur kataba, fataha et jalasa.
  - Idéalement, le pipeline devrait aussi refuser une Forge dont la bonne réponse n'a pas de schème vérifié.
  - **Confiance** : haute.

## Mineur
- **[02-le-scheme.json · schèmes « seulement montrés »]** Le plan (§ C, 3.2) prévoit de montrer en aperçu فَعِلَ (شَرِبَ, سَمِعَ), فُعْل et un quadrilitère فِعْلَل / فِعْلَال (دِرْهَمٌ, vu en 3.1). La leçon les déclare dans `schemes`, mais aucun écran ne les présente. Correction : ajouter une ligne d'aperçu, par exemple dans la règle « Le moule », ou bien retirer ces trois schèmes de la liste et le noter dans les décisions. Retirer عَقْرَبٌ n'empêche pas l'aperçu : دِرْهَمٌ → فِعْلَل suffit.
- **[02-le-scheme.json · écran règle « Le moule »]** Le texte écrit « كِتَابٌ → فِعَال » avec le tanwīn, avant l'écran qui explique que la fin ne compte pas. Le principe B2 veut que, dans la comparaison, le mot s'affiche lui aussi sans sa fin (كِتَاب ↔ فِعَال). Correction : écrire « كِتَاب → فِعَال » ici. Les QCM de moule qui suivent la seconde règle peuvent garder le tanwīn, puisque cela a été expliqué.
- **[02-le-scheme.json · atelier, exercice « ordonner »]** « Hilāl a frappé la porte » est peu naturel en français. Correction : « Hilāl a frappé à la porte. », comme dans la question de lecture.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- Aucun doute de langue.
- **[mots.json · taraqa]** La fiche porte `racine: "Trq"` sans lemme : le verbe طَرَقَ ne figure probablement pas dans le Corpus, qui n'a que des dérivés de cette racine. C'est conforme au plan (« R Trq »), mais je n'ai pas pu ouvrir le Corpus pour le confirmer. Confiance : moyenne. La construction vérifie que la racine existe.

## Points vérifiés sans problème
- **A. Respect du Coran**
  - J'ai cherché des suites coraniques dans toutes les phrases (dialogue, lecture, atelier, exemples des fiches) : je n'en ai trouvé aucune.
  - Tous les ⚠ du plan sont respectés :
    - aucun « حَبْلٌ مِنْ… », aucun « عَلَى سَفَرٍ », aucun « تَحْتَهُ كَنْزٌ » ni « كَنْزٌ لَهُمَا » ;
    - aucun « بِسَاطًا » avec الْأَرْض, aucun « الْحَدِيدَ فِيهِ » (« الْحَدِيدَ فِي الصَّبَاحِ » n'en est pas une) ;
    - aucun « بَرْدًا », aucun طَارِق.
  - Le récit est profane. Il n'y a aucune scène de forge ou de montagne inspirée d'un récit coranique.
  - Aucun nom divin n'apparaît, aucun mot n'est sur un monstre.
- **B. Vocabulaire et sens** : les sens sont généraux, sans glose religieuse.
- **C. Forme**
  - Vocalisation complète et juste partout, y compris les fins de cas : sujet en -u, complément en -a, génitif après فِي.
  - Orthographe juste : هَٰذَا, tāʾ marbūṭa.
  - Accords justes :
    - « الْكُنُوزُ كَثِيرَةٌ » : pluriel de choses accordé au féminin singulier ;
    - طَرَقَ avec un sujet singulier ;
    - « التُّجَّارُ الَّذِينَ رَجَعُوا ».
  - Pluriels justes : حِبَال et كُنُوز. Le registre est classique.
- **D. Sens et traductions**
  - Les traductions sont fidèles : طَرَقَ « frapper (une porte, un métal) », سَفَر « voyage », بِسَاط « tapis », كَنْز « trésor », حَبْل « corde ».
  - Le pluriel de سَفَر n'est pas affiché, comme le plan le prévoit.
- **E. Données linguistiques**
  - Les lemmes (safar, Habol, kanz, bisaAT) et la racine Trq sont contrôlés par `vocab.py`. Les `scheme` et `scheme_pluriel` des cinq fiches sont exacts :
    - سَفَر = فَعَل ;
    - حَبْل = فَعْل, pluriel فِعَال ;
    - كَنْز = فَعْل, pluriel فُعُول ;
    - بِسَاط = فِعَال ;
    - طَرَقَ = فَعَلَ.
  - Toutes les racines analysées sont sans lettre faible, sans hamza et sans lettre doublée (B3).
- **F. Pédagogie**
  - Tous les mots employés ont été enseignés avant : حَدَّاد, حَدِيد, صُنْدُوق, غُرْفَة, قَدِيم, جَمِيل, طَوِيل, كَثِير, تَرَكَ, صَبَاح, تُجَّار, رَجَعَ, جِدَار, مِدَاد, قَلِيل, etc.
  - Le texte de lecture n'emploie que des mots connus (règle des 95 %).
  - Les QCM ont 3 choix et une seule bonne réponse à chaque fois. Les distracteurs sont plausibles : قَلِيلٌ et جَمَلٌ sont d'une autre racine, ce qui est légitime.
  - La notation des schèmes, sans tanwīn ni voyelle de cas, est conforme à B2.
  - Le piège « فِعَال singulier ou pluriel » est bien traité. Les règles sont courtes et exactes.
  - Les translittérations des fiches sont justes : safarun, ḥablun, kanzun, bisāṭun, ṭaraqa.
- **G. Statuts et sources** : toutes les fiches portent « rédigé par IA ». Le statut de la leçon est `ia_non_verifie`.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas lu directement le Corpus (/home/user/iqura/tools/build_content/sources/qac/quranic-corpus-morphology-0.4.zip, archive compressée), ni les fréquences. Les lemmes et la racine sont vérifiés par la construction (`vocab.py`, l. 286-300) : il faut lancer `build_content.py` et `unittest` pour en avoir la preuve.
- Je n'ai pas pu lancer `quran_guard.py`. Mon contrôle des suites coraniques est manuel.
- L'audio est suspendu : il n'y a rien à vérifier de ce côté.

---

## Rapport de relecture — Leçon 3.3 « Celui qui fait, ce qui est fait » (moteur-03)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/03-celui-qui-fait.json
- /home/user/iqura/tools/build_content/vocab/mots.json : les 8 fiches `"lecon": "moteur-03"` (maktub, hamil, kharij, jalis, rakib, maftuh, sani, sakin)
- Plan de référence : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (principes B et plan de la 3.3)

Stade : région 3, leçon 3.3 ; notions supposées acquises : régions 1 et 2 entières (phrase nominale, cas, iḍāfa, accords, passé et inaccompli…), 3.1 (la racine) et 3.2 (le schème : فَعَلَ, فَعْل, فَعَل, فِعَال).

## Verdict : À corriger

Il y a un point Important, et rien en catégorie A.

## Bloquant
- Aucun.

## Important
- **[mots.json · kharij · exemple]** La phrase d'exemple est `الْحَارِسُ خَارِجَ الْبَيْتِ.` (« Le gardien est dehors, hors de la maison »).
  - **Problème** : ici, خَارِجَ est à l'accusatif. Il sert de complément de lieu (ẓarf) suivi d'un complément du nom, au sens de « hors de ». Ce n'est pas le participe فَاعِل au nominatif que la leçon enseigne.
  - **Conséquences** :
    - la notion (accusatif de lieu) n'a pas encore été vue ;
    - la fin en ـَ sans tanwīn contredit le modèle de la leçon (خَارِجٌ) ;
    - c'est le seul exemple de la fiche, donc l'apprenant mémorise une autre construction que celle du moule.
  - **Correction proposée** : un exemple qui emploie le participe comme attribut, sur le modèle de `الشَّيْخُ جَالِسٌ`. Par exemple `الْحَارِسُ خَارِجٌ.` (« Le gardien est dehors / est sorti »). La variante `الْحَارِسُ خَارِجٌ مِنَ الْبَيْتِ.` est possible, mais elle est proche d'une tournure de la liste ⚠ (« بِخَارِجٍ مِنْهَا ») : à faire passer par le garde-fou et le conseiller.
  - Raccourcir aussi la traduction : « dehors, hors de la maison » répète la même idée.
  - **Confiance** : haute pour le décalage avec la leçon ; moyenne pour la phrase de remplacement.

## Mineur
- **[03-celui-qui-fait.json · entraînement, explication de `رَاكِبُ الْجَمَلِ`]** Texte actuel : « Après un participe, on emploie l'iḍāfa ». Dit comme une règle générale, c'est faux : `رَاكِبٌ الْجَمَلَ` (avec un complément à l'accusatif) est correct en arabe classique. Le plan dit seulement qu'on n'enseigne pas encore cette construction. Proposition : « Ici, on emploie l'iḍāfa : رَاكِبُ الْجَمَلِ (l'autre construction viendra plus tard). »
- **[03-celui-qui-fait.json · atelier, 1er exercice, 3e choix `جَالِسٌ الشَّيْخُ فِي خَيْمَةٍ.`]**
  - Le prédicat placé en tête (`جَالِسٌ الشَّيْخُ`) est grammatical en arabe classique. Ce choix est faux seulement à cause de `خَيْمَةٍ` (« une tente » au lieu de « la tente »).
  - Il y a bien une seule bonne réponse. Mais l'apprenant risque de croire que c'est l'ordre des mots qui est fautif.
  - Proposition : remplacer ce choix par `الشَّيْخُ جَالِسَةٌ فِي الْخَيْمَةِ.` (erreur d'accord, notion vue), ou bien expliquer pourquoi c'est faux.
- **[03-celui-qui-fait.json · contenu par rapport au plan]** Le plan du conseiller prévoit de montrer deux pièges que la leçon n'aborde pas :
  - مُسَافِرٌ et مُعَلِّمٌ ont un autre moule (renvoi à 3.20) ;
  - بَارِدٌ a la forme فَاعِل mais un sens d'adjectif.

  Un apprenant qui connaît مُسَافِرٌ « celui qui voyage » risque de l'analyser comme فَاعِل. Proposition : ajouter une phrase à la 2e règle ou à l'écran de fin.
- **[mots.json · catégorie (`nature`)]** Les fiches ne sont pas cohérentes entre elles :
  - jalis, maktub et maftuh sont des « adjectif » ;
  - hamil (« qui porte, porteur »), kharij (« qui sort ; dehors ») et rakib (« monté, cavalier ») sont des « nom », alors que leur sens est donné comme adjectif.

  Proposition : harmoniser, par exemple « adjectif / nom » ou une étiquette « participe ».
- **[mots.json · sani, sakin · `scheme_pluriel` فُعَّال]** La forme est juste (صُنَّاعٌ, سُكَّانٌ). Mais le moule de pluriel فُعَّال n'est exercé qu'en 3.7 : l'afficher sur la fiche dès la 3.3 devance le programme. C'est acceptable en simple affichage ; à confirmer.

## Doutes (à soumettre au conseiller, ne pas trancher)
- **[03-celui-qui-fait.json · 2e règle « Un verbe sans complément… n'a que فَاعِل » et la question « Le verbe جَلَسَ a-t-il un مَفْعُول ? → non »]**
  - **Ce qui me fait douter** : la grammaire classique admet un مَفْعُول des verbes intransitifs quand il est suivi d'une préposition, par exemple `مَجْلُوسٌ عَلَيْهِ`. Dite de façon absolue, l'affirmation est donc trop forte.
  - Le principe B4 du plan (« Jamais de مَفْعُول d'un verbe intransitif ») porte sur la Forge, pas sur une règle grammaticale aussi absolue.
  - **Pistes** : « n'a pas de مَفْعُول employé seul » ; ou garder la simplification et ajouter « (sauf cas vus plus tard) ».
  - **Confiance** : moyenne-haute sur le fait grammatical. La simplification est un choix pédagogique.

## Points vérifiés sans problème
- **A (respect du Coran)** :
  - aucun nom divin, aucun طَارِق, aucune figure religieuse, aucun sens religieux ;
  - aucune des suites ⚠ du plan (مَكْتُوبًا عِنْدَهُمْ, بِخَارِجٍ مِنْهَا, سَاكِنًا, بِحَامِلِينَ, الرَّكْبُ, etc.) ;
  - j'ai relu à la main toutes les suites de 3 mots du dialogue, de la lecture, de l'atelier et des exemples de fiches : je n'y reconnais aucune suite coranique. Le garde-fou de construction fait foi.
- **B et E (données du corpus)** :
  - les lemmes `makotuwb` et `xaArij` sont présents dans assets/content/iqura_content.db ;
  - les autres fiches ne renvoient qu'à une racine (Hml, jls, rkb, ftH, SnE, skn), sans fréquence inventée, comme prévu par le plan ;
  - سَاكِنٌ n'est pas rattaché au lemme du corpus (dont le sens est « immobile »), comme prévu ;
  - les schèmes فَاعِل et مَفْعُول sont justes pour les 8 mots, avec des racines sans lettre faible, conformes au principe B3.
- **C (forme)** :
  - vocalisation complète et juste partout : مَنِ الْجَالِسُ (kasra de liaison), حَامِلُ السَّلَّةِ sans tanwīn dans l'iḍāfa, الْبَابُ مَفْتُوحٌ (masculin), الرِّسَالَةُ مَكْتُوبَةٌ (féminin) ;
  - les pluriels صُنَّاعٌ et سُكَّانٌ sont justes ;
  - registre classique respecté.
- **D (sens)** : sens et traductions exacts (مَفْتُوحٌ « ouvert », رَاكِبٌ « monté, cavalier », صَانِعٌ « artisan », سَاكِنٌ « habitant ») ; aucun participe actif traduit par un passif.
- **F (pédagogie)** :
  - chaque question a 3 choix et une seule bonne réponse ;
  - tous les mots des textes sont connus (سَلَّة, حَدَّاد, رِسَالَة, خَيْمَة, شَيْخ, تَاجِر, صَدِيق, عِنْدَ, قَالَ, دَخَلَ ont une fiche ; مَدِينَة est vu depuis la région 1) ;
  - la Forge ne produit que des mots de la liste ;
  - aucun مَفْعُول de verbe intransitif ;
  - aucun complément direct après un participe ;
  - translittérations Arabica conformes (maktūbun, ḥāmilun, ḫāriǧun, ǧālisun, rākibun, maftūḥun, ṣāniʿun, sākinun).
- **G (statuts et sources)** : `source_sens` « rédigé par IA » sur les 8 fiches ; aucun exercice d'écoute.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas lancé le garde-fou `quran_guard.py` (je n'ai pas d'outil d'exécution) : la vérification automatique des suites de 3 mots reste à faire à la construction.
- Les fréquences du corpus sont stockées en entiers binaires dans la base : je ne les ai pas lues. Ici, aucune fréquence n'est affirmée.
- Je n'ai pas pu confirmer en SQL que les racines Hml, jls, rkb, ftH, SnE et skn existent dans la table `root` : c'est à `vocab.validate` de le faire.

---

## Rapport de relecture : leçon 3.4 « Le nom d'action » (maṣdar)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/04-le-nom-d-action.json
- /home/user/iqura/tools/build_content/vocab/mots.json : les 8 fiches `"lecon": "moteur-04"` (kitaba, dirasa, khuruj, dukhul, julus, jam, fahm, hifz)
- Plan de référence : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (B, C, D 3.4)

Stade : région 3, leçon 3.4. Notions supposées acquises : régions 1 et 2 entières (tous les verbes nécessaires sont connus : كَتَبَ، خَرَجَ، دَخَلَ، جَلَسَ، دَرَسَ، حَفِظَ، فَهِمَ، شَرِبَ، ذَهَبَ، طَلَبَ، عَرَفَ، جَمَعَ), et les leçons 3.1 à 3.3 (racine, schèmes فَعْل، فَعَل، فِعَال، فَاعِل، مَفْعُول).

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- **[mots.json · fahm · exemple] « الْفَهْمُ قَبْلَ الْحِفْظِ. »**
  - Problème 1 : قَبْلَ n'est enseigné nulle part. Ce n'est pas un mot de vocabulaire de mots.json, et on ne le trouve dans aucune autre leçon. Il est seulement placé dans `apercu`, apparemment pour que l'exemple passe la validation. L'apprenant le rencontre donc sans explication, ce qui contredit la règle des prérequis (F1 et F8).
  - Problème 2 : la traduction « Comprendre vient avant mémoriser » est du français fautif (il faudrait « avant de mémoriser »).
  - Correction proposée : un exemple fait de mots connus, par exemple « فَهْمُ الدَّرْسِ جَمِيلٌ. » (« La compréhension de la leçon est une belle chose »), puis retirer قَبْلَ de `apercu`.
  - Confiance : haute.
- **[04-le-nom-d-action.json · mini_boss · completer « On mémorise les mots le soir »]**
  - Problème : la consigne française appelle un verbe (« on mémorise »), alors que la bonne réponse est un nom (حِفْظُ). De plus, le distracteur حَفِظَ donne une phrase juste : « حَفِظَ الْكَلِمَاتِ فِي الْمَسَاءِ » (« il a mémorisé les mots le soir »). Un apprenant qui suit le français est poussé vers le verbe, et deux réponses deviennent défendables (F4).
  - Correction proposée : consigne « Complète : « La mémorisation des mots, c'est le soir. » ». Ou bien garder la consigne et remplacer حَفِظَ par un distracteur non grammatical, comme حَافِظٌ.
  - Confiance : haute.

## Mineur
- **[mots.json · dukhul · exemple]** « دُخُولُ السُّوقِ فِي الصَّبَاحِ. » est traduit « On entre au marché le matin. » La traduction efface le nom d'action que la leçon enseigne. Proposé : « L'entrée au marché, c'est le matin. »
- **[mots.json · jam · exemple]** « هَٰذَا جَمْعُ كِتَابٍ. » : la phrase est juste, mais هَٰذَا ne désigne rien. Plus clair : « كُتُبٌ جَمْعُ كِتَابٍ. » (« كُتُبٌ est le pluriel de كِتَابٌ »).
- **[lesson · dialogue, ordonner, completer, fiche khuruj]** « Le départ de la caravane est le matin. » sonne lourd en français. Proposé : « Le départ de la caravane a lieu le matin. »
- **[lesson · regle 1]** « Pour les verbes simples… » : l'apprenant ne connaît pas encore la notion de « verbe simple ». Proposé : « Pour les verbes que tu connais (كَتَبَ, خَرَجَ…), aucune règle ne permet de le prévoir. »
- **[lesson · regle « À reconnaître »]** L'écran porte deux idées : plusieurs moules, puis دَرْسٌ / دِرَاسَةٌ. On pourrait déplacer la remarque « Attention » dans l'explication d'un exercice (règle « un écran = une idée »).
- **[mots.json · julus · exemple]** جَمِيلٌ est traduit « agréable ». Ailleurs la leçon traduit « beau » ; « est une belle chose » serait plus fidèle.

## Doutes (à soumettre au conseiller, ne pas trancher)
- **[plan D 3.4 contre données] « Il est donné sur la fiche du verbe. »**
  - Ce qui me fait douter : aucune fiche de verbe de mots.json ne contient de champ « nom d'action » (je n'ai trouvé aucun champ masdar). La règle de la leçon dit « on l'apprend avec le verbe », mais les fiches de verbes ne le montrent pas. Le plan du conseiller prévoyait aussi « Sur les fiches, à reconnaître : ذَهَابٌ, شُرْبٌ, طَلَبٌ, مَعْرِفَةٌ » ; ces mots ne sont qu'en aperçu dans la leçon.
  - Pistes : ajouter le nom d'action aux fiches de كَتَبَ, خَرَجَ, دَخَلَ, جَلَسَ, دَرَسَ, حَفِظَ, فَهِمَ, جَمَعَ, ذَهَبَ, شَرِبَ, طَلَبَ, عَرَفَ ; ou bien noter que ce point est reporté.
  - Confiance : moyenne (cela dépend de ce que le conseiller attendait).
- **[fiche shurb, si elle est créée]** Le nom d'action de شَرِبَ a classiquement plusieurs vocalisations (شُرْب, شَرْب). Le Corpus donne `$urob` شُرْب, ce qui convient pour la leçon.
  - Pistes : garder شُرْبٌ seul, sans mention des variantes à ce stade.
  - Confiance : moyenne.

## Points vérifiés sans problème
- **A. Respect du Coran**
  - Aucune suite coranique reconnue dans les phrases, de mémoire. Les suites à éviter du plan sont absentes : « يَوْمُ الْخُرُوجِ », « حِفْظًا », « شُرْبَ الْهِيمِ », « يَوْمَ الْجَمْعِ », « عَلَى ذَهَابٍ », سَمْع.
  - Aucun nom divin, aucune scène coranique de forge, aucun sens religieux.
- **B et E. Lemmes du Corpus**, retrouvés dans `assets/content/iqura_content.db` :
  - diraAsat دِرَاسَت (drs), xuruwj خُرُوج (xrj), jamoE جَمْع (jmE), HifoZ حِفْظ (HfZ) ;
  - ainsi que $urob شُرْب, *ahaAb ذَهَاب, Talab طَلَب.
  - Comme prévu par le plan, il n'y a pas de lemme pour كِتَابَة, دُخُول, جُلُوس, فَهْم, مَعْرِفَة (racine seule).
  - Aucune fréquence n'est affichée dans la leçon.
- **E. Schèmes** des fiches, tous exacts : كِتَابَة et دِرَاسَة = فِعَالَة ; خُرُوج, دُخُول et جُلُوس = فُعُول ; جَمْع et فَهْم = فَعْل ; حِفْظ = فِعْل. Toutes les racines sont sans lettre faible ni hamza, ce qui respecte B3.
- **C. Forme**
  - Vocalisation complète et correcte, y compris les shaddas des lettres solaires (الدِّرَاسَةُ, الطُّلَّابُ, الصَّبَاحِ, السُّوقِ, الدُّخُولُ).
  - Iḍāfa correcte : خُرُوجُ الْقَافِلَةِ, دُخُولُ السُّوقِ, حِفْظُ الْكَلِمَاتِ.
  - Accords justes : جَلَسَ الطُّلَّابُ (verbe en tête, au singulier) ; الْكِتَابَةُ جَمِيلَةٌ.
  - سَمِيرٌ est bien triptote ; جَلَسَ لِلدِّرَاسَةِ est une tournure classique.
- **D. Sens** : écriture, étude, sortie, entrée, le fait de s'asseoir, rassemblement / pluriel, compréhension, garde / mémorisation. Les sens sont linguistiques et justes.
- **F. Pédagogie**
  - Chaque QCM a 3 choix et une seule bonne réponse, sauf le point Important ci-dessus.
  - Les Forges ne produisent que des mots de la liste, et aucun مَفْعُول de verbe intransitif.
  - Les révisions (حَامِلٌ, جَبَلٌ = فَعَل, مَفْتُوحٌ) sont correctes.
- **F7. Translittération Arabica** exacte : kitābatun, dirāsatun, ḫurūǧun, duḫūlun, ǧulūsun, ǧamʿun, fahmun, ḥifẓun.
- **G. Statuts** : chaque fiche porte « rédigé par IA ».

## Ce que je n'ai pas pu vérifier
- Je n'ai pas exécuté le garde-fou `quran_guard.py` ni la construction : la vérification « aucune suite de 3 mots du Coran » repose sur ma lecture, et le garde-fou fait foi.
- Je n'ai pas lu les fréquences (entiers binaires dans la base).
- Je n'ai pas vérifié que le seuil de 95 % de mots connus est atteint par le calcul du pipeline, seulement à la lecture.
- L'audio est suspendu, donc rien à contrôler de ce côté.

---

## Rapport de relecture : leçon 3.5 « Lieux et instruments »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/05-lieux-et-instruments.json
- /home/user/iqura/tools/build_content/vocab/mots.json : les 8 fiches `"lecon": "moteur-05"` (majlis, maskan, madkhal, makhraj, madrasa, mazraa, misbah, mitraqa)
- Référence : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (principes B, plan de la 3.5)

Stade : région 3, leçon 3.5. Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.4 (racine, schème, فَاعِل / مَفْعُول, noms d'action).

## Verdict : À corriger

Il y a un seul point Important : une question accepte deux bonnes réponses. Le reste est juste.

## Bloquant
- Aucun.

## Important
- **[05-lieux-et-instruments.json · entraînement, exercice « Comment dit-on « la sortie » ? »]**
  - Problème : il y a deux bonnes réponses. La fiche khuruj donne خُرُوجٌ = « sortie, départ (le fait de sortir) ». Donc الْخُرُوجُ traduit lui aussi « la sortie », comme الْمَخْرَجُ.
  - Correction proposée : préciser la consigne. Par exemple : « Comment dit-on « la sortie » (le lieu par où l'on sort) ? ». Autre solution : remplacer le distracteur الْخُرُوجُ par un mot sans rapport (ex. الْمَجْلِسُ).
  - Confiance : haute.

## Mineur
- **[05 · écran règle « Le lieu »]**
  - Problème : le texte de la règle ne présente que مَفْعَل et مَفْعِل. Pourtant, la question qui suit porte sur مَدْرَسَةٌ et son explication dit « Moule مَفْعَلَة : un lieu ». مَفْعَلَة est donc utilisé sans avoir été annoncé. Il est pourtant prévu comme moule exercé dans le plan (tableau C).
  - Correction proposée : ajouter une phrase dans le texte, par exemple : « … et parfois مَفْعَلَة, avec ة : دَرَسَ → مَدْرَسَةٌ. » On peut aussi ajouter مَدْرَسَةٌ ou مَزْرَعَةٌ aux exemples.
  - Confiance : haute.
- **[05 · règle « L'outil »]**
  - Problème : la règle dit de la racine de مِيزَانٌ : « tu verras plus tard pourquoi elle se cache ». Or le و ne disparaît pas : il devient ي (on attendrait مِوْزَان). L'apprenant voit un ي qui n'est pas dans la racine.
  - Correction proposée : « …sa racine est و ز ن : le و s'est changé en ي ; tu verras pourquoi plus tard. »
  - Confiance : moyenne-haute.
- **[05 · atelier, ordonner « La lampe est sur le mur. »]**
  - Problème : la tuile piège فِي pousse à composer « الْمِصْبَاحُ فِي … ». C'est le début d'une suite coranique connue (« الْمِصْبَاحُ فِي زُجَاجَةٍ »). Seuls deux mots se suivent, donc ce n'est pas bloquant et le garde-fou ne réagira pas. Mais le plan demande déjà de tenir مِصْبَاح à l'écart de فِي.
  - Correction proposée : remplacer la tuile فِي par تَحْتَ ou مِنْ.
  - Confiance : moyenne.
- **[05 · contenu du plan non repris]**
  - Le plan prévoyait de montrer en aperçu deux choses absentes de la leçon : l'exception مَغْرِبٌ (« lieu ou moment du coucher du soleil ; l'ouest », alors qu'on attendrait un a) et le moule مِفْعَل. Ce n'est pas une erreur de langue, mais un écart par rapport au plan.
  - À ajouter ou à noter comme écart volontaire. Si مَغْرِب est ajouté, respecter les ⚠ du plan : pas de « مَغْرِبَ الشَّمْسِ », jamais مَشْرِق et مَغْرِب ensemble.

## Doutes (à soumettre au conseiller, ne pas trancher)
- **[05 · entraînement, sens de مَزْرَعَةٌ]**
  - Ce qui me fait douter : le distracteur « jardin » est assez proche de « ferme, champ » pour qu'un apprenant hésite. Je pense que la réponse reste unique.
  - Piste : remplacer « jardin » par « marché ».
  - Confiance que ce soit un problème : faible.

## Points vérifiés sans problème

**A. Respect du Coran**
- Aucune suite coranique repérée de mémoire (le garde-fou de construction fait foi).
- Aucun ⚠ du plan n'est employé : pas de مَسَاكِن, de « فِي الْمَجَالِسِ », de « مَخْرَجًا » avec لَهُ, de مَدْخَل avec صِدْق ou كَرِيم, de بِمَصَابِيحَ.
- Aucun nom divin, aucun sens religieux ; le récit est profane.

**B et E. Données du Corpus**, vérifiées dans `assets/content/iqura_content.db` :
- Lemmes présents et vocalisés comme les fiches : masokan, maxoraj, miSobaAH.
- Racines présentes : jls, dxl, drs, zrE, Trq (ainsi que skn, xrj, SbH).
- Le lemme singulier de مَجْلِس est bien absent ; la fiche affiche seulement la racine, ce qui est conforme.
- Aucune fréquence n'est affichée.

**C. Forme de l'arabe**
- Vocalisation complète et correcte partout. Les fins de cas sont justes :
  - génitif après فِي, عَلَى et مِنَ ;
  - iḍāfa sans tanwīn : مِطْرَقَةُ الْحَدَّادِ, مَدْخَلُ الْمَزْرَعَةِ ;
  - accords justes : قَرِيبَةٌ avec مَزْرَعَة, ثَقِيلَةٌ avec مِطْرَقَة, هَٰذِهِ avec مِطْرَقَة.
- Pluriels diptotes (مَجَالِسُ, مَصَابِيحُ) au nominatif seulement.
- Pas de بِـ d'instrument.

**Schèmes des fiches**
- مَجْلِس = مَفْعِل (il vient de يَجْلِسُ) ; مَسْكَن, مَدْخَل, مَخْرَج = مَفْعَل ; مَدْرَسَة, مَزْرَعَة = مَفْعَلَة ; مِصْبَاح = مِفْعَال ; مِطْرَقَة = مِفْعَلَة.
- Pluriels : مَجَالِس, مَسَاكِن = مَفَاعِل ; مَصَابِيح = مَفَاعِيل.
- Genres justes : مِصْبَاح m., مِطْرَقَة f.

**D. Sens et traductions** : sens et traductions exacts, exemples des fiches justes et naturels.

**F. Pédagogie**
- Une seule bonne réponse dans tous les QCM, sauf le point Important ci-dessus.
- La Forge ne produit que des mots de la liste vérifiée : مَسْكَن, مِطْرَقَة, مِفْتَاح, مَخْرَج, جَالِس, مَكْتُوب.
- Toutes les racines analysées ont leurs trois lettres visibles et ne sont pas faibles. مِيزَان est seulement montré en aperçu.
- Le moule est présenté comme une tendance (règle et QCM « toujours ? »).
- Tous les mots de la lecture et de l'atelier sont connus : طُلَّاب, ضُيُوف, حَدَّاد, ثَقِيل, جِدَار, كُرْسِيّ, نَهْر, قَرِيب, بَيْت, صَغِير, سُوق, هُنَاكَ, مَطْبَخ, مِفْتَاح.

**Translittération Arabica** : maǧlisun, maskanun, madḫalun, maḫraǧun, madrasatun, mazraʿatun, miṣbāḥun, miṭraqatun, toutes correctes.

**G. Statuts et sources** : chaque fiche porte « rédigé par IA ».

## Ce que je n'ai pas pu vérifier
- Les fréquences : je n'ai pas lancé de requête SQL, j'ai seulement cherché du texte dans la base.
- Le passage réel au garde-fou `quran_guard.py` : je ne l'ai pas exécuté.
- Le contrôle automatique « schème + racine = mot » à la construction : je ne l'ai pas exécuté non plus.
- L'affichage du statut `ia_non_verifie` comme « rédigé par IA » à l'écran (ce statut est commun à toutes les leçons).
- L'audio est suspendu : rien à vérifier.

---

## Rapport de relecture — Leçon 3.6 « Adjectifs et intensifs » (فَعِيل / فَعَّال)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/06-adjectifs-et-intensifs.json
- /home/user/iqura/tools/build_content/vocab/mots.json (les 8 fiches `"lecon": "moteur-06"` : marid, faqir, daif, sari, said, tabbakh, hammal, rahhal)
- Pour comparaison : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (plan 3.6, principes B), /home/user/iqura/tools/build_content/fondations.py, la leçon 2.15, iqura_content.db (recherche de texte).

Stade : région 3, leçon 3.6. Acquis supposés : régions 1 et 2, leçons 3.1 à 3.5 (racine, schème, فَاعِل / مَفْعُول, noms d'action, lieux et instruments).

## Verdict : À corriger

Un seul point Important (deux bonnes réponses possibles). Je n'ai relevé aucun point Bloquant.

## Bloquant
- Aucun.

## Important
- **[06-…json · atelier, exercice « ordonner »]** Problème : la consigne dit « Le porteur a porté les charges », et la tuile piège est الْحَامِلُ. Or la fiche de حَامِلٌ (leçon 3.3) le traduit par « qui porte, **porteur** ». La phrase حَمَلَ الْحَامِلُ الْأَحْمَالَ est donc juste, elle aussi, et correspond à la consigne : l'exercice a deux réponses. | Correction proposée : écrire dans la consigne « Le porteur (de métier) a porté les charges. », comme sur la fiche de حَمَّالٌ et dans le mini-boss. Autre solution : retirer la tuile الْحَامِلُ. | Confiance : haute.

## Mineur
- **[règle « Le métier : فَعَّال »]** Les exceptions de فَعِيل (« حَدِيدٌ « fer » est un nom en فَعِيل, حَبِيبٌ veut dire « aimé » ») sont placées sur l'écran de فَعَّال. Cela mélange deux idées sur un même écran (F5). | Proposition : déplacer cette phrase à la fin de l'écran « La qualité : فَعِيل ». Sur l'écran de فَعَّال, garder seulement « Ce sont des tendances ».
- **[lecture · question 1]** « Pourquoi le vieil homme est-il à la maison ? » : le texte dit seulement « الشَّيْخُ مَرِيضٌ الْيَوْمَ، وَهُوَ فِي الْبَيْتِ » (« il est malade, et il est à la maison »). Le lien de cause n'est pas écrit. | Proposition : « Comment va le vieil homme aujourd'hui ? ». Les choix et la réponse restent les mêmes.
- **[entraînement · traduire]** « la corde est faible » sonne peu naturel en français. On peut le garder, puisque le sens enseigné est « faible ». Ajouter « (peu solide) » serait plus clair. Facultatif.

## Doutes (à soumettre au conseiller, ne pas trancher)
- **[lecture · phrase 4] « رَحَّالٌ مِنَ الْمَدِينَةِ جَالِسٌ فِي الْمَجْلِسِ. »**
  - Ce qui me fait douter : la phrase commence par un sujet indéfini. En classique, c'est permis, parce que le nom est précisé par مِنَ الْمَدِينَةِ (nakira muḫaṣṣaṣa). Mais la leçon 2.15 a enseigné la règle « Quand le sujet est indéfini, le lieu passe devant ». Un débutant verra ici une contradiction.
  - Pistes : (a) garder la phrase et ajouter une note courte ; (b) écrire « فِي الْمَجْلِسِ رَحَّالٌ مِنَ الْمَدِينَةِ. » et adapter la question (« Qui est dans la salle de réunion ? »).
  - Confiance que la phrase est grammaticalement correcte : haute. Confiance que c'est un problème pédagogique : moyenne.
- **[fiche sari, mini-boss « moule de سَرِيعٌ »]**
  - Ce qui me fait douter : de mémoire, dans le Coran, le lemme sariyE apparaît presque seulement dans سَرِيعُ الْحِسَابِ / الْعِقَابِ, qui qualifient Dieu. Ce n'est pas un nom divin selon les listes habituelles, et il ne figure pas dans la liste d'exclusion B5. Ici, il est employé avec son sens général (« le chameau est rapide »), et l'avertissement ⚠ du plan est respecté.
  - Pistes : le conseiller confirme qu'on peut l'employer en combat, ou on l'ajoute à la liste d'exclusion du combat seulement.
  - Confiance : basse (je penche pour « acceptable »).
- **[fiche marid · `"lemme": "m~ariyD"`]**
  - Ce qui me fait douter : la shadda initiale vient sans doute d'une assimilation notée par le Corpus (مِّنكُم مَّرِيضًا). Le lemme existe bien tel quel dans iqura_content.db, donc l'identifiant est juste. Mais si sa forme arabe est affichée quelque part (dictionnaire), elle apparaîtrait comme « مَّرِيض ».
  - Pistes : vérifier que seul le champ `ar` (مَرِيضٌ) est affiché.
  - Confiance : moyenne.

## Points vérifiés sans problème
- **A (Coran)** :
  - aucune suite de mots coranique repérée dans le dialogue, la lecture, l'atelier ou les exemples ;
  - les ⚠ du plan sont respectés : pas de حَمَّالَة, pas de حَطَب, pas de سَرِيعُ + nom, pas de ضَعِيفًا, pas de فَقِير avec غَنِيّ, pas de الْمَرْضَى ;
  - aucun nom divin de la liste B5 ;
  - aucune figure religieuse, aucune glose religieuse.
- **B / E (données)** :
  - les lemmes m~ariyD, faqiyr, DaEiyf, sariyE et saEiyd sont présents dans iqura_content.db ;
  - les racines Hml et rHl sont correctes ;
  - طَبَّاخ est sans racine ni schème, comme le prévoit le plan (« — ») ;
  - les schèmes sont tous justes : فَعِيل pour les 5 adjectifs, فَعَّال pour حَمَّال et رَحَّال ;
  - les pluriels sont justes : مَرْضَى, فُقَرَاءُ, ضُعَفَاءُ, سُعَدَاءُ, avec scheme_pluriel فُعَلَاء ;
  - les féminins en ة sont justes ;
  - aucune fréquence n'est affichée dans la leçon.
- **C (forme)** :
  - toutes les phrases sont entièrement vocalisées, avec les bons cas : attribut de لَيْسَ au cas direct (فَقِيرًا), sujets au nominatif, génitif après إِلَى / فِي / مِنْ, accord au féminin (الْبِنْتُ سَعِيدَةٌ, الرِّسَالَةُ طَوِيلَةٌ) ;
  - les lettres solaires portent leur shadda (الطَّبَّاخُ, الشَّيْخُ, الرِّسَالَةُ, السُّوقِ) ;
  - le registre est classique.
- **D (sens)** :
  - les sens sont justes : malade, pauvre, faible, rapide, heureux, cuisinier, porteur de métier, grand voyageur ;
  - حَبِيبٌ « aimé » est juste (sens passif) ;
  - les traductions sont fidèles.
- **F (pédagogie)** :
  - tous les mots employés sont connus (dont الْمَدِينَة, vue en région 1 et 2, et الْأَحْمَال, pluriel affiché sur la fiche de حِمْل) ; حَبِيبٌ est en aperçu ;
  - les racines analysées respectent B3 : ق ص ر, ف ق ر, ر ح ل, ح م ل, ض ع ف, س ر ع, ك ب ر, sans lettre faible ;
  - les Forges ne produisent que des mots de la liste ;
  - les QCM ont 3 choix et une seule bonne réponse, sauf le point Important ci-dessus. قَصِيرَةٌ ne correspond pas au moule فَعِيل (il porte ة), donc il n'y a pas d'ambiguïté ;
  - les règles suivent le plan du conseiller ;
  - les renvois aux leçons 2.20, 3.4 et 3.5 sont exacts.
- **F7 (translittération Arabica)** : celle des 8 fiches correspond à la vocalisation (marīḍun, ṭabbāḫun, raḥḥālun…).
- **G (statuts et sources)** : `statut: ia_non_verifie` et `source_sens: « rédigé par IA »` sur chaque fiche.

## Ce que je n'ai pas pu vérifier
- Les fréquences des lemmes (champs binaires de la base ; aucune fréquence n'est affichée dans la leçon).
- Le garde-fou `quran_guard.py` sur ce fichier : je n'ai pas pu lancer de commande. Je n'ai fait qu'une relecture à l'œil, et c'est le résultat de la construction qui fait foi.
- Que `vocab.validate` et `fondations.py` passent bien sur la leçon. J'ai seulement constaté que مِفْعَلَة, employé dans une consigne en français du mini-boss, ne figure pas dans la liste `schemes`. Cela n'a pas d'effet si seuls les champs arabes sont contrôlés.
- L'audio, qui est suspendu.

---

## Rapport de relecture : leçon 3.7 « Les pluriels internes »

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/07-les-pluriels-internes.json ; /home/user/iqura/tools/build_content/vocab/mots.json (fiches tifl, sarj, jisr, sahn, saqr, fahd) ; plan : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (B, C, D 3.7)
Stade : région 3, leçon 3.7 ; notions supposées acquises : régions 1 et 2 (cas, accords, pluriel de choses au féminin singulier en 2.18), leçons 3.1 à 3.6 (racine, moule, فَاعِل/مَفْعُول, noms d'action, lieu et instrument, فَعِيل/فَعَّال).

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [07 · entraînement, traduire « Comment dit-on « les enfants » ? »] Problème : il y a **deux bonnes réponses**. Le distracteur الْأَوْلَادُ est juste lui aussi, puisque la fiche de وَلَدٌ (mots.json, l. 371) donne « enfant ; garçon ». | Correction proposée : remplacer الْأَوْلَادُ par un pluriel connu sans ambiguïté, par exemple الرِّجَالُ ou الطُّلَّابُ (الطُّلَّابُ est déjà parmi les choix ; prendre alors الصُّقُورُ ou الرِّجَالُ). | Confiance : haute
- [07 · atelier, completer « Les plats sont sur la table » ; apercu « الْمَائِدَةِ » ; fiche sahn, exemple « الصَّحْنُ عَلَى الْمَائِدَةِ. »] Problème : مَائِدَة n'a aucune fiche dans mots.json et n'est enseigné nulle part avant (il n'apparaît que dans cette leçon). Il ne passe le contrôle que parce qu'il est déclaré en « apercu ». Or ce mot sert dans une phrase de production (Atelier) et dans l'exemple de la fiche. La règle F8 n'est pas respectée : les phrases modèles ne doivent employer que des notions déjà vues. | Correction proposée : employer un lieu connu, par exemple « الصُّحُونُ فِي السِّلَالِ. » (« Les plats sont dans les paniers. »), ou « الصَّحْنُ فِي السَّلَّةِ. » pour la fiche. Retirer alors « الْمَائِدَةِ » de « apercu ». Autre solution : donner à مَائِدَةٌ une fiche en bonne et due forme (le lemme est à vérifier dans le Corpus). | Confiance : haute
- [07 · mini_boss, completer « Forge : racine ص ق ر dans le moule فُعُول »] Problème : la règle B3 du conseiller n'admet dans les exercices d'analyse (Forge, schème, Détective) que les racines **du Corpus**. Or ص ق ر n'est pas dans la table `root` : j'ai cherché « Sqr » dans iqura_content.db, sans résultat. La fiche saqr n'a d'ailleurs ni racine ni schème. L'exercice demande donc d'analyser une racine que l'application ne documente pas. | Correction proposée : prendre une racine admise dont le pluriel فُعُول figure sur une fiche, par exemple « ك ن ز dans فُعُول », avec les choix كُنُوزٌ / كَنْزٌ / كُتُبٌ, ou « ن ج م » → نُجُومٌ. | Confiance : haute
- [07 · atelier, explication « Pluriel de صَحْنٌ : صُحُونٌ, moule فُعُول » ; fin « صُقُورٌ → صَقْرٌ » « par sa racine »] Problème : c'est le même écart à B3, mais moins grave (analyse de moule sur des mots sans racine dans le Corpus). | Correction proposée : dans l'explication, écrire seulement « Pluriel de صَحْنٌ : صُحُونٌ ». Dans « fin », remplacer صُقُورٌ → صَقْرٌ par كُنُوزٌ → كَنْزٌ ou نُجُومٌ → نَجْمٌ. | Confiance : moyenne (cela dépend de la lecture stricte de B3 ; à confirmer par le conseiller)

## Mineur
- [07 · mini_boss, question « Le pluriel interne… », explication « Aucune règle ne permet de le prévoir » ; règle 2 « Le pluriel ne se prévoit pas »] Problème : c'est trop absolu. La leçon elle-même donne une tendance : فَاعِل → فُعَّال (سَاكِنٌ → سُكَّانٌ). Les fiches de 3.5 et 3.6 en montrent d'autres : فَعِيل → فُعَلَاء, مَفْعَل → مَفَاعِل. | Correction proposée : « On ne peut pas le prévoir à coup sûr : on l'apprend avec le mot. »
- [07 · mini_boss, sens de طِفْلٌ, distracteur « garçon »] Problème : طِفْلٌ peut désigner un petit garçon. Un apprenant peut juger « garçon » acceptable. | Correction proposée : remplacer par « marchand » ou « vieil homme ».
- [07 · règles] Problème : deux points du plan manquent. La règle « un pluriel de choses s'accorde au féminin singulier (2.18) » n'apparaît que dans les explications d'exercices, pas dans un écran de règle. Le piège « فِعَال est aussi un moule de singulier (كِتَابٌ) ; أَفْعَال n'est pas أَفْعَلُ » n'est pas traité. Les pluriels « à reconnaître seulement » (مَجَالِسُ, مَدَارِسُ, مَصَابِيحُ, فُقَرَاءُ…) ne sont montrés nulle part, alors que فُعَلَاء, مَفَاعِل et مَفَاعِيل sont déclarés dans « schemes » et que مَدَارِسُ est déclaré en « apercu » sans être employé. | Correction proposée : ajouter une phrase à la règle 1 ou 2 ; employer ou retirer مَدَارِسُ de l'aperçu.
- [07 · mini_boss, explication « فَعَّال : le porteur de métier »] La formulation est maladroite. Proposer : « فَعَّال : celui qui exerce un métier (leçon 3.6) ».
- [07 · titre] Le titre est identique à celui de la leçon 2.18 (« Les pluriels internes »). Le différencier, par exemple « Du pluriel au singulier ».

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- [mots.json · tifl, remarque « sert aussi au féminin et au pluriel en arabe classique »] Ce qui me fait douter : cette remarque, juste en lexicographie, rend discutable le distracteur de l'Atelier « الطِّفْلُ فِي الْحَدِيقَةِ. » pour « Les enfants sont dans le jardin ». Par ailleurs, l'emploi de الطِّفْل au pluriel est surtout connu par un passage coranique (d'où le ⚠ « الطِّفْلِ الَّذِينَ »). | Pistes : garder la remarque mais remplacer le distracteur par « الصُّقُورُ فِي الْحَدِيقَةِ. », ou alléger la remarque. | Confiance : moyenne
- [mots.json · sarj, racine srj] Ce qui me fait douter : la racine srj du Corpus ne vient que de سِرَاج « lampe ». Classer سَرْج « selle » sous cette racine est défendable, car les dictionnaires classiques les rangent sous la même entrée. Mais la famille affichera « selle » à côté de « lampe ». | Pistes : en 3.10, étiqueter « éloigné : le lien de sens n'est pas évident ». | Confiance : moyenne
- [mots.json · sahn « plat, assiette »] « assiette » a une couleur moderne ; en classique, صَحْن est plutôt un grand plat creux, une écuelle. | Pistes : « plat, écuelle ». | Confiance : faible

## Points vérifiés sans problème
- A : aucune suite coranique repérée dans le dialogue, la lecture, l'Atelier ou les exemples des fiches. Aucun des ⚠ du plan n'apparaît (بَلَغَ الْأَطْفَالُ, طِفْلًا, الطِّفْلِ الَّذِينَ, الْأَنْهَارُ). Aucun nom divin, aucun monstre-mot. Le garde-fou de construction reste à exécuter, je n'ai pas pu le lancer.
- B/E : le lemme Tifol est présent, avec la racine Tfl. La racine srj est présente dans la table `root`. jsr, SHn, Sqr et fhd sont absents, ce qui est cohérent avec les fiches sans racine ni schème. Les schèmes tifl (فِعْل → أَفْعَال) et sarj (فَعْل → فُعُول) sont justes. Les pluriels جُسُورٌ, صُحُونٌ, صُقُورٌ, فُهُودٌ, سُرُوجٌ, أَطْفَالٌ sont classiques et corrects.
- C : la vocalisation est complète et juste partout. Les accords sont justes : الْجُسُورُ طَوِيلَةٌ, سُرُوجٌ جَدِيدَةٌ, السُّرُوجُ جَدِيدَةٌ. Les phrases nominales à prédicat antéposé avec sujet indéfini sont correctes (عَلَى الْجِسْرِ تُجَّارٌ وَجِمَالٌ ; فِي السِّلَالِ صُحُونٌ وَأَقْلَامٌ). Le génitif après préposition et après فَوْقَ est juste. Aucun diptote après une préposition.
- D : les traductions françaises sont fidèles (dialogue, lecture, modèles).
- F : les moules donnés sont justes (أَحْمَالٌ أَفْعَال, صُخُورٌ فُعُول, كُتُبٌ فُعُل, مِصْبَاحٌ مِفْعَال, حَمَّالٌ فَعَّال, مَجْلِسٌ مَفْعِل). Les singuliers sont justes (جِبَالٌ, أَشْجَارٌ, سُكَّانٌ, أَطْفَالٌ, رِجَالٌ). La racine de كُنُوزٌ est ك ن ز. Hormis les deux cas signalés, chaque QCM a 3 choix et une seule bonne réponse. Les autres mots employés ont tous une fiche antérieure (سَلَّة/سِلَال, حَدِيقَة, قَرْيَة, سَكَنَ, رَاكِب, سِرَاج…).
- G : toutes les fiches portent « rédigé par IA ». La translittération est conforme à Arabica (ṭiflun, sarǧun, ǧisrun, ṣaḥnun, ṣaqrun, fahdun).

## Ce que je n'ai pas pu vérifier
- Le garde-fou `quran_guard.py` et le validateur : je n'avais pas d'outil d'exécution.
- Les fréquences du Corpus : la base est binaire, et j'ai seulement vérifié par recherche de texte la présence des lemmes et des racines.
- L'audio : il est suspendu.

---

## Rapport de relecture : leçon 3.8 « Plus grand, le plus grand »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/08-plus-grand.json
- /home/user/iqura/tools/build_content/vocab/mots.json (les 8 fiches « moteur-08 » : akbar, asghar, akthar, asra, abad, atwal, sahl, sab)
- Référence : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (§B et plan 3.8)

Stade : région 3, leçon 3.8 ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.7 (racine, schème, participes, maṣdar, lieu et instrument, فَعِيل / فَعَّال, pluriels internes).

## Verdict : Bloqué

La leçon est saine dans l'ensemble. Le verdict vient d'une paire ⚠ du conseiller, recopiée dans un exemple de fiche. Elle se corrige en une ligne.

## Bloquant
- **[mots.json · fiche `sab` (صَعْبٌ), exemple]** Problème : l'exemple « الطَّرِيقُ إِلَى الْجَبَلِ صَعْبٌ. » contient « إِلَى الْجَبَلِ ». Cette suite figure explicitement dans la liste ⚠ du plan (B6 : « إِلَى الْجَبَلِ », à remplacer sans discussion). Le garde-fou, qui cherche des suites de 3 mots, ne la détecte pas. | Correction proposée : « طَرِيقُ الْجَبَلِ صَعْبٌ. », « Le chemin de la montagne est difficile. » (iḍāfa connue ; je ne connais pas cette suite dans le Coran, à faire confirmer par le garde-fou) | Confiance : haute (violation du plan)

## Important
- **[08-plus-grand.json · règle « Plus… que », mini-boss « أَفْعَلُ au féminin… », atelier (explication « أَفْعَلُ ne change pas au féminin ») ; mots.json · `akbar` (remarque)]** Problème : la phrase « أَفْعَلُ ne change ni de genre ni de nombre » est donnée comme une règle absolue. Or avec l'article, la forme change : الْكُبْرَى, الصُّغْرَى. La réponse « ne change pas » du mini-boss est donc fausse prise hors contexte. Le plan prévoyait aussi en aperçu الْأَكْبَرُ / كُبْرَى (table C : فُعْلَى seulement montré), et cet aperçu manque. | Correction proposée :
  - règle : « Dans أَفْعَلُ مِنْ… et devant un nom indéfini, أَفْعَلُ ne change ni de genre ni de nombre » ;
  - ajouter l'aperçu prévu (كُبْرَى, « tu le verras plus tard ») ;
  - mini-boss : « Dans الْبِنْتُ أَصْغَرُ مِنَ الْوَلَدِ, أَفْعَلُ… » ;
  - remarque de la fiche `akbar` : « avec مِنْ, ne change ni de genre ni de nombre ».
  | Confiance : haute
- **[08 · dialogue, question « Qui est plus rapide que le chameau ? »]** Problème : le distracteur « le faucon » est vrai dans la réalité (un faucon va plus vite qu'un chameau). On a donc deux réponses défendables. | Correction proposée : « D'après Bāsim, qui est plus rapide que le chameau ? » et remplacer « le faucon » par un distracteur faux, ou poser la question sur la phrase (« le guépard est plus rapide que le chameau » / « le chameau est plus rapide que le guépard » / « l'âne est plus rapide que le chameau »). | Confiance : haute
- **[08 · lecture, question « Qui est le plus jeune ? »]** Problème : le texte compare seulement Salmā et Bāsim. Hilāl, l'un des choix, n'est pas comparé : « le plus jeune » des trois ne se déduit pas du texte. | Correction proposée : « Qui est plus jeune que l'autre, Salmā ou Bāsim ? », avec les choix « Salmā », « Bāsim », « on ne sait pas ». | Confiance : haute
- **[mots.json · fiche `akthar`, exemple « الْجِمَالُ فِي السُّوقِ أَكْثَرُ مِنَ الْخَيْلِ. »]** Problème : خَيْل n'est pas un mot connu (absent de mots.json). Il est seulement déclaré en `apercu` pour passer le contrôle, alors qu'il n'est jamais présenté (règle F1/F8). | Correction proposée : « الْجِمَالُ فِي السُّوقِ أَكْثَرُ مِنَ الْحَمِيرِ. », « Au marché, les chameaux sont plus nombreux que les ânes. » (حَمِيرٌ est affiché comme pluriel sur la fiche حِمَار). Retirer ensuite « الْخَيْلِ » de `apercu`. | Confiance : haute
- **[08 · lecture « دَرْسُ الْيَوْمِ سَهْلٌ… » et mini-boss « دَرْسُ الْيَوْمِ … » ; fiche `sahl`]** Problème : l'arabe est correct (الْيَوْم, nom, au génitif d'iḍāfa). Mais la fiche الْيَوْمَ apprise à l'apprenant dit « sa fin ne change pas ». Voir الْيَوْمِ sans explication contredit ce qu'il a appris. | Correction proposée : ajouter une explication courte (« ici الْيَوْم est le nom « le jour », complément d'iḍāfa : دَرْسُ الْيَوْمِ ») ou une note sur la fiche `sahl`. Le modèle vient du conseiller ; c'est la présentation qu'il faut corriger. | Confiance : moyenne

## Mineur
- **[08 · Forge (3 exercices) et schemes]** La consigne dit « moule أَفْعَل » et l'explication dit « dans أَفْعَلُ ». Le principe B2 veut un schème sans voyelle de cas. Il faut harmoniser, ou dire une fois que le -u de أَفْعَلُ est la fin du mot (nominatif sans tanwīn). Le tableau `schemes` contient d'ailleurs les deux formes.
- **[08 · règle 1, question compléter (أَصْغَرُ / صَغِيرَةٌ / أَصْغَرَ)]** L'explication n'écarte que صَغِيرَةٌ. Ajouter : « أَصْغَرَ : attribut au nominatif → -u ».
- **[08 · atelier, compléter أَبْعَدُ / بَعِيدٌ]** « الْجَبَلُ بَعِيدٌ مِنَ النَّهْرِ » est une phrase juste, qui veut dire « loin de la rivière ». L'explication peut le dire, pour que l'apprenant ne croie pas que la phrase est fautive.
- **[08 · règle 2, QCM « le plus long pont »]** En français naturel : « le pont le plus long ». Le mini-boss dit d'ailleurs « le chameau le plus rapide ».

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- **[08 · entraînement, QCM أَفْتَحُ / أَكْبَرُ, distracteur « أَكْبَرُ est un verbe »]** Ce qui me fait douter : le classique connaît كَبِرَ يَكْبَرُ « vieillir », dont la 1re personne est أَكْبَرُ « je vieillis ». Le distracteur n'est donc pas absolument faux. La réponse attendue, « le contexte donne le sens », reste la meilleure. | Pistes : reformuler en « أَكْبَرُ est toujours un verbe », ou laisser tel quel. | Confiance : moyenne (cité de mémoire, non vérifiable dans le Corpus du dépôt)

## Points vérifiés sans problème
- **A** :
  - aucune autre paire ⚠ du plan 3.8 (« هَٰذَا أَكْبَرُ », « وَلَا أَكْبَرَ », « أَنَا أَكْثَرُ مِنْكَ », « أَسْرَعُ الْحَاسِبِينَ », etc.) ;
  - aucun sujet pronom, aucun tamyīz ;
  - أَقْرَبُ bien absent ;
  - aucune formule sacrée, aucun sujet divin.
- **B / E** :
  - les lemmes >akobar, >aSogar, >akovar et >asoraE existent dans assets/content/iqura_content.db, avec les racines kbr, Sgr, kvr et srE ;
  - les racines bEd, Twl et shl existent ; أَبْعَدُ et أَطْوَلُ n'ont pas de lemme, ce qui confirme qu'ils sont bien notés « R » ;
  - أَطْوَلُ n'a pas de schème (racine en و), conformément à B3 ;
  - les Forge (كبر, صغر, بعد, سكن) n'utilisent que des racines saines et des mots de la liste.
- **C** :
  - vocalisation complète et correcte ; أَفْعَلُ toujours au nominatif sans tanwīn, jamais après une préposition ;
  - مِنْ بَاسِمٍ, دَرْسُ أَمْسِ (أَمْسِ invariable), سَلْمَى (alif maqṣūra) corrects ;
  - accords et iḍāfa corrects.
- **D** : les sens des fiches sont exacts (أَطْوَلُ « plus grand de taille » couvre bien le dialogue).
- **F** :
  - QCM de 3 choix, avec une seule bonne réponse en dehors des deux questions signalées ;
  - mots connus (حِمَار, قَرْيَة, نَهْر, رِسَالَة, جِسْر, فَهْد, أَمْسِ, نَعَمْ, أَفْتَحُ en région 2), sauf خَيْل ;
  - la translittération omet le ʾ initial, de façon cohérente avec le reste du dépôt (anta, amsi, arbaʿatun).
- **G** : `source_sens` « rédigé par IA » sur les 8 fiches.

## Ce que je n'ai pas pu vérifier
- Le passage du garde-fou `quran_guard.py` : je n'ai pas pu exécuter de commande. Les suites ⚠ ont été vérifiées de mémoire et à l'aide de la liste du conseiller.
- Les fréquences (champ binaire de la base, illisible par recherche de texte).
- L'audio (suspendu).

---

## Rapport de relecture — Leçon 3.9 « L'adjectif de relation » (nisba)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/09-l-adjectif-de-relation.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches `"lecon": "moteur-09"` : arabi, lugha, misri, baghdadi, dimashqi, farisi, hindi, jabali)
- Comparaison avec /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (§3.9 et principes B)

Stade : région 3, leçon 3.9 (Intermédiaire 1) ; notions supposées acquises : régions 1 et 2 (dont l'accord de l'adjectif, les pluriels réguliers et internes, قَالَ), leçons 3.1 à 3.8 (racine, schème, participes, lieux, فَعِيل/فَعَّال, pluriels internes, أَفْعَلُ).

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [09 · atelier, exercice 1 « C'est un marchand égyptien. »] Problème : le distracteur `هُوَ مِصْرِيٌّ تَاجِرٌ.` n'est pas faux en arabe classique. On peut le lire comme deux attributs de suite (خَبَرٌ بَعْدَ خَبَرٍ) : « il est égyptien, marchand », ce qui revient presque au même sens. On risque donc d'avoir deux réponses justes. | Correction proposée : le remplacer par un distracteur nettement fautif sur l'accord de définition, par exemple `هُوَ تَاجِرٌ الْمِصْرِيُّ.`, ou de genre, par exemple `هُوَ تَاجِرَةٌ مِصْرِيٌّ.`. La première solution est plus en lien avec la règle de la leçon. | Confiance : moyenne à haute.

## Mineur
- [09 · écran « La nisba », texte] La règle dit « après avoir enlevé l'article et ة », mais aucun des deux exemples (جَبَلٌ → جَبَلِيٌّ, مِصْرُ → مِصْرِيٌّ) ne montre ces suppressions. L'exemple الْبَصْرَةُ → بَصْرِيٌّ du plan n'a pas été repris. Ajouter un exemple qui le montre, par exemple `الْهِنْدُ → هِنْدِيٌّ` (avec l'article). On pourrait aussi préciser qu'on enlève le tanwīn.
- [09 · écran « La nisba »] « L'adjectif suit le nom et s'accorde avec lui » ne parle que de l'adjectif épithète. Or la question de cet écran (`سَلْمَى دِمَشْقِيَّةٌ`) et plusieurs exercices l'emploient comme attribut. On peut ajouter : « Il peut aussi être attribut : سَلْمَى دِمَشْقِيَّةٌ. »
- [09 · « Salmā est de Damas » (règle et mini-boss), « Samīr est de Bagdad »] Les explications ne parlent que du genre. Le distracteur à l'accusatif (`دِمَشْقِيَّةً`, `دِمَشْقِيًّا`, `بَغْدَادِيًّا`) n'est pas expliqué. On peut ajouter « au nominatif ».
- [09 · entrée, réplique 2] « transforme un nom de lieu en adjectif » : la leçon forme aussi عَرَبِيٌّ à partir d'un nom de peuple. On peut écrire « un nom (de lieu, de peuple…) ».

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- [09 · lecture, phrase 1 `فِي الْمَجْلِسِ تُجَّارٌ كَثِيرُونَ.`] Ce qui me fait douter : la forme `كَثِيرُونَ` n'est jamais une bonne réponse ailleurs. Elle n'apparaît qu'une fois, comme distracteur, en 2.18. Elle est correcte en arabe classique, qui emploie aussi bien كَثِيرٌ / كَثِيرَةٌ que كَثِيرُونَ avec un pluriel de personnes. Mais l'apprenant l'a vue présentée comme « fausse » avec un pluriel de choses. | Pistes : la garder, puisque تُجَّار désigne des personnes et que le pluriel en -ūna a été vu en 2.17, ou la remplacer par `كَثِيرٌ` pour éviter toute confusion. | Confiance : moyenne (la forme est juste ; c'est le choix pédagogique qui se discute).
- [09 · écran « Attention » et QCM « Lequel est une nisba ? »] « كُرْسِيٌّ ressemble à une nisba sans en être une » est conforme au plan. Certains grammairiens anciens décrivent toutefois le ي de كُرْسِيٌّ comme ayant la forme du ي de nisba sans en avoir le sens. Le QCM reste juste, mais la formulation pourrait gêner un apprenant avancé. | Piste : garder tel quel (confiance moyenne qu'aucun changement n'est nécessaire).

## Points vérifiés sans problème
- A : aucune suite coranique repérée (اللُّغَةُ الْعَرَبِيَّةُ, سَيْفٌ هِنْدِيٌّ قَدِيمٌ, فِي الْمَجْلِسِ au singulier et non الْمَجَالِسِ, عَلَى الْجِدَارِ…). Les interdits ⚠ du plan sont respectés : pas de لِسَان ni de كِتَاب avec عَرَبِيّ, pas de الْأَعْرَاب, pas de nisba religieuse, pas de بِـ. Les noms de villes ne viennent jamais après une préposition (مِصْرُ seulement au nominatif, dans l'aperçu et la règle). Aucun nom divin, aucune figure sacrée, récit profane. Le garde-fou de construction reste le contrôle qui fait foi.
- B/E : lemmes `Earabiy~` et `miSor` et racine `lgw` présents dans `assets/content/iqura_content.db` (recherche de texte). Les nisbas de lieux n'affichent pas de racine ; جَبَلِيٌّ affiche jbl. Aucune fréquence n'est affirmée dans la leçon.
- C : vocalisation complète et correcte partout. Formes justes : ـِيٌّ / ـِيَّةٌ avec shadda, عَرَبِيٌّ, مِصْرِيٌّ, بَغْدَادِيٌّ, دِمَشْقِيٌّ, فَارِسِيٌّ, هِنْدِيٌّ, جَبَلِيٌّ, سَلْمَى avec alif maqṣūra, هَٰذَا avec alif suscrit. Accords justes : بِنْتٌ مِصْرِيَّةٌ, بِسَاطٌ فَارِسِيٌّ, اللُّغَةُ الْعَرَبِيَّةُ جَمِيلَةٌ, صَدِيقُهُ بَغْدَادِيٌّ. Registre classique ; سَيْفٌ هِنْدِيٌّ est une tournure classique.
- D : traductions fidèles. Sens corrects : لُغَةٌ « langue (que l'on parle) », جَبَلِيٌّ « de montagne, montagnard ».
- F : un seul bon choix dans tous les QCM, sauf le point Important. Tous les mots de la lecture ont déjà été vus (مَجْلِس 3.5, رَحَّال 3.6, تُجَّار, جِدَار, قَدِيم…) : règle des 95 % respectée. Les exercices de révision (أَكْبَرُ, جُسُورٌ, صَعْبٌ, سَهْلٌ, صَخْرَةٌ) correspondent bien aux leçons 3.7 et 3.8. Translittérations Arabica des fiches exactes (ʿarabiyyun, luġatun, miṣriyyun, baġdādiyyun, dimašqiyyun, fārisiyyun, hindiyyun, ǧabaliyyun).
- G : `source_sens: "rédigé par IA"` sur chaque fiche ; exemples construits.

## Ce que je n'ai pas pu vérifier
- Les fréquences (champ binaire de la base, non lisible par recherche de texte) : la leçon n'en affirme aucune.
- Le passage du garde-fou `quran_guard.py`, que je n'ai pas exécuté.
- L'affichage effectif de la mention « rédigé par IA », de l'avertissement sur la racine pour لُغَةٌ et de la source « exemple construit » dans l'application.
- L'audio, suspendu.

---

## Rapport de relecture : leçon 3.10 « Ce que la racine ne dit pas »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/10-ce-que-la-racine-ne-dit-pas.json
- /home/user/iqura/tools/build_content/vocab/mots.json (les fiches nahar, qasr, sikkin, tariqa, fatha et sukun, avec "lecon": "moteur-10")
- Référence : /home/user/iqura/docs/relectures/decisions-intermediaire-1.md (plan de la 3.10, ⚠ et principes)

Stade : région 3, leçon 3.10. Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.9 (racines, moules, participes, lieux et outils, intensifs en فَعَّال vus en 3.6, élatif, nisba).

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [10-…json · entraînement, QCM « طَرِيقٌ → طَرِيقَةٌ : quelle relation ? »] Problème : la réponse attendue est « figurée », mais l'étiquette « figuré » n'est jamais présentée avant cette question. L'écran de règle « Les relations de sens » ne montre que trois étiquettes : proche, spécialisé et éloigné. « Intensif » a été vu en 3.6, « figuré » ne l'a été nulle part. Le plan prévoit pourtant de montrer les cinq étiquettes. Le mot n'apparaît qu'à l'écran « fin ». | Correction proposée : compléter le texte de la règle, par exemple : « … proches (كَتَبَ → كَاتِبٌ), intensifs (حَامِلٌ → حَمَّالٌ), spécialisés (طَالِبٌ…), figurés (طَرِيقٌ « chemin » → طَرِيقَةٌ « manière ») ou éloignés (جَمَلٌ / جَمِيلٌ). » Si la règle devient trop chargée pour un seul écran, faire un second écran de règle. | Confiance : haute.
- [10-…json · lecture, QCM « Où est le couteau ? »] Problème : le distracteur « dans le palais » peut aussi être juste. Le voyageur entre dans le palais, puis le cuisinier dit que le couteau est dans la cuisine. Rien n'empêche que cette cuisine soit dans le palais, donc deux réponses sont défendables. | Correction proposée : remplacer « dans le palais » par un lieu exclu par le texte, par exemple « dans la rivière » ou « sur les lettres ». | Confiance : moyenne-haute.
- [10-…json · mini-boss, traduire « le jour (la clarté) »] Problème : le distracteur « الْيَوْمَ » veut dire littéralement « le jour ». La fiche de l'apprenant le donne comme « aujourd'hui », avec la remarque « "le jour" à l'accusatif ». La précision « (la clarté) » sépare les deux, mais de justesse. De plus, ce choix est le seul à l'accusatif (-a) alors que les deux autres sont au nominatif (-u), ce qui l'élimine sans réflexion. | Correction proposée : remplacer « الْيَوْمَ » par « الصَّيْفُ » (même thème du temps ; mot présent dans l'aperçu de la leçon) ou par un autre nom connu au nominatif. Ne pas utiliser « اللَّيْلُ » à côté de « النَّهَارُ » (⚠ du plan). | Confiance : moyenne-haute.

## Mineur
- [10-…json · dialogue, consigne « Que montrent ces phrases de Hilāl ? »] La première réplique est dite par Bāsim, pas par Hilāl. | Correction proposée : « Que montrent ces phrases ? »
- [10-…json · entraînement, L'intrus « ثَمَرَةٌ / تَمْرٌ / تَمْرَةٌ »] « تَمْرَةٌ » (une datte, nom d'unité) n'a été enseigné nulle part : seul « تَمْرٌ » a une fiche. Le contrôle automatique l'accepte seulement parce que le ة est retiré comme s'il s'agissait du pronom ه, ce qui est un faux positif. L'exercice reste faisable, puisque les lettres ت م ر sont visibles. | Correction proposée : remplacer « تَمْرَةٌ » par un mot connu de racine ت م ر s'il en existe un ; sinon, garder le mot et l'annoncer dans l'explication (« تَمْرَةٌ : une datte »).
- [10-…json · entraînement, traduire « la fatḥa », distracteur « الْفَتْحُ »] Ce nom (« ouverture ») n'a jamais été enseigné. Il passe le contrôle parce qu'il a le même squelette que le verbe فَتَحَ. Voir aussi les Doutes. | Correction proposée : remplacer ce distracteur par « الْمَفْتُوحُ » (connu depuis 3.3).
- [mots.json · sukun] Le sens donné, « sukūn (le signe de l'absence de voyelle) », est seulement le sens grammatical. Or la leçon montre justement que c'est un sens spécialisé de la racine de سَكَنَ, et la fiche ne donne pas le sens général. | Correction proposée : ajouter, par exemple, « ; calme, immobilité (sens général) ». La fiche fatha peut garder son sens actuel.
- [10-…json · mini-boss, sens de « فَتْحَةٌ », distracteur « ouverture du marché »] « فَتْحَةٌ » peut aussi vouloir dire « une ouverture » (un acte d'ouvrir, une ouverture). Le complément « du marché » rend ce choix faux, mais la formule est étrange. | Correction proposée : le remplacer par un distracteur net, par exemple « porte ».

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- [10-…json · entraînement, sens de « طَرِيقَةٌ », distracteur « chemin » ; traduire « la méthode », distracteur « الطَّرِيقُ »] Ce qui me fait douter : de mémoire, les dictionnaires classiques (Lane, Lisān) donnent aussi à طَرِيقَةٌ un sens proche de طَرِيقٌ (voie, chemin), et à طَرِيقٌ un sens figuré de « voie, manière ». Chaque question aurait alors deux réponses défendables. | Pistes : remplacer « chemin » par « marché » ou « histoire », et « الطَّرِيقُ » par « الطَّبَّاخُ » ou « الْقِصَّةُ » ; ou faire confirmer le sens par le conseiller avec un dictionnaire. | Confiance : moyenne.
- [10-…json · traduire « la fatḥa », choix « الْفَتْحُ »] Ce qui me fait douter : chez les grammairiens, « الْفَتْحُ » désigne la voyelle a elle-même (par exemple « مَبْنِيٌّ عَلَى الْفَتْحِ »). Ce distracteur pourrait donc être une seconde bonne réponse pour un lecteur averti. | Pistes : le remplacer par « الْمَفْتُوحُ » (voir Mineur). | Confiance : moyenne.
- [10-…json · atelier, compléter « هَٰذِهِ … هِلَالٍ », distracteur « طَرِيقُ »] Ce qui me fait douter : en arabe classique, طَرِيقٌ peut être masculin ou féminin, donc « هَٰذِهِ طَرِيقُ هِلَالٍ » est grammatical (« voici le chemin de Hilāl »). Seul le sens « méthode » de la consigne exclut ce choix. Il n'y a sans doute pas deux réponses justes, mais l'explication ne doit pas faire croire que la forme est fausse. | Pistes : garder ce distracteur, ou le remplacer par « طُرُقُ ». | Confiance : faible à moyenne.
- [10-…json · entraînement, explication « Le chemin à suivre devient la manière de faire : sens figuré. »] Ce qui me fait douter : la phrase décrit un passage de sens, sans étymologie précise. Je la trouve acceptable, mais le conseiller ne donnait qu'une confiance moyenne à l'étiquette « figuré ». | Pistes : la garder ; ou la remplacer par « De "chemin" à "manière de faire" : sens figuré. » | Confiance : moyenne.

## Points vérifiés sans problème
- A : aucune suite coranique repérée à la lecture. Les ⚠ du plan sont respectés : pas de نَهَار avec لَيْل, pas de مِنَ/بِالنَّهَارِ, pas de « قُصُورًا », de « سِكِّينًا », de « طَرِيقَةً » ni de « عَلَى الطَّرِيقَةِ », pas de حَمَّال avec حَطَب. Aucun mot sur un monstre ; récit profane ; aucun sens religieux.
- B et E : les lemmes nahaAr, qaSor, sik~iyn et Tariyqap sont bien présents dans la base de contenu (assets/content/iqura_content.db). Aucune fréquence affichée. Les relations « éloignées » ne s'appuient que sur une racine commune (ن ه ر, ق ص ر, س ك ن, ج م ل), sans étymologie inventée (« lien non évident »). Les racines des faux amis sont justes : ق ل م ≠ ق ل ل, ت م ر ≠ ث م ر.
- C : vocalisation complète et juste. Bon cas après لَيْسَ (قَصِيرًا) ; iḍāfa sans tanwīn (طَرِيقَةُ هِلَالٍ) ; nisba accordée (اللُّغَةُ الْعَرَبِيَّةُ) ; أَفْتَحُ et أَكْبَرُ sur أَفْعَلُ ; prédicat placé avant un sujet indéfini (عَلَى الْبَاءِ فَتْحَةٌ). Orthographe correcte (ة, hamza, hamzat al-waṣl).
- Moules : les fiches sont justes (نَهَار فَعَال, قَصْر فَعْل, سِكِّين فِعِّيل, طَرِيقَة فَعِيلَة, فَتْحَة فَعْلَة, سُكُون فُعُول) ; كِتَابٌ et جِبَالٌ partagent bien فِعَال.
- D : traductions fidèles (le palais n'est pas court ; le chameau est beau ; il y a une fatḥa sur le bāʾ…). La remarque sur le genre de سِكِّين suit le plan.
- F : les autres QCM ont 3 choix et une seule bonne réponse. Les mots de la lecture sont tous connus (رَحَّال, طَبَّاخ, مَطْبَخ, حُرُوف…) ; صَيْف, بَاء et مِيم sont dans l'aperçu. Translittérations Arabica justes (nahārun, qaṣrun, sikkīnun, ṭarīqatun, fatḥatun, sukūnun).
- G : toutes les fiches portent « rédigé par IA » ; pas d'audio.

## Ce que je n'ai pas pu vérifier
- Le passage du garde-fou `quran_guard.py` : je n'ai pas exécuté la construction. Le garde-fou fait foi.
- La racine que le Corpus attribue à chaque lemme, et les nombres d'occurrences : je n'ai pas pu interroger la base SQLite, seulement constater que les lemmes y sont.
- Le sens de طَرِيقَةٌ dans les dictionnaires classiques (voir Doutes), que je cite de mémoire.
- L'affichage de "statut": "ia_non_verifie" (la mention visible doit être « rédigé par IA », d'après la décision du 22/10).
