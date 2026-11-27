# Décision — Plan de langue du niveau Intermédiaire 2 (leçons 3.11 à 3.21, « Les formes verbales »)

Question : pour chaque leçon de 3.11 à 3.21, donner l'objectif, la règle, les mots nouveaux, les phrases modèles et les pièges. Fixer aussi les racines admises dans la Forge, la notation des formes, l'assimilation du tāʾ en forme VIII, les dérivés de 3.20 et le passif de 3.21.

Stade : région 3, leçons 3.11 à 3.21 (Moulin des formes, Salle des copistes, Tour du guet ; maîtresse Rabāb).
- **Acquis** : régions 1 et 2, plus 3.1 à 3.10 (racine, schème فعل, فَاعِل / مَفْعُول, nom d'action, مَفْعَل / مِفْعَال, فَعِيل / فَعَّال, pluriels internes, أَفْعَلُ, nisba). Les 277 mots de `mots.json`.
- **Pas encore enseignés** : بِـ, فَـ, عَنْ.
- **Verbes connus**, tous de forme I : فَعَلَ, ou فَعِلَ (شَرِبَ, فَرِحَ, لَعِبَ, رَكِبَ, حَفِظَ, فَهِمَ, لَبِسَ, سَمِعَ, صَعِدَ). Aucun فَعُلَ n'est encore connu.

## Décision

### A. Méthode et limites

- **Lemmes** : vérifiés par recherche de texte dans `/home/user/iqura/assets/content/iqura_content.db`. Une entrée ressemble à `Eal~amaعَلَّمَElmVVII` : lemme, forme arabe, racine, nature, forme verbale (I à X).
  - Ce n'est pas du SQL : `vocab.validate` fait foi.
  - L = lemme du Corpus de même sens ; R = racine seule, sans fréquence (règle d'Élémentaire 2).
  - Je n'ai proposé aucun mot sans racine dans le Corpus.
- **Fréquences** : je n'ai pas pu les lire (champ binaire). Claude Code doit les vérifier en SQL. Il peut remplacer un mot par un lemme plus fréquent de la même forme, à deux conditions : racine saine, et respect des exclusions (B5).
- **Forme des lemmes du Corpus** : ce n'est pas toujours la forme du dictionnaire (`>udoxila` est au passif, `yataEal~amu` à l'inaccompli, avec ٱ). On ne les affiche jamais ; seul le champ `ar` est montré (décision 4 d'Intermédiaire 1).
- **Suites ⚠** : citées de mémoire, la liste est incomplète. Le garde-fou fait foi ; toute paire signalée est remplacée sans discussion.

### B. Principes du niveau

1. **Notation.**
   - Chiffre romain, puis le schème du passé et celui de l'inaccompli, puis le nom d'action. Exemple : « forme II — فَعَّلَ / يُفَعِّلُ — nom d'action تَفْعِيل ». Même règles de schème qu'en Intermédiaire 1 : pas de tanwīn, ة gardé.
   - **Le tableau du niveau** (ف = 1re lettre de la racine, ع = 2e, ل = 3e) :

     | Forme | Passé / inaccompli | Nom d'action | Participe actif / passif |
     | --- | --- | --- | --- |
     | II | فَعَّلَ / يُفَعِّلُ | تَفْعِيل | مُفَعِّل / مُفَعَّل |
     | III | فَاعَلَ / يُفَاعِلُ | مُفَاعَلَة, فِعَال | مُفَاعِل / مُفَاعَل |
     | IV | أَفْعَلَ / يُفْعِلُ | إِفْعَال | مُفْعِل / مُفْعَل |
     | V | تَفَعَّلَ / يَتَفَعَّلُ | تَفَعُّل | مُتَفَعِّل / — |
     | VI | تَفَاعَلَ / يَتَفَاعَلُ | تَفَاعُل | مُتَفَاعِل / — |
     | VII | انْفَعَلَ / يَنْفَعِلُ | انْفِعَال | مُنْفَعِل / — |
     | VIII | افْتَعَلَ / يَفْتَعِلُ | افْتِعَال | مُفْتَعِل / مُفْتَعَل |
     | X | اسْتَفْعَلَ / يَسْتَفْعِلُ | اسْتِفْعَال | مُسْتَفْعِل / مُسْتَفْعَل |

   - Les numéros sont une convention occidentale. En aperçu : الْمُجَرَّدُ, الْمَزِيدُ, « عَلَى وَزْنِ فَعَّلَ ». La forme IX est seulement mentionnée (« rare, non étudiée »).
2. **Alif de liaison (VII, VIII, X et leurs noms d'action)** : écrit sans voyelle partout dans le jeu (انْطَلَقَ, اسْتَخْرَجَ, schème انْفَعَلَ). C'est la convention d'Élémentaire 3 (اسْمٌ, اكْتُبْ). La translittération donne la lecture (« inṭalaqa »). Règle : « Cet alif se lit i en début de phrase ou après une pause, et disparaît après un mot lu sans pause (comme وَ) : وَانْطَلَقَ (wa-nṭalaqa). » Le hamza de la forme IV (أَ) se prononce toujours. La graphie اِنْفَعَلَ du tableau du cahier n'est qu'une graphie de document, pas une décision du §16.
3. **Règle clé, répétée de 3.12 à 3.20** : « Préfixe en u pour II, III, IV (يُعَلِّمُ) ; en a pour I et V à X. Le participe actif remplace le préfixe par مُ et met i avant la dernière lettre (مُعَلِّم) ; le passif met a (مُعَلَّم). » Les deux formes de 3.3 (مُسَافِرٌ, مُعَلِّمٌ) sont enfin expliquées.
4. **Forge des formes.**
   - Racine du Corpus à 3 lettres, sans و, ي ni ء, **non doublée**, chaque lettre visible.
   - **Elle ne forge que les verbes et dérivés de la liste vérifiée** : jamais de انْكَتَبَ ni de forme inventée. Un distracteur se dit « absent de notre dictionnaire ».
   - **En forme VIII, elle exclut les racines qui commencent par ت ث د ذ ز ص ض ط ظ** (assimilation).
   - **Pas de passif ni de مَفْعُول pour un verbe intransitif** : جَلَسَ, خَرَجَ, ذَهَبَ, رَجَعَ, صَعِدَ, فَرِحَ, les verbes en فَعُلَ, les formes V, VI, VII. Par prudence, pas non plus pour دَخَلَ, رَكِبَ, بَلَغَ, نَظَرَ.
5. **Exclusions (Forge, combat, générateurs).**
   - **Racines exclues de toute forme dérivée** : ن ز ل (نَزَّلَ, أَنْزَلَ, تَنْزِيل), ك ف ر, ش ر ك, غ ف ر, س ج د, ع ب د, س ب ح, ق د س, خ ل ق, ر ز ق.
   - **Formes exclues** : كَبَّرَ, تَكَبَّرَ, اسْتَكْبَرَ ; أَحْسَنَ, إِحْسَان ; صَدَّقَ, تَصَدَّقَ ; تَقَبَّلَ ; اسْتَعَاذَ ; طَهَّرَ ; تَبَارَكَ ; مُعَلَّمٌ (passif) ; مُرْسَلٌ, مُرْسَلُونَ ; رَسُولٌ.
   - Plus la liste des noms divins d'Intermédiaire 1 (B5), et الْأَكْرَمُ.
   - **Jamais de sujet divin**, et jamais de « nous » de majesté avec أَرْسَلَ, أَخْرَجَ, أَدْخَلَ, عَلَّمَ, فَرَّقَ, قَطَّعَ (أَرْسَلْنَا, أَخْرَجْنَا, etc. : dans le tableau seulement, jamais dans une phrase).
6. **Conjugaison des formes II à X.**
   - Exercées : هُوَ, هِيَ, هُمْ, أَنَا, au passé et à l'inaccompli.
   - Tableau complet à reconnaître. Impératifs en aperçu seulement (أَخْرِجْ ≠ اخْرُجْ).
7. **Le sens des formes est une tendance** : chaque leçon le dit et donne un contre-exemple (cahier §5).
8. **Schème sur la fiche.** Vérifié comme le veut le §16 du 05/11/2026. Pour les formes VIII assimilées (اضْطَرَبَ, ادَّخَرَ, اصْطَبَرَ, اطَّلَعَ, ازْدَادَ), remplacer ف ع ل ne redonne pas le mot : **aucun schème sur leur fiche**, et la règle est enseignée dans la leçon.
9. **Règles maintenues.** Pas de بِـ, فَـ, عَنْ. Les mots sans tanwīn restent au nominatif (donc ni دَنَانِيرُ ni دَرَاهِمُ en complément). La règle des 95 % de mots connus reste absolue.

### C. Plan par leçon

Format des mots : forme | sens | L/R | inaccompli | nom d'action | schème.

**3.11 La forme I (Moulin des formes)**
- **Objectif** : reconnaître فَعَلَ, فَعِلَ, فَعُلَ et la voyelle de l'inaccompli.
- **Règle** (2 phrases) : « فَعَلَ fait يَفْعُلُ, يَفْعِلُ ou يَفْعَلُ (souvent a si la 2e ou la 3e lettre est ء ه ع ح غ خ) ; فَعِلَ fait le plus souvent يَفْعَلُ. فَعُلَ dit une qualité ou un état, fait toujours يَفْعُلُ et n'a jamais de complément direct. »
- **Mots (8)** :
  - عَلِمَ | savoir, apprendre (une chose) | L Ealima | يَعْلَمُ | عِلْمٌ (L) | فَعِلَ
  - عَمِلَ | faire, travailler | L Eamila | يَعْمَلُ | عَمَلٌ (L) | فَعِلَ
  - نَظَرَ | regarder | L n~aZara (à confirmer) | يَنْظُرُ | نَظَرٌ (L) | فَعَلَ
  - كَبُرَ | devenir grand, grandir (chose, affaire) | L kabura | يَكْبُرُ | pas de champ (noms d'action ambigus) | فَعُلَ
  - كَثُرَ | être ou devenir nombreux, abonder | L kavura | يَكْثُرُ | كَثْرَةٌ (L) | فَعُلَ
  - ثَقُلَ | être ou devenir lourd | L vaqula | يَثْقُلُ | ثِقَلٌ (R) | فَعُلَ
  - بَعُدَ | être loin | L baEuda | يَبْعُدُ | بُعْدٌ (L) | فَعُلَ
  - حَسُنَ | être beau, être bon | L Hasuna | يَحْسُنُ | حُسْنٌ (L) | فَعُلَ
- **Avec les mots connus** : فَعُلَ ↔ adjectif (كَثِيرٌ / كَثُرَ, ثَقِيلٌ / ثَقُلَ, بَعِيدٌ / بَعُدَ, كَبِيرٌ / كَبُرَ). Contre-exemples de la tendance : دَخَلَ يَدْخُلُ, رَجَعَ يَرْجِعُ, طَلَبَ يَطْلُبُ. On ne donne pas d'exemple de فَعِلَ / يَفْعِلُ : le plus courant, حَسِبَ, a deux lectures de son inaccompli.
- **Modèles** :
  - عَلِمَ الطَّالِبُ الْجَوَابَ. « L'étudiant a su la réponse. »
  - يَعْمَلُ النَّجَّارُ فِي الصَّبَاحِ. « Le menuisier travaille le matin. »
  - نَظَرَ الطِّفْلُ إِلَى الصَّقْرِ. « L'enfant a regardé le faucon. »
  - ثَقُلَ الصُّنْدُوقُ. « Le coffre est devenu lourd. »
  - كَبُرَتِ الْمَدِينَةُ. « La ville s'est agrandie. »
- **Pièges** :
  - كَبُرَ (devenir grand) ≠ كَبِرَ يَكْبَرُ (vieillir, en aperçu) : pas de كَبُرَ avec une personne.
  - ⚠ كَبُرَ + عَلَى, « كَبُرَ مَقْتًا », « كَبُرَتْ كَلِمَةً ».
  - ⚠ عَلِمَ / يَعْلَمُ avec un sujet divin, + مَا, + الْغَيْب ; « لَا يَعْلَمُونَ ».
  - ⚠ عَمِلَ + صَالِحًا / الصَّالِحَاتِ / مَا.
  - ⚠ نَظَرَ jamais avec الْجَبَل, الْجِبَال, السَّمَاء, النُّجُوم, طَعَام ; pas d'impératif انْظُرْ.
  - ⚠ « ثَقُلَتْ مَوَازِينُهُ », « بَعُدَتْ عَلَيْهِمُ », « بُعْدًا », « حَسُنَتْ مُسْتَقَرًّا » ; jamais قَلَّ et كَثُرَ ensemble.

**3.12 Forme II فَعَّلَ / يُفَعِّلُ**
- **Règle** : « La shadda sur la 2e lettre rend souvent l'action plus forte (قَطَعَ → قَطَّعَ) ou fait faire l'action (عَلِمَ « savoir » → عَلَّمَ « enseigner »). L'inaccompli a u, puis i : يُعَلِّمُ. »
- **Mots (7)**, tous de schème فَعَّلَ :
  - عَلَّمَ | enseigner | L Eal~ama | يُعَلِّمُ | تَعْلِيمٌ (R)
  - فَهَّمَ | faire comprendre, expliquer | L fah~ama | يُفَهِّمُ | تَفْهِيمٌ (R)
  - قَطَّعَ | couper en morceaux | L qaT~aEa | يُقَطِّعُ | تَقْطِيعٌ (R)
  - فَرَّقَ | séparer, disperser | L far~aqa | يُفَرِّقُ | تَفْرِيقٌ (L)
  - قَدَّمَ | présenter, offrir ; mettre devant | L qad~ama | يُقَدِّمُ | تَقْدِيمٌ (R)
  - حَدَّثَ | raconter à, parler à (quelqu'un) | L Had~ava | يُحَدِّثُ | تَحْدِيثٌ (R)
  - كَلَّمَ | adresser la parole à | L kal~ama | يُكَلِّمُ | تَكْلِيمٌ (L)
- **Contre-exemples** : كَلَّمَ et حَدَّثَ n'intensifient aucun verbe connu. مُعَلِّمٌ, déjà connu, est le participe de عَلَّمَ (renvoi à 3.20).
- **Modèles** :
  - عَلَّمَتْ رَبَابُ الطُّلَّابَ الْكِتَابَةَ. « Rabāb a enseigné l'écriture aux étudiants. » (deux compléments, en aperçu)
  - قَطَّعَ الطَّبَّاخُ اللَّحْمَ. « Le cuisinier a coupé la viande en morceaux. »
  - قَدَّمَ الْخَبَّازُ الْخُبْزَ لِلضُّيُوفِ. « Le boulanger a offert le pain aux invités. »
  - يُكَلِّمُ الشَّيْخُ الْمُسَافِرِينَ. « Le vieil homme parle aux voyageurs. »
- **Pièges** :
  - يُعَلِّمُ (u) ≠ يَعْلَمُ (a).
  - Sans voyelles, عَلَّمَ et عَلِمَ s'écrivent pareil : on vocalise toujours.
  - Pas de doublée en Forge (pas de جَدَّدَ).
  - ⚠ عَلَّمَ + الْإِنْسَان, الْقُرْآن, بِالْقَلَم, « عَلَّمَنِي », « عُلِّمْنَا ».
  - ⚠ قَطَّعَ / قَدَّمَ avec يَد / أَيْدِي ; « قَدَّمْتُمْ ».
  - ⚠ فَرَّقَ + بَيْنَ, دِين ; « فَفَهَّمْنَاهَا ».
  - ⚠ « تُحَدِّثُ أَخْبَارَهَا » ; pas d'impératif حَدِّثْ.
  - ⚠ « كَلَّمَ اللَّهُ » ; يُكَلِّمُ / تُكَلِّمُ + النَّاس ; « أُكَلِّمَ الْيَوْمَ ».

**3.13 Forme III فَاعَلَ / يُفَاعِلُ**
- **Règle** : « Un ā après la 1re lettre dit souvent une action faite avec ou envers quelqu'un : جَالَسَهُ « il lui a tenu compagnie ». Nom d'action : مُفَاعَلَة, parfois فِعَال. »
- **Mots (8)**, tous de schème فَاعَلَ :
  - سَافَرَ | voyager | R sfr | يُسَافِرُ | مُسَافَرَةٌ (R)
  - جَالَسَ | tenir compagnie à, s'asseoir avec | R jls | يُجَالِسُ | مُجَالَسَةٌ (R)
  - كَاتَبَ | correspondre avec, écrire à | R ktb (le lemme du Corpus a un sens juridique) | يُكَاتِبُ | مُكَاتَبَةٌ (R)
  - سَاعَدَ | aider | R sEd | يُسَاعِدُ | مُسَاعَدَةٌ (R)
  - فَارَقَ | quitter, se séparer de | L faAraqa | يُفَارِقُ | فِرَاقٌ (L, du schème فِعَال)
  - سَابَقَ | faire la course avec | L saAbaqa | يُسَابِقُ | مُسَابَقَةٌ (R)
  - صَاحَبَ | accompagner | L SaAHaba | يُصَاحِبُ | مُصَاحَبَةٌ (R)
  - قَابَلَ | rencontrer, faire face à | R qbl | يُقَابِلُ | مُقَابَلَةٌ (R)
- **Contre-exemple** : سَافَرَ, on voyage sans partenaire. مُسَافِرٌ, déjà connu, est expliqué. Pour « voyage », on garde سَفَرٌ.
- **Modèles** :
  - جَالَسَ بَاسِمٌ الشَّيْخَ فِي الْمَجْلِسِ. « Bāsim a tenu compagnie au vieil homme dans l'assemblée. »
  - سَافَرَتِ الْقَافِلَةُ فِي الصَّبَاحِ. « La caravane a voyagé le matin. »
  - سَاعَدَ الْحَمَّالُ التَّاجِرَ. « Le porteur a aidé le marchand. »
  - كَاتَبَ الْكَاتِبُ صَدِيقَهُ. « Le scribe a correspondu avec son ami. »
- **Pièges** :
  - La personne est complément direct : pas de مَعَ (on ne dit pas « جَالَسَ مَعَ »).
  - يُسَافِرُ (u) ≠ يَسْكُنُ.
  - فَاعَلَ ≠ فَاعِل (participe de la forme I).
  - ⚠ « فَكَاتِبُوهُمْ », « فَارِقُوهُنَّ », فِرَاق + بَيْن, « سَابِقُوا إِلَى », « تُصَاحِبْنِي ».

**3.14 Forme IV أَفْعَلَ / يُفْعِلُ**
- **Règle** : « أَ devant la racine, sukūn sur la 1re lettre : souvent « faire faire » (خَرَجَ « sortir » → أَخْرَجَ « faire sortir »). L'inaccompli a u, puis i : يُخْرِجُ. Nom d'action : إِفْعَال. »
- **Mots (8)**, tous de schème أَفْعَلَ :
  - أَخْرَجَ | faire sortir, sortir (quelque chose) | L >axoraja | يُخْرِجُ | إِخْرَاجٌ (L)
  - أَدْخَلَ | faire entrer | L >udoxila (lemme au passif, à confirmer ; sinon R dxl) | يُدْخِلُ | إِدْخَالٌ (R)
  - أَجْلَسَ | faire asseoir | R jls | يُجْلِسُ | إِجْلَاسٌ (R)
  - أَطْعَمَ | nourrir, donner à manger | L >aToEama | يُطْعِمُ | إِطْعَامٌ (L)
  - أَرْسَلَ | envoyer | L >arosala | يُرْسِلُ | إِرْسَالٌ (R)
  - أَكْرَمَ | traiter avec honneur (un hôte) | L >akorama | يُكْرِمُ | إِكْرَامٌ (L)
  - أَصْلَحَ | réparer, remettre en état | L >aSolaHa | يُصْلِحُ | إِصْلَاحٌ (L)
  - أَعْجَبَ | plaire à | L >aEojaba | يُعْجِبُ | إِعْجَابٌ (R)
- **Contre-exemple** : أَرْسَلَ ne correspond à aucun verbe I connu. Dans أَعْجَبَ, le sens va à l'inverse du français : la chose est sujet, la personne complément.
- **Modèles** :
  - خَرَجَ الْجَمَلُ. / أَخْرَجَ بَاسِمٌ الْجَمَلَ. « Le chameau est sorti. / Bāsim a fait sortir le chameau. »
  - أَجْلَسَ الشَّيْخُ الضَّيْفَ فِي الْمَجْلِسِ. « Le vieil homme a fait asseoir l'invité dans l'assemblée. »
  - أَرْسَلَ التَّاجِرُ رِسَالَةً. « Le marchand a envoyé une lettre. »
  - أَصْلَحَ الْحَدَّادُ الْمِفْتَاحَ. « Le forgeron a réparé la clé. »
  - أَعْجَبَ الْقَصْرُ الْمُسَافِرِينَ. « Le palais a plu aux voyageurs. »
- **Pièges** :
  - Trois moules à ne pas confondre : أَكْرَمَ (il a honoré) ≠ أَكْبَرُ (élatif) ≠ أَكْتُبُ (j'écris).
  - يُخْرِجُ ≠ يَخْرُجُ.
  - ⚠ أَخْرَجَ + الْأَرْض, مَاء, مِنْهَا, ثَمَرَات ; « أَخْرَجْنَا ».
  - ⚠ « أَدْخِلْنِي », أَدْخَلَ + جَنَّة.
  - ⚠ « أَطْعَمَهُمْ », « يُطْعِمُنِي », إِطْعَام + مِسْكِين / عَشَرَة.
  - ⚠ أَرْسَلَ seulement avec un sujet humain et رِسَالَة ou une personne : jamais رَسُول, الرِّيَاح, « أَرْسَلْنَا ».
  - ⚠ « أَكْرَمَنِ », « أَكْرِمِي », الْمُكْرَمِينَ, الْأَكْرَمُ ; إِكْرَام jamais avec الْجَلَال.
  - ⚠ أَصْلَحَ + بَيْنَ ; أَعْجَبَ + كَثْرَة ou حُسْن.

**3.15 Forme V تَفَعَّلَ / يَتَفَعَّلُ** (Salle des copistes)
- **Règle** : « تَـ + forme II : souvent l'effet de II sur le sujet lui-même (عَلَّمَ « enseigner » → تَعَلَّمَ « apprendre »). Inaccompli en a : يَتَعَلَّمُ ; nom d'action تَفَعُّل : تَعَلُّمٌ. »
- **Mots (7)**, tous de schème تَفَعَّلَ :
  - تَعَلَّمَ | apprendre | L taEal~ama | يَتَعَلَّمُ | تَعَلُّمٌ (R)
  - تَكَلَّمَ | parler | L takal~ama | يَتَكَلَّمُ | تَكَلُّمٌ (R)
  - تَقَدَّمَ | s'avancer | L taqad~ama | يَتَقَدَّمُ | تَقَدُّمٌ (R)
  - تَفَرَّقَ | se disperser | L tafar~aqa | يَتَفَرَّقُ | تَفَرُّقٌ (R)
  - تَحَدَّثَ | parler, converser | R Hdv | يَتَحَدَّثُ | تَحَدُّثٌ (R)
  - تَذَكَّرَ | se souvenir | L ta*ak~ara | يَتَذَكَّرُ | تَذَكُّرٌ (R)
  - تَعَجَّبَ | s'étonner | R Ejb | يَتَعَجَّبُ | تَعَجُّبٌ (R)
- **Contre-exemple** : تَعَجَّبَ, aucune forme II n'est connue.
- **Modèles** :
  - تَعَلَّمَ الطُّلَّابُ الْكِتَابَةَ. « Les étudiants ont appris l'écriture. »
  - تَكَلَّمَ الشَّيْخُ فِي الْمَجْلِسِ. « Le vieil homme a parlé dans l'assemblée. »
  - تَقَدَّمَتِ الْقَافِلَةُ. « La caravane s'est avancée. »
  - تَفَرَّقَ الضُّيُوفُ فِي الْمَسَاءِ. « Les invités se sont dispersés le soir. »
- **Pièges** :
  - Le تَـ de la forme ≠ le préfixe تَـ (تَكْتُبُ).
  - L'inaccompli garde a, a, a : يَتَفَعَّلُ, pas de i.
  - ⚠ « يَتَعَلَّمُونَ مَا », تَعَلَّمَ + مِنْهُمَا ; « يَتَكَلَّمُونَ إِلَّا » ; « مَا تَقَدَّمَ مِنْ » ; « يَتَقَدَّمَ أَوْ ».
  - ⚠ « وَلَا تَفَرَّقُوا », « يَتَفَرَّقُونَ » ; « يَتَذَكَّرُ الْإِنْسَانُ », « يَتَذَكَّرُ أُولُو ».

**3.16 Forme VI تَفَاعَلَ / يَتَفَاعَلُ**
- **Règle** : « تَـ + forme III : souvent une action réciproque, avec un sujet pluriel ou duel (تَكَاتَبَ الصَّدِيقَانِ). Parfois : faire semblant (تَمَارَضَ « faire le malade »). Nom d'action تَفَاعُل. »
- **Mots (8)**, tous de schème تَفَاعَلَ :
  - تَكَاتَبَ | s'écrire l'un à l'autre | R ktb | يَتَكَاتَبُ | تَكَاتُبٌ
  - تَعَارَفَ | faire connaissance (mutuellement) | L taEaArafa | يَتَعَارَفُ | تَعَارُفٌ
  - تَقَاسَمَ | se partager | L taqaAsama | يَتَقَاسَمُ | تَقَاسُمٌ
  - تَسَابَقَ | faire la course ensemble | R sbq | يَتَسَابَقُ | تَسَابُقٌ
  - تَنَازَعَ | se disputer | L tanaAzaEa | يَتَنَازَعُ | تَنَازُعٌ
  - تَشَابَهَ | se ressembler | L ta$aAbaha | يَتَشَابَهُ | تَشَابُهٌ
  - تَصَافَحَ | se serrer la main | R SfH | يَتَصَافَحُ | تَصَافُحٌ
  - تَمَارَضَ | feindre d'être malade | R mrD | يَتَمَارَضُ | تَمَارُضٌ
  - Tous les noms d'action sont « R ».
- **Modèles** :
  - تَكَاتَبَ الصَّدِيقَانِ. « Les deux amis se sont écrit. »
  - تَقَاسَمَ الْأَطْفَالُ التَّمْرَ. « Les enfants se sont partagé les dattes. »
  - تَعَارَفَ الْمُسَافِرُونَ فِي الْقَافِلَةِ. « Les voyageurs ont fait connaissance dans la caravane. »
  - تَشَابَهَتِ الْكَلِمَتَانِ. « Les deux mots se ressemblent. »
- **Pièges** :
  - Verbe en tête au singulier, même pour une action réciproque (règle de 2.23).
  - Pas de complément direct de personne.
  - تَفَاعَلَ ≠ تَفَعَّلَ : on compte le ā.
  - ⚠ « لِتَعَارَفُوا », « يَتَعَارَفُونَ بَيْنَهُمْ » ; « تَقَاسَمُوا بِاللَّهِ ».
  - ⚠ « فَإِنْ تَنَازَعْتُمْ », « وَلَا تَنَازَعُوا », « يَتَنَازَعُونَ فِيهَا ».
  - ⚠ « تَشَابَهَ عَلَيْنَا », « تَشَابَهَتْ قُلُوبُهُمْ », مُتَشَابِه.

**3.17 Forme VII انْفَعَلَ / يَنْفَعِلُ**
- **Règle** : « انْـ devant la racine : souvent ce qui arrive au complément du verbe I, sans dire qui agit (فَتَحَ الْبَابَ → انْفَتَحَ الْبَابُ « la porte s'est ouverte »). Jamais de complément direct ; nom d'action انْفِعَال. »
- **Mots (6)**, tous de schème انْفَعَلَ ; tous les noms d'action sont « R » :
  - انْفَتَحَ | s'ouvrir | R ftH | يَنْفَتِحُ | انْفِتَاحٌ
  - انْقَطَعَ | se rompre, s'interrompre | R qTE | يَنْقَطِعُ | انْقِطَاعٌ
  - انْقَسَمَ | se diviser | R qsm | يَنْقَسِمُ | انْقِسَامٌ
  - انْطَلَقَ | partir, se mettre en route | L {nTalaqa | يَنْطَلِقُ | انْطِلَاقٌ
  - انْصَرَفَ | s'en aller, se retirer | L {nSarafa | يَنْصَرِفُ | انْصِرَافٌ
  - انْقَلَبَ | se retourner, se renverser | L {nqalaba | يَنْقَلِبُ | انْقِلَابٌ
- **Contre-exemple** : انْطَلَقَ n'est le passif d'aucun verbe connu. La forme VII n'existe pas pour tous les verbes (pas de انْكَتَبَ).
- **Modèles** :
  - فَتَحَ الْحَارِسُ الْبَابَ. / انْفَتَحَ الْبَابُ. « Le gardien a ouvert la porte. / La porte s'est ouverte. »
  - انْطَلَقَتِ الْقَافِلَةُ فِي الصَّبَاحِ. « La caravane est partie le matin. »
  - انْقَطَعَ الْحَبْلُ. « La corde s'est rompue. »
  - انْقَلَبَ الصَّحْنُ. « Le plat s'est renversé. »
- **Pièges** :
  - L'alif de liaison (B2).
  - Le ن de انْـ n'appartient pas à la racine (ط ل ق, pas ن ط ل).
  - **انْفَجَرَ est retiré** : l'eau qui jaillit d'un rocher rappelle un récit coranique.
  - ⚠ « فَانْطَلَقَا », « انْطَلِقُوا », انْطَلَقَ + الْمَلَأ ; « ثُمَّ انْصَرَفُوا » (ثُمَّ est connu : jamais).
  - ⚠ انْقَلَبَ jamais suivi de إِلَى ou عَلَى.

**3.18 Forme VIII افْتَعَلَ / يَفْتَعِلُ**
- **Règle 1** : « Un ت se glisse après la 1re lettre : جَمَعَ → اجْتَمَعَ « se réunir ». Nom d'action افْتِعَال. »
- **Règle 2** : « Après ص ض ط ظ, ce ت devient ط (اصْطَبَرَ) ; après د ذ ز, il devient د (ازْدَادَ, ادَّخَرَ). »
- **Mots (8)** :
  - اجْتَمَعَ | se réunir | L {jotamaEa | يَجْتَمِعُ | اجْتِمَاعٌ (R) | افْتَعَلَ
  - اسْتَمَعَ | écouter attentivement | L {sotamaEa | يَسْتَمِعُ | اسْتِمَاعٌ (R) | افْتَعَلَ
  - انْتَظَرَ | attendre | L {ntaZara | يَنْتَظِرُ | انْتِظَارٌ (R) | افْتَعَلَ
  - اقْتَرَبَ | s'approcher | L {qotaraba | يَقْتَرِبُ | اقْتِرَابٌ (R) | افْتَعَلَ
  - اعْتَرَفَ | reconnaître, avouer | L {Eotarafa | يَعْتَرِفُ | اعْتِرَافٌ (R) | افْتَعَلَ
  - اخْتَلَفَ | différer ; être en désaccord | L {xotalafa | يَخْتَلِفُ | اخْتِلَافٌ (L) | افْتَعَلَ
  - اضْطَرَبَ | s'agiter, trembler | R Drb | يَضْطَرِبُ | اضْطِرَابٌ (R) | pas de schème (B8)
  - ادَّخَرَ | mettre en réserve | L {d~axara | يَدَّخِرُ | ادِّخَارٌ (R) | pas de schème (B8)
- **Exemples sûrs d'assimilation**, tous du Corpus sauf اضْطَرَبَ (R) :
  - ط : اصْطَبَرَ (L), اضْطَرَبَ (R), اطَّلَعَ (L, fusion طّ) ;
  - د : ازْدَادَ (L, racine faible : aperçu, chapitre C), ادَّخَرَ (L).
  - Ces mots sont lus, jamais forgés.
  - اتَّصَلَ (و) est renvoyé au chapitre C.
- **Modèles** :
  - اجْتَمَعَ الطُّلَّابُ فِي الْمَدْرَسَةِ. « Les étudiants se sont réunis à l'école. »
  - انْتَظَرَ بَاسِمٌ صَدِيقَهُ عِنْدَ الْبَابِ. « Bāsim a attendu son ami à la porte. »
  - اقْتَرَبَتِ الْقَافِلَةُ مِنَ الْمَدِينَةِ. « La caravane s'est approchée de la ville. »
  - ادَّخَرَ الْفَقِيرُ دِرْهَمًا. « Le pauvre a mis un dirham de côté. »
- **Pièges** :
  - اسْتَمَعَ est une forme VIII (س م ع) qui ressemble à une forme X : on compte les lettres.
  - Dans انْتَظَرَ, le ن est de la racine (ن ظ ر) : ne pas le confondre avec انْفَعَلَ.
  - ⚠ « اجْتَمَعَتِ الْإِنْسُ », « اجْتَمَعُوا لَهُ ».
  - ⚠ « اسْتَمَعَ نَفَرٌ », « فَاسْتَمِعُوا », « يَسْتَمِعُونَ إِلَيْكَ / الْقَوْلَ », يَسْتَمِعِ + الْآنَ.
  - ⚠ « انْتَظِرُوا », « مُنْتَظِرُونَ » ; اقْتَرَبَ + السَّاعَة, الْوَعْد, لِلنَّاسِ.
  - ⚠ اعْتَرَفَ + بِذَنْب ; اخْتِلَاف + اللَّيْل / النَّهَار / أَلْسِنَة ; « اخْتَلَفُوا فِيهِ ».
  - ⚠ ادَّخَرَ + بُيُوت.

**3.19 Forme X اسْتَفْعَلَ / يَسْتَفْعِلُ** (Tour du guet)
- **Règle** : « اسْتَـ devant la racine : souvent demander quelque chose (اسْتَطْعَمَ « demander à manger ») ou juger que quelque chose est tel (اسْتَكْثَرَ « trouver que c'est beaucoup »). Nom d'action اسْتِفْعَال. »
- **Mots (8)**, tous de schème اسْتَفْعَلَ ; tous les noms d'action sont « R » :
  - اسْتَخْرَجَ | extraire | L {sotaxoraja | يَسْتَخْرِجُ | اسْتِخْرَاجٌ
  - اسْتَطْعَمَ | demander à manger | L {sotaToEama | يَسْتَطْعِمُ | اسْتِطْعَامٌ
  - اسْتَفْهَمَ | demander une explication | R fhm | يَسْتَفْهِمُ | اسْتِفْهَامٌ
  - اسْتَنْسَخَ | faire copier | L {sotanosaxa | يَسْتَنْسِخُ | اسْتِنْسَاخٌ
  - اسْتَكْثَرَ | trouver que c'est beaucoup | L {sotakovara | يَسْتَكْثِرُ | اسْتِكْثَارٌ
  - اسْتَصْغَرَ | trouver petit | R Sgr | يَسْتَصْغِرُ | اسْتِصْغَارٌ
  - اسْتَحْسَنَ | trouver beau, approuver | R Hsn | يَسْتَحْسِنُ | اسْتِحْسَانٌ
  - اسْتَقْبَلَ | aller au-devant de, accueillir | R qbl (le participe est dans le Corpus) | يَسْتَقْبِلُ | اسْتِقْبَالٌ
- **Contre-exemple** : اسْتَقْبَلَ ne dit ni une demande ni un jugement.
- **Modèles** :
  - اسْتَخْرَجَ الرِّجَالُ الْمَاءَ مِنَ الْبِئْرِ. « Les hommes ont tiré l'eau du puits. »
  - اسْتَكْثَرَ الْمُسَافِرُ الثَّمَنَ. « Le voyageur a trouvé le prix trop élevé. »
  - اسْتَحْسَنَتْ سَلْمَى الْقَمِيصَ. « Salmā a trouvé la tunique belle. »
  - اسْتَقْبَلَ الشَّيْخُ الضُّيُوفَ. « Le vieil homme a accueilli les invités. »
  - اسْتَنْسَخَ التَّاجِرُ الْكِتَابَ. « Le marchand a fait copier le livre. »
- **Pièges** :
  - اسْتَمَعَ (VIII) et اسْمٌ ne sont pas des formes X.
  - Pas de sens juridique pour اسْتِحْسَانٌ : seulement « fait de trouver beau ».
  - ⚠ اسْتَخْرَجَ + كَنْز ou حِلْيَة ; « فَاسْتَخْرَجَهَا ».
  - ⚠ اسْتَطْعَمَ + أَهْل ; « تَسْتَكْثِرُ », « اسْتَكْثَرْتُمْ », « لَاسْتَكْثَرْتُ ».
  - ⚠ « نَسْتَنْسِخُ مَا ».

**3.20 Participes et noms d'action des formes II à X**
- **Règle** : « Participe : on remplace le préfixe de l'inaccompli par مُ ; i avant la dernière lettre = celui qui fait (مُعَلِّم), a = ce qui est fait (مُقَطَّع). Le nom d'action suit le moule de sa forme (B1). »
- **Exemples sûrs par forme** (actif / passif / nom d'action) :

  | Forme | Actif | Passif | Nom d'action |
  | --- | --- | --- | --- |
  | II | مُعَلِّمٌ | مُقَطَّعٌ | تَعْلِيمٌ, تَفْرِيقٌ (L) |
  | III | مُسَافِرٌ, مُسَاعِدٌ | — | مُسَاعَدَةٌ, فِرَاقٌ |
  | IV | مُرْسِلٌ (L), مُخْرِجٌ (L) | — | إِخْرَاجٌ, إِرْسَالٌ |
  | V | مُتَعَلِّمٌ, مُتَفَرِّقٌ (L) | — | تَعَلُّمٌ |
  | VI | مُتَسَابِقٌ | — | تَعَارُفٌ |
  | VII | مُنْطَلِقٌ, مُنْقَطِعٌ | — | انْطِلَاقٌ |
  | VIII | مُسْتَمِعٌ (L), مُخْتَلِفٌ (L) | مُنْتَظَرٌ | اجْتِمَاعٌ, انْتِظَارٌ |
  | X | مُسْتَقْبِلٌ | مُسْتَحْسَنٌ | اسْتِخْرَاجٌ, اسْتِفْهَامٌ |

- **Mots (8)** :
  - مُتَعَلِّمٌ | apprenant | R Elm | مُتَفَعِّل
  - مُسَاعِدٌ | qui aide | R sEd | مُفَاعِل
  - مُرْسِلٌ | expéditeur | L murosil | مُفْعِل
  - مُتَفَرِّقٌ | dispersé, épars | L | مُتَفَعِّل
  - مُسْتَمِعٌ | auditeur | L | مُفْتَعِل
  - مُخْتَلِفٌ | différent | L | مُفْتَعِل
  - مُقَطَّعٌ | coupé en morceaux | R qTE | مُفَعَّل
  - اسْتِفْهَامٌ | interrogation | R fhm | اسْتِفْعَال ; en aperçu : أَدَوَاتُ الِاسْتِفْهَامِ = هَلْ, مَا, مَنْ, أَيْنَ.
- **Modèles** :
  - الْمُتَعَلِّمُ فِي الْمَجْلِسِ. « L'apprenant est dans l'assemblée. »
  - مُرْسِلُ الرِّسَالَةِ تَاجِرٌ. « L'expéditeur de la lettre est un marchand. »
  - اللَّحْمُ مُقَطَّعٌ. « La viande est coupée en morceaux. »
  - هَلْ أَدَاةُ اسْتِفْهَامٍ. « هَلْ est un mot interrogatif. »
- **Pièges** :
  - مَفْعُول (forme I) ≠ مُفْعَل (forme IV) ; مُفْعِل ≠ مُفَعِّل.
  - Sans voyelles, actif et passif s'écrivent pareil.
  - Pas de passif aux formes V, VI, VII dans les exercices.
  - ⚠ jamais مُعَلَّمٌ, مُرْسَل(ُونَ) ; مُرْسِل + النَّاقَة ou هَدِيَّة.
  - ⚠ مُتَفَرِّق + أَبْوَاب / أَرْبَاب ; « مُسْتَمِعُونَ », « مُسْتَمِعُهُمْ ».
  - ⚠ مُخْتَلِف + أَلْوَان, « قَوْلٍ مُخْتَلِفٍ », « مُخْتَلِفِينَ » ; « مُخْرِجٌ مَا ».

**3.21 La voix passive**
- **Règle** : « Au passif, on ne dit pas qui agit : le complément devient sujet, en u. Passé فُعِلَ (u-i) : فُتِحَ الْبَابُ ; inaccompli يُفْعَلُ (u-a) : يُفْتَحُ الْبَابُ. »
- **Exercé** : هُوَ / هِيَ, verbe en tête, sujet nom ; pluriel de choses au féminin singulier.
- **Verbes admis** : كَتَبَ, فَتَحَ, حَمَلَ, تَرَكَ, طَلَبَ, جَمَعَ, عَرَفَ, حَفِظَ, فَهِمَ, سَمِعَ, زَرَعَ, صَنَعَ, طَرَقَ, دَرَسَ, شَرِبَ, لَبِسَ, عَلِمَ, عَمِلَ.
- **Aperçu, dans un tableau seulement** :
  - II : قُدِّمَ / يُقَدَّمُ ;
  - IV : أُدْخِلَ / يُدْخَلُ ;
  - X : اسْتُخْرِجَ / يُسْتَخْرَجُ.
  - Remarque : يُسْمَعُ peut venir de سَمِعَ ou de أَسْمَعَ ; c'est le contexte qui décide.
- **Mots (6)** :
  - مَجْهُولٌ | inconnu | R jhl | مَفْعُول
  - مَعْلُومٌ | connu, su | L m~aEoluwm | مَفْعُول
  - مَصْنُوعٌ | fabriqué | R SnE | مَفْعُول
  - مَزْرُوعٌ | semé, cultivé | R zrE | مَفْعُول
  - مَفْهُومٌ | compris | R fhm | مَفْعُول
  - مَطْلُوبٌ | demandé, recherché | L maToluwb | مَفْعُول
  - Termes en aperçu : الْمَبْنِيُّ لِلْمَجْهُولِ / لِلْمَعْلُومِ, نَائِبُ الْفَاعِلِ.
- **Modèles** :
  - كُتِبَتِ الرِّسَالَةُ فِي الصَّبَاحِ. « La lettre a été écrite le matin. »
  - فُتِحَ الصُّنْدُوقُ. « Le coffre a été ouvert. »
  - تُزْرَعُ الْأَزْهَارُ فِي الْحَدِيقَةِ. « Les fleurs sont semées dans le jardin. »
  - يُصْنَعُ الْخُبْزُ فِي الصَّبَاحِ. « Le pain est fait le matin. »
  - قُدِّمَ الطَّعَامُ لِلضُّيُوفِ. « Le repas a été servi aux invités. » (aperçu de la forme II)
- **Pièges** :
  - يَفْهَمُ ≠ يُفْهَمُ, كَتَبَ ≠ كُتِبَ ≠ كُتُبٌ : on vocalise toujours.
  - **Jamais d'agent avec مِنْ قِبَلِ** : c'est un calque moderne.
  - Pas de passif d'un verbe intransitif (B4).
  - ⚠ كُتِبَ + عَلَيْ… (jamais) ; فُتِحَ / تُفَتَّحُ + أَبْوَاب, السَّمَاء.
  - ⚠ حُمِلَ + الْأَرْض, الْجِبَال, « تُحْمَلُونَ » ; جُمِعَ + الشَّمْس, السَّحَرَة.
  - ⚠ « يُتْرَكَ », « يُتْرَكُوا » ; « يُعْرَفُ الْمُجْرِمُونَ » ; « لِتُصْنَعَ ».
  - ⚠ قُطِّعَتْ + ثِيَاب ; أُدْخِلَ + الَّذِينَ ou نَار ; « تُخْرَجُونَ », « أُخْرِجُوا ».
  - ⚠ jamais الطَّالِبُ وَالْمَطْلُوبُ ; مَعْلُوم jamais avec كِتَاب, حَقّ, يَوْم, مَقَام, أَشْهُر.

## Pourquoi

- **Conformité** : le plan suit le cahier §5 (tableau des leçons 3.11 à 3.21 ; le sens d'une forme est une tendance, avec des contre-exemples) et le §3 (pas de sujet divin, exclusions, aucune suite coranique).
- **Décisions respectées** :
  - le §16 du 05/11/2026 : schème vérifié, et aucun schème sur les fiches des formes VIII assimilées ;
  - Intermédiaire 1 : Forge, noms divins, règle L/R, mots sans tanwīn au nominatif ;
  - Élémentaire 3 : alif de liaison sans voyelle, personnes exercées, verbe en tête au singulier.
- **Choix des mots** : tous les mots ont leur racine dans le Corpus ; la plupart des verbes sont des lemmes vérifiés dans la base. Ils ont été choisis sur des racines connues (عَلِمَ → عَلَّمَ / تَعَلَّمَ / مُتَعَلِّم ; خ ر ج → أَخْرَجَ / اسْتَخْرَجَ ; ج ل س → جَالَسَ / أَجْلَسَ ; ك ت ب → كَاتَبَ / تَكَاتَبَ ; ق د م, ف ر ق, س م ع), pour que chaque forme se rattache à un mot déjà su.
- **Prérequis** : seules les racines saines et non doublées sont forgées. L'assimilation est enseignée sur des mots lus, pas forgés. Les racines faibles (ازْدَادَ, اتَّصَلَ) sont renvoyées au chapitre C.

## Confiance

- **Haute** : les moules, les noms d'action réguliers, la règle u/a des préfixes et des participes, le passif, l'assimilation du tāʾ (règle classique sûre).
- **Moyenne-haute** : sens et lemmes.
  - À confirmer à la construction : `n~aZara`, `>udoxila` (أَدْخَلَ ; sinon R), la racine de مُسْتَقْبِل.
  - Les « R » n'ont pas de fréquence.
- **Moyenne** : quelques noms d'action peu usités, mais réguliers : مُسَافَرَةٌ, إِجْلَاسٌ, تَمَارُضٌ. Le sens de كَبُرَ est réservé aux choses ; pour l'âge, c'est كَبِرَ.
- **Fréquences** : non lues, à vérifier en SQL.
- **Suites ⚠** : liste de mémoire, incomplète ; le garde-fou fait foi.
- **Aucune décision de l'utilisateur n'est nécessaire.** Une seule option facultative : il pourrait autoriser plus tard un schème « افْتَعَلَ (ت devenu ط / د) » sur les fiches des formes VIII assimilées, vérifié par une règle de construction. C'est une extension du §16 du 05/11 ; d'ici là, aucun schème sur ces fiches.

## Résumé pour l'utilisateur

Le plan des leçons 3.11 à 3.21 est prêt : environ 80 mots nouveaux, les formes verbales I à X sur des racines déjà connues, leurs participes et noms d'action, et le passif. Les mots liés au sacré sont exclus, et les formes difficiles sont seulement lues, jamais fabriquées. Aucune question ne t'attend.

À enregistrer dans `/home/user/iqura/docs/relectures/decisions-intermediaire-2.md`. Références : `/home/user/iqura/docs/CAHIER_DES_CHARGES.md` (§5 l. 296-310, §16 du 05/11/2026), `/home/user/iqura/docs/relectures/decisions-intermediaire-1.md`, `/home/user/iqura/docs/relectures/decisions-elementaire-3.md`, `/home/user/iqura/assets/content/iqura_content.db`.

---

## Note de mise en œuvre (07 au 11/11/2026)

Identifiants de lemmes réellement présents dans la base (le plan en citait certains qui n'existent pas) : `{jotamaEu` (اجْتَمَعَ), `yantaZiru` (انْتَظَرَ), `tad~axiru` (ادَّخَرَ), `{nSarafu` (انْصَرَفَ), `nasotansixu` (اسْتَنْسَخَ), `{sotakovaro` (اسْتَكْثَرَ), `fah~amo`, `far~aqu`, `tuHad~ivu`, `faAriqu`, `saAbiqu`, `yataEal~amu`, `yatakal~amu`, `vaqulato`, `baEudato`. Les autres mots sans lemme sont reliés à leur seule racine (R). اعْتَرَفَ a été retiré de 3.18 (il demande بِـ, pas encore enseigné). L'identifiant et la forme arabe du lemme ne sont jamais affichés (vérifié dans `fondations_views.dart`).

# Décisions — Doutes du relecteur, Intermédiaire 2 (3.11 à 3.21)

Stade : région 3, leçons 3.11 à 3.21. Acquis : régions 1 et 2, leçons 3.1 à 3.10, verbes de forme I, conjugaison de هُوَ, هِيَ, هُمْ et أَنَا. Pas encore enseignés : بِـ, فَـ, عَنْ.
Lu avant de trancher : le plan `/home/user/iqura/docs/relectures/decisions-intermediaire-2.md`, `decisions-intermediaire-1.md` (décision 4), les leçons 3.8, 3.14, 3.16, 3.17 et 3.18, `mots.json` et la base (table `lemma`, par recherche de texte). Aucune décision de l'utilisateur inscrite au §16 n'est touchée.

---

## 1. Sens des verbes : infinitif ou « il a… » ; تَقَاسَمَ « ils se sont partagé »

**Décision**
- **Fiches.** On garde les deux styles :
  - les anciennes fiches (« il est entré », « il a écrit », طَرَقَ « il a frappé ») sont validées, on ne les refait pas ;
  - à partir de 3.11, l'infinitif devient la règle, comme dans un dictionnaire français-arabe.
- **Ajout dans `/home/user/iqura/tools/build_content/lessons/etape3/11-*.json`**, sur un écran de règle déjà présent (une seule phrase) : « Un verbe arabe se cite au passé, à la forme « il » : كَتَبَ « il a écrit ». Dans tes fiches, son sens est maintenant donné à l'infinitif : « écrire ». »
- **Harmoniser les anciennes fiches** : seulement plus tard, et avec l'accord de l'utilisateur. À noter dans `docs/DECISIONS_A_REVOIR.md`.
- **« ils se sont partagé » pour تَقَاسَمَ seul : non.** تَقَاسَمَ seul est la forme de « il » ; « ils » se dit تَقَاسَمُوا.
- **À corriger dans `/home/user/iqura/tools/build_content/lessons/etape3/16-la-forme-vi.json`**, dans toutes les questions « sens » posées sur un verbe seul : choix, réponse et explication passent à l'infinitif de la fiche.
  - تَقَاسَمَ « se partager » ; تَنَازَعَ « se disputer » ; تَعَارَفَ « faire connaissance » ;
  - تَكَاتَبَ « s'écrire » ; تَشَابَهَ « se ressembler » ; تَصَافَحَ « se serrer la main » ;
  - les mauvais choix aussi : « se diviser », « se séparer », « savoir », « faire la course »…
  - Exemple d'explication : « تَقَاسَمَ veut dire « se partager ». »
- **À garder tel quel** :
  - les questions « Comment dit-on « ils se ressemblent » ? » → يَتَشَابَهُونَ (c'est bien « ils ») ;
  - les questions de compréhension d'un récit (« Que font Bāsim et Samīr ? »).
- **À vérifier aussi** dans les leçons 3.11 à 3.21 : aucune question « sens » sur un verbe seul ne doit donner une traduction avec « ils ».

**Pourquoi.** Dire que تَقَاسَمَ veut dire « ils se sont partagé » apprendrait une erreur de conjugaison, à l'endroit même où l'on exerce la forme de هُمْ. L'infinitif est le sens de dictionnaire que demande le §3, règle 1. Les fiches validées ne sont pas refaites (avenant n° 2).

**Confiance** : haute.

**Pour l'utilisateur** : les verbes sont désormais traduits à l'infinitif (« écrire »), une phrase de la leçon 3.11 l'explique, et une erreur (« ils » au lieu de « il ») est corrigée dans les questions de la leçon 3.16.

---

## 2. 3.16 : تَشَابَهَتِ الْكَلِمَتَانِ traduit « Les deux mots se ressemblent »

**Décision**
- **On garde la phrase arabe** et on corrige la traduction : « Les deux mots se ressemblaient. »
- **À modifier** :
  - `/home/user/iqura/tools/build_content/vocab/mots.json`, vers la ligne 5259 (l'exemple de la fiche) ;
  - `16-la-forme-vi.json`, vers la ligne 312 : consigne « Complète : « Les deux mots se ressemblaient. » » ;
  - la phrase modèle de 3.16, si elle porte cette traduction.
- Les choix et l'explication de l'exercice ne changent pas.

**Pourquoi.** تَشَابَهَتْ est un passé ; le traduire au présent brouille la distinction passé / inaccompli, qui vient d'être exercée. Pour un état passé, l'imparfait est la traduction française naturelle. C'est la correction la plus petite : un seul mot français, aucun exercice arabe à refaire.

**Confiance** : haute.

**Pour l'utilisateur** : la traduction de la phrase « Les deux mots se ressemblent » passe au passé, comme le verbe arabe.

---

## 3. 3.12 : فَرَّقَ الْحَمَّالُ الْأَحْمَالَ « a séparé les charges »

**Décision**
- **Ajouter « répartir »** au sens de la fiche : fr « séparer, disperser, répartir ».
- **Traduire l'exemple** : « Le porteur a réparti les charges. »
- **À modifier** : `mots.json` (fiche `farraqa`, vers la ligne 4946, champ `fr` et `exemple.fr`), et la même traduction partout où cette phrase revient dans `12-la-forme-ii.json`.
- On ajoute **aucun complément avec بَيْنَ ou عَلَى** : ce sont des suites ⚠ du plan, et بِـ/عَنْ restent absents.

**Pourquoi.** « Répartir, distribuer » est un sens classique courant de فَرَّقَ (« diviser en parts »). C'est aussi la lecture naturelle de la phrase ; « séparer des charges » sonne mal en français. Les questions qui demandent « séparer » restent justes.

**Confiance** : moyenne-haute.

**Pour l'utilisateur** : le mot « séparer » (فَرَّقَ) reçoit aussi le sens « répartir », plus naturel dans la phrase d'exemple.

---

## 4. 3.13 : قَابَلَ « rencontrer, faire face à »

**Décision**
- **Mettre le sens classique d'abord** : fr « faire face à, rencontrer ».
- **À modifier** : `mots.json`, fiche `qaabala`, vers la ligne 4717 (ordre des sens seulement).
- **On garde** les exercices sur « rencontrer » et l'exemple قَابَلَ التَّاجِرُ الصَّرَّافَ فِي السُّوقِ.
- **On ne donne jamais à مُقَابَلَةٌ le sens « entretien » ou « interview »** : c'est un sens moderne.

**Pourquoi.** Le sens premier de قَابَلَ en arabe classique est « se tenir en face de, faire face à ». « Rencontrer face à face » en découle et suffit à l'apprenant. Le sens « avoir un entretien » est moderne.

**Confiance** : moyenne. L'ordre des sens est prudent ; il n'invente rien.

**Pour l'utilisateur** : pour قَابَلَ, le sens ancien « faire face à » passe en premier ; « rencontrer » reste.

---

## 5. 3.14 : أَكْبَرُ peut aussi vouloir dire « je vieillis »

**Décision**
- **On n'ajoute pas « je vieillis »** : كَبِرَ n'est qu'un aperçu de 3.11, et l'ajouter embrouillerait.
- **On lève l'ambiguïté du QCM** en donnant la phrase connue de 3.8.
- **À modifier dans `/home/user/iqura/tools/build_content/lessons/etape3/14-la-forme-iv.json`, vers la ligne 201** :
  - consigne : « Dans الْجَمَلُ أَكْبَرُ مِنَ الْحِمَارِ, أَكْبَرُ c'est… » ;
  - choix et explication inchangés.
- Le texte de la règle (ligne 193) reste tel quel : il donne déjà « plus grand ».

**Pourquoi.** Seul, أَكْبَرُ est vraiment ambigu : élatif, ou « je » de كَبِرَ يَكْبَرُ. Une question qui affirme « c'est un élatif » sans contexte serait donc trop absolue. La phrase vient de la leçon 3.8, avec des mots déjà connus.

**Confiance** : haute.

**Pour l'utilisateur** : une question de la leçon 3.14 reçoit une petite phrase, pour qu'il n'y ait qu'une seule bonne réponse.

---

## 6. 3.17 / 3.19 : alif de liaison après une virgule

**Décision**
- **Oui, on le précise.**
- **À modifier dans `/home/user/iqura/tools/build_content/lessons/etape3/17-la-forme-vii.json`, ligne 163**, remplacer :
  - « Son alif se lit i en début de phrase ; »
  - par « Son alif se lit i en début de phrase ou après une pause (une virgule où l'on s'arrête) ; ».
- **Dans le plan**, compléter B2 de la même façon.
- La translittération de فِي الصَّبَاحِ، انْفَتَحَ (en « infataḥa ») reste juste.

**Pourquoi.** Règle classique : après un arrêt, on reprend avec une voyelle d'appui (i pour ces formes). Si l'on enchaîne sans s'arrêter, l'alif disparaît, comme pour وَ. Avec ces quelques mots, la règle couvre les phrases de 3.17 et 3.19 sans nouvel écran.

**Confiance** : haute.

**Pour l'utilisateur** : la leçon 3.17 précise qu'après une virgule où l'on s'arrête, on lit le premier son « i ».

---

## 7. 3.18 : écran « Une tendance »

**Décision**
- **La valeur est bonne** : اجْتَمَعَ « se réunir » (l'action revient sur le sujet).
- **Le contre-exemple est à reformuler.**
- **À modifier dans `/home/user/iqura/tools/build_content/lessons/etape3/18-la-forme-viii.json`, ligne 160**, remplacer :
  - « Simple tendance : انْتَظَرَ « attendre » a la racine de نَظَرَ « regarder », mais son sens ne se devine pas. »
  - par « Simple tendance : انْتَظَرَ « attendre » a la racine de نَظَرَ « regarder », mais l'action ne revient pas sur le sujet : il a un complément, انْتَظَرَ صَدِيقَهُ. »
- La question et l'explication restent les mêmes.

**Pourquoi.** En arabe classique, نَظَرَ peut lui-même vouloir dire « attendre ». Dire que le sens de انْتَظَرَ « ne se devine pas » est donc discutable. Le vrai contre-exemple est grammatical : انْتَظَرَ prend un complément direct, sans retour sur le sujet. La phrase ajoutée reprend le modèle du plan (« Bāsim a attendu son ami »).

**Confiance** : haute.

**Pour l'utilisateur** : l'exemple qui montre que le sens d'une forme n'est qu'une tendance est remplacé par une explication plus juste.

---

## 8. 3.19 : اسْتَفْهَمَ الطَّالِبُ الْمُعَلِّمَ ; اسْتَنْسَخَ « faire copier »

**Décision**
- **اسْتَفْهَمَ + personne en complément direct : classique, on garde.**
- **اسْتَنْسَخَ** :
  - fr de la fiche : « faire copier, copier (un écrit) » ;
  - à modifier : `mots.json`, fiche `istansakha`, vers la ligne 5613 ;
  - l'exemple « Le marchand a fait copier le livre » ne change pas ;
  - le ⚠ « نَسْتَنْسِخُ مَا » reste valable (jamais le « nous », jamais suivi de مَا).

**Pourquoi.**
- اسْتَفْهَمَهُ (« lui demander de faire comprendre ») est attesté dans les dictionnaires classiques, sans عَنْ, qui n'est d'ailleurs pas encore enseigné.
- Pour اسْتَنْسَخَ, les dictionnaires classiques donnent aussi le sens simple « copier, transcrire ». « Faire copier » n'en est qu'une lecture.
- Donner les deux sens est plus honnête, et rien ne change dans les exercices.

**Confiance** : moyenne-haute.

**Pour l'utilisateur** : le mot اسْتَنْسَخَ reçoit aussi le sens simple « copier ».

---

## 9. 3.21 : aperçu des passifs dérivés en texte, sans tableau

**Décision**
- **Acceptable**, à trois conditions :
  - les formes sont données seules (قُدِّمَ / يُقَدَّمُ, أُدْخِلَ / يُدْخَلُ, اسْتُخْرِجَ / يُسْتَخْرَجُ), présentées comme un aperçu ;
  - aucun exercice ne les demande ;
  - aucune phrase de récit ou de combat ne les emploie, sauf le modèle قُدِّمَ الطَّعَامُ لِلضُّيُوفِ, déjà prévu au plan.
- **Aucun fichier à modifier**, si ces conditions sont remplies.

**Pourquoi.** « Dans un tableau seulement » voulait dire « vu, jamais exercé ». Le texte remplit ce but et garde un écran pour une idée.

**Confiance** : haute.

**Pour l'utilisateur** : le passif des formes II, IV et X est montré en aperçu, sans exercice.

---

## 10. Lemmes du Corpus dont l'identifiant n'est pas au passé

**Décision**
- **Conforme à ma décision 4 d'Intermédiaire 1** : l'identifiant et la forme arabe du lemme du Corpus ne s'affichent jamais ; seul le champ `ar` est montré.
- **Vérifié dans `/home/user/iqura/assets/content/iqura_content.db`** : chaque lemme cité est bien un verbe, avec la bonne racine et la bonne forme. Le tableau donne le mot de la fiche, puis le lemme du Corpus et sa racine.

| Forme | Mot de la fiche | Lemme du Corpus (racine) |
| --- | --- | --- |
| I | بَعُدَ | baEudato (bEd) |
| I | ثَقُلَ | vaqulato (vql) |
| II | فَهَّمَ | fah~amo (fhm) |
| II | فَرَّقَ | far~aqu (frq) |
| II | حَدَّثَ | tuHad~ivu (Hdv) |
| III | فَارَقَ | faAriqu (frq) |
| III | سَابَقَ | saAbiqu (sbq) |
| V | تَعَلَّمَ | yataEal~amu (Elm) |
| V | تَكَلَّمَ | yatakal~amu (klm) |
| VII | انْصَرَفَ | {nSarafu (Srf) |
| VIII | اجْتَمَعَ | {jotamaEu (jmE) |
| VIII | انْتَظَرَ | yantaZiru (nZr) |
| VIII | ادَّخَرَ | tad~axiru (*xr) |
| X | اسْتَكْثَرَ | {sotakovaro (kvr) |
| X | اسْتَنْسَخَ | nasotansixu (nsx) |

- **À vérifier par Claude Code** (test ou SQL), parce que plusieurs de ces formes arabes de lemme viennent directement d'un mot du Coran conjugué (par exemple نَسْتَنسِخُ) :
  - aucun écran, ni la fiche, ni le dictionnaire, ni la recherche, n'affiche la forme arabe du lemme ;
  - aucun écran n'affiche non plus son identifiant.
- **Dans le plan** : corriger les identifiants qui n'existent pas dans la base. C'est une correction de forme, sans changement de décision.

**Pourquoi.** Le Corpus range certains verbes sous une forme conjuguée. C'est une particularité de la source, pas une erreur, tant que rien n'est affiché. Racine et forme concordent pour tous les lemmes cités.

**Confiance** : haute.

**Pour l'utilisateur** : les mots sont bien reliés à la source ; le code interne de la source n'est jamais montré.

---

**Fichiers à modifier en tout** : `/home/user/iqura/tools/build_content/vocab/mots.json` (fiches farraqa, qaabala, istansakha, et l'exemple de tashaabaha) ; dans `/home/user/iqura/tools/build_content/lessons/etape3/`, les fichiers `11-*.json`, `12-la-forme-ii.json`, `14-la-forme-iv.json`, `16-la-forme-vi.json`, `17-la-forme-vii.json` et `18-la-forme-viii.json` ; le plan `/home/user/iqura/docs/relectures/decisions-intermediaire-2.md` (B2 et les identifiants) ; `docs/DECISIONS_A_REVOIR.md` (harmoniser plus tard les anciennes fiches). Après les corrections, il faut relancer le relecteur sur les fichiers modifiés, puis le garde-fou coranique pendant la construction de la base.

---

## Liste de fin de niveau (10 points)

1. Les verbes sont maintenant traduits à l'infinitif sur les fiches (« écrire ») ; la leçon 3.11 l'explique. Les anciennes fiches (« il a écrit ») restent ; les harmoniser plus tard, avec votre accord (`DECISIONS_A_REVOIR.md`).
2. Leçon 3.16 : les questions de sens sur un verbe seul sont à l'infinitif (« se partager »), et « Les deux mots se ressemblaient » est au passé.
3. فَرَّقَ reçoit aussi le sens « répartir » ; اسْتَنْسَخَ « faire copier, copier » ; قَابَلَ « faire face à, rencontrer ».
4. Leçon 3.14 : la question sur أَكْبَرُ est posée dans une phrase, pour éviter le sens « je vieillis ».
5. L'alif de liaison (انْـ, افْتَـ, اسْتَـ) se lit i en début de phrase ou après une pause, et disparaît après un mot lu sans pause.
6. Leçon 3.18 : la forme VIII dit souvent que l'action revient sur le sujet ; contre-exemple : انْتَظَرَ, qui prend un complément.
7. اسْتَفْهَمَ الطَّالِبُ الْمُعَلِّمَ (personne en complément direct) est classique.
8. Leçon 3.21 : le passif des formes II, IV et X n'est qu'un aperçu en texte, sans exercice ; le passif « impersonnel » des verbes sans complément n'est pas encore abordé.
9. Les formes VIII où le ت change (اضْطَرَبَ, ادَّخَرَ) n'ont pas de schème sur leur fiche ; elles sont lues, jamais forgées.
10. Les noms d'action affichés sur la fiche d'un verbe comptent comme mots connus dans les textes.

