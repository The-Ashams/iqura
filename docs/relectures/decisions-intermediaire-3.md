# Décision — Plan de langue du niveau Intermédiaire 3 (leçons 3.22 à 3.32 et examen de la région 3)

Question : pour chaque leçon de 3.22 à 3.32, donner l'objectif, la règle, les mots nouveaux, les modèles, les pièges et les conjugaisons exercées. Fixer aussi le traitement des verbes faibles (personnes, temps, Forge, exemples sûrs), le partage entre ce qui a été vu en région 2 et ce qui est nouveau en 3.27–3.32, et l'examen de la région 3.

Stade : région 3, leçons 3.22 à 3.32 et examen.
- Lieux et maîtres : Ruines aux inscriptions (Ziyād, 3.22–3.26) ; Tribunal des scribes et Bibliothèque du col (Widād, 3.27–3.32) ; Éboulis de la Précipitation (examen).
- **Acquis** : les régions 1 et 2 ; les leçons 3.1 à 3.21 ; les 358 mots de `mots.json`, avec les noms d'action des fiches.
- **Pas encore enseignés** : بِـ, فَـ, عَنْ ; les verbes à racine faible, à hamza ou doublée (sauf قَالَ / قَالَتْ, figés) ; la défense ; لَنْ ; les formes qui perdent leur ن.

## Décision

### A. Méthode et limites (mêmes règles qu'en Intermédiaire 2)

- **Lemmes** : vérifiés par recherche de texte dans `/home/user/iqura/assets/content/iqura_content.db`. Ce n'est pas du SQL : `vocab.validate` fait foi.
  - L = lemme du Corpus de même sens.
  - R = racine seule, sans fréquence.
- **Fréquences** : je n'ai pas pu les lire (le champ est binaire). Les listes sont rangées par fréquence *probable*. Claude Code vérifie en SQL et peut réordonner les mots, ou remplacer un mot par un lemme plus fréquent de la même classe, à condition de respecter les exclusions.
- **Identifiants de lemmes** : plusieurs sont curieux (`m~a$a`, `laqu`, `bakato`, `$adado`, `>aHobabo`, `w~azanu`, `yaSilu`, `zuro`, `taSiyru`, `yabiytu`, `zaAlat`, `>abN`). Ils ne sont **jamais affichés** (décision 4 d'Intermédiaire 1).
- **Suites ⚠** : citées de mémoire, la liste est incomplète. Le garde-fou fait foi, et toute paire signalée est remplacée.

### B. Principes du niveau

1. **Pas de génération automatique pour les verbes faibles.**
   - Chaque verbe de 3.22 à 3.26 reçoit dans ses données une liste explicite des formes admises (champ `formes`), relue par le relecteur.
   - Le contrôle des mots connus n'accepte que ces formes. Le générateur des verbes sains continue de refuser toute racine qui contient و, ي ou ء, ou une lettre doublée.
   - **قَالَ** cesse d'être figé en 3.25. Ses formes admises sont : قَالَ, قَالَتْ, قَالُوا, قُلْتُ, قُلْتَ, قُلْنَا, يَقُولُ, تَقُولُ, أَقُولُ, نَقُولُ, يَقُولُونَ, لَمْ يَقُلْ, أَنْ يَقُولَ.
   - Nouvelle remarque sur sa fiche : « les formes de ce verbe changent de voyelle au milieu (leçon 3.25) ».
   - Nom d'action ajouté à la fiche de قَالَ : قَوْلٌ (L), ce qui tient la promesse de la décision 3 d'Intermédiaire 1.
2. **Personnes exercées** (passé et inaccompli) :
   - hamza, doublés, assimilés, concaves : هُوَ, هِيَ, هُمْ, أَنَا, نَحْنُ, أَنْتَ. On ajoute نَحْنُ et أَنْتَ parce que c'est là que la forme change (مَدَدْتُ, قُلْتُ, نِمْنَا) ;
   - défectueux : هُوَ, هِيَ, أَنَا, نَحْنُ, أَنْتَ. هُمْ est à reconnaître seulement (دَعَوْا, مَشَوْا, نَسُوا ; يَدْعُونَ, يَمْشُونَ, يَنْسَوْنَ) ;
   - pour tous : tableau complet de 13 formes, à reconnaître ;
   - لَمْ + هُوَ / أَنَا, exercé pour les concaves et les défectueux (لَمْ يَقُلْ, لَمْ يَنْسَ) ;
   - impératif singulier masculin exercé seulement pour قِفْ, ضَعْ, قُمْ, نَمْ, بِعْ ; tous les autres impératifs restent dans le tableau.
3. **Forge et schèmes.**
   - La Forge reste fermée aux racines faibles, à hamza ou doublées (B3 d'Intermédiaire 1, §16 du 05/11). `vocab.check_scheme` le fait déjà : aucun schème sur ces fiches.
   - Au chapitre C, la Forge laisse la place à « **Réparer l'inscription** », en trois types d'exercice, tous tirés des données :
     - **Détective** : trouver la racine d'une forme conjuguée ou d'un mot connu (قُلْتُ → ق و ل ; يَجِدُ → و ج د ; مَدَدْتُ → م د د ; مِيزَانٌ → و ز ن). La réponse est la racine du Corpus inscrite sur la fiche. L'exclusion de l'analyse (B3 d'Intermédiaire 1) est levée **pour ces mots seulement**.
     - **La lettre cachée** : dire quelle lettre de la racine a changé ou s'est cachée (و, ي, ء, ou la lettre doublée).
     - **La bonne forme** : choisir la forme juste parmi 3 ou 4. Une fausse forme est expliquée par la règle (« قَالْتُ : forme fautive, le ā devient u quand la syllabe se ferme → قُلْتُ »). Seules sont proposées les formes listées dans les données.
   - Un maître peut dire dans le texte d'une leçon « بَائِعٌ suit le moule de كَاتِبٌ ; le ي du milieu s'écrit ئ ». C'est une règle de grammaire. Mais il n'y a jamais d'exercice de schème sur ces mots.
4. **Orthographe.**
   - لَٰكِنَّ s'écrit avec le petit alif, comme هَٰذَا. Petite correction à faire : `etape3/19-la-forme-x.json`, l. 99, porte لَكِنَّ sans petit alif.
   - Les verbes à hamza finale (قَرَأَ, بَدَأَ, جَاءَ) : la forme de هُمْ n'est ni exercée ni affichée, parce que son écriture varie (قَرَءُوا / قَرَؤُوا). Le tableau dit : « la forme « ils » s'écrit de plusieurs façons ; elle n'est pas étudiée ici ».
5. **Règles levées dans ce niveau.**
   - En 3.27 : بِـ et عَنْ entrent dans le niveau ; un pluriel en -āt peut servir de complément.
   - En 3.28 : un mot sans tanwīn peut venir après une préposition ou servir de complément.
   - En 3.30 : on peut employer les formes sans ن et la défense.
   - فَـ reste pour 4.1 et 4.13.
6. **Exclusions maintenues** : les décisions B5 d'Intermédiaire 1 et B5 d'Intermédiaire 2 (aucun sujet divin, aucun nom divin, aucune formule sacrée), et les impératifs de mouvement employés seuls (règle d'Élémentaire 3), y compris au pluriel.
   - **Jamais**, nulle part : اقْرَأْ ; قُلْ dans une phrase ou un combat ; كُنْ ; ادْعُ ; « أَلَمْ تَرَ » ; قِيلَ dans une phrase.
   - **Sens linguistique seulement** : قَرَأَ « lire », jamais « réciter » ; قَامَ « se lever » ; دَعَا « appeler, inviter ».
7. **Récits** : aucune scène qui rappelle un récit coranique.
   - Pas d'objet retrouvé dans la charge d'un voyageur, pas de loup.
   - Pas d'enfant ni de chemise près d'un puits ; pas de voyageurs qui demandent à manger à une ville ; pas de mur près de tomber ni de trésor sous un mur ; pas d'hôte avec un veau.
   - Pas de chamelle prodige ; pas de maisons taillées dans la montagne.
   - Pas d'homme qui arrive du bout de la ville.

### C. Plan par leçon

Format : forme | sens | L/R | inaccompli | nom d'action.

**3.22 Verbes à hamza (Ruines aux inscriptions)**
- **Objectif** : lire et conjuguer un verbe dont la racine contient ء.
- **Règle** : « ء est une vraie lettre de la racine : seul son support change selon les voyelles voisines (سَأَلَ, يَسْأَلُ, سُؤَالٌ). Quand deux hamzas se suivent au début, elles s'écrivent آ : أَنَا آكُلُ, سَآخُذُ. »
- **Mots (7)** :
  - أَخَذَ | prendre | L >axa*a | يَأْخُذُ | أَخْذٌ (L)
  - سَأَلَ | demander, interroger | L sa>ala | يَسْأَلُ | سُؤَالٌ (déjà connu)
  - أَكَلَ | manger | L >akala | يَأْكُلُ | أَكْلٌ (L)
  - رَأْسٌ | tête ; sommet | L ra>os | pluriel non affiché (écriture variable)
  - بَدَأَ | commencer | L bada>a | يَبْدَأُ | بَدْءٌ (R)
  - قَرَأَ | lire | L qara>a | يَقْرَأُ | قِرَاءَةٌ (R)
  - مَسْأَلَةٌ | question, problème | R s'l (moule مَفْعَلَة, dit dans la leçon seulement)
- **Mots connus à expliquer** : سُؤَالٌ, بِئْرٌ, أَرْضٌ, إِبْرَةٌ.
- **Modèles** :
  - أَخَذَتْ سَلْمَى الْمِفْتَاحَ. « Salmā a pris la clé. »
  - سَأَلَ الطَّالِبُ الْمُعَلِّمَ سُؤَالًا. « L'étudiant a posé une question au maître. »
  - أَكَلَ الضُّيُوفُ التَّمْرَ فِي الْمَجْلِسِ. « Les invités ont mangé des dattes dans l'assemblée. »
  - يَقْرَأُ سَمِيرٌ الرِّسَالَةَ. « Samīr lit la lettre. »
  - بَدَأَ الدَّرْسُ فِي الصَّبَاحِ. « La leçon a commencé le matin. »
- **Conjugaisons** : les six personnes de B2 ; آكُلُ / آخُذُ, سَآكُلُ, لَمْ آكُلْ.
  - Pour قَرَأَ et بَدَأَ : sans هُمْ (B4).
  - Impératifs كُلْ, خُذْ, اسْأَلْ : tableau seulement. Pour قَرَأَ, aucun impératif.
- **Pièges** :
  - On écrit أَنَا آكُلُ, pas « أَأْكُلُ ».
  - ء compte dans la racine : س ء ل, pas س ل.
  - ⚠ أَكَلَ jamais avec طَعَام, خُبْز, لَحْم, ثَمَر / ثَمَرَة, شَجَرَة, ذِئْب, نَاقَة, « مِنْهَا », ni dans la même phrase que شَرِبَ.
  - ⚠ أَخَذَ jamais avec رَأْس, أَخ, مَكَان, كِتَاب, أَلْوَاح, نَوْم ; jamais de sujet divin (« فَأَخَذَهُمُ »).
  - ⚠ سَأَلَ : jamais « يَسْأَلُونَكَ », « أَسْأَلُكُمْ », « سَأَلَ سَائِلٌ », « مَا سَأَلْتُمْ », ni سَأَلَ + قَرْيَة.
  - ⚠ قَرَأَ jamais avec كِتَاب, اسْم, « قَرَأْنَاهُ », « قَرَأْتَ ».
  - ⚠ بَدَأَ jamais avec خَلْق, ni dans la même phrase que عَادَ.
  - ⚠ رَأْس jamais avec خُبْز, طَيْر, « رَأْسِي », « رَأْسِهِ ». On l'emploie en iḍāfa (رَأْسُ الْجَمَلِ).

**3.23 Verbes doublés**
- **Règle** : « Les deux lettres semblables se fondent en une shadda quand la dernière porte une voyelle (مَدَّ, يَمُدُّ, مَدُّوا) ; elles se séparent quand elle porte un sukūn (مَدَدْتُ, مَدَدْنَا). »
- **Mots (7)** :
  - أَحَبَّ | aimer | L >aHobabo (forme IV) | يُحِبُّ | pas de champ (حُبٌّ vient d'un autre verbe)
  - رَدَّ | rendre, renvoyer | L rad~a | يَرُدُّ | رَدٌّ (L)
  - عَدَدٌ | nombre | L Eadad
  - مَدَّ | tendre, étendre | L mad~a | يَمُدُّ | مَدٌّ (L)
  - عَدَّ | compter | L Ead~a | يَعُدُّ | عَدٌّ (R)
  - دَلَّ (عَلَى) | indiquer, montrer (le chemin) | L dal~a | يَدُلُّ | pas de champ (plusieurs noms d'action)
  - شَدَّ | serrer, attacher | L $adado | يَشُدُّ | شَدٌّ (R)
- **Mots connus expliqués** : أُمٌّ, حَارٌّ, سَلَّةٌ, قِصَّةٌ (ق ص ص), أَقَلُّ, أَخَفُّ (promis en 3.8).
- **Modèles** :
  - مَدَّ الْحَمَّالُ الْحَبْلَ. / مَدَدْتُ الْحَبْلَ. « Le porteur a tendu la corde. / J'ai tendu la corde. »
  - عَدَّ التَّاجِرُ الْأَكْيَاسَ. « Le marchand a compté les bourses. » Pas دَرَاهِمَ, qui reste au nominatif jusqu'à 3.28.
  - يَشُدُّ بَاسِمٌ الْحِمْلَ عَلَى الْجَمَلِ. « Bāsim attache la charge sur le chameau. »
  - دَلَّ الشَّيْخُ الْمُسَافِرِينَ عَلَى الطَّرِيقِ. « Le vieil homme a indiqué le chemin aux voyageurs. »
  - رَدَّ بَاسِمٌ الْمِفْتَاحَ إِلَى سَلْمَى. « Bāsim a rendu la clé à Salmā. »
  - يُحِبُّ الطِّفْلُ التَّمْرَ. « L'enfant aime les dattes. »
- **Conjugaisons** : les six personnes de B2.
  - Le jussif et l'impératif ont deux formes (لَمْ يَمُدَّ / لَمْ يَمْدُدْ ; مُدَّ / امْدُدْ). Ils sont seulement montrés en 3.30, jamais exercés.
- **Pièges** :
  - يُحِبُّ (forme IV, u) ≠ يَمُدُّ.
  - مَدَّ / مَدَدْتُ : on compte les lettres.
  - Jamais de schème.
  - ⚠ مَدَّ jamais avec الْأَرْض, الظِّلّ, « إِلَى السَّمَاءِ », « فِي طُغْيَانِهِمْ » ; jamais أَمَدَّ / نُمِدُّ.
  - ⚠ رَدَّ jamais avec أُمّ ; jamais « رُدَّتْ إِلَيْنَا », « رَدَدْنَا », « رَدَّ السَّلَامَ ».
  - ⚠ « نَعُدُّ لَهُمْ », « عَدَدَ سِنِينَ », « عَدَدًا » employé seul ; jamais مَعْدُود.
  - ⚠ jamais « هَلْ أَدُلُّكُمْ / أَدُلُّكَ ».
  - ⚠ « شَدَدْنَا », « اشْدُدْ ».
  - ⚠ أَحَبَّ : jamais de sujet divin ; jamais « لَا يُحِبُّ », « لَا أُحِبُّ », « تُحِبُّونَ », « أَحْبَبْتُ ».

**3.24 Verbes assimilés**
- **Règle** : « Quand l'inaccompli a i (et parfois a), le و du début tombe : وَجَدَ → يَجِدُ, وَضَعَ → يَضَعُ. Au passé, rien ne change : وَجَدْتُ. »
- **Mots (8)** :
  - وَجَدَ | trouver | L wajada | يَجِدُ | pas de champ (plusieurs noms d'action selon le sens)
  - وَعَدَ | promettre | L waEada | يَعِدُ | وَعْدٌ (L)
  - وَضَعَ | poser, mettre | L waDaEa | يَضَعُ | وَضْعٌ (R)
  - وَقَعَ | tomber | L waqaEa | يَقَعُ | وُقُوعٌ (R)
  - وَزَنَ | peser | L w~azanu | يَزِنُ | وَزْنٌ (L) : c'est aussi le mot « schème » de 3.2, relation « spécialisé »
  - وَصَلَ (إِلَى) | arriver à | L yaSilu | يَصِلُ | وُصُولٌ (R)
  - وَقَفَ | s'arrêter, se tenir debout | R wqf | يَقِفُ | وُقُوفٌ (R)
  - مَوْضِعٌ | endroit | R wDE (le lemme du Corpus est au pluriel)
- **Mots connus expliqués** : مِيزَانٌ (و ز ن : و devient ي après i), وَلَدٌ, وَرَقَةٌ, وِسَادَةٌ, وَاحِدٌ.
- **En aperçu** :
  - وَجِلَ يَوْجَلُ garde son و ;
  - اتَّصَلَ (و + ت → تّ), promis en 3.18 : lu, jamais forgé.
- **Modèles** :
  - وَجَدَ بَاسِمٌ الْمِفْتَاحَ تَحْتَ الْكِيسِ. « Bāsim a trouvé la clé sous la bourse. »
  - يَصِلُ الْمُسَافِرُونَ إِلَى الْمَدِينَةِ فِي الْمَسَاءِ. « Les voyageurs arrivent à la ville le soir. »
  - وَضَعَتْ سَلْمَى السَّلَّةَ عَلَى الْكُرْسِيِّ. « Salmā a posé le panier sur la chaise. »
  - وَقَفَ الْحَارِسُ عِنْدَ الْبَابِ. « Le gardien s'est tenu à la porte. »
  - يَزِنُ الصَّرَّافُ الذَّهَبَ. « Le changeur pèse l'or. »
  - يَا بَاسِمُ، ضَعِ الْكِيسَ هُنَا. « Bāsim, pose la bourse ici. »
- **Conjugaisons** : les six personnes de B2 ; impératifs قِفْ et ضَعْ exercés ; جِدْ, صِلْ, زِنْ, عِدْ dans le tableau.
- **Pièges** :
  - La racine de يَضَعُ est و ض ع, pas ض ع.
  - وَصَلَ ≠ وَصَّلَ (forme II, ⚠).
  - ⚠ وَجَدَ jamais avec جِدَار, الشَّمْس, امْرَأَة, « عَلَيْهِ / عِنْدَهُ » au puits ; jamais « لَمْ يَجِدُوا », « لَا يَجِدُونَ », « لَنْ تَجِدَ », « وَجَدْنَا عَلَيْهِ ».
  - ⚠ وَضَعَ jamais avec حِمْل / حَمْل, مِيزَان, كِتَاب, أَرْض ; jamais « وَضَعَتْ » au sens de « mettre au monde » ; jamais وُضِعَ.
  - ⚠ وَعَدَ : jamais de sujet divin ; jamais « وَعَدَنَا », « وَعَدَكُمْ », « يَعِدُهُمْ », « وَعْدَ اللَّهِ », « الْوَعْدُ الْحَقُّ ».
  - ⚠ jamais « يَصِلُونَ إِلَيْكَ », « تَصِلُ إِلَيْهِ », ni وَصَلَ + « إِلَى الْجَبَلِ » (⚠ d'Intermédiaire 1).
  - ⚠ « قِفُوهُمْ », « وُقِفُوا ».
  - ⚠ « وَزَنُوهُمْ », « زِنُوا », مَوْزُون.
  - ⚠ وَقَعَ jamais avec الْقَوْل, الْحَقّ, الْوَاقِعَة.
  - ⚠ مَوْضِع : jamais « عَنْ مَوَاضِعِهِ ».

**3.25 Verbes concaves**
- **Règle** : « Le ā du milieu cache un و ou un ي de la racine (قَالَ : ق و ل ; بَاعَ : ب ي ع) ; il redevient ū ou ī à l'inaccompli (يَقُولُ, يَبِيعُ). Quand la syllabe se ferme, il devient bref : u si l'inaccompli a ū (قُلْتُ), i sinon (بِعْتُ, نِمْتُ, لَمْ يَقُلْ). »
- **Mots (8, plus قَالَ conjugué)** :
  - جَاءَ | venir | L jaA^'a | يَجِيءُ | مَجِيءٌ (R) | seulement هُوَ, هِيَ, أَنَا (جِئْتُ) et يَجِيءُ
  - خَافَ (مِنْ) | avoir peur (de) | L xaAfa | يَخَافُ | خَوْفٌ (L)
  - زَادَ | augmenter | L zaAda | يَزِيدُ | زِيَادَةٌ (L) : lien avec le nom de Ziyād
  - قَامَ | se lever | L qaAma | يَقُومُ | قِيَامٌ (R)
  - عَادَ | revenir | L EaAda | يَعُودُ | عَوْدَةٌ (R)
  - زَارَ | rendre visite à | L zuro | يَزُورُ | زِيَارَةٌ (R)
  - بَاعَ | vendre | R byE | يَبِيعُ | بَيْعٌ (L)
  - نَامَ | dormir | R nwm | يَنَامُ | نَوْمٌ (L)
- **Mots connus expliqués** : بَائِعٌ (ي devient ئ), بَابٌ, دَارٌ, سُوقٌ, جَارٌ, مَكَانٌ (ك و ن, moule مَفْعَل).
- **En aperçu, sans exercice** : كَانَ se conjugue comme قَالَ (3.32) ; أَرَادَ et أَقَامَ (forme IV) ; قِيلَ, dans le tableau seulement.
- **Modèles** :
  - قُلْتُ لِسَلْمَى: « الطَّرِيقُ طَوِيلٌ. » « J'ai dit à Salmā : « Le chemin est long. » »
  - بَاعَ التَّاجِرُ الْقَمِيصَ فِي السُّوقِ. « Le marchand a vendu la tunique au marché. »
  - نَامَ الطِّفْلُ فِي الْخَيْمَةِ. / لَمْ يَنَمِ الطِّفْلُ. « L'enfant a dormi dans la tente. / L'enfant n'a pas dormi. »
  - عَادَتِ الْقَافِلَةُ مِنَ الْمَدِينَةِ. « La caravane est revenue de la ville. »
  - زَارَ بَاسِمٌ صَدِيقَهُ. « Bāsim a rendu visite à son ami. »
  - زَادَ الثَّمَنُ. « Le prix a augmenté. »
  - خَافَ الطِّفْلُ مِنَ الْكَلْبِ. « L'enfant a eu peur du chien. »
  - جَاءَ سَمِيرٌ مِنَ الْقَرْيَةِ. « Samīr est venu du village. »
- **Conjugaisons** : les six personnes de B2 ; لَمْ + هُوَ / أَنَا ; impératifs قُمْ, نَمْ, بِعْ exercés, seuls ou après يَا + nom.
- **Pièges** :
  - Racine de قَامَ : ق و م, pas ق ا م.
  - نَامَ et خَافَ (inaccompli en ā) font نِمْتُ, خِفْتُ, avec i.
  - On écrit جَاءَتْ ; « ils sont venus » n'est pas exercé (B4).
  - ⚠ قَالَ toujours avec le nom de celui qui parle ; jamais « قُلْتُ لَهُمْ / لَهُ », ni قَوْل + ثَقِيل, كَرِيم ou مَعْرُوف.
  - ⚠ قَامَ jamais avec اللَّيْل ni الصَّلَاة ; jamais « يَوْمَ يَقُومُ », « تَقُومُ السَّاعَةُ », « قُمْ فَـ… ».
  - ⚠ « لَا تَخَفْ / تَخَافُوا » (3.30) ; jamais خَافَ dans la même phrase que أَكَلَ ; jamais « لَا خَوْفٌ », خَوْف + عَلَيْهِمْ.
  - ⚠ جَاءَ jamais avec رَجُل, الْحَقّ, أَمْر, نَصْر, أَبَاهُمْ, « مِنْ أَقْصَى », « أَهْلُ الْمَدِينَةِ » ; jamais الْآنَ + جِئْتَ.
  - ⚠ « زِدْنِي », زَادَ + هُمْ, « الْحُسْنَى وَزِيَادَةٌ ».
  - ⚠ « زُرْتُمُ » ; « عَادُوا », « عُدْتُمْ » ; بَيْع jamais avec حَلَّ ni « لَا بَيْعٌ ».
  - ⚠ « نَائِمُونَ » avec هُمْ ; jamais ثَمَن + دَرَاهِم dans une vente de personne.

**3.26 Verbes défectueux**
- **Règle** : « La dernière lettre و ou ي devient une voyelle longue : دَعَا يَدْعُو, مَشَى يَمْشِي, نَسِيَ يَنْسَى. Au jussif, cette voyelle devient brève : لَمْ يَدْعُ, لَمْ يَمْشِ, لَمْ يَنْسَ. »
- **Mots (8)** :
  - رَأَى | voir | L ra'aA | يَرَى | pas de champ
    - formes admises : رَأَى, رَأَتْ, رَأَيْتُ, يَرَى, أَرَى ;
    - ce verbe a aussi un hamza : mot à reconnaître, peu exercé.
  - دَعَا | appeler, inviter (quelqu'un) | L daEaA | يَدْعُو | pas de champ (plusieurs noms d'action selon le sens)
  - لَقِيَ | rencontrer | L laqu | يَلْقَى | لِقَاءٌ (R)
  - نَسِيَ | oublier | L nasiYa | يَنْسَى | نِسْيَانٌ (R)
  - بَقِيَ | rester | L baqiYa | يَبْقَى | بَقَاءٌ (R)
  - بَنَى | construire | L banaY` | يَبْنِي | بِنَاءٌ (R)
  - مَشَى | marcher | L m~a$a | يَمْشِي | مَشْيٌ (L)
  - بَكَى | pleurer | L bakato | يَبْكِي | بُكَاءٌ (R)
- **Modèles** :
  - دَعَا التَّاجِرُ بَاسِمًا. « Le marchand a appelé Bāsim. »
  - مَشَى بَاسِمٌ إِلَى الْجِسْرِ. « Bāsim a marché jusqu'au pont. »
  - بَنَى النَّجَّارُ بَيْتًا صَغِيرًا. « Le menuisier a construit une petite maison. »
  - نَسِيتُ الْمِفْتَاحَ فِي الْبَيْتِ. « J'ai oublié la clé à la maison. »
  - لَقِيَ سَمِيرٌ صَدِيقَهُ فِي السُّوقِ. « Samīr a rencontré son ami au marché. »
  - لَمْ يَنْسَ الطَّالِبُ الدَّرْسَ. « L'étudiant n'a pas oublié la leçon. »
- **Conjugaisons** : B2 ; impératifs (امْشِ, ابْقَ) dans le tableau seulement.
- **Pièges** :
  - Racine en و : le ā final s'écrit ا (دَعَا) ; racine en ي : il s'écrit ى (مَشَى).
  - يَدْعُونَ peut être « ils » ou « elles » : le tableau le montre.
  - ⚠ دَعَا jamais avec رَبّ, اللَّه, « إِلَى + idée », « دَعَانِي », « يَدْعُونَ », دُعَاء, ni أَبِي + يَدْعُو.
  - ⚠ رَأَى jamais avec نَار, قَمِيص, كَوْكَب, قَمَر, شَمْس, رُؤْيَا ; jamais « أَلَمْ تَرَ / يَرَوْا », « رَأَيْتُهُمْ », ni لَنْ + رَأَى.
  - ⚠ مَشَى jamais avec الْأَرْض, السُّوق / الْأَسْوَاق, عَلَى ; jamais « لَا تَمْشِ ».
  - ⚠ نَسِيَ jamais avec الْحُوت, « بِمَا نَسِيتُ », « نَسِينَا », « نَسُوا » + objet.
  - ⚠ لَقِيَ jamais avec « لَقِينَا », غُلَام, « إِذَا لَقِيتُمُ », لِقَاء + رَبّ / يَوْم.
  - ⚠ بَقِيَ : jamais « مَا بَقِيَ », « يَبْقَى وَجْهُ ».
  - ⚠ بَنَى jamais avec السَّمَاء, « ابْنِ لِي », « بَنَيْنَاهَا ».
  - ⚠ « يَبْكُونَ ».
  - ⚠ jamais شَيْخ et بِئْر dans la même scène.

**3.27 Les trois cas (Tribunal des scribes)**
- **Déjà vu** :
  - 2.12 : -u / -a / -i, avec les termes مَرْفُوعٌ, مَنْصُوبٌ, مَجْرُورٌ ;
  - le tanwīn ; l'iḍāfa ; l'attribut de لَيْسَ en -a (2.20) ;
  - les marques du duel et du pluriel (2.16, 2.17) ; le complément en -a (2.23).
- **Nouveau** :
  - expliquer une fin de mot par sa fonction, avec les termes ;
  - l'adjectif prend le cas de son nom ;
  - les pluriels en -āt font -i au cas direct (كَتَبَ الْكَلِمَاتِ) ;
  - مَبْنِيٌّ / مُعْرَبٌ : هَٰذَا, الَّذِي, أَمْسِ, هُنَا ne changent pas ;
  - بِـ et عَنْ, deux autres prépositions suivies du génitif ;
  - en aperçu : l'ordre verbe, complément, sujet (أَكْرَمَ الضَّيْفَ الشَّيْخُ), où seule la fin montre qui agit.
- **Règle** : « -u pour le sujet du verbe, le sujet et l'attribut de la phrase nominale ; -a pour le complément direct ; -i après une préposition et pour le second nom d'une iḍāfa. L'adjectif suit le cas de son nom. »
- **Mots (8)** :
  - بِـ | avec (au moyen de), à, par | particule (pas de lemme, c'est un préfixe dans le Corpus)
  - عَنْ | de (en s'éloignant), au sujet de | L Ean
  - خَبَرٌ | nouvelle ; (en grammaire) attribut | L xabar pour « nouvelle »
  - جُمْلَةٌ | phrase | R jml
  - فَاعِلٌ | (en grammaire) sujet du verbe | R fEl
  - مَفْعُولٌ بِهِ | complément direct | R fEl
  - مُبْتَدَأٌ | sujet de la phrase nominale | R bdA
  - إِعْرَابٌ | analyse des fins de mots | R Erb
- **Modèles** :
  - فَتَحَ الْحَارِسُ بَابَ الْبَيْتِ. Analyse : الْحَارِسُ فَاعِلٌ مَرْفُوعٌ ; بَابَ مَفْعُولٌ بِهِ مَنْصُوبٌ ; الْبَيْتِ مَجْرُورٌ (second nom de l'iḍāfa).
  - كَتَبَ سَمِيرٌ الرِّسَالَةَ بِالْقَلَمِ. « Samīr a écrit la lettre avec le calame. »
  - سَأَلَ بَاسِمٌ التَّاجِرَ عَنِ الثَّمَنِ. « Bāsim a demandé le prix au marchand. »
  - حَفِظَ الطُّلَّابُ الْكَلِمَاتِ. « Les étudiants ont appris les mots par cœur. »
  - الْقَرْيَةُ بَعِيدَةٌ عَنِ النَّهْرِ. « Le village est loin du fleuve. »
- **Pièges** :
  - فَاعِل-fonction ≠ فَاعِل-moule : dans انْفَتَحَ الْبَابُ, الْبَابُ est فَاعِل sans « faire » l'action.
  - مَفْعُولٌ بِهِ ≠ مَفْعُول (le moule).
  - عَنِ devant l'article.
  - ⚠ بِـ jamais avec اسْم / بِسْمِ, اللَّه, الْحَقّ, الْغَيْب, الْآخِرَة, الْمَعْرُوف, الْعَدْل, الْقِسْط, إِذْن, مَا, حَبْل, قَمِيص, مَصَابِيح, النَّهَار ; jamais عَلَّمَ + بِالْقَلَمِ.
  - ⚠ عَنْ jamais avec سَبِيل, الصَّلَاة, ذِكْر, السَّاعَة ; jamais « يَسْأَلُونَكَ عَنْ », « رَضِيَ … عَنْ », « عَنْ أَمْرِي ».
  - ⚠ jamais قَطَّعَ + سِكِّين.

**3.28 Noms particuliers**
- **Nouveau** : les diptotes et les cinq noms. Le tanwīn et les cas sont déjà connus.
- **Règle 1** : « Certains noms n'ont jamais de tanwīn et font -a au lieu de -i : مِنْ بَغْدَادَ, مَعَ رَبَابَ, ثَلَاثَةُ دَرَاهِمَ. Avec الْ ou en iḍāfa, ils reprennent -i : فِي الْمَدَارِسِ. »
- **Règle 2** : « أَبٌ, أَخٌ et ذُو allongent leur voyelle devant un nom : أَبُو بَاسِمٍ, أَبَا بَاسِمٍ, أَبِي بَاسِمٍ. »
- **Diptotes** :
  - prénoms féminins : رَبَابُ, وِدَادُ, نُورَةُ ;
  - villes : بَغْدَادُ, دِمَشْقُ. **Pas مِصْرُ**, qui hésite en classique ;
  - أَفْعَلُ, couleurs comprises ;
  - pluriels مَفَاعِلُ / مَفَاعِيلُ / فُعَلَاءُ.
  - Jamais de nom de prophète comme exemple.
- **Mots (7)** :
  - أَبٌ | père | L >abN
  - أَخٌ | frère | L >ax
  - ذُو | qui a, doté de | L *uw ; en aperçu seulement
  - أُخْتٌ | sœur | L >uxot
  - أَبْيَضُ (f. بَيْضَاءُ) | blanc | L >aboyaD
  - أَسْوَدُ (f. سَوْدَاءُ) | noir | L >asowad
  - أَحْمَرُ (f. حَمْرَاءُ) | rouge | R Hmr
- **Modèles** :
  - سَافَرَ التَّاجِرُ إِلَى بَغْدَادَ. « Le marchand est parti en voyage pour Bagdad. »
  - جَلَسَ بَاسِمٌ مَعَ رَبَابَ. « Bāsim s'est assis avec Rabāb. »
  - فِي الْكِيسِ ثَلَاثَةُ دَرَاهِمَ. « Il y a trois dirhams dans la bourse. »
  - أَبُو بَاسِمٍ تَاجِرٌ. / جَلَسْتُ مَعَ أَبِي بَاسِمٍ. « Le père de Bāsim est marchand. / Je me suis assis avec le père de Bāsim. »
  - أُخْتُ سَمِيرٍ طَالِبَةٌ. « La sœur de Samīr est étudiante. »
  - هَٰذِهِ خَيْمَةٌ سَوْدَاءُ. « C'est une tente noire. »
- **Pièges** :
  - أَحْمَرُ n'est pas un comparatif.
  - Les cinq noms seulement devant un nom : avec un pronom collé (أَبِي, أَخُوهُ), tableau seulement.
  - مَرْضَى (ى) ne montre pas son cas.
  - ⚠ jamais أَب + شَيْخ كَبِير ; jamais أَبُونَا, أَبَاهُمْ, أَبِيهِ, أَخِيهِ, أَخَاهُ, أَخُوكَ, « يَا أَبَتِ » ; أُخْت jamais avec هَارُون ni « لِأُخْتِهِ » ; jamais كَانَ + أَبُو….
  - ⚠ ذُو / ذَا / ذِي jamais avec الْقَرْنَيْنِ, الْعَرْش, فَضْل, عِلْم, مَال, الْقُرْبَى, زَرْع.
  - ⚠ couleurs : jamais خَيْط + أَبْيَض / أَسْوَد ; jamais يَد + بَيْضَاء ; jamais وَجْه + couleur ; jamais شَجَر / شَجَرَة + أَخْضَر ; jamais بَقَرَة ni « صَفْرَاءُ » ; jamais قَمِيص + أَحْمَر ; jamais حُمُر.
  - ⚠ « دَرَاهِمَ مَعْدُودَةٍ », « بِمَصَابِيحَ », « فِي الْمَجَالِسِ ».

**3.29 Le subjonctif**
- **Nouveau** : tout le mode.
- **Règle** : « Après أَنْ, لَنْ et كَيْ, l'inaccompli finit par -a : أُرِيدُ أَنْ أَكْتُبَ. Les formes en ـُونَ et ـِينَ perdent leur ن : أَنْ يَكْتُبُوا (avec un alif muet), أَنْ تَكْتُبِي. »
- **Mots (6)** :
  - أَنْ | que (+ verbe) | L >an
  - أَرَادَ | vouloir | L >araAda (forme IV, verbe concave) | يُرِيدُ | formes : أَرَادَ, أُرِيدُ, يُرِيدُ, أَرَدْتُ
  - قَبْلَ | avant | L qabol
  - بَعْدَ | après | L baEod
  - لَنْ | ne… pas (au futur) | L lan
  - كَيْ | pour que | L kaY
- **Modèles** :
  - أُرِيدُ أَنْ أَكْتُبَ رِسَالَةً. « Je veux écrire une lettre. »
  - طَلَبَ التَّاجِرُ مِنْ سَمِيرٍ أَنْ يَكْتُبَ الرِّسَالَةَ. « Le marchand a demandé à Samīr d'écrire la lettre. »
  - لَنْ أَنْسَى الْقِصَّةَ. « Je n'oublierai pas l'histoire. »
  - جَلَسَ الطُّلَّابُ فِي الْمَجْلِسِ كَيْ يَسْمَعُوا الْقِصَّةَ. « Les étudiants se sont assis dans l'assemblée pour écouter l'histoire. »
  - اكْتُبِ الرِّسَالَةَ قَبْلَ أَنْ تَخْرُجَ. « Écris la lettre avant de sortir. »
- **Formes faibles** : يَدْعُوَ, يَمْشِيَ (le a se voit) ; يَنْسَى (sans changement) ; أَنْ يَمُدَّ, أَنْ يَقُولَ, أَنْ أَقْرَأَ.
- **Personnes** : أَنَا, هُوَ, هِيَ, نَحْنُ, أَنْتَ, هُمْ, أَنْتِ.
- **Pièges** :
  - أَنْ (+ verbe) ≠ أَنَّ (3.31) ≠ أَنَا.
  - لَنْ + -a (futur nié) ≠ لَمْ + sukūn (passé nié).
  - ⚠ لَنْ jamais avec رَأَى, وَجَدَ, دَخَلَ, خَرَجَ, اسْتَطَاعَ, كَلَّمَ, دَعَا, قَالَ, صَبَرَ.
  - ⚠ كَيْ jamais avec تَقَرَّ ou عَيْن ; jamais « كَيْ لَا يَكُونَ », « لِكَيْلَا ».
  - ⚠ أَرَادَ : sujet humain seulement ; jamais « إِذَا أَرَادَ », « أَرَدْنَا », « أَرَادُوا بِهِ » ; jamais avec يُطْعِمُ, يَبْلُغَ, يُخْرِجَ ou سَأَلَ après أَنْ.
  - ⚠ jamais « مِنْ قَبْلِ / مِنْ بَعْدِ / مِنْ قَبْلُ », « قَبْلَ / بَعْدَ ذَٰلِكَ », قَبْلَ + الشَّمْس, « قَبْلَ أَنْ تَقُومَ / يَأْتِيَ ».
  - ⚠ « أَنْ تَقُولُوا / يَقُولُوا », « أُمِرْتُ أَنْ ».

**3.30 Le jussif**
- **Déjà vu** : لَمْ + أَ, تَ, يَ, نَ au singulier (2.27) ; l'impératif masculin singulier (2.29).
- **Nouveau** :
  - les formes sans ن : لَمْ يَكْتُبُوا, لَمْ تَكْتُبِي ;
  - le jussif des verbes faibles ;
  - **لَا de défense** ;
  - l'impératif complet : اكْتُبِي et اكْتُبُوا exercés ; اكْتُبَا et اكْتُبْنَ dans le tableau ;
  - les deux formes des doublés (لَمْ يَمُدَّ / لَمْ يَمْدُدْ), à reconnaître ;
  - لِـ de commande (لِيَكْتُبْ), en aperçu.
- **Règle** : « لَمْ (passé nié) et لَا de défense (« ne… pas ! ») mettent l'inaccompli au jussif : sukūn final, ن perdu, voyelle longue finale abrégée (لَمْ يَنْسَ). Défense : لَا + forme de « tu » au jussif : لَا تَكْتُبْ. »
- **Mots (6)** :
  - لَا (de défense) | ne… pas ! | sens nouveau d'un mot connu
  - تَعَجَّلَ | se hâter, se précipiter | L, forme V (Ejl) | يَتَعَجَّلُ | تَعَجُّلٌ (R)
  - تَأَخَّرَ | être en retard, tarder | L ta>ax~ara | يَتَأَخَّرُ | تَأَخُّرٌ (R)
  - وَقْتٌ | temps, moment | L waqot
  - خَطَأٌ | erreur | R xTA
  - صَوَابٌ | ce qui est juste | L SawaAb
- **Modèles** :
  - لَا تَكْتُبْ عَلَى الْجِدَارِ. « N'écris pas sur le mur. »
  - يَا سَلْمَى، لَا تَجْلِسِي هُنَا. « Salmā, ne t'assieds pas ici. »
  - لَا تَلْعَبُوا فِي الْمَطْبَخِ. « Ne jouez pas dans la cuisine. »
  - لَا تَتَعَجَّلْ، الطَّرِيقُ طَوِيلٌ. « Ne te hâte pas, le chemin est long. » C'est le thème de la Précipitation.
  - لَمْ يَكْتُبُوا الدَّرْسَ. / لَمْ يَقُمِ الطِّفْلُ. « Ils n'ont pas écrit la leçon. / L'enfant ne s'est pas levé. »
  - هَٰذَا خَطَأٌ. « C'est une erreur. »
- **Défense, verbes sûrs seulement** : كَتَبَ, جَلَسَ, لَعِبَ, تَرَكَ, فَتَحَ, رَكِبَ, نَامَ, بَاعَ, سَافَرَ, وَضَعَ, تَعَجَّلَ, تَأَخَّرَ, et شَرِبَ (jamais avec نَهْر).
- **Pièges** :
  - لَا تَكْتُبُ (« tu n'écris pas ») ≠ لَا تَكْتُبْ (« n'écris pas ») : on vocalise toujours.
  - Le sukūn devient i devant l'article.
  - ⚠ défense **jamais** avec : قَالَ, خَافَ, حَزِنَ, أَكَلَ, سَأَلَ, مَشَى, دَعَا, نَسِيَ, دَخَلَ, ذَهَبَ, خَرَجَ, رَجَعَ, مَدَّ, حَمَلَ, سَمِعَ, فَرِحَ, كَانَ, كَلَّمَ, تَفَرَّقَ, تَنَازَعَ, قَرُبَ, أَخَذَ, رَفَعَ.
  - ⚠ jamais اخْرُجُوا, ادْخُلُوا, اذْهَبُوا, ارْجِعُوا, ارْكَبُوا, اسْكُنُوا, اسْمَعُوا.
  - ⚠ « وَقْتِ الْمَعْلُومِ » ; « صَوَابًا » après قَالَ ; « إِلَّا خَطَأً » ; تَعَجَّلَ + « فِي يَوْمَيْنِ » ; jamais تَقَدَّمَ et تَأَخَّرَ ensemble.

**3.31 إِنَّ et ses sœurs (Bibliothèque du col)**
- **Nouveau** : toute la leçon (لَٰكِنَّ n'a été qu'aperçu en 3.19).
- **Règle** : « إِنَّ et ses sœurs se placent devant une phrase nominale : le sujet passe en -a, l'attribut reste en -u : إِنَّ الطَّرِيقَ طَوِيلٌ. Après قَالَ on écrit إِنَّ, après les autres verbes أَنَّ (عَرَفْتُ أَنَّ…). »
- **Le sujet vient toujours juste après la particule** : jamais d'attribut placé en tête (pas de « إِنَّ فِي… »).
- **Mots (6)** : tous des lemmes du Corpus (ACC) :
  - إِنَّ | (insiste ; souvent non traduit) | L <in~
  - أَنَّ | que (+ nom) | L >an~
  - لَٰكِنَّ | mais | L la`kin~
  - لَعَلَّ | peut-être que | L laEal~
  - كَأَنَّ | on dirait que | L ka>an~
  - لَيْتَ | si seulement | L layot
- **Modèles** :
  - إِنَّ الطَّرِيقَ طَوِيلٌ. « Le chemin est vraiment long. »
  - عَرَفْتُ أَنَّ الْحَارِسَ عِنْدَ الْبَابِ. « J'ai su que le gardien était à la porte. »
  - الْبَيْتُ صَغِيرٌ، لَٰكِنَّ الْحَدِيقَةَ كَبِيرَةٌ. « La maison est petite, mais le jardin est grand. »
  - لَعَلَّ سَمِيرًا فِي الْمَدْرَسَةِ. « Samīr est peut-être à l'école. »
  - كَأَنَّ السُّوقَ مَدِينَةٌ. « On dirait que le marché est une ville. »
  - لَيْتَ الطَّرِيقَ قَصِيرٌ. « Si seulement le chemin était court ! »
- **Pronoms collés** : ـهُ et ـهَا exercés après إِنَّ et أَنَّ seulement ; إِنِّي / إِنَّنِي et les autres formes dans le tableau.
- **Pièges** :
  - إِنَّ fait passer le sujet en -a, كَانَ fait passer l'attribut en -a (3.32).
  - أَنَّ ≠ أَنْ.
  - لَٰكِنَّ (lourd, + nom en -a) ≠ لَٰكِنْ (léger, région 4).
  - ⚠ إِنَّ jamais avec اللَّه, هَٰذَا, الَّذِينَ, فِي, الْإِنْسَان, رَبّ ; jamais « إِنَّا », « إِنَّهُ هُوَ ».
  - ⚠ أَنَّ jamais avec اللَّه ou الْأَرْض ; jamais عَلِمَ / اعْلَمُوا + أَنَّ.
  - ⚠ لَٰكِنَّ jamais avec أَكْثَر ou اللَّه.
  - ⚠ لَعَلَّ jamais avec ـكُمْ, ـهُمْ, ـي.
  - ⚠ jamais « يَا لَيْتَ », « لَيْتَنِي ».
  - ⚠ كَأَنَّ jamais avec un pronom collé, ni avec مِصْبَاح, نَجْم, جَبَل, حِمَار, بُيُوت ; jamais « كَأَنْ لَمْ ».

**3.32 كَانَ et ses sœurs**
- **Déjà vu** : لَيْسَ, avec l'attribut en -a (2.20, 2.22).
- **Nouveau** : كَانَ et ses sœurs, leur conjugaison concave, كَانَ + inaccompli.
- **Règle** : « كَانَ et ses sœurs se placent devant une phrase nominale : le sujet reste en -u, l'attribut passe en -a : كَانَ الطَّرِيقُ طَوِيلًا. كَانَ met la phrase au passé ; يَكُونُ (avec سَـ) au futur ; كَانَ + inaccompli dit une habitude ou une durée. »
- **Mots (6)** :
  - كَانَ | être (au passé) | L kaAna | يَكُونُ | pas de champ
  - أَصْبَحَ | devenir ; être au matin | L >aSobaHa
  - ظَلَّ | rester (tout le jour) | L Zal~a
  - صَارَ | devenir | L taSiyru | يَصِيرُ
  - مَا زَالَ | être toujours, ne pas cesser de | L zaAlat (racine z y l : pas le lemme zaAla, racine z w l)
  - بَاتَ | passer la nuit | L yabiytu ; aperçu
  - أَمْسَى, en aperçu, sans fiche.
- **Formes admises de كَانَ** : كَانَ, كَانَتْ, كَانُوا, كُنْتُ, كُنْتَ, كُنَّا, يَكُونُ, سَيَكُونُ, لَمْ يَكُنْ. **Jamais** كُنْ ni لَمْ يَكُ.
- **Modèles** :
  - كَانَ الطَّرِيقُ طَوِيلًا. « Le chemin était long. »
  - كُنْتُ مَرِيضًا أَمْسِ. « J'étais malade hier. »
  - صَارَ الْمَاءُ بَارِدًا. « L'eau est devenue froide. »
  - ظَلَّ الْبَابُ مَفْتُوحًا. « La porte est restée ouverte. »
  - مَا زَالَ بَاسِمٌ فِي السُّوقِ. « Bāsim est toujours au marché. »
  - كَانَ بَاسِمٌ يَلْعَبُ فِي الْحَدِيقَةِ. « Bāsim jouait dans le jardin. »
  - لَمْ يَكُنِ الْبَابُ مَفْتُوحًا. « La porte n'était pas ouverte. »
  - سَيَكُونُ الدَّرْسُ سَهْلًا. « La leçon sera facile. »
- **Pièges** :
  - Ne pas confondre l'attribut en -a (كَانَ) et le sujet en -a (إِنَّ).
  - كُنْتُ se conjugue comme قُلْتُ.
  - ⚠ كَانَ jamais avec اللَّه, النَّاس, الْإِنْسَان, « فِي الْمَدِينَةِ », « لَهُ », أَب.
  - ⚠ jamais « إِنْ كُنْتُمْ », « مَا كَانَ », « كَانُوا + inaccompli », « لَمْ يَكُنْ لَهُ », « كُنْتُ تُرَابًا / نَسْيًا ».
  - ⚠ أَصْبَحَ jamais avec « فِي الْمَدِينَةِ », خَائِف, نَادِمِينَ.
  - ⚠ ظَلَّ jamais avec وَجْه ou مُسْوَدّ.
  - ⚠ jamais « لَا يَزَالُ », « مَا زَالَتْ تِلْكَ », زَالَ + مُخْتَلِف.
  - ⚠ صَارَ jamais suivi de إِلَى, jamais مَصِير ; بَاتَ jamais suivi de لِـ.

**Atelier des phrases (chapitre D)** : transformer
- يَكْتُبُ → أُرِيدُ أَنْ يَكْتُبَ ;
- une phrase nominale → la même avec إِنَّ ou avec كَانَ (le cas change) ;
- une phrase affirmative → avec لَمْ, ou avec la défense.

### D. Examen de la région 3 (Éboulis de la Précipitation)

Sans audio, et sans réponse libre (décision du 30/10).

1. **Lire : « L'inscription du col »**
   - **Texte** : environ 300 mots (cahier §5.11), tous connus (100 %), en 3 parties d'environ 100 mots.
   - **Trame** :
     - Ziyād, Bāsim et deux marchands descendent du col ; il fait froid.
     - Bāsim veut arriver avant le soir (أُرِيدُ أَنْ أَصِلَ…).
     - Ziyād voit une inscription sur une vieille porte : « لَا تَتَعَجَّلْ… لَا تُسَافِرْ فِي الْمَسَاءِ ».
     - Bāsim n'en comprend pas un mot ; Ziyād retrouve sa racine.
     - Ils restent au relais ; la neige tombe ; le matin, le chemin est devenu blanc (صَارَ الطَّرِيقُ أَبْيَضَ).
     - Deux répliques : لَيْتَ الطَّرِيقَ قَصِيرٌ / لَعَلَّ الْقَرْيَةَ قَرِيبَةٌ.
     - Ils rencontrent أَبُو سَمِيرٍ, un marchand de Bagdad, qui les invite de lui-même (دَعَا الْمُسَافِرِينَ أَبُو سَمِيرٍ).
     - Bāsim : « لَنْ أَنْسَى الْقِصَّةَ » ; Widād écrit : « التَّعَجُّلُ خَطَأٌ ».
   - **Interdits du récit** : jamais اسْتَطْعَمَ ; pas de ville qui refuse l'hospitalité ; pas de mur ni de trésor ; pas de puits (B7).
   - **12 QCM à 4 choix, seuil 10/12.**
     - Les questions portent sur les points du niveau : لَمْ + verbe faible, le but (كَيْ / أَنْ), لَنْ, لَيْتَ, لَعَلَّ, صَارَ + attribut, أَبُو + nom, la ville sans tanwīn.
     - Une question demande qui agit dans une phrase verbe, complément, sujet.
2. **Décoder** : 20 mots inconnus, aucun dans `mots.json` ni dans les noms d'action des fiches.
   - **16 mots à racine saine** et schème vérifié par `check_scheme`. Pour chacun, deux questions : la racine et le moule (ou la forme). Pour 10 d'entre eux, une troisième : le sens probable, sur des mots dont la relation est « proche » ; le sens vérifié s'affiche ensuite.
   - **Candidats** (racine du Corpus ; L/R à vérifier) :

     | Mot | Racine | Moule | Sens |
     | --- | --- | --- | --- |
     | مَلْعَبٌ | ل ع ب | مَفْعَل | lieu où l'on joue |
     | مَكْتَبٌ | ك ت ب | مَفْعَل | lieu où l'on écrit |
     | مَشْرَبٌ | ش ر ب | مَفْعَل | lieu où l'on boit |
     | مَنْظَرٌ | ن ظ ر | مَفْعَل | vue |
     | مَرْكَبٌ | ر ك ب | مَفْعَل | monture |
     | مَحْمُولٌ | ح م ل | مَفْعُول | porté |
     | مَسْمُوعٌ | س م ع | مَفْعُول | entendu |
     | مَحْفُوظٌ | ح ف ظ | مَفْعُول | gardé |
     | لَاعِبٌ | ل ع ب | فَاعِل | joueur |
     | زَارِعٌ | ز ر ع | فَاعِل | cultivateur |
     | سَامِعٌ | س م ع | فَاعِل | qui entend |
     | جَلِيسٌ | ج ل س | فَعِيل | compagnon d'assemblée |
     | مُدَرِّسٌ | د ر س | مُفَعِّل | enseignant |
     | تَدْرِيسٌ | د ر س | تَفْعِيل | enseignement |
     | تَعْرِيفٌ | ع ر ف | تَفْعِيل | fait de faire connaître |
     | مُتَكَلِّمٌ | ك ل م | مُتَفَعِّل | qui parle |
     | مُنْتَظِرٌ | ن ظ ر | مُفْتَعِل | qui attend (jamais au pluriel مُنْتَظِرُونَ) |

   - **4 formes faibles** (قُلْتُ, يَجِدُ, مَدَدْتُ, دَعَوْتُ) : la racine, puis « la lettre cachée ».
   - **Écartés** : مَعْرُوف (sens religieux), جَامِع (sens religieux), حَافِظ (nom divin proche), مَصْنَع (sens incertain), et les racines absentes du Corpus (comme ط ب خ).
   - **Seuil** : 80 % des réponses (40 sur 50).
3. **Remettre en ordre** : 5 phrases découpées mot par mot, l'ordre attendu donné dans la consigne, et une tuile fausse qui teste un point du niveau. **Seuil 4/5.**
   - كُنْتُ فِي السُّوقِ (fausse tuile : كَانَ) ;
   - نَعَمْ، وَجَدْتُهُ تَحْتَ الْكِيسِ (fausse tuile : أَجِدُهُ) ;
   - أُرِيدُ أَنْ أَقْرَأَ الرِّسَالَةَ (fausse tuile : أَقْرَأُ) ;
   - لَا تَتْرُكِ الْبَابَ مَفْتُوحًا (fausse tuile : تَتْرُكُ) ;
   - إِنَّ الطَّرِيقَ طَوِيلٌ (fausse tuile : الطَّرِيقُ).
4. **Écoute** : 10 phrases écrites dans les données, masquées et non comptées jusqu'à la phase audio J6 (décision du 03/11). Elles ne diffèrent jamais par une seule voyelle finale.

### E. Points pour l'utilisateur

1. **Format de l'examen** (c'est une question de jeu, pas de langue).
   - **Recommandation** : 3 épreuves comptées (lecture 10/12, décodage 40/50, ordre 4/5), plus l'écoute masquée.
   - **Alternative, plus courte** : décodage en 20 questions seulement, une par mot, en alternant racine, moule et sens (seuil 16/20).
2. **Aucune autre décision ne lui revient.** L'ajout de بِـ et عَنْ en 3.27 est une décision de prérequis que je prends : sans eux, ni le texte de 300 mots ni les verbes سَأَلَ عَنْ et بَعِيدٌ عَنْ ne sont possibles. Le cahier n'est pas contredit : 3.27 traite du génitif. À noter au §16.

## Pourquoi

- **Cahier** : le plan suit le §5.7 (l. 312-332 : أَكَلَ, سَأَلَ, مَدَّ, وَجَدَ, قَالَ, دَعَا, مَشَى, أَنْ, لَنْ, كَيْ, لَمْ, لَا de défense, impératif complet, إِنَّ et ses sœurs, كَانَ et ses sœurs). L'examen suit le §5.11 (20 mots à décoder, texte de 300 mots).
- **Décisions respectées** :
  - §16 du 05/11 : aucun schème pour les racines faibles, à hamza ou doublées ; c'est déjà codé dans `vocab.check_scheme` ;
  - §16 des 30/10 et 03/11 : pas de réponse libre, audio masqué ;
  - Intermédiaires 1 et 2 : Forge, noms divins, L/R, identifiants jamais affichés ;
  - Élémentaire 3 : قَالَ protégé, impératifs de mouvement employés seuls, ordre donné dans la consigne.
- **Prérequis** : chaque règle d'Élémentaire 3 et d'Intermédiaire 1 et 2 qui retenait une forme (-āt en complément, mots sans tanwīn, perte du ن, défense, بِـ / عَنْ) est levée dans la leçon qui l'enseigne, pas avant.
- **Données** : lemmes vérifiés dans la base, notamment >axa*a, sa>ala, >akala, qara>a, bada>a, ra>os, mad~a, rad~a, Ead~a, dal~a, $adado, >aHobabo, Eadad, wajada, waEada, waDaEa, waqaEa, w~azanu, yaSilu, jaA^'a, xaAfa, zaAda, qaAma, EaAda, zuro, ra'aA, daEaA, laqu, nasiYa, baqiYa, banaY`, m~a$a, bakato, >araAda, qabol, baEod, >an, lan, kaY, <in~, >an~, la`kin~, laEal~, ka>an~, layot, Ean, kaAna, >aSobaHa, Zal~a, taSiyru, zaAlat, yabiytu, >abN, >ax, >uxot, *uw, >aboyaD, >asowad, Ejl (forme V), ta>ax~ara, waqot, SawaAb.
- **Absents de la base comme verbes** : بَاعَ et نَامَ (on prend leur racine seule, R), وَقَفَ (seulement au passif, donc R) et أَسْرَعَ (verbe ; seul l'élatif existe, d'où تَعَجَّلَ à sa place).

## Confiance

- **Haute** : les règles de conjugaison des cinq classes de verbes faibles, les modes, les cas, les diptotes, les cinq noms, إِنَّ et كَانَ (grammaire classique sûre), et le traitement de la Forge.
- **Moyenne-haute** : les sens et les lemmes.
  - À confirmer en SQL : `zaAlat` (z y l) plutôt que `zaAla` (z w l) pour مَا زَالَ ; `laqu` et `m~a$a`.
  - Les noms d'action choisis quand un verbe en a plusieurs (عَوْدَةٌ, قِيَامٌ).
  - Les « R » n'ont pas de fréquence.
- **Moyenne** : l'emploi de رَأَى, أَكَلَ et جَاءَ. Ce sont des verbes très chargés de tournures coraniques ; je les garde à cause de leur fréquence, mais avec des listes ⚠ strictes. Le garde-fou reste la vraie protection.
- **Fréquences** : non lues ; l'ordre des listes est probable.
- **Suites ⚠** : citées de mémoire, la liste est incomplète.

## Résumé pour l'utilisateur

Le plan des leçons 3.22 à 3.32 est prêt : environ 75 mots nouveaux, les verbes « irréguliers » (à hamza, doublés, faibles), les cas, le subjonctif, le jussif et la défense, إِنَّ et كَانَ avec leurs sœurs ; « avec » (بِـ) et « de, au sujet de » (عَنْ) arrivent en 3.27. Une seule question t'attend : le format et les seuils de l'examen de la région 3 (recommandé : lecture 10/12, décodage 80 %, phrases à remettre en ordre 4/5 ; l'écoute reste masquée).

À enregistrer dans `/home/user/iqura/docs/relectures/decisions-intermediaire-3.md`.

Références :
- `/home/user/iqura/docs/CAHIER_DES_CHARGES.md` (§5.7 l. 312-332, §5.11 l. 428-436, §16)
- `/home/user/iqura/docs/relectures/decisions-intermediaire-1.md`, `decisions-intermediaire-2.md`, `decisions-elementaire-3.md`
- `/home/user/iqura/tools/build_content/vocab.py` (l. 171-209, `check_scheme`)
- `/home/user/iqura/tools/build_content/exams/examen-r2.json`
- `/home/user/iqura/tools/build_content/lessons/etape3/19-la-forme-x.json` (l. 99 : لَكِنَّ → لَٰكِنَّ)
- `/home/user/iqura/assets/content/iqura_content.db`
