# Décisions du conseiller : niveau Intermédiaire 1 (leçons 3.1 à 3.10)

Agent : conseiller-arabe, 03/11/2026. Point A tranché par l'utilisateur le 05/11/2026 : schème calculé à partir du Corpus et vérifié à la construction.

## Plan de langue du niveau Intermédiaire 1 (leçons 3.1 à 3.10, « La forge »)

**Question** : pour chaque leçon de 3.1 à 3.10, l'objectif, les mots, les phrases modèles et les pièges ; la notation des schèmes ; le traitement des racines faibles, à hamza ou doublées ; la liste des schèmes à enseigner.

**Stade** : région 3, leçons 3.1 à 3.10.
- **Acquis** : la région 1 et la région 2 entière (phrase nominale, cas, iḍāfa, suffixes, duel, pluriels, nombres, لَيْسَ, passé, inaccompli, négation, futur, impératif, relatifs). Les 203 mots de `vocab/mots.json` sont connus.
- **Décisions toujours en vigueur** : `decisions-elementaire-1.md`, `-2.md` et `-3.md`. L'audio est suspendu (§16, 03/11) : aucun exercice d'écoute ni de répétition. Les emplacements audio restent dans les données.
- **Sources lues** : cahier §3, §5.6-5.7, §6, §7, §11 et §16 ; `ETAT_DU_PROJET.md` §3 ; les trois fichiers de décisions ; `mots.json` ; `qac.py` ; le schéma de `build_content.py`.
- **Lemmes** : vérifiés par recherche de texte dans `assets/content/iqura_content.db` (lignes du type `makotuwbمَكْتُوبktbNNIPASS_PCPL`). Ce n'est pas une requête SQL : `vocab.validate` doit confirmer.
- **Fréquences** : je n'ai pas pu les lire (entiers binaires). Claude Code doit les vérifier en SQL. Il peut remplacer un mot par un lemme neutre plus fréquent du même schème.
- **Notations** : « L » = lemme du Corpus de même sens ; « R » = racine seule, sans fréquence ; « — » = absent du Corpus ; ⚠ = suite à ne jamais écrire. Les ⚠ sont cités de mémoire : le garde-fou de construction fait foi.

## Décision

### A. Point bloquant, à soumettre à l'utilisateur avant d'écrire 3.2

Le §16 (22/10/2026) dit : « Schèmes : absents du Quranic Arabic Corpus 0.4 ; QUL sera examiné avant la région 3 ; rien n'est inventé d'ici là. » Dans le dépôt, la colonne `lemma.pattern` est vide (`build_content.py` l. 71 : « aucune source ouverte, reste NULL »). Je ne contredis pas cette décision. Je renvoie donc la question à l'utilisateur, avec une recommandation sur le fond.

- **Ce qui ne pose pas de problème de source.** Enseigner la notation فعل et les valeurs des moules, c'est enseigner une règle de grammaire, comme les conjugaisons de la région 2. Les leçons peuvent l'expliquer.
- **Ce qui pose problème : le champ « schème » de chaque mot.**
  - **Option recommandée** : Claude Code écrit le schème dans les données, et la construction le vérifie. En remplaçant ف ع ل par les lettres de la racine du Corpus, on doit retrouver exactement le mot vocalisé, sans sa fin de cas. Cette vérification n'est fiable que pour les racines dont toutes les lettres sont visibles (voir B). Pour une racine faible, la forme écrite ne montre pas le schème (قَالَ ≠ « فَالَ ») : on n'affiche alors aucun schème.
  - **Option prévue par la décision du 22/10** : examiner d'abord QUL (contenu et licence).
- **Qui tranche** : c'est une question de source et de règle de travail, donc l'utilisateur.

### B. Principes du niveau

1. **Notation de la racine** : lettres séparées par des espaces, sans voyelles, dans l'ordre (ك ت ب).
   - En arabe, on emploie en aperçu le terme classique الْحُرُوفُ الْأَصْلِيَّةُ, en signalant que جَذْرٌ est le mot courant aujourd'hui.
   - Définition : « trois lettres (parfois quatre), dans le même ordre, communes à une famille de mots ».
2. **Notation du schème** : ف ع ل, entièrement vocalisés.
   - Le schème n'a ni tanwīn ni voyelle de cas : فَاعِل, مَفْعُول, فِعَال.
   - Il garde ة, les voyelles longues et la shadda : فِعَالَة, فَعَّال.
   - Les verbes gardent leur finale : فَعَلَ, يَفْعُلُ.
   - Pour la comparaison avec le schème, le mot s'affiche lui aussi sans sa fin (كَاتِب ↔ فَاعِل). Règle du maître : « La fin du mot (-un, -u, -i, -a) ne fait pas partie du moule : elle change avec le rôle du mot. »
   - Couleurs : ف = 1re lettre de la racine, ع = 2e, ل = 3e, dans les couleurs de la racine surlignée de la région 2. Les lettres ajoutées restent en noir.
   - Quadrilitères : فَعْلَل, en aperçu seulement.
   - Terme arabe en aperçu : وَزْنٌ.
3. **Racines admises dans les exercices d'analyse** (Détective, schème, Forge, Deviner puis vérifier). Une condition testable automatiquement :
   - racine du Corpus à 3 lettres (ou 4 en 3.1), sans و, ي ni ء ;
   - chaque lettre de la racine visible dans le mot, une shadda comptant pour une lettre répétée.
   - Sont donc admis : قَلِيل, جَدِيد, خَفِيف, حَدِيد, حَدَّاد (ح د د bien visibles).
   - Sont exclus de l'analyse : les formes contractées (حَارّ, أُمّ, سَلَّة, قِصَّة, أَقَلّ, أَخَفّ) ; tout mot à racine faible (بَيْت, بَاب, مَاء, نَار, سُوق, جَار, يَد, مَكَان, مِيزَان, سَيْف, خَيْط, ثَوْب, صَوْت, شَيْخ, يَوْم) ; tout mot à hamza (سُؤَال, أَرْض, بِئْر).
   - Exclu aussi : نَهْرٌ, parce que le Corpus le vocalise نَهَر.
   - Ces mots gardent leur racine sur leur fiche (déjà décidé). Ils ne sont **ni évités dans les textes ni analysés**.
   - **Un écran d'aperçu en 3.1** : « Quand la racine contient و, ي ou ء, ou deux fois la même lettre, ces lettres peuvent changer ou se cacher (بَيْتٌ : ب ي ت ; حَارٌّ : ح ر ر). Tu les étudieras aux leçons 3.22 à 3.26. »
4. **La Forge ne crée jamais un mot.**
   - Elle ne propose que des couples racine + schème dont le résultat figure dans la liste de mots vérifiée.
   - Un distracteur qui n'est pas un mot s'explique ainsi : « absent de notre dictionnaire », jamais « n'existe pas en arabe ».
   - Jamais de مَفْعُول d'un verbe intransitif : pas de مَجْلُوس, مَخْرُوج, مَدْخُول, مَذْهُوب, مَرْجُوع.
5. **Noms divins** : aucun exercice ni générateur ne produit عَلِيم, حَكِيم, رَحِيم, سَمِيع, بَصِير, عَزِيز, كَرِيم, عَظِيم, قَدِير, خَبِير, لَطِيف, حَلِيم, حَمِيد, مَجِيد, رَقِيب, شَهِيد, وَكِيل, حَفِيظ, ni غَفَّار, وَهَّاب, رَزَّاق, فَتَّاح, تَوَّاب, قَهَّار, جَبَّار, خَلَّاق, ni le participe طَارِق (titre de sourate). Cette liste d'exclusion est à coder.
   - كَبِير et قَرِيب restent des adjectifs généraux (région 2), jamais avec un sujet divin.
   - ⚠ « إِنِّي قَرِيبٌ ».
6. **Récits de la forge et des montagnes** : aucune scène qui reprend un récit coranique.
   - Pas de muraille de fer et de cuivre fondu entre deux montagnes, pas de fer assoupli ni de cottes de mailles, pas de chaudrons de génies, pas de construction d'arche, pas de maisons taillées dans la montagne.
   - ⚠ « زُبَرَ الْحَدِيدِ », « قِطْرًا », « انْفُخُوا », « أَلَنَّا لَهُ الْحَدِيدَ », « الْحَدِيدَ فِيهِ », « مِنَ الْجِبَالِ بُيُوتًا » (jamais بُيُوت avec الْجِبَال), « إِلَى جَبَلٍ », « عَلَى جَبَلٍ », « إِلَى الْجَبَلِ », « الْجِبَالُ » suivi d'un verbe de mouvement, « قُدُورٍ ».
   - ⚠ « الذَّهَبُ وَالْفِضَّةُ » côte à côte, sous toute forme.
7. **Cas** : jusqu'à 3.28, les mots sans tanwīn (أَفْعَلُ, مَفَاعِلُ, مَفَاعِيلُ, فَعَائِلُ, فُعَلَاءُ, les noms de villes) restent au nominatif, jamais après une préposition (règle de la région 2 prolongée). La préposition بِـ « avec, au moyen de » n'est pas encore enseignée : on ne l'emploie pas.
8. **Lecture** : la règle des 95 % de mots connus reste absolue. Un mot dérivé « à deviner » ne paraît que **seul**, dans l'exercice Deviner puis vérifier, jamais dans un texte gradué.
9. **Avertissement du §7**, visible en 3.1, puis sur chaque fiche de racine : « La racine aide à repérer et à retenir les mots d'une famille ; elle ne permet pas de deviner le sens exact de chaque mot. »
10. **Étymologie** : les étiquettes de relation de sens (proche, intensif, spécialisé, figuré, éloigné) n'apparaissent qu'à partir de 3.10, et seulement sur des mots relus. On ne donne aucune étymologie : quand le lien n'est pas évident, on écrit « éloigné : le lien de sens n'est pas évident ».

### C. Schèmes enseignés

| Leçon | Exercés | Seulement montrés |
| --- | --- | --- |
| 3.2 | فَعَلَ (verbe), فَعْل, فَعَل, فِعَال | فَعِلَ (détail en 3.11), فُعْل ; quadrilitère فِعْلَل / فِعْلَال |
| 3.3 | فَاعِل, مَفْعُول (et en ـَة) | فَعِل adjectif (فَرِحٌ) ; autre moule pour مُسَافِرٌ, مُعَلِّمٌ (3.20) |
| 3.4 | noms d'action فَعْل, فُعُول, فِعَالَة | فَعَل (طَلَب), فِعْل (حِفْظ), فُعْل (شُرْب), فَعَال (ذَهَاب), مَفْعِلَة (مَعْرِفَة) |
| 3.5 | lieu : مَفْعَل, مَفْعِل, مَفْعَلَة ; instrument : مِفْعَال, مِفْعَلَة | مِفْعَل ; temps (مَغْرِب) ; مِيزَان (racine faible) |
| 3.6 | فَعِيل (qualité), فَعَّال (métier, intensif) | فَعِيل au sens passif (حَبِيب) ; فَعِيل nom (حَدِيد) |
| 3.7 | pluriels أَفْعَال, فِعَال, فُعُول, فُعُل, فُعَّال | فُعَلَاءُ, أَفْعِلَاءُ, فَعْلَى, مَفَاعِلُ, مَفَاعِيلُ, فَعَائِلُ (nominatif seulement) |
| 3.8 | أَفْعَلُ (comparatif, superlatif) | فُعْلَى (كُبْرَى) ; أَقَلُّ, أَخَفُّ (contraction, chapitre C) |
| 3.9 | suffixe ـِيٌّ / ـِيَّةٌ | nisbas irrégulières (قَرَوِيٌّ, مَدَنِيٌّ non employé) |

**Termes arabes, en aperçu** : اسْمُ الْفَاعِلِ, اسْمُ الْمَفْعُولِ, مَصْدَرٌ, اسْمُ الْمَكَانِ, اسْمُ الزَّمَانِ, اسْمُ الْآلَةِ, الصِّفَةُ الْمُشَبَّهَةُ, صِيغَةُ الْمُبَالَغَةِ, اسْمُ التَّفْضِيلِ, النِّسْبَةُ.

### D. Plan par leçon

**3.1 La racine**
- **Objectif** : extraire la racine d'un mot connu.
- **On montre** la méthode :
  1. enlever ce qui s'ajoute au mot : الـ, la fin, ة, ـَانِ, ـُونَ / ـِينَ, ـَات, les pronoms collés, يَـ / تَـ / أَ / نَـ / سَـ, ـتُ / ـنَا / ـُوا ;
  2. enlever ا, و, ي longs ;
  3. enlever un م ou un أ du début s'il reste plus de trois lettres.
- On montre aussi les quadrilitères avec دِرْهَمٌ (racine drhm) et قِرْطَاسٌ (racine qrTs), toutes deux dans le Corpus, ainsi que l'écran d'aperçu sur les racines faibles (B3).
- **On laisse de côté** : les schèmes et les racines faibles.
- **Mots (7)** :
  - دَرْسٌ « leçon », m., pluriel دُرُوسٌ, R drs. Mot lu en région 1, il reçoit sa fiche ;
  - بَرْدٌ « le froid », m., L barod ;
  - ثَلْجٌ « neige », m., — ;
  - صَخْرَةٌ « rocher », f., pluriel صُخُورٌ, L Saxorap ;
  - فَحْمٌ « charbon », m., nom collectif, — ;
  - نُحَاسٌ « cuivre », m., L nuHaAs ;
  - صَعِدَ « il est monté, il a gravi », inaccompli يَصْعَدُ (a). Lemme du Corpus `yaSoEadu` (verbe, forme I), à confirmer.
- **Mots connus à réutiliser** : كَتَبَ / كَاتِبٌ / كِتَابٌ / كُتُبٌ, حَمَلَ / حِمْلٌ / أَحْمَالٌ, دَرَسَ, طَالِبٌ / طَلَبَ, خَبَّازٌ / خُبْزٌ, فَتَحَ / مِفْتَاحٌ, جَبَلٌ / جِبَالٌ, بَارِدٌ.
- **Modèles** :
  - صَعِدَ الْمُسَافِرُونَ الْجَبَلَ فِي الصَّبَاحِ. « Les voyageurs ont gravi la montagne le matin. »
  - فِي الْجَبَلِ ثَلْجٌ كَثِيرٌ. « Il y a beaucoup de neige sur la montagne. »
  - الْبَرْدُ كَثِيرٌ فِي الْجِبَالِ. « Il fait très froid dans les montagnes. »
- **Pièges** :
  - les lettres de la racine gardent leur ordre ;
  - ذَهَبٌ et ذَهَبَ ont la même racine : la racine ne donne pas le sens (renvoi à 3.10) ;
  - ⚠ « بَرْدًا », jamais (« بَرْدًا وَسَلَامًا », « بَرْدًا وَلَا شَرَابًا ») ;
  - ⚠ « إِلَى الصَّخْرَةِ », « فِي صَخْرَةٍ », « الصَّخْرَ » ; jamais نُحَاس à côté de نَار ;
  - ⚠ يَصْعَدُ avec إِلَيْهِ, et صَعِدَ avec السَّمَاء ;
  - ⚠ « دَرَسُوا مَا ».

**3.2 Le schème**
- **Objectif** : reconnaître le moule et lire la notation.
- **Règle** : « Le moule garde les voyelles et les lettres ajoutées. On remplace les trois lettres de la racine par ف, ع, ل : كَتَبَ → فَعَلَ ; كِتَاب → فِعَال. Des mots de racines différentes peuvent avoir le même moule. »
- **Mots (7)** :
  - سَفَرٌ « voyage », m., L safar. Pluriel non affiché (أَسْفَار est ambigu) ;
  - حَبْلٌ « corde », m., pluriel حِبَالٌ, L Habol ;
  - كَنْزٌ « trésor », m., pluriel كُنُوزٌ, L kanz ;
  - حِزَامٌ « ceinture », m., —, à vérifier ;
  - بِسَاطٌ « tapis », m., lemme à vérifier (racine bsT) ;
  - طَرَقَ « il a frappé (une porte, un métal) », يَطْرُقُ (u), R Trq ;
  - عَقْرَبٌ « scorpion », —, aperçu du quadrilitère, hors exercices d'accord (genre incertain).
- **Mots connus** :
  - فَعْل : كَلْبٌ, لَحْمٌ, شَمْسٌ, سَطْرٌ, دَرْسٌ ;
  - فَعَل : جَبَلٌ, جَمَلٌ, قَلَمٌ, ذَهَبٌ, ثَمَنٌ, لَبَنٌ ;
  - فِعَال : كِتَابٌ, جِدَارٌ, مِدَادٌ ;
  - فَعَلَ : كَتَبَ, فَتَحَ, جَلَسَ ; فَعِلَ en aperçu : شَرِبَ, سَمِعَ.
- **Modèles** :
  - طَرَقَ الْحَدَّادُ الْحَدِيدَ. « Le forgeron a frappé le fer. »
  - الْحَبْلُ طَوِيلٌ. « La corde est longue. »
  - الْكَنْزُ فِي الصُّنْدُوقِ. « Le trésor est dans le coffre. »
- **Pièges** :
  - فِعَال est aussi un moule de pluriel (جِبَالٌ, رِجَالٌ) : le moule seul ne dit pas « singulier » ou « pluriel » ;
  - ⚠ « حَبْلٌ مِنْ… » (jamais, sous aucune forme), « حَبْلِ اللَّهِ », « حَبْلِ الْوَرِيدِ », « حِبَالُهُمْ » ;
  - ⚠ « عَلَى سَفَرٍ », « سَفَرِنَا هَٰذَا » ;
  - ⚠ « كَنْزٌ لَهُمَا », « تَحْتَهُ كَنْزٌ », كَنَزَ / يَكْنِزُ avec ذَهَب ;
  - ⚠ « بِسَاطًا » avec الْأَرْض.

**3.3 Celui qui fait, ce qui est fait**
- **Règle** : « فَاعِل : celui qui fait l'action (كَاتِب). مَفْعُول : ce qui la subit (مَكْتُوب). Le féminin prend ة. Un verbe sans complément (جَلَسَ, خَرَجَ) n'a pas de مَفْعُول. »
- **Mots (8)** :
  - مَكْتُوبٌ « écrit (ce qui est écrit) », L makotuwb ;
  - حَامِلٌ « qui porte, porteur », R Hml (dans le Corpus, les lemmes sont au pluriel) ;
  - خَارِجٌ « qui sort ; dehors », L xaArij ;
  - جَالِسٌ « assis », R jls ;
  - رَاكِبٌ « monté (sur une monture), cavalier », R rkb, pluriel non affiché ;
  - مَفْتُوحٌ « ouvert », R ftH (le Corpus n'a que la forme II) ;
  - صَانِعٌ « artisan, celui qui fabrique », pluriel صُنَّاعٌ, R SnE ;
  - سَاكِنٌ « habitant », pluriel سُكَّانٌ, R skn. Dans le Corpus, le sens est « immobile » : pas de lien au lemme (réutilisé en 3.10).
- **Mots connus** : كَاتِبٌ, حَارِسٌ, طَالِبٌ, بَارِدٌ (forme فَاعِل, sens d'adjectif), مَشْغُولٌ.
- **Modèles** :
  - الْبَابُ مَفْتُوحٌ. « La porte est ouverte. »
  - الشَّيْخُ جَالِسٌ فِي الْخَيْمَةِ. « Le vieil homme est assis dans la tente. »
  - الرِّسَالَةُ مَكْتُوبَةٌ. « La lettre est écrite. »
  - حَامِلُ السَّلَّةِ صَدِيقِي. « Celui qui porte le panier est mon ami. »
- **Pièges** :
  - pas de complément direct après un participe (règle non vue) : on emploie l'iḍāfa (رَاكِبُ الْجَمَلِ) ;
  - مُسَافِرٌ et مُعَلِّمٌ ont un autre moule (renvoi à 3.20) ;
  - pas de طَارِق, et pas de participe de verbe qui ne figure pas dans la liste ;
  - ⚠ « مَكْتُوبًا عِنْدَهُمْ », « بِخَارِجٍ مِنْهَا », « بِخَارِجِينَ », « سَاكِنًا », « بِحَامِلِينَ », « غَيْرَ مَسْكُونَةٍ », « الرَّكْبُ ».

**3.4 Le nom d'action (maṣdar)**
- **Règle** : « Le nom d'action nomme l'action elle-même : الْكِتَابَةُ « l'écriture, le fait d'écrire ». En forme I, aucune règle ne permet de le prévoir : on l'apprend avec le verbe. Il est donné sur la fiche du verbe. »
- **Mots (8)** :
  - كِتَابَةٌ « écriture », R ktb ;
  - دِرَاسَةٌ « étude », lemme `diraAsat`, à confirmer ;
  - خُرُوجٌ « sortie », L xuruwj ;
  - دُخُولٌ « entrée (le fait d'entrer) », R dxl ;
  - جُلُوسٌ « le fait de s'asseoir », R jls ;
  - جَمْعٌ « rassemblement ; (en grammaire) pluriel », L jamoE. Lien avec 2.17 ;
  - فَهْمٌ « compréhension », R fhm ;
  - حِفْظٌ « garde ; mémorisation », L HifoZ.
- **Sur les fiches, à reconnaître** : ذَهَابٌ (L), شُرْبٌ (L), طَلَبٌ (L), مَعْرِفَةٌ (R).
- **Modèles** :
  - الْكِتَابَةُ جَمِيلَةٌ. « L'écriture est belle. »
  - خُرُوجُ الْقَافِلَةِ فِي الصَّبَاحِ. « Le départ de la caravane est le matin. »
  - الدِّرَاسَةُ فِي الْمَسَاءِ. « L'étude a lieu le soir. »
- **Pièges** :
  - دَرْسٌ (leçon) et دِرَاسَةٌ (étude) viennent tous deux de دَرَسَ ;
  - كِتَابٌ (livre) a le moule فِعَال d'un nom d'action : aperçu, repris en 3.10 ;
  - ⚠ « يَوْمُ الْخُرُوجِ », « إِلَى خُرُوجٍ », « حِفْظًا », « شُرْبَ الْهِيمِ » ; jamais شِرْبٌ (autre mot) ;
  - ⚠ سَمْع : ce mot n'est pas présenté ici (« السَّمْعَ وَالْأَبْصَارَ ») ;
  - ⚠ « يَوْمَ الْجَمْعِ », « الْجَمْعَانِ », « عَلَى ذَهَابٍ ».

**3.5 Lieux et instruments**
- **Règle 1** : « مَفْعَل, ou مَفْعِل quand l'inaccompli a i : c'est l'endroit de l'action (يَجْلِسُ → مَجْلِس ; يَدْخُلُ → مَدْخَل). »
- **Règle 2** : « مِفْعَال, مِفْعَلَة : c'est l'outil (مِفْتَاح). »
- Présenté comme une **tendance**. Exception en aperçu : مَغْرِبٌ « lieu ou moment du coucher (du soleil) ; l'ouest », alors qu'on attendrait a.
- **Mots (9)** :
  - مَجْلِسٌ « lieu où l'on s'assoit, assemblée », pluriel مَجَالِسُ, R jls (le Corpus n'a que le pluriel) ;
  - مَسْكَنٌ « habitation », pluriel مَسَاكِنُ, L masokan ;
  - مَدْخَلٌ « entrée (lieu) », R dxl ;
  - مَخْرَجٌ « sortie, issue », L maxoraj ;
  - مَدْرَسَةٌ « école », f., R drs ;
  - مَزْرَعَةٌ « champ cultivé, ferme », f., R zrE ;
  - مِصْبَاحٌ « lampe », pluriel مَصَابِيحُ, L miSobaAH. Même racine que صَبَاحٌ, sans expliquer le lien ;
  - مِنْشَارٌ « scie », R n$r (à vérifier) ;
  - مِطْرَقَةٌ « marteau », f., R Trq.
- **Mots connus** : مَطْبَخٌ, مِفْتَاحٌ. Pour مِيزَانٌ, seulement en aperçu : « même moule, mais racine و ز ن : chapitre C ».
- **Modèles** :
  - جَلَسَ الضُّيُوفُ فِي الْمَجْلِسِ. « Les invités se sont assis dans la salle de réunion. »
  - يَدْرُسُ الطُّلَّابُ فِي الْمَدْرَسَةِ. « Les étudiants étudient à l'école. »
  - مِطْرَقَةُ الْحَدَّادِ ثَقِيلَةٌ. « Le marteau du forgeron est lourd. »
- **Pièges** :
  - مَكَانٌ ne s'analyse pas (racine faible) ;
  - pas de بِـ d'instrument ;
  - les pluriels sans tanwīn restent au nominatif ;
  - ⚠ مِصْبَاح jamais après فِي ou فِيهَا, ni avec زُجَاجَة ; « بِمَصَابِيحَ » ;
  - ⚠ « مَسَاكِنَ طَيِّبَةً », « مَسَاكِنُهُمْ », « مَسَاكِنَكُمْ » ; « مَخْرَجًا » avec لَهُ ; مُدْخَل / مَدْخَل avec صِدْق ou كَرِيم ; « فِي الْمَجَالِسِ » ;
  - ⚠ « مَغْرِبَ الشَّمْسِ » ; jamais مَشْرِق et مَغْرِب ensemble.

**3.6 Adjectifs et intensifs**
- **Règle 1** : « فَعِيل dit souvent une qualité qui dure : قَصِيرٌ. فَاعِل dit plutôt un état du moment : جَالِسٌ. »
- **Règle 2** : « فَعَّال dit un métier (خَبَّازٌ) ou quelqu'un qui fait beaucoup une action (رَحَّالٌ). »
- Ce sont des tendances.
- **Mots (8)** :
  - مَرِيضٌ « malade », pluriel مَرْضَى, L ;
  - فَقِيرٌ « pauvre », pluriel فُقَرَاءُ, L ;
  - ضَعِيفٌ « faible », pluriel ضُعَفَاءُ, L ;
  - سَرِيعٌ « rapide », L, pluriel non affiché ;
  - سَعِيدٌ « heureux », pluriel سُعَدَاءُ, L ;
  - طَبَّاخٌ « cuisinier », — ;
  - حَمَّالٌ « porteur (de métier) », R Hml ;
  - رَحَّالٌ « grand voyageur », R rHl.
  - Chaque adjectif a sa forme en ة sur la fiche.
- **Mots connus** :
  - فَعِيل : les adjectifs de 2.9 à 2.20 ; فَعِيل nom : حَدِيدٌ, سَرِيرٌ, قَمِيصٌ, طَرِيقٌ ; فَعِيل au sens passif, en aperçu : حَبِيبٌ « aimé » ;
  - فَعَّال : خَبَّازٌ, خَيَّاطٌ, حَدَّادٌ, نَجَّارٌ, نَسَّاجٌ, صَرَّافٌ.
- **Modèles** :
  - الشَّيْخُ مَرِيضٌ الْيَوْمَ. « Le vieil homme est malade aujourd'hui. »
  - حَمَلَ الْحَمَّالُ الْأَحْمَالَ إِلَى السُّوقِ. « Le porteur a porté les charges au marché. »
  - التَّاجِرُ لَيْسَ فَقِيرًا. « Le marchand n'est pas pauvre. »
- **Pièges** :
  - حَامِلٌ (qui porte, ici et maintenant) et حَمَّالٌ (porteur de métier) se distinguent par la shadda ;
  - les pluriels فُعَلَاءُ restent au nominatif ;
  - ⚠ jamais حَمَّالَة, jamais حَمَّال avec حَطَب ;
  - ⚠ « سَرِيعُ الْحِسَابِ / الْعِقَابِ » : سَرِيع seulement comme attribut ou épithète ;
  - ⚠ « ضَعِيفًا » ; jamais فَقِير avec غَنِيّ ; jamais أَنْتُمْ avec الْفُقَرَاء ; « شَقِيٌّ وَسَعِيدٌ » ; « الْمَرْضَى » après عَلَى.

**3.7 Les pluriels internes**
- **Règle** : « Pour retrouver le singulier, cherche la racine, puis essaie les moules de singulier que tu connais. Le pluriel ne se prévoit pas : il s'apprend avec le mot. Un pluriel de choses s'accorde au féminin singulier (2.18). »
- **Mots (6)** :
  - طِفْلٌ « petit enfant », pluriel أَطْفَالٌ, L Tifol, avec la remarque « sert aussi au féminin et au pluriel en classique » ;
  - سَرْجٌ « selle », pluriel سُرُوجٌ, R srj ;
  - جِسْرٌ « pont », pluriel جُسُورٌ, — ;
  - صَحْنٌ « plat, assiette », pluriel صُحُونٌ, — ;
  - صَقْرٌ « faucon », pluriel صُقُورٌ, — ;
  - فَهْدٌ « guépard », pluriel فُهُودٌ, —.
- **Pluriels déjà affichés à exercer** : أَقْلَامٌ, أَوْلَادٌ, أَحْمَالٌ, أَشْجَارٌ, أَزْهَارٌ ; رِجَالٌ, جِبَالٌ, جِمَالٌ, حِبَالٌ, كِلَابٌ ; لُحُومٌ, نُجُومٌ, كُنُوزٌ, دُرُوسٌ, صُخُورٌ, حُرُوفٌ, سُطُورٌ ; كُتُبٌ, سُقُفٌ, جُدُرٌ ; تُجَّارٌ, طُلَّابٌ, حُرَّاسٌ, كُتَّابٌ, سُكَّانٌ, صُنَّاعٌ.
- **À reconnaître seulement** : مَجَالِسُ, مَدَارِسُ, مَسَاكِنُ ; مَفَاتِيحُ, مَصَابِيحُ ; رَسَائِلُ, حَدَائِقُ ; فُقَرَاءُ ; مَرْضَى.
- **Modèles** :
  - الْجُسُورُ طَوِيلَةٌ. « Les ponts sont longs. »
  - الصُّقُورُ فَوْقَ الْجَبَلِ. « Les faucons sont au-dessus de la montagne. »
  - الْأَطْفَالُ فِي الْحَدِيقَةِ. « Les enfants sont dans le jardin. »
- **Pièges** :
  - فِعَال est aussi un moule de singulier (كِتَابٌ) ; أَفْعَال (أَقْلَامٌ) n'est pas أَفْعَلُ (أَكْبَرُ, en 3.8) ;
  - on ne demande pas le pluriel de mots à racine faible ;
  - ⚠ « الْأَنْهَارُ » avec تَحْت ou تَجْرِي ; « بَلَغَ الْأَطْفَالُ » ; « طِفْلًا » ; « الطِّفْلِ الَّذِينَ ».

**3.8 Plus grand, le plus grand**
- **Règle 1** : « Comparatif : أَفْعَلُ مِنْ… ; il ne change ni de genre ni de nombre : الْبِنْتُ أَصْغَرُ مِنَ الْوَلَدِ. »
- **Règle 2** : « Superlatif : أَفْعَلُ suivi d'un nom indéfini en i : أَكْبَرُ بَيْتٍ. »
- أَفْعَلُ ne prend pas de tanwīn (comme دَرَاهِمُ). En aperçu : الْأَكْبَرُ « l'aîné », كُبْرَى.
- **Mots (9)** :
  - أَكْبَرُ, أَصْغَرُ, أَكْثَرُ, أَقْرَبُ, أَسْرَعُ : L (ce sont des lemmes à part dans le Corpus) ;
  - أَبْعَدُ, أَطْوَلُ : R ;
  - سَهْلٌ « facile », R shl (dans le Corpus, le sens est « plaine ») ;
  - صَعْبٌ « difficile », —, à vérifier.
- **Modèles** :
  - الْجَمَلُ أَطْوَلُ مِنَ الْحِمَارِ. « Le chameau est plus grand que l'âne. »
  - بَيْتُ سَلْمَى أَكْبَرُ بَيْتٍ فِي الْقَرْيَةِ. « La maison de Salmā est la plus grande du village. »
  - دَرْسُ الْيَوْمِ سَهْلٌ. « La leçon d'aujourd'hui est facile. »
- **Pièges** :
  - أَفْتَحُ « j'ouvre » a le même moule que أَكْبَرُ (sens donné par le contexte) ;
  - أَرْبَعَةٌ, أَرْضٌ et أَمْسِ commencent par أ sans être des أَفْعَلُ ;
  - أَحْمَرُ (couleurs, plus tard) n'est pas un comparatif ;
  - sujet : un nom, pas un pronom (le garde-fou des paires) ;
  - ⚠ « هَٰذَا أَكْبَرُ » (jamais), « أَكْبَرُ مِنْ » suivi de خَلْق, الْقَتْل ou نَفْع ; « وَلَا أَكْبَرَ » ;
  - ⚠ « أَكْثَرُهُمْ », « أَكْثَرَ النَّاسِ », « أَنَا أَكْثَرُ مِنْكَ » ;
  - ⚠ « نَحْنُ أَقْرَبُ », « هُوَ أَقْرَبُ », « أَقْرَبُ لِلتَّقْوَى » ; « أَسْرَعُ الْحَاسِبِينَ », « أَسْرَعُ مَكْرًا » ;
  - pas de tamyīz (« أَكْثَرُ مَالًا ») ; pas de أَحْسَنُ dans ce niveau.

**3.9 L'adjectif de relation (nisba)**
- **Règle** : « On ajoute ـِيٌّ (féminin ـِيَّةٌ), après avoir enlevé l'article et ة : الْبَصْرَةُ → بَصْرِيٌّ ; جَبَلٌ → جَبَلِيٌّ. »
- On exerce le masculin et le féminin singuliers. Le pluriel en -ūna est en aperçu.
- **Mots (8)** :
  - عَرَبِيٌّ « arabe », L Earabiy~ ;
  - لُغَةٌ « langue », f., R lgw, selon la règle d'Élémentaire 1, avec l'avertissement ;
  - مِصْرِيٌّ « égyptien » (مِصْرُ : L miSor) ;
  - بَغْدَادِيٌّ ; دِمَشْقِيٌّ ; فَارِسِيٌّ « persan » ; هِنْدِيٌّ « indien » ;
  - جَبَلِيٌّ « de montagne », R jbl.
  - Noms de lieux et leurs nisbas : **pas de racine affichée** (بَصْرَة n'a pas de lien avec ب ص ر « voir »).
- **Modèles** :
  - اللُّغَةُ الْعَرَبِيَّةُ جَمِيلَةٌ. « La langue arabe est belle. »
  - سَمِيرٌ بَغْدَادِيٌّ، وَسَلْمَى دِمَشْقِيَّةٌ. « Samīr est de Bagdad et Salmā de Damas. »
  - هَٰذَا سَيْفٌ هِنْدِيٌّ قَدِيمٌ. « Ceci est une vieille épée indienne. »
- **Pièges** :
  - بَيْتِي « ma maison » (-ī) n'est pas une nisba (-iyy) ;
  - كُرْسِيٌّ ressemble à une nisba sans en être une ;
  - l'arabe se dit الْعَرَبِيَّةُ ;
  - les noms de villes, sans tanwīn, restent au nominatif ;
  - aucune nisba religieuse (إِسْلَامِيّ, مَكِّيّ, مَدَنِيّ, قُرْآنِيّ, noms de communautés religieuses) ;
  - ⚠ jamais لِسَان avec عَرَبِيّ ; « عَرَبِيٌّ مُبِينٌ », « قُرْآنًا عَرَبِيًّا », « حُكْمًا عَرَبِيًّا », « أَعْجَمِيٌّ وَعَرَبِيٌّ » ; jamais كِتَاب avec عَرَبِيّ (par prudence) ; jamais الْأَعْرَاب ;
  - ⚠ « مِصْرَ » après ادْخُلُوا ou مِنْ, « مِصْرًا », « مُلْكُ مِصْرَ » ;
  - ⚠ jamais شَرْقِيّ et غَرْبِيّ ensemble.

**3.10 Ce que la racine ne dit pas**
- **Objectif** : savoir quand la déduction échoue, et toujours vérifier dans le dictionnaire.
- **On montre** les cinq étiquettes du §7, avec ces exemples :
  - **proche** : كَتَبَ → كَاتِبٌ, مَكْتُوبٌ ; فَتَحَ → مِفْتَاحٌ ;
  - **intensif** : حَامِلٌ → حَمَّالٌ ;
  - **spécialisé** : طَالِبٌ « étudiant » (de « chercher ») ; كَاتِبٌ « scribe » ; فَتْحَةٌ « la voyelle a » (racine de « ouvrir ») ; سُكُونٌ « absence de voyelle » (racine de سَكَنَ) ;
  - **figuré** : طَرِيقٌ « chemin » → طَرِيقَةٌ « manière, méthode » ;
  - **éloigné** : جَمَلٌ / جَمِيلٌ ; نَهْرٌ / نَهَارٌ ; قَصِيرٌ / قَصْرٌ ; سَكَنَ / سِكِّينٌ ; ذَهَبَ / ذَهَبٌ ; طَرِيقٌ / مِطْرَقَةٌ.
- **Le moule trompe aussi** : كِتَابٌ (فِعَال singulier) et جِبَالٌ (pluriel) ; أَفْتَحُ et أَكْبَرُ ; كُرْسِيٌّ ; حَدِيدٌ, nom en فَعِيل.
- **Faux amis pour l'exercice L'intrus** : قَلَمٌ / قَلِيلٌ (ق ل م ≠ ق ل ل), تَمْرٌ / ثَمَرَةٌ, سَرِيرٌ / سِرَاجٌ.
- **Mots (6)** :
  - نَهَارٌ « jour (temps de clarté) », L ;
  - قَصْرٌ « palais », L ;
  - سِكِّينٌ « couteau », L, avec la remarque « masculin ou féminin en classique », hors exercices d'accord ;
  - طَرِيقَةٌ « manière, méthode », L ;
  - فَتْحَةٌ, سُكُونٌ (termes de grammaire), R.
- **Modèles** :
  - الْقَصْرُ لَيْسَ قَصِيرًا. « Le palais n'est pas court. »
  - الْجَمَلُ جَمِيلٌ. « Le chameau est beau. »
  - السِّكِّينُ فِي الْمَطْبَخِ، وَالسَّاكِنُ فِي الْبَيْتِ. « Le couteau est dans la cuisine, et l'habitant dans la maison. »
- **Exercices** : Relation de sens ; Deviner puis vérifier (mot seul) ; L'intrus.
- **Pièges** :
  - aucune étymologie inventée (« éloigné » = lien non évident) ;
  - ⚠ jamais نَهَار avec لَيْل ; « آيَةَ النَّهَارِ », « وَجْهَ النَّهَارِ », « مِنَ النَّهَارِ », « بِالنَّهَارِ » ;
  - ⚠ « قَصْرٍ مَشِيدٍ », « قُصُورًا » ; « سِكِّينًا » ; « عَلَى الطَّرِيقَةِ », « طَرِيقَتِكُمُ », « طَرِيقَةً ».

## Pourquoi

- **Conformité aux décisions** : le plan suit le cahier §5.7 et §7. Il ne contredit ni le §16 ni les décisions de la région 2 (règles des lemmes L/R/—, mots sans tanwīn hors génitif, mots à double genre hors accords, sens général pour les mots à charge religieuse). La question de la source des schèmes revient à l'utilisateur (A).
- **Prérequis** :
  - ne sont analysés que des mots dont la racine est entièrement visible, ce qui rend la méthode d'extraction fiable et vérifiable par un test ;
  - les racines faibles, à hamza et contractées sont signalées, puis renvoyées au chapitre C (3.22 à 3.26) ;
  - sont aussi évités : بِـ, la construction directe du participe, le tamyīz, et les mots sans tanwīn après une préposition.
- **Les dérivés choisis sont réguliers et courants en arabe classique** : participes, noms d'action, lieux en مَفْعَل / مَفْعِل selon la voyelle de l'inaccompli, outils en مِفْعَال / مِفْعَلَة, élatif invariable, nisba.
- **Vérifications dans la base** :
  - lemmes du Corpus trouvés : makotuwb, xaArij, saAkin, xuruwj, jamoE, HifoZ, masokan, maxoraj, miSobaAH, >akobar, >aSogar, >akovar, >aqorab, >asoraE, Earabiy~, miSor, nahaAr, nahar, qaSor, sik~iyn, Tariyqap, Saxorap, nuHaAs, barod, safar, Habol, kanz, Tifol, m~ariyD, faqiyr, DaEiyf, sariyE, saEiyd ;
  - les relations « éloignées » de 3.10 reposent sur des racines communes attestées dans le Corpus (nhr, qSr, skn, jml, *hb, Trq).

## Confiance

- **Notation et règles des schèmes (B, C)** : haute.
- **Exclure de l'analyse les racines faibles, à hamza et contractées** : haute (choix prudent).
- **Source des schèmes (A)** : la question n'est pas tranchée, elle revient à l'utilisateur.
- **Mots et sens** : moyenne-haute.
  - À vérifier à la construction : بِسَاط, حِزَام, صَعْب, مِنْشَار (racine n$r), دِرَاسَة (`diraAsat`), صَعِدَ (`yaSoEadu`).
  - Pluriels non affichés quand ils sont ambigus : سَفَر, رَاكِب, سَرِيع.
  - Genre incertain, hors exercices d'accord : عَقْرَب, سِكِّين.
- **Fréquences** : non lues (champ binaire). À confirmer en SQL ; un mot peut être remplacé par un mot plus fréquent du même schème.
- **Suites coraniques ⚠** : citées de mémoire, liste incomplète. Le garde-fou fait foi, et toute paire signalée est remplacée sans discussion.
- **Étiquettes de 3.10** : moyenne pour « figuré » (طَرِيقَة) et « spécialisé » (فَتْحَة, سُكُون) ; haute pour « éloigné », qui n'affirme aucune étymologie.

## Résumé pour l'utilisateur

Le plan des leçons 3.1 à 3.10 est prêt : environ 75 mots nouveaux, la notation فعل, et les mots à lettres « faibles » seulement signalés, en attendant le chapitre C. Une question t'attend avant la leçon 3.2 : peut-on afficher le moule de chaque mot en le vérifiant automatiquement à partir de la racine du Corpus, ou faut-il d'abord examiner QUL, comme décidé le 22/10 ?

Fichiers concernés :
- /home/user/iqura/docs/CAHIER_DES_CHARGES.md (§5.7, §7, §16, ligne du 22/10 sur les schèmes)
- /home/user/iqura/tools/build_content/build_content.py (colonne `lemma.pattern` vide)
- /home/user/iqura/tools/build_content/vocab/mots.json
- /home/user/iqura/assets/content/iqura_content.db
- Décisions à enregistrer dans /home/user/iqura/docs/relectures/decisions-intermediaire-1.md


---

## Doutes du 1er passage tranchés (conseiller-arabe, 05/11/2026)

# Décisions — doutes du relecteur, Intermédiaire 1 (3.1 à 3.10), passage 1

Je n'ai modifié aucun fichier. Claude Code doit enregistrer ces décisions dans /home/user/iqura/docs/relectures/decisions-intermediaire-1.md.
Sources lues : mon plan (decisions-intermediaire-1.md), le rapport /home/user/iqura/docs/relectures/2026-11-05-intermediaire-1-passage-1.md, /home/user/iqura/tools/build_content/vocab/mots.json, les leçons 03, 04, 08, 09 et 10 de etape3, le cahier (§3 règle 1 sur le combat, §5.7 et §16).
Lemmes cherchés par recherche de texte dans assets/content/iqura_content.db : `*ahaAb`, `$urob`, `Talab`, `sariyE`, `m~ariyD`, `Tifol`, `Tariyq`, `siraAj` sont présents. Je n'ai pas trouvé `maEorifat`.

---

### Décision 1 — الْبَرْدُ كَثِيرٌ (3.1)
Question : faut-il garder « الْبَرْدُ كَثِيرٌ فِي الْجِبَالِ. » pour « Il fait très froid dans les montagnes » ?
Stade : région 3, leçon 3.1 ; acquis : régions 1 et 2 ; شَدِيدٌ n'est pas enseigné.
## Décision
On **garde** la phrase et sa traduction. Plus tard, quand شَدِيدٌ sera enseigné, on montrera الْبَرْدُ شَدِيدٌ comme la tournure la plus courante. On n'introduit pas شَدِيدٌ maintenant.
Il ne faut pas écrire « فِي الْجِبَالِ بَرْدٌ », ni aucune phrase qui rapproche جِبَال, بَرَد et فِيهَا : cela ferait écho à un passage coranique.
## Pourquoi
La phrase est grammaticale. كَثْرَةُ الْبَرْدِ et كَثِيرُ الْبَرْدِ appartiennent à l'usage classique. C'est une question de tournure plus ou moins idiomatique, pas une faute. Introduire un mot nouveau pour une seule phrase irait contre le principe de simplicité.
## Confiance
Moyenne : شَدِيدٌ reste plus idiomatique.
## Résumé pour l'utilisateur
« Le froid est grand dans les montagnes » reste écrit avec كَثِيرٌ. C'est correct ; la tournure la plus courante, avec شَدِيدٌ, viendra plus tard.

---

### Décision 2 — verbe sans complément et مَفْعُول (3.3)
Question : la phrase « Un verbe sans complément… n'a pas de مَفْعُول employé seul » est-elle acceptable, alors que مَجْلُوسٌ عَلَيْهِ existe ?
Stade : région 3, leçon 3.3 ; acquis : فَاعِل, مَفْعُول.
## Décision
On garde l'idée, en précisant « complément direct ».
- Écran (03-celui-qui-fait.json, l. 162) : « Au féminin, on ajoute ة : مَكْتُوبَةٌ, حَامِلَةٌ. Un verbe sans complément direct, comme جَلَسَ ou خَرَجَ, n'a pas de مَفْعُول employé seul : on dit جَالِسٌ, خَارِجٌ. »
- Titre : « Féminin, et verbes sans complément direct ».
- QCM (l. 293), bonne réponse : « non : pas de مَفْعُول employé seul ».
- Explication (l. 298) : « Un verbe sans complément direct n'a pas de مَفْعُول employé seul ; on dit جَالِسٌ. »
## Pourquoi
جَلَسَ prend des compléments avec préposition (جَلَسَ فِي…). Ce qu'il n'a pas, c'est un complément direct. « Employé seul » exclut مَجْلُوسٌ عَلَيْهِ, qui a besoin de sa préposition. La formulation est donc exacte, et elle reste conforme au principe B4 (la Forge ne crée pas de مَجْلُوس).
## Confiance
Haute.
## Résumé pour l'utilisateur
Précisé : un verbe sans complément direct (s'asseoir, sortir) n'a pas de forme « ce qui est fait » employée seule.

---

### Décision 3 — le nom d'action sur les fiches de verbes (3.4)
Question : faut-il ajouter le maṣdar aux fiches de verbes, et sous quelle forme ?
Stade : région 3, leçon 3.4 ; acquis : les verbes de la région 2, et les noms d'action de 3.4.
## Décision
On ajoute un champ « nom d'action » (par exemple `nom_action`) aux fiches de verbes. On garde la règle « on l'apprend avec le verbe » et, sur l'écran de la l. 148, on ajoute : « Il est donné sur la fiche du verbe. »

**Groupe A, obligatoire.** Ce sont les noms d'action enseignés ou montrés en 3.4 :
- كَتَبَ → كِتَابَةٌ
- خَرَجَ → خُرُوجٌ
- دَخَلَ → دُخُولٌ
- جَلَسَ → جُلُوسٌ
- دَرَسَ → دِرَاسَةٌ
- حَفِظَ → حِفْظٌ
- فَهِمَ → فَهْمٌ
- جَمَعَ → جَمْعٌ
- ذَهَبَ → ذَهَابٌ (lemme `*ahaAb`)
- شَرِبَ → شُرْبٌ (lemme `$urob` ; on ne donne qu'une forme)
- طَلَبَ → طَلَبٌ (lemme `Talab`)
- عَرَفَ → مَعْرِفَةٌ (racine seule, je n'ai pas trouvé de lemme)

**Groupe B, à ajouter aussi.** Ce sont des noms d'action usuels et sûrs ; ainsi, la règle est vraie pour tous les verbes connus :
- فَتَحَ → فَتْحٌ ; حَمَلَ → حَمْلٌ ; رَكِبَ → رُكُوبٌ ; بَلَغَ → بُلُوغٌ ; تَرَكَ → تَرْكٌ
- رَجَعَ → رُجُوعٌ ; زَرَعَ → زَرْعٌ ; صَعِدَ → صُعُودٌ ; فَرِحَ → فَرَحٌ
- لَبِسَ → لُبْسٌ ; صَنَعَ → صُنْعٌ ; لَعِبَ → لَعِبٌ ; طَرَقَ → طَرْقٌ

**Pas de champ** pour :
- سَكَنَ : plusieurs noms d'action selon le sens (سُكْنَى, سُكُونٌ), ce qui est ambigu ;
- سَمِعَ : mon plan l'interdit déjà (⚠) ;
- قَالَ : racine faible, à voir au chapitre C ;
- لَيْسَ : pas de nom d'action.

Sur la fiche, le champ est seulement affiché. Les mots du groupe B ne servent pas dans les exercices tant qu'ils ne sont pas enseignés. La construction vérifie le lemme ou la racine quand il existe ; sinon le mot reste « R ». Le schème n'est affiché que s'il passe la vérification automatique.
## Pourquoi
La règle de la leçon promet un renseignement que les données ne contiennent pas. Il faut le donner, et pour tous les verbes connus : sinon la promesse n'est tenue qu'à moitié. Ces noms d'action sont les formes usuelles des dictionnaires classiques. Pour les verbes qui en ont plusieurs (كَتْبٌ, شَرْبٌ, عِرْفَانٌ…), j'ai retenu la plus courante, ou celle du Corpus.
## Confiance
Haute pour les groupes A et B. Les absences de lemme sont à confirmer à la construction.
## Résumé pour l'utilisateur
Chaque verbe connu affiche maintenant son « nom d'action » (écrire → l'écriture), comme le promet la leçon 3.4.

---

### Décision 4 — سَرِيعٌ en combat, lemme m~ariyD (3.6)
Question : سَرِيعٌ peut-il servir au mini-boss ? Est-il acceptable de n'afficher que مَرِيضٌ quand le lemme est `m~ariyD` ?
Stade : région 3, leçon 3.6.
## Décision
1. سَرِيعٌ peut servir en combat, sous sa forme de dictionnaire et avec son sens général (« rapide », « le chameau est rapide »). Il ne faut jamais l'employer en annexion (سَرِيعُ + nom) ; ce ⚠ est déjà dans le plan. On ne l'ajoute pas à la liste d'exclusion.
2. `m~ariyD` est accepté comme identifiant interne, à une condition : l'application n'affiche jamais la forme arabe du lemme du Corpus, ni dans le dictionnaire, ni sur la fiche ; seul le champ `ar` est montré (مَرِيضٌ). Claude Code doit le vérifier. La même condition vaut pour نَجْمٌ (lemme `n~ajom`).
## Pourquoi
D'après le §3, règle 1, un mot du vocabulaire, même fréquent dans le Coran, peut paraître dans une question de combat sous sa forme de dictionnaire. Seuls les noms divins, les noms de prophètes et les formules sacrées sont exclus, et سَرِيعٌ n'en est pas un. La shadda de `m~ariyD` est une assimilation notée dans le Corpus ; elle ne fait pas partie du mot.
## Confiance
Haute.
## Résumé pour l'utilisateur
« Rapide » peut apparaître en combat ; « malade » s'affiche bien sous sa forme normale.

---

### Décision 5 — remarque de طِفْلٌ, racine de سَرْجٌ (3.7)
Question : faut-il garder la remarque « sert aussi au féminin et au pluriel » sur طِفْلٌ, et rattacher سَرْجٌ à la racine srj ?
Stade : région 3, leçon 3.7.
## Décision
1. On **retire** la remarque de la fiche طِفْلٌ. Dans l'Atelier, le distracteur « الطِّفْلُ فِي الْحَدِيقَةِ. » devient « الطِّفْلَانِ فِي الْحَدِيقَةِ. », avec l'explication : « الطِّفْلَانِ, c'est deux enfants (duel) ; les enfants : الْأَطْفَالُ. »
2. On **garde** سَرْجٌ sous la racine س ر ج, en statut « R », sans lemme. Si une étiquette de relation s'affiche à côté de سِرَاجٌ, ce sera « éloigné : le lien de sens n'est pas évident ». L'avertissement du §7 s'applique, comme sur toute fiche de racine.
## Pourquoi
L'emploi de طِفْل au pluriel est surtout connu par un passage coranique. De plus, la remarque rendait un distracteur défendable : la retirer est plus simple et plus prudent pour un débutant. Pour سَرْجٌ, la racine est une propriété de forme : les dictionnaires classiques le rangent sous س ر ج. L'étiquette « éloigné » n'affirme aucune étymologie.
## Confiance
Haute pour les deux points.
## Résumé pour l'utilisateur
« Enfant » est simplifié (sans remarque savante) ; « selle » reste dans la famille de « lampe », avec la mention « lien de sens pas évident ».

---

### Décision 6 — distracteur « أَكْبَرُ est toujours un verbe » (3.8)
Question : ce distracteur est-il acceptable, puisque كَبِرَ يَكْبَرُ « vieillir » existe ?
Stade : région 3, leçon 3.8.
## Décision
On le **garde** tel quel (08-plus-grand.json, l. 293).
## Pourquoi
Le mot « toujours » le rend clairement faux : أَكْبَرُ est souvent un comparatif. La bonne réponse, « le contexte donne le sens », couvre justement le cas rare de أَكْبَرُ « je vieillis ».
## Confiance
Haute.
## Résumé pour l'utilisateur
Pas de changement : « أَكْبَرُ est toujours un verbe » est bien une mauvaise réponse.

---

### Décision 7 — كُرْسِيٌّ et la nisba (3.9)
Question : faut-il garder « كُرْسِيٌّ ressemble à une nisba sans en être une » ?
Stade : région 3, leçon 3.9.
## Décision
On **garde** la phrase.
## Pourquoi
Les grammairiens anciens disent la même chose : le ي de كُرْسِيٌّ a la forme du ي de nisba, sans son sens de relation. La phrase dit exactement cela, en termes simples.
## Confiance
Haute.
## Résumé pour l'utilisateur
Pas de changement : « chaise » ressemble à un adjectif en -iyy sans en être un.

---

### Décision 8 — طَرِيقٌ → طَرِيقَةٌ, « figuré » (3.10)
Question : l'étiquette « figuré » et l'explication « Le chemin à suivre devient la manière de faire » sont-elles acceptables ?
Stade : région 3, leçon 3.10.
## Décision
- On garde l'étiquette « figuré » et le retrait de « chemin » et de الطَّرِيقُ des distracteurs.
- L'explication (l. 276) devient : « De « chemin » à « manière de faire » : sens figuré. »
- Si le distracteur طَرِيقُ est toujours dans l'Atelier « هَٰذِهِ … هِلَالٍ » : on le remplace par « طَرِيقَةٌ » (avec tanwīn), avec l'explication « Avant un complément (iḍāfa), le mot perd son tanwīn : طَرِيقَةُ هِلَالٍ. » Il ne faut pas mettre طُرُقُ : « هَٰذِهِ طُرُقُ هِلَالٍ » est grammatical.
## Pourquoi
La nouvelle explication décrit une relation de sens, sans raconter une évolution historique (principe B10 : aucune étymologie). Pour que l'exercice n'ait qu'une seule bonne réponse, chaque distracteur doit être faux par la forme, et pas seulement par le sens.
## Confiance
Moyenne pour « figuré » : les sens de طَرِيقٌ et طَرِيقَةٌ se recouvrent en partie chez les lexicographes. Haute pour les nouveaux textes.
## Résumé pour l'utilisateur
« Méthode » est présenté comme un sens figuré de « chemin », sans histoire du mot ; les fausses réponses ambiguës sont retirées.

---

### Décision 9 — schèmes ajoutés aux fiches de la région 2
Question : les schèmes et schèmes de pluriel ajoutés sont-ils justes ?
Stade : région 3, leçons 3.2 à 3.7.
## Décision
Je n'ai trouvé **aucune erreur** ; j'ai vérifié chaque mot avec le pluriel affiché sur sa fiche :
- قَلَمٌ فَعَل / أَقْلَامٌ أَفْعَال ; جَبَلٌ فَعَل / جِبَالٌ فِعَال ; كِتَابٌ فِعَال / كُتُبٌ فُعُل ; جِدَارٌ فِعَال / جُدُرٌ فُعُل ;
- كَلْبٌ فَعْل / كِلَابٌ فِعَال ; لَحْمٌ فَعْل / لُحُومٌ فُعُول ; شَمْسٌ فَعْل ; نَجْمٌ فَعْل / نُجُومٌ فُعُول ;
- كَتَبَ, فَتَحَ, جَلَسَ : فَعَلَ ;
- كَاتِبٌ, حَارِسٌ, تَاجِرٌ, طَالِبٌ : فَاعِل / فُعَّال (كُتَّابٌ, حُرَّاسٌ, تُجَّارٌ, طُلَّابٌ) ;
- مِفْتَاحٌ مِفْعَال / مَفَاتِيحُ مَفَاعِيل ; قَصِيرٌ, كَبِيرٌ : فَعِيل ; حَدَّادٌ, خَبَّازٌ : فَعَّال (ح د د bien visible) ;
- شَجَرَةٌ فَعَلَة / أَشْجَارٌ أَفْعَال ; حِمْلٌ فِعْل / أَحْمَالٌ أَفْعَال ; رَجُلٌ فَعُل / رِجَالٌ فِعَال.

Deux remarques, sans correction :
- أَشْجَارٌ est au sens strict le pluriel du collectif شَجَرٌ, mais il s'emploie couramment comme pluriel de « arbres » ; on le garde.
- La vérification automatique de نَجْمٌ doit partir de la racine et non de la forme du lemme `n~ajom` (voir la décision 4).
## Pourquoi
En remplaçant ف ع ل par les lettres de la racine, on retrouve chaque mot vocalisé, sans sa fin de cas, avec le pluriel de sa fiche. C'est conforme au point A tranché par l'utilisateur le 05/11/2026.
## Confiance
Haute.
## Résumé pour l'utilisateur
Les « moules » ajoutés aux mots déjà connus sont justes.

---

## Liste de fin de niveau (proposition, 9 points)
1. « Il fait très froid » reste écrit avec كَثِيرٌ ; la tournure avec شَدِيدٌ viendra plus tard.
2. Leçon 3.3 : on précise « complément direct ».
3. Leçon 3.4 : chaque verbe connu affiche son nom d'action (25 verbes, formes données plus haut).
4. « Rapide » est autorisé en combat ; « malade » et « étoile » s'affichent sous leur forme normale.
5. « Enfant » : la remarque savante est retirée, et la fausse réponse devient « deux enfants ».
6. « Selle » reste dans la famille de « lampe », avec la mention « lien de sens pas évident ».
7. « أَكْبَرُ est toujours un verbe » reste une mauvaise réponse, sans changement.
8. « Chaise » ressemble à une nisba sans en être une, sans changement.
9. « Méthode », sens figuré de « chemin » : explication simplifiée et distracteurs ambigus retirés. Les moules ajoutés aux mots de la région 2 sont justes.
