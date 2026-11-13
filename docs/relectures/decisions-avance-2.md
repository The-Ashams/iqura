# Décision — Plan de langue du niveau Avancé 2 (leçons 4.15 à 4.28, région 4 « La Cité des Lecteurs », chapitres B « La place des débats » et C « L'atelier des copistes », et examen de la région 4)

Question : pour chaque leçon de 4.15 à 4.28, donner l'objectif, les mots nouveaux, la règle, les phrases modèles, les pièges et ce qui est reporté. Fixer aussi les principes du niveau : registre classique à l'oral, lecture sans voyelles, texte classique de 4.28, listes ⚠. Enfin, proposer l'examen de la région 4 : récit de 800 mots, dialogue, 5 phrases.

Stade : région 4, leçons 4.15 à 4.28 et examen.
- **Lieux et maîtres (proposés, à confirmer)** :
  - chapitre B : la Place des débats (Nadīm) pour 4.15, 4.17, 4.21 et 4.22 ; la Maison de Nadīm (Nadīm) pour 4.16, 4.18 et 4.20 ; le Marché couvert (Hāla, qui garde les comptes) pour 4.19 ;
  - chapitre C : l'Atelier des copistes (Zuhayr, nouveau) pour 4.23, 4.24 et 4.26 ; la Salle du dictionnaire (Zuhayr) pour 4.25 ; la Grande Salle de lecture (Zuhayr) pour 4.27 et 4.28 ;
  - examen au Labyrinthe de la Distraction (boss « la Grande Distraction », sur le modèle de « la Grande Précipitation »). Bāsim accompagne toujours le voyageur.
  - Ce sont les lieux 6 à 11 annoncés dans `PROPOSITION_REGION_4.md`.
- **Troisième maître proposé** : **Zuhayr** (زُهَيْرٌ, prend le tanwīn), diminutif de زَهْرٌ, « petite fleur ». C'est un prénom arabe ancien et profane. Il n'est jamais employé dans un exercice de racine : la racine z h r a un emploi chargé dans le Coran. Alternative : Daʿd (دَعْد).
- **Famille de Nadīm (4.16)** : sa femme **Lubnā** (لُبْنَى, terminaison invariable, donc simple) et son fils **ʿĀmir** (عَامِرٌ). Ces noms sont à valider par l'utilisateur (§8.2).
- **Acquis** :
  - régions 1 à 3, et Avancé 1 : conditions, لَوْ / لَوْلَا, discours rapporté, حِينَ / لَمَّا, لِأَنَّ / لِـ / حَتَّى, ḥāl, tamyīz, mafʿūl muṭlaq et li-aǧlih, إِلَّا / غَيْرُ, appel, قَدْ et insistance, فَـ / بَلْ / لَٰكِنْ / أَمَّا, nombres jusqu'à 99, puis 100 et 1 000 ;
  - les mots de `mots.json` (fondations-*, moteur-*, cite-01 à cite-14) et les noms d'action des fiches (dont قِرَاءَةٌ, وَزْنٌ, عَمَلٌ, كِتَابَةٌ, تِجَارَةٌ).
- **Pas encore enseignés** :
  - aucune salutation ; ابْنٌ ; مَاذَا employé seul ; les mots du temps (يَوْم, شَهْر, سَنَة, سَاعَة), les jours, les mois, مُنْذُ ;
  - اشْتَرَى ; كُلُّ + singulier ; les centaines de 200 à 900 ; ضَمَّة, كَسْرَة, شَدَّة (seules فَتْحَة et سُكُون ont une fiche) ; les nombres ordinaux.

## Décision

### A. Méthode et limites (mêmes règles qu'en Avancé 1)

- **Lemmes** : vérifiés par recherche de texte dans `/home/user/iqura/assets/content/iqura_content.db`. Ce n'est pas du SQL : `vocab.validate` fait foi.
  - L = lemme du Corpus de même sens ; R = racine seule, sans fréquence ; « hors Corpus » = ni lemme ni racine affichés, comme صُنْدُوقٌ.
  - Racines en Buckwalter.
- **Trouvés dans la base** : balad, maroHab, >ahol, {bon, zawoj, xaAl, Eam~, jad~ (autre sens), yawom, $ahor, sanap, saAEap, >amaAm, xalof, bayon, yamiyn, mar~a, {$otaraY`, $ukor, >aw~al, A^xir, Eumur, daliyl, wazon, wasaT, nusoxap, fiEol, $araHa, >aHosana, >aSaAba, >aSol, jumuEap.
- **À vérifier en SQL** :
  - lemmes non trouvés par ma recherche : xayor, ra>oy, kalaAm, baHava, rajaA (أَرْجُو), EaSor, sabot, <i*FA (إِذَنْ), na$a>a ;
  - racines dont l'absence du Corpus est probable (sinon on les note R) : kasr (كَسْرَة), tEb (تَعِبٌ), SHH (صَحِيحٌ), nSS (نَصٌّ), lxS (لَخَّصَ), rxS (رَخِيصٌ).
- **Fréquences** : non lues. **Suites ⚠** : citées de mémoire, la liste est incomplète. Le garde-fou fait foi, et toute paire signalée est remplacée (§16, 25/10/2026). Le garde-fou compare des squelettes sans voyelles (`quran_guard.py`, l. 13) : les textes sans voyelles du chapitre C sont donc contrôlés eux aussi.
- **Risque propre à ce niveau** :
  - la conversation fait entrer des formules (salutations, politesse, souhaits) souvent chargées d'un sens religieux ;
  - les mots du temps et de la famille ouvrent beaucoup de tournures et de récits du Coran ;
  - au chapitre C, les mots de l'écrit (قَلَم, سَطْر, كِتَاب, صُحُف) sont très présents dans le Coran.
  - Réponse : chaque mot à risque a une liste ⚠, et l'on emploie de préférence des noms propres et des noms concrets de la Cité.

### B. Principes du niveau

1. **Registre classique à l'oral** (cahier §5.8 : « parler (registre classique) »).
   - Pas de dialecte ni de calque moderne non signalé.
   - **Écartés** :
     - مِنْ فَضْلِكَ (calque moderne ; فَضْل est chargé : « مِنْ فَضْلِهِ ») ;
     - عَفْوًا au sens de « de rien » ; صَبَاحُ الْخَيْرِ ; إِلَى اللِّقَاءِ (لِقَاء est chargé de sens dans le Coran) ;
     - شَارِعٌ, l'heure de l'horloge, les loisirs « modernes ».
   - **Retenus** :
     - pour accueillir : مَرْحَبًا بِكَ, أَهْلًا وَسَهْلًا ;
     - pour demander poliment : أَرْجُو أَنْ + subjonctif ;
     - pour remercier : شُكْرًا لَكَ ;
     - pour prendre congé : نَلْتَقِي غَدًا.
   - **مَعَ السَّلَامَةِ** : en aperçu seulement, avec la mention « usage courant, plus tardif ».
   - **السَّلَامُ عَلَيْكُمْ** : soumis à l'utilisateur (point E1).
2. **Formes admises (suite de B1 d'Avancé 1).**
   - Liste fermée de formes pour chaque verbe faible, à hamza, doublé ou très chargé :
     - وُلِدَ, نَشَأَ, مَرَّ, اشْتَرَى, سَاوَمَ, اسْتَرَاحَ, غَسَلَ, وَافَقَ, كَرَّرَ, الْتَقَى, اشْتَاقَ, بَحَثَ, شَرَحَ, لَخَّصَ ;
     - deux formes figées : أَصَبْتَ, أَحْسَنْتَ.
   - **Indiquer un chemin** : on emploie l'inaccompli de la 2e personne (تَمُرُّ بِالْجِسْرِ، ثُمَّ تَجِدُ…), pas l'impératif.
   - **Toujours écartés** : اذْهَبْ, امْشِ, دُلَّنِي, اقْرَأْ, قُلْ, كُنْ, ادْعُ.
3. **Exclusions maintenues** (B4 d'Avancé 1, B5 et B6 d'Intermédiaire 1 à 3) :
   - aucun sujet divin, aucun nom divin, aucune formule sacrée, aucun serment ;
   - ضَرَبَ est écarté de tout le niveau ;
   - رَسُولٌ est exclu ;
   - pas de phrase qui commence par وَ suivi d'un nom de la nature ou d'un moment (« وَالْعَصْرِ », « وَاللَّيْلِ », « وَالْقَلَمِ ») ;
   - **jamais**, nulle part : إِنْ شَاءَ اللَّهُ, جَزَاكَ اللَّهُ, فِي أَمَانِ اللَّهِ, أَسْتَوْدِعُكَ اللَّهَ, « سَلَامٌ عَلَيْكَ / عَلَيْكُمْ » (forme indéfinie), « وَالسَّلَامُ » en fin de lettre, « قَالُوا سَلَامًا », « رَدَّ السَّلَامَ ».
   - Le nom arabe de la Cité ne doit jamais être « مَدِينَةُ الْقُرَّاءِ » : الْقُرَّاءُ désigne les récitants du Coran. On garde le nom français.
4. **Les maximes ne sont jamais attribuées** (B6 d'Avancé 1).
   - Une parole « de sage » dite dans un débat (4.21) est construite et signalée « rédigé par IA ». Elle n'est ni un proverbe réel, ni introduite par « قِيلَ ».
   - Elle ne parle ni de Dieu, ni du destin, ni de la mort. Pas de « يَا بُنَيَّ ».
5. **Récits et dialogues : aucune scène qui rappelle un récit du Coran** (complète B5 d'Avancé 1 et B7 d'Intermédiaire 3, toujours valables) :
   - **Se présenter** :
     - personne ne se présente comme envoyé ;
     - pas de « أَنَا X وَهَٰذَا أَخِي », ni de « إِنِّي أَنَا » ;
     - pas de frère qui révèle qui il est.
   - **Famille** :
     - pas de frères jaloux, ni d'un père et de onze ou douze fils, ni d'un fils préféré ;
     - pas de fils qui refuse de monter à bord, ni de père qui adore des idoles ;
     - pas de vieillard ni de femme stérile à qui naît un enfant ; pas de naissance sous un palmier ;
     - pas de mère qui confie un bébé à un coffre ou au fleuve, ni de sœur qui le suit ;
     - pas de femme qui se plaint de son mari, pas de divorce (c'est une question de jurisprudence) ;
     - pas de « شَيْخٌ كَبِيرٌ ».
   - **Chemin** :
     - pas d'homme qui accourt du bout de la ville ;
     - pas de peuple errant pendant des années ;
     - pas de « deux mers » ni de lieu « entre deux montagnes » ;
     - personne ne revient sur ses pas pour retrouver un objet oublié (le poisson oublié près d'un rocher).
   - **Temps** :
     - pas d'années de sommeil, ni de « mille ans » ;
     - pas de sept années d'abondance ou de famine, ni de rêve de vaches ou d'épis ;
     - pas de pêche le samedi.
   - **Marché** :
     - pas de tricherie à la balance, pas de foule qui court vers une caravane (règles d'Avancé 1) ;
     - pas de grain mesuré pour des frères venus de loin ;
     - pas de marchandise ni d'argent retrouvés dans les bagages ;
     - pas de vente d'une personne ;
     - pas de prêt ni d'intérêt ; aucun jugement sur ce qui est permis.
   - **Journée** : pas de rêve raconté à un père, pas de puits, pas de loup.
   - **Débat** :
     - pas de débat sur Dieu, les idoles ou la religion ;
     - pas de « apportez votre preuve » (بُرْهَان jamais) ;
     - pas de dispute avec un père.
   - **Écrit** :
     - pas de tablettes (أَلْوَاح), pas de rouleau qu'on plie (طَوَى jamais) ;
     - jamais « عَلَّمَ بِالْقَلَمِ » ; jamais « كَتَبَ بِيَدِهِ / بِأَيْدِيهِمْ » ; jamais خَطَّ avec يَمِين ;
     - pas d'âne chargé de livres ;
     - jamais صُحُف, مَسْطُور, يَسْطُرُونَ, أُمِّيّ.
6. **Lecture sans voyelles (chapitre C) : trois paliers.** Les paliers et la façon de vérifier sa lecture sont en C (4.23 et 4.24).
   - Ce qui reste toujours : les lettres-supports de hamza (أ إ ؤ ئ ء), آ, ة, ى, et l'alif du tanwīn -an (c'est une lettre).
   - Ce qui ne se met jamais : ٱ (réservé à l'écriture du Mushaf, leçon 14).
   - Le petit alif disparaît, comme dans l'écriture courante : هذا, لكن. On le dit en 4.23.
7. **Récits du niveau** :
   - au moins 95 % de mots connus ;
   - entièrement vocalisés au chapitre B ;
   - au chapitre C, ils suivent le palier de la leçon en cours (cahier §5.10 : « non vocalisé progressivement en région 4 »).
8. **Production (au moins 40 %, règle du niveau précédent ; au chapitre B, viser la moitié).**
   - L'oral reste masqué tant que l'audio est suspendu (§16, 03/11/2026). « Parler de soi une minute » devient une présentation écrite de 6 à 8 phrases : tuiles dans la leçon, puis texte libre dans le carnet du voyageur, comparé à un modèle et auto-évalué, sans note. L'emplacement oral est gardé pour la phase J6.
   - Exercices :
     - choisir la bonne réplique ;
     - compléter un dialogue ;
     - remettre une présentation, une lettre ou un résumé en ordre ;
     - transformer du discours direct en indirect ;
     - vocaliser une fin de mot ;
     - trouver la racine d'une forme.
9. **Noms comptés.**
   - La liste fermée de 4.14 est élargie à جُمْلَة, نَصّ, سِلْعَة et كَلِمَة (déjà dedans).
   - Les mots du temps se comptent **seulement** selon la liste de 4.18.
   - L'exception « onze et douze » (§16, 12/11/2026) reste limitée à la liste de 4.14, jamais avec un mot du temps.
10. **Nombres ordinaux** : reportés en région 5, avec leur propre liste ⚠ (ثَانِيَ اثْنَيْنِ, ثَالِثُ ثَلَاثَةٍ, رَابِعُهُمْ, الْخَامِسَةُ…). Seuls أَوَّلٌ et آخِرٌ entrent ici, en 4.20.

### C. Plan par leçon

Format : forme | sens | L/R (racine) | formes admises | remarque.

**4.15 Se présenter en détail (Place des débats, Nadīm)**
- **Objectif** : accueillir, dire son nom, son pays, sa naissance, où l'on vit, ce que l'on fait, ce que l'on aime.
- **Règle** : « Pour se présenter : اسْمِي…, أَنَا مِنْ…, وُلِدْتُ فِي…, نَشَأْتُ فِي…, أَسْكُنُ فِي…, أُحِبُّ + nom d'action (أُحِبُّ الْقِرَاءَةَ). Pour accueillir : مَرْحَبًا بِكَ, أَهْلًا وَسَهْلًا. »
- **Mots (7)** :
  - مَرْحَبًا | bienvenue | L maroHab | seulement مَرْحَبًا seul, ou بِكَ / بِكِ
  - أَهْلًا وَسَهْلًا | sois le bienvenu | expression ; أَهْل L >ahol, سَهْل connu | une seule fiche « expression »
  - بِخَيْرٍ | bien (« je vais bien ») | خَيْر, L à vérifier (xayor) | forme figée : « كَيْفَ حَالُكَ ؟ — بِخَيْرٍ »
  - بَلَدٌ | pays, contrée | L balad | بَلَدِي, بَلَدُهُ, مِنْ بَلَدٍ بَعِيدٍ
  - وُلِدَ | naître (« il est né ») | R wld (le lemme du Corpus est l'actif وَلَدَ) | formes : وُلِدْتُ, وُلِدَ, وُلِدَتْ, toujours + فِي + lieu
  - نَشَأَ | grandir (quelque part) | L ou R à vérifier (n$>) | formes : نَشَأْتُ, نَشَأَ, نَشَأَتْ + فِي + lieu
  - مَاذَا | que ? quoi ? (devant un verbe) | L maA*aA (connu dans لِمَاذَا)
- **Modèles** :
  - مَرْحَبًا بِكَ. اسْمِي بَاسِمٌ، وَأَنَا مِنْ قَرْيَةٍ صَغِيرَةٍ. « Bienvenue. Je m'appelle Bāsim, je viens d'un petit village. »
  - وُلِدْتُ فِي دِمَشْقَ، وَنَشَأْتُ فِي بَغْدَادَ. « Je suis né à Damas, et j'ai grandi à Bagdad. »
  - أَسْكُنُ الْآنَ فِي بَيْتٍ قَرِيبٍ مِنَ السُّوقِ. « J'habite maintenant une maison proche du marché. »
  - كَيْفَ حَالُكَ؟ — بِخَيْرٍ. « Comment vas-tu ? — Bien. »
  - مَاذَا تَعْمَلُ؟ — أَنَا كَاتِبٌ، وَأُحِبُّ الْقِرَاءَةَ. « Que fais-tu ? — Je suis scribe, et j'aime la lecture. »
  - أَتَكَلَّمُ الْعَرَبِيَّةَ، وَأَتَعَلَّمُ الْفَارِسِيَّةَ. « Je parle l'arabe, et j'apprends le persan. »
- **Pièges** :
  - اسْمِي (et non « أَنَا اسْمِي ») ; مِنْ أَيْنَ أَنْتَ ؟
  - Les noms de pays et de villes modernes ne sont pas employés : le voyageur vient « d'un pays lointain » (مِنْ بَلَدٍ بَعِيدٍ).
  - ⚠ بَلَد : jamais « هَٰذَا الْبَلَد », jamais avec أَمِين / آمِن / مَيِّت / طَيِّب ; jamais « إِلَى بَلَدٍ », بَلْدَة, بِلَاد.
  - ⚠ وُلِدَ : jamais يَوْمَ + وُلِدَ / وُلِدْتُ ; jamais يَلِدُ, لَمْ يَلِدْ, لَمْ يُولَدْ, وَالِد / وَالِدَة / وَالِدَيْنِ ; aucune scène de naissance.
  - ⚠ نَشَأَ : jamais أَنْشَأَ, نَشْأَة, نَاشِئَة, « يُنَشَّأُ ».
  - ⚠ مَرْحَبًا : jamais « لَا مَرْحَبًا », jamais بِهِمْ / بِكُمْ.
  - ⚠ خَيْر : seulement dans بِخَيْرٍ ; jamais خَيْرٌ لَكَ / لَكُمْ, خَيْرًا, « خَيْرٌ مِنْ ».
  - ⚠ أُحِبُّ : seulement à l'affirmatif, + nom d'action ou nom concret (règle de 3.23 : jamais « لَا أُحِبُّ », « أَحْبَبْتُ »).
  - ⚠ مَاذَا : jamais avec قَالَ (3e personne), أَرَادَ, تَعْبُدُونَ, يُنْفِقُونَ, أُجِبْتُمْ ; jamais « فَعَلْتَ » (règle de 4.9).
  - ⚠ قَلِيلًا : jamais « قَلِيلًا مَا ».
- **Reporté** : l'âge (4.18, avec سَنَة) ; السَّلَامُ عَلَيْكُمْ (point E1).

**4.16 Famille et métiers (Maison de Nadīm)**
- **Objectif** : nommer et décrire ses proches, dire leur métier.
- **Règle 1** : « La parenté se dit par l'annexion : عَمُّ بَاسِمٍ, ابْنُ عَمِّي. أَبٌ et أَخٌ deviennent أَبُو / أَبَا / أَبِي devant un complément. »
- **Règle 2** : « Le nom d'un métier suit souvent le moule فِعَالَة : نِجَارَة, خِيَاطَة, كِتَابَة, تِجَارَة. »
  - C'est une règle classique ; le moule est montré, jamais forgé pour une racine faible.
- **Mots (7)** :
  - ابْنٌ | fils | L {bon | ابْنُ + nom propre ou nom de métier, ابْنُ عَمٍّ ; pluriel non affiché
  - زَوْجٌ / زَوْجَةٌ | époux / épouse | L zawoj (une fiche) | remarque : « en arabe classique, زَوْجٌ se dit aussi de l'épouse »
  - جَدٌّ / جَدَّةٌ | grand-père / grand-mère | R jdd (le lemme du Corpus a un autre sens)
  - عَمٌّ / عَمَّةٌ | oncle, tante (côté du père) | L Eam~
  - خَالٌ / خَالَةٌ | oncle, tante (côté de la mère) | L xaAl
  - أُسْرَةٌ | famille (les proches) | R >sr | avertissement de racine visible : dans le Coran, la racine a le sens de « captivité »
  - حِرْفَةٌ | métier | R Hrf | avertissement de racine visible
- **Modèles** :
  - هَٰذِهِ أُسْرَةُ نَدِيمٍ. « Voici la famille de Nadīm. »
  - لُبْنَى زَوْجَةُ نَدِيمٍ، وَهِيَ خَيَّاطَةٌ. « Lubnā est l'épouse de Nadīm ; elle est couturière. »
  - عَامِرٌ ابْنُ نَدِيمٍ، وَهُوَ طَالِبٌ فِي الْمَدْرَسَةِ. « ʿĀmir est le fils de Nadīm ; il est élève à l'école. »
  - عَمُّ بَاسِمٍ نَجَّارٌ، وَخَالُهُ حَدَّادٌ. « L'oncle paternel de Bāsim est menuisier, son oncle maternel est forgeron. »
  - جَدُّ سَلْمَى كَانَ تَاجِرًا فِي بَغْدَادَ. « Le grand-père de Salmā était marchand à Bagdad. »
  - حِرْفَةُ أَبِي سَمِيرٍ التِّجَارَةُ. « Le métier du père de Samīr, c'est le commerce. »
  - ابْنُ عَمِّي صَدِيقِي أَيْضًا. « Mon cousin est aussi mon ami. »
- **Pièges** :
  - Dans « عَامِرٌ ابْنُ نَدِيمٍ » (phrase complète), on écrit l'alif de ابْن. Entre deux noms (بَاسِمُ بْنُ سَمِيرٍ, « Bāsim fils de Samīr »), il tombe : en aperçu.
  - عَمّ (côté du père) ≠ خَال (côté de la mère).
  - ⚠ Les mots de parenté vont seulement avec ـِي, ـهُ, ـهَا, ـكَ ou un nom propre. Jamais avec ـكُمْ, ـهُمْ, ـهُنَّ. Jamais plus de deux mots de parenté dans une même phrase : ces listes sont des passages du Coran.
  - ⚠ Jamais au pluriel : أَعْمَام, عَمَّات, أَخْوَال, خَالَات, بَنَات, أَبْنَاء, إِخْوَة, أَزْوَاج.
  - ⚠ ابْن : jamais avec مَرْيَم, السَّبِيل, أُمّ, أَهْل ; jamais ابْنِي, ابْنُكَ, ابْنَهُ ; jamais « يَا بُنَيَّ ».
  - ⚠ زَوْج : seulement avec un nom propre (زَوْجَةُ نَدِيمٍ). Jamais زَوْجُكَ, زَوْجَهُ, زَوْجِهَا, امْرَأَتُهُ ; jamais avec اسْكُنْ, جَنَّة, أَمْسِكْ.
  - ⚠ جَدّ : jamais avec رَبّ ni تَعَالَى ; aucun exercice de racine (جِدًّا et جَدّ partagent j d d).
  - ⚠ أُسْرَة : jamais أَسِير, أَسْرَى. ⚠ حِرْفَة : jamais « عَلَى حَرْفٍ », حَرَّفَ.
  - ⚠ Jamais « شَيْخٌ كَبِيرٌ », ni « أَبُوكِ / أَبُوكَ » avec كَانَ.
- **Reporté** : حَمٌ (le dernier des « cinq noms »), les pluriels de parenté.

**4.17 Dans la cité : demander et donner son chemin (Place des débats)**
- **Objectif** : demander un lieu, comprendre et donner un itinéraire simple.
- **Règle** : « أَمَامَ, خَلْفَ, بَيْنَ sont suivis du génitif : خَلْفَ الْقَصْرِ. Pour indiquer un chemin, on parle à l'inaccompli : تَمُرُّ بِالْجِسْرِ، ثُمَّ تَجِدُ الْحَدِيقَةَ عَلَى يَمِينِكَ. »
- **Mots (6)** :
  - يَمِينٌ | droite | L yamiyn | seulement عَلَى يَمِينِكَ / يَمِينِ + nom de lieu
  - يَسَارٌ | gauche | R ysr (le lemme du Corpus, يُسْر, a un autre sens)
  - أَمَامَ | devant | L >amaAm
  - خَلْفَ | derrière | L xalof
  - بَيْنَ | entre | L bayon | بَيْنَ X وَ Y, avec des lieux
  - مَرَّ بِـ | passer par, passer devant | L mar~a | formes : مَرَرْتُ بِـ, مَرَرْنَا بِـ, تَمُرُّ بِـ, نَمُرُّ بِـ
- **Modèles** :
  - هَلْ تَدُلُّنِي عَلَى السُّوقِ؟ « Peux-tu m'indiquer le marché ? »
  - السُّوقُ أَمَامَكَ، وَالْمَدْرَسَةُ عَلَى يَسَارِكَ. « Le marché est devant toi, l'école à ta gauche. »
  - تَمُرُّ بِالْجِسْرِ، ثُمَّ تَجِدُ الْحَدِيقَةَ عَلَى يَمِينِكَ. « Tu passes le pont, puis tu trouves le jardin à ta droite. »
  - بَيْتُ نَدِيمٍ بَيْنَ السُّوقِ وَالْمَدْرَسَةِ. « La maison de Nadīm est entre le marché et l'école. »
  - الْحَدِيقَةُ خَلْفَ الْقَصْرِ. « Le jardin est derrière le palais. »
  - مَرَرْتُ بِالسُّوقِ فِي الصَّبَاحِ. « Je suis passé par le marché le matin. »
- **Pièges** :
  - عَلَى يَمِينِكَ (« à ta droite »), et non « فِي يَمِينِكَ ».
  - مَرَّ بِـ (passer par) ≠ مَرَّةٌ (fois, 4.8).
  - Verbe doublé : مَرَرْتُ, mais تَمُرُّ (règle de 3.23).
  - ⚠ يَمِين : jamais شِمَال (le mot est écarté) ; jamais عَنِ الْيَمِينِ, ذَاتَ الْيَمِينِ, بِيَمِينِ / بِيَمِينِكَ / بِيَمِينِهِ, أَيْمَان, أَصْحَاب ; jamais au sens de « serment ».
  - ⚠ خَلْف : jamais « مِنْ خَلْفِ », خَلْفَكَ, خَلْفَهُمْ ; seulement + nom de lieu.
  - ⚠ بَيْن : jamais بَيْنَ يَدَيْ, بَيْنَهُمَا, « بَيْنَنَا وَبَيْنَ », بَيْنَ ذَٰلِكَ, ni avec سَدّ, جَبَلَيْنِ, بَحْرَيْنِ.
  - ⚠ أَمَام : jamais أَمَامَهُ.
  - ⚠ مَرَّ : jamais مَرَّ عَلَى, مَرُّوا, ni avec قَرْيَة ou مَلَأ.
  - ⚠ دَلَّ : seulement « هَلْ تَدُلُّنِي عَلَى… » ; jamais « هَلْ أَدُلُّكَ / أَدُلُّكُمْ » (règle de 3.23).
  - ⚠ Jamais « رَجَعْنَا إِلَى الْمَدِينَةِ ».
- **Reporté** : les impératifs de mouvement ; نَحْوَ ; les rues nommées.

**4.18 Le temps qui passe (Maison de Nadīm)**
- **Objectif** : dire les jours, les mois, les moments de la journée, une durée, son âge.
- **Règle 1** : « Pour dire quand, on met le nom de temps à l'accusatif, sans préposition : يَوْمَ الْخَمِيسِ, صَبَاحًا (ou فِي الصَّبَاحِ). »
- **Règle 2** : « مُنْذُ (« depuis ») est suivi du génitif : مُنْذُ شَهْرٍ. »
- **Règle 3** : « Pour dire son âge en arabe classique : أَنَا ابْنُ عِشْرِينَ سَنَةً (« fils de vingt ans ») ; au féminin : بِنْتُ. On demande : ابْنُ كَمْ أَنْتَ ؟ »
- **Mots (8, leçon thématique comme 4.14)** :
  - يَوْمٌ | jour | L yawom
  - أُسْبُوعٌ | semaine | R sbE | pluriel أَسَابِيعُ
  - شَهْرٌ | mois | L $ahor
  - سَنَةٌ | année | L sanap | pluriel سَنَوَاتٌ seulement (jamais سِنِين) ; « on dit aussi عَامٌ » (en lecture seulement)
  - سَاعَةٌ | heure (durée), moment | L saAEap
  - ظُهْرٌ | midi | R Zhr (le lemme du Corpus a le sens de « dos »)
  - عَصْرٌ | fin d'après-midi | L à vérifier (EaSor)
  - مُنْذُ | depuis | hors Corpus
- **Notions sans carte** :
  - **les jours** : الْأَحَدُ, الِاثْنَانِ, الثُّلَاثَاءُ, الْأَرْبِعَاءُ, الْخَمِيسُ, الْجُمُعَةُ, السَّبْتُ. Dans les phrases, on dit « يَوْمَ + nom du jour » au génitif.
    - **Le vendredi** s'écrit seul (الْجُمُعَةُ), jamais après يَوْم : « يَوْمُ الْجُمُعَةِ » est une paire du Coran, qu'on remplace (§16, 25/10). Il n'est pas employé dans les exercices.
  - **les mois** : un tableau des douze mois lunaires, à reconnaître (une seule notion), sans dire ce qu'ils signifient pour la religion.
    - Dans les phrases, on n'emploie que صَفَر, رَبِيعٌ الْأَوَّلُ, رَجَب, شَعْبَان, شَوَّال.
    - مُحَرَّم, رَمَضَان, ذُو الْقَعْدَةِ et ذُو الْحِجَّةِ restent dans le tableau : ils n'apparaissent dans aucune phrase.
  - **l'heure de l'horloge** : on ne la donne pas. Les Anciens divisaient la journée en moments (صَبَاح, ظُهْر, عَصْر, مَسَاء, لَيْل).
- **Modèles** :
  - وَصَلْتُ إِلَى الْمَدِينَةِ يَوْمَ الْخَمِيسِ. « Je suis arrivé en ville jeudi. »
  - أَسْكُنُ فِي الْمَدِينَةِ مُنْذُ شَهْرٍ. « J'habite en ville depuis un mois. »
  - سَافَرَ التَّاجِرُ أُسْبُوعَيْنِ. « Le marchand a voyagé deux semaines. »
  - يَبْدَأُ الدَّرْسُ بَعْدَ الظُّهْرِ. « La leçon commence après midi. »
  - انْتَظَرْتُ صَدِيقِي سَاعَتَيْنِ. « J'ai attendu mon ami deux heures. »
  - ابْنُ كَمْ أَنْتَ؟ — أَنَا ابْنُ خَمْسٍ وَعِشْرِينَ سَنَةً. « Quel âge as-tu ? — J'ai vingt-cinq ans. »
  - رَجَعَ عَمِّي إِلَى بَغْدَادَ فِي رَجَبٍ. « Mon oncle est rentré à Bagdad en Rajab. »
- **Nombres avec les mots du temps (liste fermée ; tout le reste est interdit)** :
  - أَيَّام : 5, 9, 15, et de 20 à 29 ;
  - أُسْبُوع : de 1 à 10 (أُسْبُوعَانِ, ثَلَاثَةُ أَسَابِيعَ) ;
  - شَهْر : شَهْرٌ seul, ou خَمْسَةُ أَشْهُرٍ ;
  - سَنَة : de 11 à 18, de 20 à 29, de 31 à 39 (jamais 30, 40, 50, 100, 300, 1 000, ni 7 ou 9 avec سَنَوَات) ;
  - سَاعَة : de 2 à 10.
- **Pièges** :
  - Le nom du temps à l'accusatif est un complément de temps, pas un complément direct.
  - Les jours viennent tous des nombres (الْأَحَد ← أَحَد, الْخَمِيس ← خَمْسَة…). Ce rapprochement est sûr : il est dit dans la leçon, sans exercice de racine.
  - ⚠ يَوْم : jamais avec الْقِيَامَة, الدِّين, الْآخِر, الْحِسَاب, الْفَصْل, الْجَمْع, عَظِيم, عَسِير, مَعْلُوم, الزِّينَة, الْجُمُعَة ; jamais يَوْمَئِذٍ, يَوْمَيْنِ, « ذَٰلِكَ الْيَوْمُ », « كُلَّ يَوْمٍ », « يَوْمًا أَوْ بَعْضَ يَوْمٍ », « أَيَّامًا مَعْدُودَاتٍ », « أَيَّام » + nom divin, « تِلْكَ الْأَيَّامُ ».
  - ⚠ شَهْر : jamais avec رَمَضَان, الْحَرَام, حُرُم, عِدَّة ; jamais شَهْرَيْنِ, « ثَلَاثَةُ / أَرْبَعَةُ أَشْهُرٍ », « أَلْفِ شَهْرٍ ».
  - ⚠ سَنَة : jamais سِنِين ; jamais avec نَوْم ou لَبِثَ (« سِنَةٌ وَلَا نَوْمٌ » s'écrit de même sans voyelles).
  - ⚠ عَام : jamais avec أَلْف, مِائَة, خَمْسِين, ni « يُغَاثُ ».
  - ⚠ سَاعَة : jamais السَّاعَة avec l'article (le mot désigne « l'Heure » dans le Coran) ; jamais seule ; jamais avec تَأَخَّرَ, اسْتَأْخَرَ, تَقَدَّمَ, نَهَار, لَبِثَ, قَامَ, أَتَى, قَرِيب, بَغْتَة.
  - ⚠ عَصْر : jamais « وَالْعَصْرِ », jamais avec إِنْسَان ou خُسْر. ⚠ ظُهْر : jamais ظَهِيرَة ni ظُهُور ; jamais de prière nommée avec ces moments.
  - ⚠ السَّبْت : jamais avec سَمَك, حُوت, بَحْر, عَدَا, اعْتَدَى, قِرَدَة.
  - ⚠ Toujours en vigueur : لَيْل et نَهَار jamais dans la même phrase.
- **Reporté** : les ordinaux et les dates complètes (région 5) ; عُمُرٌ (« âge, vie »), trop chargé (« أَرْذَلِ الْعُمُرِ », « فَطَالَ عَلَيْهِمُ الْعُمُرُ ») ; فَجْرٌ et ضُحًى (serments).

**4.19 Au marché : acheter, négocier, politesse (Marché couvert, Hāla)**
- **Objectif** : demander un prix, acheter, marchander poliment, remercier ; les nombres de 200 à 900.
- **Règle 1** : « Le prix suit بِـ : بِعْتُ الْبِسَاطَ بِمِائَةِ دِرْهَمٍ. Pour demander le prix : بِكَمْ هَٰذَا ؟ »
- **Règle 2** : « 200 se dit مِائَتَانِ (مِائَتَا دِرْهَمٍ, le ن tombe devant le nom). De 300 à 900, l'unité et مِائَة s'écrivent en un seul mot : ثَلَاثُمِائَةِ دِرْهَمٍ. Le nom compté reste au singulier, au génitif. »
- **Règle 3** : « La politesse : أَرْجُو أَنْ + subjonctif (« je te prie de… ») ; شُكْرًا لَكَ (« merci »), un mafʿūl muṭlaq figé (4.8). »
- **Mots (6, plus les centaines)** :
  - اشْتَرَى | acheter | L {$otaraY` (forme VIII) | formes : اشْتَرَى, اشْتَرَتْ, اشْتَرَيْتُ, أَشْتَرِي, يَشْتَرِي, نَشْتَرِي
  - سِلْعَةٌ | marchandise | hors Corpus ou R à vérifier
  - رَخِيصٌ | bon marché | R ou hors Corpus à vérifier (rxS) ; élatif أَرْخَصُ
  - سَاوَمَ | marchander | R swm (forme III) | formes : سَاوَمَ, سَاوَمْتُ, يُسَاوِمُ ; avertissement de racine visible
  - أَرْجُو أَنْ… | je te prie de…, j'espère que… | L à vérifier (rajaA) | forme figée أَرْجُو, toujours + أَنْ + verbe dont le sujet est une personne
  - شُكْرًا (لَكَ) | merci | L $ukor | forme figée
  - centaines : مِائَتَانِ, ثَلَاثُمِائَةٍ… تِسْعُمِائَةٍ, une seule règle (comme les dizaines en 4.14) ; غَالٍ (« cher ») en aperçu seulement (participe d'un verbe défectueux)
- **Modèles** :
  - بِكَمْ هَٰذَا الْبِسَاطُ؟ — بِثَلَاثِمِائَةِ دِرْهَمٍ. « Combien ce tapis ? — Trois cents dirhams. »
  - الثَّمَنُ كَثِيرٌ؛ أُرِيدُ بِسَاطًا أَرْخَصَ مِنْ هَٰذَا. « C'est cher ; je veux un tapis moins cher que celui-ci. »
  - سَاوَمَ بَاسِمٌ الْبَائِعَ، فَبَاعَ الْبَائِعُ الْبِسَاطَ بِمِائَتَيْ دِرْهَمٍ. « Bāsim a marchandé avec le vendeur, et le vendeur a vendu le tapis deux cents dirhams. »
  - اشْتَرَيْتُ قِرْطَاسًا وَمِدَادًا لِزُهَيْرٍ. « J'ai acheté du papier et de l'encre pour Zuhayr. »
  - أَرْجُو أَنْ تَنْتَظِرَنِي قَلِيلًا. « Je te prie de m'attendre un peu. »
  - هَٰذِهِ السِّلْعَةُ رَخِيصَةٌ. شُكْرًا لَكَ. « Cette marchandise est bon marché. Merci. »
- **Pièges** :
  - بَاعَ (vendre) ≠ اشْتَرَى (acheter) ; le prix suit toujours بِـ.
  - ثَلَاثُمِائَةٍ en un mot (ثَلَاثُ مِائَةٍ en deux mots reste exclu, §16, 12/11) ; مِائَتَا / مِائَتَيْ devant le nom.
  - شُكْرًا ne change pas (il ne s'accorde pas).
  - ⚠ اشْتَرَى : jamais اشْتَرَوْا, يَشْتَرُونَ, اشْتَرَاهُ, « بِثَمَنٍ » ; jamais avec ثَمَنًا قَلِيلًا, مِصْر / مِصْرِيّ, ضَلَالَة, هُدًى ; jamais une personne pour complément.
  - ⚠ ثَمَن jamais avec قَلِيل ni بَخْس ; jamais بِدِينَارٍ ; jamais « دَرَاهِمَ مَعْدُودَةٍ » (règles de 4.14).
  - ⚠ Jamais بِضَاعَة (on dit سِلْعَة), كَيْل, مِكْيَال, « حِمْلَ بَعِيرٍ », مُزْجَاة, نَقَصَ (avec le sens d'enlever à la mesure), حِطَّة.
  - ⚠ رَدَّ jamais avec دَرَاهِم ni « إِلَيْنَا ».
  - ⚠ شُكْرًا : seulement « شُكْرًا » ou « شُكْرًا لَكَ / لَكِ » ; jamais avec اعْمَلُوا, عَمَل, آل, لِلَّهِ ; jamais شُكُورًا ; le verbe شَكَرَ n'est pas enseigné.
  - ⚠ سَاوَمَ : jamais يَسُومُ, سَوْم, مُسَوَّمَة.
  - ⚠ أَرْجُو : jamais avec لِقَاء, رَحْمَة, اللَّه, الْيَوْم.
  - ⚠ مِائَتَانِ : jamais seul, ni avec غَلَبَ (règle de 4.14).
- **Reporté** : قَرْض et la dette (écartés) ; غَالٍ dans un exercice.

**4.20 Raconter sa journée (Maison de Nadīm)**
- **Objectif** : raconter au passé dans l'ordre ; dire une habitude.
- **Règle 1** : « On raconte au passé, relié par ثُمَّ, فَـ, بَعْدَ أَنْ, لَمَّا. Pour une habitude passée, كَانَ + inaccompli : كُنْتُ أَكْتُبُ كُلَّ مَسَاءٍ. »
- **Règle 2** : « كُلَّ + singulier indéfini veut dire « chaque » : كُلَّ صَبَاحٍ. »
- **Mots (6, plus une notion)** :
  - أَوَّلٌ | premier ; أَوَّلًا : d'abord | L >aw~al
  - آخِرٌ | dernier, fin (آخِرُ الْأُسْبُوعِ) | L A^xir
  - كُلَّ + singulier | chaque | sens nouveau de كُلّ (L kul~), **liste fermée** : صَبَاح, مَسَاء, أُسْبُوع, دَرْس
  - غَسَلَ | laver | L à vérifier (gsl) | formes : غَسَلَ, غَسَلْتُ, يَغْسِلُ ; compléments admis : ثَوْب, صَحْن seulement
  - تَعِبٌ | fatigué | hors Corpus à vérifier (tEb) ; jamais تَعْبَانُ (forme tardive)
  - اسْتَرَاحَ | se reposer | R rwH (forme X) | formes : اسْتَرَاحَ, اسْتَرَحْتُ, يَسْتَرِيحُ
  - عَادَةٌ | habitude | R Ewd
- **Modèles** :
  - اسْتَيْقَظْتُ فِي الصَّبَاحِ، ثُمَّ غَسَلْتُ ثَوْبِي. « Je me suis réveillé le matin, puis j'ai lavé mon vêtement. »
  - أَوَّلًا ذَهَبْتُ إِلَى السُّوقِ، ثُمَّ جَلَسْتُ فِي الْمَدْرَسَةِ حَتَّى الْعَصْرِ. « D'abord je suis allé au marché, puis je suis resté à l'école jusqu'à la fin de l'après-midi. »
  - كُنْتُ تَعِبًا، فَاسْتَرَحْتُ قَلِيلًا. « J'étais fatigué, alors je me suis un peu reposé. »
  - أَشْرَبُ اللَّبَنَ كُلَّ صَبَاحٍ. « Je bois du lait chaque matin. »
  - عَادَةُ بَاسِمٍ أَنْ يَكْتُبَ فِي الْمَسَاءِ. « Bāsim a l'habitude d'écrire le soir. »
  - فِي آخِرِ الْأُسْبُوعِ زُرْتُ عَمِّي. « À la fin de la semaine, j'ai rendu visite à mon oncle. »
- **Pièges** :
  - آخِرٌ (« dernier ») ≠ آخَرُ (« autre ») : on vocalise toujours.
  - كُلَّ صَبَاحٍ (chaque) ≠ كُلَّ الطُّلَّابِ (tous, 4.10).
  - ⚠ أَوَّل et آخِر jamais dans la même phrase ; jamais الْأَوَّلُ / الْآخِرُ avec l'article pris seul ; jamais الْأَوَّلِينَ, الْآخِرِينَ, الْآخِرَة ; jamais آخِر avec يَوْم (dans les deux ordres) ; jamais أَوَّل avec بَيْت, خَلْق, مَرَّة ; jamais « آخِرُ دَعْوَاهُمْ ».
  - ⚠ كُلَّ + singulier : jamais en dehors de la liste fermée (jamais يَوْم, شَيْء, نَفْس, عَام).
  - ⚠ غَسَلَ : jamais avec وَجْه, يَد, رِجْل ou leurs pluriels ; jamais اغْسِلْ / اغْسِلُوا ; jamais مُغْتَسَل.
  - ⚠ Jamais « بَعْدَ ذَٰلِكَ » ni « قَبْلَ ذَٰلِكَ » (paires du Coran) : on dit ثُمَّ, ou « بَعْدَ الدَّرْسِ ».
  - ⚠ Aucun repas nommé (غَدَاء, عَشَاء, عِشَاء sont écartés) ; pas de rêve raconté.
- **Reporté** : قَضَى (« passer son temps », chargé) ; les ordinaux.

**4.21 Donner son avis (Place des débats)**
- **Objectif** : donner son opinion, la justifier, approuver, ne pas être d'accord poliment.
- **Règle** : « On donne son avis par أَرَى أَنَّ… ou أَظُنُّ أَنَّ… (+ nom en -a), on le justifie par لِأَنَّ, on nuance par لَٰكِنَّ. Pour approuver : أُوَافِقُكَ, أَصَبْتَ. Pour refuser poliment : لَا أُوَافِقُكَ، لِأَنَّ… »
- **Mots (6)** :
  - رَأْيٌ | opinion, avis | L à vérifier (ra>oy) | مَا رَأْيُكَ فِي… ؟
  - وَافَقَ | être d'accord avec | R wfq (forme III) | formes : وَافَقَ, أُوَافِقُ(كَ), لَا أُوَافِقُ(كَ)
  - صَحِيحٌ | juste, exact | hors Corpus à vérifier (SHH)
  - دَلِيلٌ | preuve, argument | L daliyl (racine de دَلَّ, déjà connu)
  - مُنَاظَرَةٌ | débat (dans les règles) | R nZr (racine de نَظَرَ)
  - أَصَبْتَ | tu as raison | L >aSaAba | forme figée (et أَحْسَنْتَ « bien dit », L >aHosana, forme figée, en aperçu)
- **Modèles** :
  - مَا رَأْيُكَ فِي هَٰذِهِ الْقِصَّةِ؟ « Que penses-tu de cette histoire ? »
  - أَرَى أَنَّ الْقِصَّةَ جَمِيلَةٌ، لِأَنَّ كَلِمَاتِهَا سَهْلَةٌ. « Je pense que l'histoire est belle, parce que ses mots sont faciles. »
  - أُوَافِقُكَ، لَٰكِنَّ الْقِصَّةَ طَوِيلَةٌ. « Je suis d'accord avec toi, mais l'histoire est longue. »
  - لَا أُوَافِقُكَ؛ دَلِيلِي أَنَّ الطَّرِيقَ صَعْبٌ. « Je ne suis pas d'accord ; ma preuve, c'est que le chemin est difficile. »
  - هَٰذَا صَحِيحٌ. — أَصَبْتَ. « C'est exact. — Tu as raison. »
  - اخْتَلَفَ الطَّالِبَانِ فِي الْمُنَاظَرَةِ. « Les deux étudiants ont été en désaccord pendant le débat. »
- **Pièges** :
  - أَرَى أَنَّ + phrase nominale (« je pense que ») ≠ أَرَى أَنْ + verbe (« je propose que »). Les deux sont classiques ; on les distingue dans les exercices.
  - Après لَٰكِنَّ, un nom en -a (règle de 3.31).
  - Sujets de débat seulement profanes : voyage, chemin, récit, lecture, écriture, saison, marché. Jamais la religion, ce qui est permis ou interdit, ni les gouvernants.
  - ⚠ أَرَى : jamais précédé de إِنِّي, jamais « أَرَى فِي », jamais avec مَنَام, ni « مَا لَا تَرَوْنَ ».
  - ⚠ رَأْي : jamais « بَادِيَ الرَّأْيِ », jamais « رَأْيَ الْعَيْنِ ».
  - ⚠ دَلِيل : jamais دَلِيلًا, ni avec شَمْس, ظِلّ, جَعَلَ.
  - ⚠ وَافَقَ : jamais وَفَّقَ, تَوْفِيق, وِفَاقًا.
  - ⚠ Jamais جَادَلَ, جِدَال, بُرْهَان, حُجَّة (حُجَّة est retiré : « الْحُجَّةُ الْبَالِغَةُ »).
  - ⚠ أَحْسَنْتَ : forme figée seulement ; jamais أَحْسِنْ, « إِنْ أَحْسَنْتُمْ ».
  - ⚠ « هَٰذَا الْكِتَابِ » jamais (paire du Coran) : on dit « هَٰذِهِ الْقِصَّةِ ».
  - ⚠ اخْتَلَفَ : règles de 3.18 (jamais « اخْتَلَفُوا فِيهِ »).
- **Reporté** : خَالَفَ (« أُخَالِفَكُمْ » est un passage du Coran) ; les débats en plusieurs étapes (région 5).

**4.22 Mener une conversation (Place des débats)**
- **Objectif** : relancer, faire répéter, demander le sens d'un mot, conclure.
- **Règle** : « Relancer : وَأَنْتَ ؟ ثُمَّ مَاذَا ؟ Faire répéter : لَمْ أَفْهَمْ ؛ أَرْجُو أَنْ تُكَرِّرَ… ؛ مَا مَعْنَى… ؟ Conclure : إِذَنْ… ، شُكْرًا لَكَ ، نَلْتَقِي غَدًا. »
- **Mots (7)** :
  - كَرَّرَ | répéter | R krr (forme II) | formes : كَرَّرَ, يُكَرِّرُ, أَنْ تُكَرِّرَ, كَرِّرْ
  - مَعْنًى | sens (d'un mot) | R Eny | nom à alif final (مَعْنًى, الْمَعْنَى), comme en 3.28
  - بِبُطْءٍ | lentement | R bT'
  - كَلَامٌ | paroles, propos | L à vérifier (kalaAm)
  - حِوَارٌ | conversation, dialogue | R Hwr
  - إِذَنْ | donc, alors (pour conclure) | L à vérifier (<i*FA) | écrit avec ن, avec la remarque « s'écrit aussi إِذًا »
  - نَلْتَقِي | nous nous retrouvons | R lqy (racine de لَقِيَ) | forme figée
- **Modèles** :
  - لَمْ أَفْهَمْ. أَرْجُو أَنْ تُكَرِّرَ الْكَلَامَ بِبُطْءٍ. « Je n'ai pas compris. Je te prie de répéter lentement. »
  - مَا مَعْنَى هَٰذِهِ الْكَلِمَةِ؟ « Que veut dire ce mot ? »
  - أَنَا مِنْ دِمَشْقَ. وَأَنْتَ؟ « Je suis de Damas. Et toi ? »
  - ثُمَّ مَاذَا؟ « Et ensuite ? »
  - كَرِّرْ هَٰذِهِ الْجُمْلَةَ. « Répète cette phrase. »
  - إِذَنْ نَلْتَقِي غَدًا. شُكْرًا لَكَ عَلَى الْحِوَارِ. « Alors nous nous retrouvons demain. Merci pour la conversation. »
- **Pièges** :
  - إِذَنْ (« donc ») ≠ إِذَا (« si, quand », 4.1).
  - مَعْنًى garde ses deux traits sans voyelle de cas (comme les noms de 3.28).
  - ⚠ Pas de كَرَّة ni de كَرَّتَيْنِ ; jamais إِذَنْ / إِذًا avec كَرَّة, لَـ, مِثْل, تِلْكَ.
  - ⚠ كَلَام : jamais avec اللَّه, ni كَلَامِي / بِكَلَامِي, ni « يَسْمَعُونَ كَلَامَ ».
  - ⚠ حِوَار : jamais يُحَاوِرُ, تَحَاوُر.
  - ⚠ نَلْتَقِي : jamais الْتَقَى, الْتَقَتَا, ni avec جَمْعَان, فِئَتَانِ, مَاء.
  - ⚠ حَدِيث est écarté (« هَلْ أَتَاكَ حَدِيثُ… », et le sens de « hadith »).
  - ⚠ مَاذَا : règles de 4.15.
- **Reporté** : مَعَ السَّلَامَةِ dans un exercice ; أَعَادَ (« يُعِيدُهُ », « نُعِيدُكُمْ » : passages sur la création).

**4.23 Lire sans voyelles (1) (Atelier des copistes, Zuhayr)**
- **Objectif** : lire un texte simple, fait de mots connus, sans voyelles brèves.
- **Règle** : « Les textes ordinaires n'écrivent ni les voyelles brèves ni le sukūn. On s'appuie sur les lettres longues, l'article, les mots-outils et la place du mot dans la phrase. Un même squelette peut se lire de plusieurs façons : ذهب = ذَهَبَ (« il est allé ») ou ذَهَبٌ (« or »). »
- **Paliers (décision pour le point 1)** :
  - **Palier A** (début de 4.23) : on retire les voyelles brèves et le sukūn **à l'intérieur** des mots. On garde la shadda, le tanwīn et la voyelle finale (le cas).
  - **Palier B** (fin de 4.23) : on retire aussi la voyelle finale et le tanwīn. On garde la shadda.
  - **Palier C** (4.24, puis chapitre C et examen) : lettres seules, comme dans un livre. Une voyelle ne reste que sur un mot vraiment ambigu, comme le font les éditeurs (passif, homographe).
  - Les textes ne contiennent que des mots connus en 4.23. Au palier C (4.24), au plus 5 % de mots inconnus qu'on peut décoder par la racine et le schème.
- **Vérification de l'élève** :
  1. il lit seul d'abord ;
  2. puis il répond : choisir la bonne vocalisation parmi 3, vocaliser une fin de mot, ou répondre à une question de compréhension ;
  3. la version vocalisée s'affiche ensuite, phrase par phrase, avec le bouton « voir les voyelles ». Elle est toujours disponible après l'exercice, jamais pendant une question notée.
  - Pas de note de prononciation (règle absolue 5).
- **Mots (6)** :
  - حَرَكَةٌ | voyelle (brève) | R Hrk | avertissement de racine visible
  - ضَمَّةٌ | ḍamma (voyelle u) | R Dmm
  - كَسْرَةٌ | kasra (voyelle i) | hors Corpus à vérifier
  - شَدَّةٌ | shadda | R $dd (racine de شَدَّ)
  - شَكْلٌ | vocalisation (le fait de mettre les voyelles) | R $kl (le lemme du Corpus a un autre sens)
  - نَصٌّ | texte | hors Corpus à vérifier
- **Modèles** (vocalisés ici ; affichés sans voyelles selon le palier) :
  - ذهب التاجر إلى السوق في الصباح. → ذَهَبَ التَّاجِرُ إِلَى السُّوقِ فِي الصَّبَاحِ.
  - في الكيس ذهب كثير. → فِي الْكِيسِ ذَهَبٌ كَثِيرٌ.
  - كتب الطالب الدرس. / الكتب على الكرسي. → كَتَبَ… / الْكُتُبُ…
  - حمل الحمال الحمل. → حَمَلَ الْحَمَّالُ الْحِمْلَ.
  - هذا النص سهل. → هَٰذَا النَّصُّ سَهْلٌ.
- **Pièges** :
  - Le petit alif disparaît (هذا, لكن) ; ٱ n'est jamais employé.
  - Verbe en tête ou nom après la préposition : c'est la place qui décide.
  - ⚠ Jamais اقْرَأْ ni « اقْرَئِي » : la consigne de lecture est en français.
  - ⚠ Pas de texte qui ressemble à l'écriture du Mushaf.
  - ⚠ Toutes les listes ⚠ des mots s'appliquent aussi sans voyelles. Le garde-fou compare les squelettes, donc un homographe peut faire signaler une paire, qu'on remplace.
  - ⚠ قَلَم, سَطْر, مِدَاد : règles de B5 (écrit).

**4.24 Lire sans voyelles (2) : racine, schème, contexte (Atelier des copistes)**
- **Objectif** : lire au palier C et deviner un mot inconnu.
- **Règle** : « Trois outils : 1) les lettres de la racine (ce qui n'est pas préfixe, suffixe ou lettre du moule) ; 2) le schème, qui donne la voyelle et le type de mot (مَفْعَل : lieu, فَاعِل : celui qui fait, مَفْعُول : ce qui subit) ; 3) le contexte : verbe ou nom, place dans la phrase, cas attendu après une préposition, après إِنَّ ou après un verbe. »
- **Avertissement visible** (règle absolue 7) : « la racine donne une piste, pas le sens certain : on vérifie au dictionnaire (4.25) ».
- **Mots (6)** :
  - أَصْلٌ | origine ; (en grammaire) lettre de la racine ; الْحُرُوفُ الْأَصْلِيَّةُ | L >aSol
  - وَزْنٌ | (en grammaire) schème | sens nouveau d'un nom d'action connu (L wazon)
  - سِيَاقٌ | contexte | R swq
  - فِعْلٌ | (en grammaire) verbe | L fiEol
  - اسْمٌ, حَرْفٌ | (en grammaire) nom, particule | sens nouveaux de mots connus
  - مُحْتَمَلٌ | probable, possible | R Hml
- **Mots inconnus à décoder (exemples)** : مَلْعَبٌ (lieu de jeu : ل ع ب + مَفْعَل), مَكْتَبٌ (lieu où l'on écrit), مَصْنَعٌ (lieu où l'on fabrique). Ils sont lus, jamais forgés pour une racine faible.
- **Modèles** :
  - لعب الأطفال في الملعب. → لَعِبَ الْأَطْفَالُ فِي الْمَلْعَبِ. « Les enfants ont joué au terrain de jeu. »
  - جلس الكاتب في المكتب. → جَلَسَ الْكَاتِبُ فِي الْمَكْتَبِ.
  - « مَلْعَب » : الْأَصْلُ ل ع ب، وَالْوَزْنُ مَفْعَل، وَالْمَعْنَى الْمُحْتَمَلُ مَكَانُ اللَّعِبِ.
- **Pièges** :
  - Les lettres « ajoutées » (م, ت, ا, س, ن…) peuvent aussi appartenir à la racine (انْتَظَرَ : ن ظ ر ; règle de 3.18).
  - Racines faibles : la lettre cachée (règle de 3.22 à 3.26).
  - ⚠ فِعْل : jamais « فِعْلَ الْخَيْرَاتِ ». ⚠ وَزْن : jamais avec قِسْط, أَقِيمُوا, يَوْمَئِذٍ. ⚠ أَصْل : jamais avec ثَابِت, شَجَرَة, فَرْع.
  - ⚠ مَشْرَب est écarté (« مَشْرَبَهُمْ » : les douze sources).

**4.25 Le dictionnaire (Salle du dictionnaire, Zuhayr)**
- **Objectif** : trouver un mot par sa racine, dans le dictionnaire intégré, classé par racines.
- **Règle** : « On retire les préfixes et les suffixes, on revient au singulier et au passé, on retrouve la lettre cachée, puis on cherche la racine (مَادَّة) dans l'ordre de l'alphabet. Exemples : يَكْتُبُونَ → ك ت ب ; الْمَدَارِسُ → مَدْرَسَة → د ر س ; قُلْتُ → ق و ل ; اجْتَمَعْنَا → ج م ع ; مَوَاضِعُ → و ض ع. »
- **Fait culturel sûr** : certains grands dictionnaires anciens (al-Ṣiḥāḥ, Lisān al-ʿArab, al-Qāmūs al-muḥīṭ) se consultent d'abord par la **dernière** lettre de la racine. Asās al-balāġa d'al-Zamaḫšarī, lui, suit la première lettre. Dans IQURA, on cherche par la première lettre.
- **Mots (6)** :
  - مُعْجَمٌ | dictionnaire | R Ejm | avertissement de racine visible
  - بَحَثَ عَنْ | chercher | L à vérifier (baHava) | formes : بَحَثَ, بَحَثْتُ, أَبْحَثُ, يَبْحَثُ, toujours + عَنْ
  - مَادَّةٌ | article (d'un dictionnaire, classé par racine) | R mdd (racine de مَدَّ)
  - شَرْحٌ | explication | nom d'action ; verbe L $araHa | formes du verbe : شَرَحَ, يَشْرَحُ
  - مُفْرَدٌ | (en grammaire) singulier | R frd
  - تَرْتِيبٌ | ordre (de classement) | R rtb (à vérifier)
- **Modèles** :
  - بَحَثْتُ عَنْ كَلِمَةِ « مَوَاضِع » فِي الْمُعْجَمِ. « J'ai cherché le mot « مَوَاضِع » dans le dictionnaire. »
  - مُفْرَدُ « مَدَارِس » مَدْرَسَةٌ. « Le singulier de « مَدَارِس » est مَدْرَسَة. »
  - فِي مَادَّةِ « ك ت ب » كَلِمَاتٌ كَثِيرَةٌ. « Dans l'article « k t b », il y a beaucoup de mots. »
  - شَرْحُ هَٰذِهِ الْكَلِمَةِ قَصِيرٌ. « L'explication de ce mot est courte. »
- **Pièges** :
  - Le pluriel interne (مَدَارِس) se cherche par le singulier.
  - La forme dérivée (اجْتَمَعَ) se cherche dans la racine simple.
  - ⚠ بَحَثَ : jamais « يَبْحَثُ فِي الْأَرْضِ », jamais غُرَاب.
  - ⚠ شَرَحَ : jamais صَدْر, اشْرَحْ, نَشْرَحْ.
  - ⚠ مُعْجَم : jamais أَعْجَمِيّ, ni avec لِسَان + عَرَبِيّ.
  - ⚠ مُفْرَد : jamais فَرْدًا.
  - ⚠ Jamais « عَلَّمَ… الْأَسْمَاءَ ».

**4.26 Écrire un message (Atelier des copistes)**
- **Objectif** : écrire une lettre de 5 à 10 phrases (cahier §5.8), avec ses formules classiques.
- **Règle** : « Une lettre classique : مِنْ… إِلَى… (l'expéditeur, puis le destinataire) ; puis أَمَّا بَعْدُ، فَـ… (« cela dit… ») ; le corps ; la date (كَتَبْتُهُ فِي…) ; la signature (صَدِيقُكَ + nom). بَعْدُ, ici sans complément, se termine toujours en -u. »
- **Mots (6)** :
  - أَمَّا بَعْدُ | cela dit, quant à ce qui suit (formule de lettre) | expression ; أَمَّا (4.13) + بَعْدُ (sens nouveau). Remarque : « formule ancienne des lettres et des discours »
  - اشْتَاقَ إِلَى | avoir la nostalgie de, désirer revoir | R $wq (forme VIII, concave) | formes : اشْتَقْتُ, أَشْتَاقُ, + إِلَى
  - شَوْقٌ | nostalgie, désir de revoir | R $wq
  - عُنْوَانٌ | titre, en-tête | R Enw à vérifier, sinon hors Corpus
  - تَارِيخٌ | date (d'une lettre) | hors Corpus à vérifier
  - الْمَكْتُوبُ إِلَيْهِ | le destinataire | mots connus ; terme classique des lettres
- **Lettre modèle** (Bāsim à Samīr) :
  - مِنْ بَاسِمٍ إِلَى سَمِيرٍ.
  - أَمَّا بَعْدُ، فَقَدْ وَصَلْتُ إِلَى الْمَدِينَةِ يَوْمَ الْخَمِيسِ.
  - أَسْكُنُ فِي بَيْتٍ قَرِيبٍ مِنَ السُّوقِ، وَأَتَعَلَّمُ الْقِرَاءَةَ مَعَ زُهَيْرٍ.
  - النُّصُوصُ صَعْبَةٌ، لَٰكِنَّ الْمُعْجَمَ يُسَاعِدُنِي.
  - اشْتَقْتُ إِلَى الْقَرْيَةِ وَإِلَى الْأَصْدِقَاءِ.
  - أَرْجُو أَنْ تَكْتُبَ لِي رِسَالَةً.
  - كَتَبْتُهُ فِي صَفَرٍ. صَدِيقُكَ بَاسِمٌ.
- **Pièges** :
  - Après أَمَّا بَعْدُ, فَـ est obligatoire (règle de 4.13).
  - بَعْدُ (sans complément) ≠ بَعْدَ (+ nom).
  - ⚠ La lettre ne commence jamais par une formule religieuse, et ne finit jamais par « وَالسَّلَامُ ».
  - ⚠ Jamais سَلَامٌ عَلَيْكَ, تَحِيَّة, سَلَّمَ, خِتَام, خَتَمَ, طَوَى, خِطَاب, مُخْلِص, مُرْسَل (on dit الْمَكْتُوبُ إِلَيْهِ).
  - ⚠ اشْتَاقَ seulement vers un lieu, une chose ou des amis : pas de ton amoureux.
  - ⚠ Pas d'oiseau porteur, ni de reine ou de roi qui reçoit une lettre (règle d'Avancé 1).
- **Production** :
  - remettre une lettre en ordre ;
  - choisir la bonne formule ;
  - compléter ;
  - écrire 5 phrases dans le carnet, comparées à un modèle et auto-évaluées, sans note.

**4.27 Résumer un récit (Grande Salle de lecture, Zuhayr)**
- **Objectif** : reformuler un récit lu en 3 à 5 phrases.
- **Règle** : « Résumer, c'est garder le début, le milieu et la fin, et l'idée la plus importante. On rapporte les paroles au discours indirect (4.3) et on relie par ثُمَّ, فَـ, لَٰكِنْ (4.13). »
- **Mots (6)** :
  - لَخَّصَ | résumer | hors Corpus ou R à vérifier (lxS) | formes : لَخَّصَ, يُلَخِّصُ, لَخِّصْ ; تَلْخِيصٌ : résumé
  - فِكْرَةٌ | idée | R fkr
  - مُهِمٌّ | important ; أَهَمُّ : le plus important | R hmm
  - بِدَايَةٌ | début | R bd'
  - نِهَايَةٌ | fin | R nhy
  - وَسَطٌ | milieu | L wasaT
- **Modèles** :
  - هَٰذِهِ الْقِصَّةُ عَنْ تَاجِرٍ وَحِمَارِهِ. « Cette histoire parle d'un marchand et de son âne. »
  - فِي بِدَايَةِ الْقِصَّةِ سَافَرَ التَّاجِرُ، وَفِي وَسَطِهَا تَأَخَّرَ، وَفِي نِهَايَتِهَا وَصَلَ. « Au début, le marchand part ; au milieu, il est retardé ; à la fin, il arrive. »
  - أَهَمُّ فِكْرَةٍ فِي الْقِصَّةِ أَنَّ التَّعَجُّلَ خَطَأٌ. « L'idée la plus importante de l'histoire, c'est que la précipitation est une erreur. »
  - لَخَّصَ الطَّالِبُ الْقِصَّةَ فِي ثَلَاثِ جُمَلٍ. « L'étudiant a résumé l'histoire en trois phrases. »
- **Pièges** :
  - On ne recopie pas : on change de personne et on passe au discours indirect.
  - ⚠ وَسَط : jamais وَسَطًا, ni avec أُمَّة ; jamais وُسْطَى.
  - ⚠ فِكْرَة : jamais فَكَّرَ وَقَدَّرَ, تَفَكَّرَ, يَتَفَكَّرُونَ.
  - ⚠ مُهِمّ : jamais هَمَّ / هَمَّتْ.
  - ⚠ نِهَايَة : jamais مُنْتَهَى.
  - ⚠ Pas de racine خ ل ص (خُلَاصَة, خَالِص, مُخْلِص sont écartés).
  - ⚠ Les récits résumés sont ceux de la bibliothèque de la Cité, profanes.

**4.28 Un texte classique (Grande Salle de lecture)**
- **Objectif** : lire un court extrait d'une œuvre classique profane, vocalisé, avec un lexique, et en comprendre le sens.
- **Choix proposé** : *Kalīla wa Dimna*, traduit en arabe par Ibn al-Muqaffaʿ (VIIIe siècle) à partir d'une version en moyen-perse.
  - Fable recommandée : **« la tortue et les deux canards »** (السلحفاة والبطتان). Elle est courte, se suffit à elle-même, ne met en scène que des animaux, et sa morale est profane (savoir tenir sa langue). Elle ne rappelle aucun récit du Coran.
  - Seconde possibilité : le début de « la colombe au collier » (الحمامة المطوقة).
  - À écarter : les fables où paraît un ascète (le *nāsik*), et toute scène de corbeau qui gratte la terre.
- **Longueur** : 120 à 200 mots, en 3 ou 4 écrans, avec au plus 10 mots nouveaux expliqués dans un lexique (2 ou 3 fiches au plus, pour les plus courants).
- **Ce que je ne peux pas faire** : citer ce texte avec certitude. Je n'en ai pas le texte exact, et je ne le reconstitue pas de mémoire (point E2).
- **Conditions pour le reproduire honnêtement** :
  1. une édition ancienne du domaine public, par exemple Silvestre de Sacy (Paris, 1816) ou Louis Cheikho (Beyrouth, Imprimerie catholique, 1905), consultée en fac-similé ;
  2. une transcription contrôlée mot à mot contre le fac-similé ;
  3. si l'édition n'est pas vocalisée, une vocalisation ajoutée marquée « vocalisation rédigée par IA, relue ». Jamais la vocalisation d'une édition moderne protégée ;
  4. une traduction française « rédigée par IA » (aucune traduction protégée, comme celle d'André Miquel) ;
  5. la source affichée : titre, auteur, éditeur, lieu, année, page ;
  6. le passage du garde-fou, comme tout le reste du contenu.
- **Pièges** :
  - Une tournure ancienne qui sort des règles connues est signalée : « tournure du texte ancien, expliquée dans le lexique ».
  - Pas de leçon morale ajoutée ; aucune formule religieuse n'est ajoutée au texte.
  - Si l'extrait choisi en contient une, on choisit un autre passage : on ne coupe pas dans le texte sans le signaler.

**Atelier des phrases (tout le niveau)** :
- présentation en tuiles (4.15) ;
- choisir la bonne réplique (4.15, 4.17, 4.19, 4.21, 4.22) ;
- compléter un itinéraire (4.17) ;
- écrire une durée avec la bonne forme (4.18) ;
- un prix en toutes lettres (4.19) ;
- remettre une journée en ordre (4.20) ;
- vocaliser une fin de mot (4.23) ;
- donner racine, schème et sens probable (4.24) ;
- trouver la racine d'une forme (4.25) ;
- remettre une lettre en ordre (4.26) ;
- choisir le meilleur résumé (4.27).

**Examen de la région 4 (Labyrinthe de la Distraction, boss « la Grande Distraction »)**

Trois épreuves notées, sur le modèle de la région 3. L'écoute reste masquée.

1. **Lecture : récit d'environ 800 mots**, « Le papier du copiste », entièrement fait de mots connus et profane.
   - Il est découpé en 4 parties d'environ 200 mots. Les parties 1 à 3 sont vocalisées ; la partie 4 est au palier B (sans voyelles brèves, shadda gardée).
   - 12 questions, seuil de 10 sur 12. La version vocalisée de la partie 4 s'affiche après les réponses.
   - **Trame** : un jeudi, Zuhayr demande à Bāsim d'acheter du papier et de l'encre avant le soir. La Distraction le retarde tout au long de la journée.
     1. Matin, à l'Atelier : Zuhayr présente le travail, Bāsim se présente à un nouvel apprenti (4.15).
     2. Bāsim demande son chemin vers le Marché couvert : droite, gauche, entre, il passe le pont (4.17).
     3. Il passe chez Nadīm, qui lui présente Lubnā et ʿĀmir. ʿĀmir est le fils de Nadīm, il a douze ans et il est élève (4.16, 4.18).
     4. Au marché, il marchande avec un vendeur sous le regard de Hāla, achète dix feuilles et de l'encre, et dit « merci » (4.19).
     5. Sur la Place des débats, deux étudiants débattent : faut-il lire avec ou sans voyelles ? Bāsim donne son avis (4.21).
     6. Il ne comprend pas un mot, demande qu'on le répète et qu'on lui en donne le sens (4.22), puis va le chercher dans la Salle du dictionnaire (4.25).
     7. Il rentre à l'Atelier juste avant le soir. Zuhayr est content (ḥāl). Ils lisent ensemble une courte page sans voyelles (partie 4, 4.23 et 4.24).
     8. Le soir, Bāsim écrit à Samīr une lettre qui résume sa journée (4.20, 4.26, 4.27).
   - **Contraintes** :
     - aucun objet perdu ni retrouvé, aucun vol, aucune accusation, aucun bagage fouillé ;
     - aucun retour sur ses pas ;
     - aucune prière nommée ;
     - « onze / douze » seulement avec un nom de la liste de 4.14 : pour l'âge de ʿĀmir, on écrit « اثْنَتَيْ عَشْرَةَ سَنَةً »… **non** : la liste du temps l'interdit. On écrit donc « ʿĀmir est élève » sans âge, ou « ابْنُ خَمْسَ عَشْرَةَ سَنَةً » (15, dans la liste de سَنَة).
   - **Types de questions** : qui, où, quand (jour, moment), combien (prix en toutes lettres), pourquoi (لِأَنَّ), avis de qui, sens d'un mot de la partie 4, ordre des événements, résumé juste parmi 3.
2. **Dialogue avec Nadīm** : 6 répliques. À chaque réplique, le joueur choisit la bonne réponse parmi 3 ou 4. Les mauvaises réponses ont soit la mauvaise fonction (une salutation au lieu d'une demande de répétition), soit une faute de cas ou d'accord. Seuil de 5 sur 6.
   1. نَدِيمٌ : مَرْحَبًا بِكَ! مَنْ أَنْتَ، وَمِنْ أَيْنَ أَنْتَ؟ → أَهْلًا وَسَهْلًا. أَنَا مُسَافِرٌ، وَبَلَدِي بَعِيدٌ.
   2. نَدِيمٌ : مَاذَا تَعْمَلُ فِي الْمَدِينَةِ؟ → أَتَعَلَّمُ الْقِرَاءَةَ وَالْكِتَابَةَ مَعَ زُهَيْرٍ.
   3. نَدِيمٌ (longue phrase rapide, en texte défilant) → لَمْ أَفْهَمْ. أَرْجُو أَنْ تُكَرِّرَ الْكَلَامَ بِبُطْءٍ.
   4. نَدِيمٌ : هَلْ تَعْرِفُ الطَّرِيقَ إِلَى السُّوقِ؟ → نَعَمْ، تَمُرُّ بِالْجِسْرِ، ثُمَّ تَجِدُ السُّوقَ عَلَى يَسَارِكَ.
   5. نَدِيمٌ : مَا رَأْيُكَ؟ هَلْ نَقْرَأُ النَّصَّ بِالْحَرَكَاتِ؟ → أَرَى أَنْ نَقْرَأَهُ بِالْحَرَكَاتِ أَوَّلًا، لِأَنَّهُ صَعْبٌ.
   6. نَدِيمٌ : انْتَهَى الدَّرْسُ. → شُكْرًا لَكَ. نَلْتَقِي غَدًا.
3. **Production : 5 phrases**, au format décidé par l'utilisateur le 30/10/2026 : à remettre en ordre, découpées mot par mot, l'ordre attendu donné dans la consigne, 4 justes sur 5. Une autre forme est soumise en E3.
   1. اسْمِي بَاسِمٌ، وُلِدْتُ فِي قَرْيَةٍ قَرِيبَةٍ مِنْ دِمَشْقَ.
   2. بَيْتُ نَدِيمٍ بَيْنَ السُّوقِ وَالْمَدْرَسَةِ، عَلَى يَمِينِ الْجِسْرِ.
   3. اشْتَرَيْتُ عَشْرَ وَرَقَاتٍ بِثَلَاثِينَ دِرْهَمًا.
   4. أَرَى أَنَّ هَٰذِهِ الْقِصَّةَ جَمِيلَةٌ، لِأَنَّ كَلِمَاتِهَا سَهْلَةٌ.
   5. أَمَّا بَعْدُ، فَقَدْ وَصَلْتُ إِلَى الْمَدِينَةِ يَوْمَ الْخَمِيسِ.
   - Ces phrases passent sous réserve du garde-fou et des listes ⚠.

### D. Prérequis manquants et comment les introduire

| Il faut | Pour | Introduit en |
| --- | --- | --- |
| Salutations (مَرْحَبًا, أَهْلًا وَسَهْلًا, بِخَيْرٍ) | 4.15, 4.22, examen | 4.15 ; السَّلَامُ عَلَيْكُمْ : point E1 |
| مَاذَا employé seul | 4.15, 4.22 | 4.15 |
| ابْنٌ | 4.16, et l'âge en 4.18 | 4.16 |
| Mots du temps, jours, mois, مُنْذُ | 4.18 à 4.20, 4.26, examen | 4.18, avec leur liste fermée |
| اشْتَرَى, centaines de 200 à 900 | 4.19, examen | 4.19 (report d'Avancé 1) |
| شُكْرًا | 4.19, 4.22 | 4.19 (report d'Avancé 1) |
| كُلَّ + singulier | 4.20 | 4.20, liste fermée de 4 noms |
| أَوَّلٌ, آخِرٌ | 4.20, 4.26 | 4.20 ; les autres ordinaux en région 5 |
| ضَمَّة, كَسْرَة, شَدَّة | 4.23 | 4.23 |
| بَعْدُ sans complément | 4.26 | 4.26 (أَمَّا بَعْدُ, report d'Avancé 1) |
| **Technique** : affichage par paliers A, B et C, et bouton « voir les voyelles » ; retrait automatique des voyelles qui garde hamza, آ, ة, ى et l'alif du tanwīn, et retire le petit alif | 4.23, 4.24, examen | avant 4.23 (Claude Code) |
| **Technique** : parcourir le dictionnaire par racine, dans l'ordre de la première lettre (aujourd'hui, on ne peut que chercher une racine) | 4.25 | avant 4.25 (Claude Code) |
| Texte de 4.28 | 4.28 | point E2 |
| إِلَيَّ, عَلَيَّ | — | toujours évités |

### E. Points pour l'utilisateur

1. **La salutation « as-salāmu ʿalaykum » (السَّلَامُ عَلَيْكُمْ).**
   - C'est la salutation la plus courante de l'arabe classique, mais elle a aussi une valeur religieuse.
   - Le cahier exclut les formules sacrées du combat et demande de les présenter avec respect en leçon. Je ne tranche pas seul si celle-ci en fait partie.
   - **Recommandation** : l'enseigner en 4.15, sur un écran à part, avec sa réponse (وَعَلَيْكُمُ السَّلَامُ), son sens linguistique (« la paix sur vous ») et aucune règle sur son usage.
     - Elle ne sert jamais au combat ni au mini-boss.
     - Jamais la suite qui contient le nom de Dieu, jamais la forme « سَلَامٌ عَلَيْكُمْ » (qui est dans le Coran), jamais en fin de lettre.
   - **Alternative** : seulement مَرْحَبًا et أَهْلًا وَسَهْلًا.
   - En attendant ta réponse, l'écran peut être écrit, mais il n'est pas publié.
2. **Le texte classique de la leçon 4.28.**
   - Le cahier demande un vrai texte ancien, avec son édition. Je ne peux pas le citer de mémoire avec certitude.
   - **Recommandation** : la fable « la tortue et les deux canards » de *Kalīla wa Dimna*, prise dans une édition ancienne libre de droits (de Sacy, 1816, ou Cheikho, 1905). Claude Code la recopie depuis le fac-similé si la session peut l'ouvrir, sinon tu fournis les pages. Puis le relecteur contrôle la copie mot à mot.
   - **Alternative** : reporter 4.28 jusqu'à ce que le texte soit vérifié, avec une leçon qui reste fermée en attendant.
   - On ne remplace jamais le texte par une imitation « à la manière de ».
3. **L'épreuve « écrire 5 phrases » de l'examen.**
   - Le cahier (§5.11) dit « écrire 5 phrases », mais ta décision du 30/10/2026 remplace les réponses libres de l'examen par des phrases à remettre en ordre.
   - Je respecte ta décision par défaut.
   - **Recommandation** : garder ce format, et ajouter dans chaque phrase deux tuiles pièges (la même forme avec une mauvaise fin de mot). On vérifie ainsi l'écriture, et pas seulement l'ordre.
   - **Alternative** : des phrases libres comparées à un modèle et auto-évaluées, mais sans compter dans la note.
4. **Information sur les noms (validation §8.2, aucune décision urgente)** : Zuhayr (« petite fleur ») comme maître du chapitre C ; Lubnā et ʿĀmir pour la famille de Nadīm.

## Pourquoi

- **Cahier** : le plan suit le §5.8 (l. 359-382) et le §5.11 (région 4, l. 435), avec les avenants n° 1 et 2. L'audio reste suspendu (§16, 03/11). Les lieux et maîtres prolongent `PROPOSITION_REGION_4.md` (lieux 6 à 11).
- **Décisions respectées** :
  - §16 du 25/10 (paires remplacées) : c'est pourquoi le vendredi s'écrit seul.
  - §16 du 30/10 (examen : phrases à remettre en ordre ; je n'y déroge pas, point E3).
  - §16 du 12/11 (« onze et douze », jamais avec un mot du temps).
  - Avancé 1 : ضَرَبَ écarté, mots du temps reportés en 4.18 avec leur liste ⚠, maximes jamais attribuées, scènes du Coran écartées, شُكْرًا en 4.19, centaines de 300 à 900 en 4.19, أَمَّا بَعْدُ en 4.26, لَمَا en 5.4.
  - Intermédiaire 3 : listes fermées de formes, jamais اقْرَأْ ni قُلْ, règles de دَلَّ et de أَحَبَّ.
- **Grammaire** : arabe classique sûr.
  - Nom de temps à l'accusatif ; مُنْذُ + génitif ; ابْنُ عِشْرِينَ سَنَةً pour l'âge.
  - Le prix avec بِـ ; centaines en un mot ; moule فِعَالَة des métiers.
  - أَرَى أَنَّ / أَنْ ; أَمَّا بَعْدُ فَـ ; plan classique d'une lettre.
  - Ordre des dictionnaires anciens par la dernière lettre (Ṣiḥāḥ, Lisān, Qāmūs).
- **Prudence** :
  - les formules à valeur religieuse sont écartées ou soumises (E1) ;
  - l'heure de l'horloge et les calques modernes sont écartés ;
  - les mois sacrés et Ramaḍān n'apparaissent que dans le tableau ;
  - aucun jugement sur ce qui est permis (prêt, marchandage, divorce) : on renvoie aux savants ;
  - aucun texte classique n'est reconstitué de mémoire (E2).

## Confiance

- **Haute** : les règles de grammaire et de politesse, l'ordre des leçons, les paliers de lecture sans voyelles, les choix de prudence (B1 à B10), le plan de lettre, les faits sur les dictionnaires anciens.
- **Moyenne-haute** :
  - les lemmes notés « à vérifier » (xayor, ra>oy, kalaAm, baHava, rajaA, EaSor, na$a>a, <i*FA) ;
  - les mots notés « hors Corpus à vérifier » (كَسْرَة, تَعِب, صَحِيح, نَصّ, لَخَّصَ, رَخِيص, تَارِيخ, سِلْعَة, عُنْوَان) : Claude Code confirme en SQL et les note R si leur racine est trouvée ;
  - « بِخَيْرٍ » et « مَعَ السَّلَامَةِ » : usage ancien courant, mais moins sûr que مَرْحَبًا et أَهْلًا وَسَهْلًا ; le second reste en aperçu.
- **Moyenne** :
  - la liste fermée des nombres avec les mots du temps : elle est volontairement étroite, mais faite de mémoire ;
  - le choix de la fable de 4.28 : son chapitre et sa longueur exacte dépendent de l'édition.
- **Suites ⚠** : citées de mémoire, la liste est incomplète. Le garde-fou, qui compare aussi les textes sans voyelles, reste la vraie protection.

## Résumé pour l'utilisateur

Le plan des leçons 4.15 à 4.28 et de l'examen de la région 4 est prêt.
- **Contenu** : environ 90 mots nouveaux.
  - Le chapitre B fait parler : se présenter, la famille, le chemin, les jours et les mois, le marché, la journée, l'avis, la conversation.
  - Le chapitre C fait lire sans voyelles en trois étapes (la version avec voyelles s'affiche après chaque réponse), puis chercher dans le dictionnaire, écrire une lettre, résumer, et lire un vrai texte ancien.
- **Examen** : un récit de 800 mots, un dialogue à choix avec Nadīm, et 5 phrases.
- **Prudence** : les formules religieuses, les tournures modernes et les scènes qui rappellent le Coran sont écartées.
- **Trois questions t'attendent** :
  - Peut-on enseigner « as-salāmu ʿalaykum » ? Je recommande oui, sur un écran respectueux, jamais en combat.
  - D'où prendre le texte de *Kalīla wa Dimna* ? Il faut une édition ancienne vérifiée.
  - Faut-il garder les phrases à remettre en ordre à l'examen ? Je recommande oui, avec des tuiles pièges.

À enregistrer dans `/home/user/iqura/docs/relectures/decisions-avance-2.md`. Aucun fichier modifié.

Références :
- `/home/user/iqura/docs/CAHIER_DES_CHARGES.md` (§5.8 l. 359-384, §5.10 l. 419, §5.11 l. 426-436, §16 du 25/10, 30/10, 03/11, 12/11 et 13/11/2026)
- `/home/user/iqura/docs/relectures/decisions-avance-1.md` (B4 à B9, reports, décisions de fin de niveau)
- `/home/user/iqura/docs/relectures/decisions-intermediaire-3.md` (B1, B6, B7 ; règles de دَلَّ et de أَحَبَّ en 3.23)
- `/home/user/iqura/docs/relectures/decisions-intermediaire-2.md` (règles ⚠ de 3.15 à 3.18)
- `/home/user/iqura/docs/PROPOSITION_REGION_4.md`
- `/home/user/iqura/tools/build_content/vocab/mots.json` (512 fiches, noms d'action)
- `/home/user/iqura/tools/build_content/quran_guard.py` (comparaison sur squelettes sans voyelles)
- `/home/user/iqura/tools/build_content/exams/examen-r3.json` (modèle d'examen)
- `/home/user/iqura/lib/ui/game/dictionary_screen.dart` (recherche par racine seulement : vue « parcourir » à ajouter)
- `/home/user/iqura/docs/DECISIONS_A_REVOIR.md` (§1, source du dictionnaire)
- `/home/user/iqura/assets/content/iqura_content.db`

## Décisions du conseiller sur les doutes du relecteur (13/11/2026, leçons 4.15 à 4.18)

1. **بِخَيْرٍ** : pas de lemme ni de fréquence ; racine `xyr` seule, avec l'avertissement ; remarque « expression figée, formée de بِـ et de خَيْرٌ « bien » ». Le lemme xayor compte aussi « meilleur que » et « biens ».
2. **يَمِينٌ et خَلْفَ** : lemme et fréquence retirés, racines `ymn` et `xlf` seules : le Corpus mêle d'autres sens (« serment »). Confiance moyenne : on remettra le lemme de خَلْف si une requête montre qu'il ne compte que « derrière ».
3. **Liste fermée de سَنَة** : corrigée en « de 13 à 18, de 20 à 29, de 31 à 39 ; jamais 11, 12 ni 19 ». سَنَوَاتٍ est admis avec 3, 4, 5, 6, 8 et 10 (jamais 7 ni 9), nombre sans ة.
4. **يَوْمًا** : non ajouté à la fiche tant qu'aucune leçon ne s'en sert.
5. **مُنْذُ + nominatif** : attesté en classique ; on retire tous les choix au nominatif après مُنْذُ. La règle dit « suivi ici du génitif ».
6. **فِي رَجَبٍ** avec tanwīn et **شَعْبَانُ** en déclinaison partielle : gardés.
7. **Tableau des 12 mois** : reporté. Dans les phrases, seuls رَجَب et شَعْبَان ; aucun autre mois sans aperçu dans la leçon qui s'en sert ; مُحَرَّم, رَمَضَان, ذُو الْقَعْدَةِ, ذُو الْحِجَّةِ hors des phrases.

## Choix de construction (13/11/2026)

- 4.17 et 4.18 au Marché couvert (lieu 7), comme le prévoit `docs/PROPOSITION_REGION_4.md` ; Nadīm y reste le maître, Hāla prend la leçon 4.19.
- 4.20 : le thé (anachronique) est remplacé par des dattes ; أَوَّلُ en tête de fiche sans tanwīn (diptote au sens « premier »), أَوَّلًا « d'abord ».
- 4.19 : شُكْرًا ne change pas, لَكَ / لَكِ selon la personne ; le prix se demande avec بِكَمْ (aucun choix كَمْ seul).
