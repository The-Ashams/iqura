# Décision — Plan de langue du niveau Avancé 1 (leçons 4.1 à 4.14, région 4 « La Cité des Lecteurs », chapitre A « La phrase complexe »)

Question : pour chaque leçon de 4.1 à 4.14, donner l'objectif, les mots nouveaux, la règle, les phrases modèles, les pièges et ce qui est reporté. Fixer aussi les principes du niveau (formes admises, tournures écartées, récits et maximes) et les prérequis qui manquent. Pas d'examen : le boss de la région 4 vient avec Avancé 2.

Stade : région 4, leçons 4.1 à 4.14.
- **Lieux et maîtres** : Porte de la Cité, Maison des messagers et Place des conteurs (Nadīm, 4.1 à 4.9) ; Jardin des maximes et Bureau des comptes (Hāla, 4.10 à 4.14) ; Bāsim accompagne.
- **Acquis** : régions 1 à 3. Les mots de `mots.json` (fondations-01 à 30, moteur-01 à 32) et les noms d'action des fiches (طَرْقٌ, فَرَحٌ, نَوْمٌ, مَشْيٌ, جُلُوسٌ, إِكْرَامٌ, انْتِظَارٌ, عَمَلٌ, طَلَبٌ, خَوْفٌ…). Les cas, le subjonctif, le jussif, la défense, إِنَّ et كَانَ avec leurs sœurs, بِـ et عَنْ, les nombres de 1 à 10 avec un nom masculin (2.19).
- **Pas encore enseignés** : فَـ ; إِذَا, إِنْ, لَوْ, لَوْلَا, حِينَ, لَمَّا, حَتَّى, لِأَنَّ, إِلَّا, غَيْرُ, أَيُّهَا, قَدْ, بَلْ, لَٰكِنْ (léger), أَمَّا, أَوْ ; les mots interrogatifs كَيْفَ, كَمْ, مَتَى, لِمَاذَا ; كُلٌّ, أَحَدٌ, مَالٌ, فَعَلَ ; les nombres de 3 à 10 devant un nom féminin (2.19 l'avait annoncé « pour plus tard ») ; les nombres au-delà de 10.

## Décision

### A. Méthode et limites (mêmes règles qu'en Intermédiaire 3)

- **Lemmes** : vérifiés par recherche de texte dans `/home/user/iqura/assets/content/iqura_content.db`. Ce n'est pas du SQL : `vocab.validate` fait foi.
  - L = lemme du Corpus de même sens.
  - R = racine seule, sans fréquence.
  - Racines notées en Buckwalter, comme dans le Corpus.
- **Vérifiés dans la base** :
  - particules et mots-outils : <in, <i*aA, law, lawolaA^, Hiyn, lam~aA, Hat~aY`, mataY`, kayof, kam, maA*aA, <il~aA, gayor, kul~, >aHad, <iHodaY, >ay~uhaA, >ay~atuhaA, qad, bal, la`kin, >am~aA, >aw, >abad ;
  - noms : Ea$ar, Ea$arap, Ei$oruwn, xamosiyn, sit~iyn, vama`niyn, miA}ap, >alof, SaAHib, nidaA^', maAl, $adiyd, waHod, masoruwr, DaAHik, mar~ap, sabab, tija`rap, layol, >ajol, tawokiyd ;
  - verbes : naAdaY`, Zan~a, *akara, >amara, HaDara, TaAla, faEala, {ntahaY` (forme VIII), {mtala>o (forme VIII).
- **À vérifier en SQL** :
  - le lemme de ضَحِكَ : la base montre `DaHikato` (forme ضَحِكَتْ) ;
  - les dizaines 30, 40, 70 et 90 : je ne les ai pas trouvées comme lemmes. Si elles sont absentes, on les note R, avec la racine de l'unité.
- **Absents du Corpus comme mots** : أَخْبَرَ, اسْتَيْقَظَ, جَائِعٌ, حَزِينٌ, رِبْحٌ, مُسْرِعٌ, زَائِرٌ, حَاضِرٌ, جِدًّا, سِنٌّ au sens d'« âge », et les termes de grammaire (شَرْطٌ, حَالٌ, تَمْيِيزٌ, مُطْلَقٌ, اسْتِثْنَاءٌ). On les note R : leur racine est dans le Corpus.
- **Fréquences** : non lues (le champ est binaire). Les listes sont rangées par fréquence *probable*. Claude Code peut les réordonner en SQL.
- **Suites ⚠** : citées de mémoire, la liste est incomplète. Le garde-fou fait foi, et toute paire signalée est remplacée (§16, 25/10/2026).
- **Risque propre à ce niveau** : les mots qui relient deux phrases (إِذَا, لَوْ, لَمَّا, حَتَّى, إِلَّا, يَا أَيُّهَا) ouvrent beaucoup de tournures du Coran. On met un nom propre (Bāsim, Nadīm, Hāla, Samīr, Salmā) ou un nom concret de la Cité juste après la particule, et on préfère les verbes déjà « sûrs » d'Intermédiaire 3.

### B. Principes du niveau

1. **Formes admises (suite de B1 d'Intermédiaire 3).**
   - Chaque verbe nouveau à racine faible, à hamza ou doublée a une liste fermée de formes, relue par le relecteur. C'est le cas de نَادَى, ظَنَّ, طَالَ, انْتَهَى, امْتَلَأَ, اسْتَيْقَظَ et أَمَرَ.
   - Pour les verbes sains très chargés de tournures du Coran (فَعَلَ, ذَكَرَ, ضَحِكَ), la liste est aussi fermée.
   - Aucun de ces verbes n'est employé à l'impératif.
2. **Ordre d'arrivée des petites particules.**
   - فَـ arrive en 4.1, **seulement** devant la réponse d'une condition. Ses autres emplois (« et aussitôt », « donc », après أَمَّا) arrivent en 4.13. Avant 4.13, les récits relient les actions avec وَ et ثُمَّ.
   - لَـ arrive en 4.2, comme réponse de لَوْ et de لَوْلَا. En 4.12, il devient un mot d'insistance.
   - لَٰكِنْ (léger) s'écrit avec le petit alif, comme لَٰكِنَّ (B4 d'Intermédiaire 3).
3. **Longueur** : une phrase modèle a au plus deux propositions et une dizaine de mots. Une virgule (،) sépare la proposition qui vient en tête (« لَمَّا وَصَلْنَا، … »).
4. **Exclusions maintenues** (B5 et B6 d'Intermédiaire 1 à 3) : aucun sujet divin, aucun nom divin, aucune formule sacrée, aucun serment.
   - **Jamais**, nulle part : إِنْ شَاءَ اللَّهُ, لَوْ شَاءَ, لَوْلَا + فَضْل / رَحْمَة / نِعْمَة / كَلِمَة / كِتَاب, لَئِنْ, وَاللَّهِ, تَاللَّهِ, لَعَمْرِي, لَا + nom + إِلَّا, لَا إِلَٰهَ, قَدْ أَفْلَحَ.
   - Pas de phrase qui commence par وَ suivi d'un nom de la nature (اللَّيْل, النَّهَار, الشَّمْس, الْفَجْر…) : elle aurait l'air d'un serment.
   - **ضَرَبَ est écarté de tout le niveau** : il est trop chargé de tournures (« ضَرَبَ اللَّهُ مَثَلًا ») et de passages sensibles. Le titre 4.8 « Il a frappé un coup » reste en français ; en arabe, on frappe à la porte avec طَرَقَ.
5. **Récits : aucune scène qui rappelle un récit du Coran** (complète B7 d'Intermédiaire 3).
   - **Lettres et messagers** :
     - pas d'oiseau qui porte une lettre ;
     - pas de reine ni de roi qui envoie un présent en réponse à une lettre ;
     - pas de lettre qui commence par une formule sacrée. Une lettre commence par « مِنْ نَدِيمٍ إِلَى بَاسِمٍ ».
     - « أَمَّا بَعْدُ » est reporté à 4.26.
   - **Caravane et voyage** :
     - pas de caravane qui part pendant qu'un père sent une odeur ;
     - pas de bagage où l'on retrouve une coupe ;
     - pas de voyage de nuit présenté comme un prodige ;
     - pas de dormeur qui s'éveille après des années et envoie des pièces en ville pour acheter à manger.
   - **Jardin et comptes** :
     - pas de deux maîtres de jardins qui comparent leurs richesses ;
     - pas de récolte prévue à l'aube ;
     - pas de marchands qui trichent à la balance et qu'un sage reprend ;
     - pas d'homme dont on envie la richesse ;
     - pas de foule qui quitte quelqu'un debout pour courir vers une caravane.
6. **Maximes du Jardin (Hāla).**
   - Elles sont toutes construites et signalées « rédigé par IA ».
   - Aucune n'est attribuée à quelqu'un ; aucune n'est un vrai proverbe ni introduite par « قِيلَ ». Beaucoup de proverbes circulent avec une fausse attribution religieuse : c'est la raison de cette règle.
   - Aucune ne parle de Dieu, du destin, de la mort ou de l'au-delà.
   - Pas de conseils d'un père à son fils (« يَا بُنَيَّ »).
   - Pas de maxime sur la démarche, la voix qu'on baisse ou la voix de l'âne : ce sont des motifs du Coran.
7. **Noms des personnages.**
   - هَالَةُ est un prénom féminin sans tanwīn (يَا هَالَةُ, مَعَ هَالَةَ) ; نَدِيمٌ en prend un.
   - Les noms des personnages ne servent jamais d'exercice de racine : نَدِيم est de la racine n d m (« regretter »), sans lien de sens avec le prénom.
8. **Production (≥ 40 %), sans « ordonner » au mini-boss.** Exercices de production :
   - relier deux phrases par la particule de la leçon (choisir entre 3 ou 4) ;
   - choisir la bonne réponse d'une condition (avec ou sans فَـ) ;
   - passer du discours direct au discours indirect ;
   - transformer un adjectif en ḥāl ;
   - compléter un mafʿūl muṭlaq ;
   - écrire un nombre en toutes lettres avec son nom.
   - La construction par tuiles reste dans les leçons.
9. **Temps** : يَوْمٌ, أَيَّامٌ, شَهْرٌ, سَنَةٌ, عَامٌ et سَاعَةٌ ne sont **pas** introduits ici. Ils sont très chargés de tournures (« السَّاعَة », « سِتَّةِ أَيَّامٍ », « اثْنَا عَشَرَ شَهْرًا », « أَلْفَ سَنَةٍ »…). Ils vont en 4.18 « Le temps qui passe », avec leur propre liste ⚠. Ici, on se sert de صَبَاحٌ, مَسَاءٌ, لَيْلٌ, أَمْسِ, الْيَوْمَ et غَدًا.

### C. Plan par leçon

Format : forme | sens | L/R (racine) | inaccompli et formes admises | remarque.

**4.1 « Si… » (Porte de la Cité, Nadīm)**
- **Objectif** : dire une condition et sa suite ; savoir quand la suite prend فَـ.
- **Règle** : « إِذَا (« quand, si ») est suivi du passé ; إِنْ (« si ») du passé ou du jussif : إِنْ تَدْرُسْ تَفْهَمْ. La réponse prend فَـ quand elle n'est pas un simple verbe : un ordre, une défense, سَـ ou une phrase nominale. »
- **Mots (5)** :
  - إِذَا | quand, si (chose attendue) | L <i*aA (le sens « condition », pas « soudain »)
  - إِنْ | si (chose incertaine) | L <in (condition)
  - فَـ | alors (devant la réponse) | préfixe, sans lemme
  - شَرْطٌ | condition ; جَوَابُ الشَّرْطِ : la réponse | R $rT
  - شَدِيدٌ | fort, intense | L $adiyd
- **Modèles** :
  - إِذَا وَصَلْتَ إِلَى الْمَدِينَةِ فَاكْتُبْ رِسَالَةً إِلَى سَلْمَى. « Quand tu arriveras à la ville, écris une lettre à Salmā. »
  - إِنْ تَدْرُسْ تَفْهَمْ. « Si tu étudies, tu comprendras. »
  - إِذَا وَصَلَتِ الْقَافِلَةُ فَتَحَ الْحَارِسُ الْبَابَ. « Quand la caravane arrive, le gardien ouvre la porte. » (simple verbe : pas de فَـ)
  - إِنْ رَجَعَ بَاسِمٌ الْيَوْمَ فَسَنُسَافِرُ غَدًا. « Si Bāsim revient aujourd'hui, nous partirons demain. »
  - إِذَا كَانَ الْبَرْدُ شَدِيدًا فَلَا تُسَافِرْ. « Si le froid est vif, ne pars pas en voyage. »
  - إِنْ تَجْلِسْ مَعَنَا نَفْرَحْ. « Si tu t'assieds avec nous, nous serons contents. »
- **Pièges** :
  - إِذَا + passé se traduit par un présent ou un futur.
  - إِنْ (condition) ≠ إِنَّ (3.31) ≠ أَنْ ≠ أَنَّ : on vocalise toujours.
  - Après إِنْ au jussif, le sukūn devient i devant l'article (إِنْ تَحْفَظِ الدَّرْسَ…).
  - ⚠ إِذَا jamais suivi de جَاءَ, وَقَعَ, قَامَ, قَرَأَ, رَأَى, سَمِعَ, لَقِيَ, سَأَلَ, بَلَغَ, أَرَادَ, قَالَ, مَرِضَ, ni de دَخَلَ au pluriel ; jamais « إِذَا الشَّمْسُ / السَّمَاءُ ».
  - ⚠ إِنْ jamais suivi de كَانَ + قَمِيص, ni de كُنْتُمْ, عَدَّ, عَادَ, سَأَلَ, جَاءَ, أَحْسَنَ, حَمَلَ / تَرَكَ (avec un chien) ; jamais de vol (« إِنْ يَسْرِقْ »).
  - ⚠ Pas de dette mise par écrit, ni de témoins (« فَاكْتُبُوهُ ») ; jamais فَاكْتُبْنَا.
  - ⚠ Pas de « si tu ne sais pas, demande… », trop proche d'un verset.
- **Reporté** :
  - إِذَا de surprise (« فَإِذَا… », région 5) ;
  - مَنْ et مَا de condition, كُلَّمَا ;
  - إِنْ de négation (5.4).

**4.2 « Si seulement… » (Porte de la Cité)**
- **Objectif** : dire l'irréel (لَوْ) et « sans… » (لَوْلَا).
- **Règle** : « لَوْ (« si » pour ce qui n'a pas eu lieu) est suivi du passé, et sa réponse prend souvent لَـ : لَوْ دَرَسْتَ لَفَهِمْتَ. لَوْلَا (« sans ») est suivi d'un nom en -u, puis d'une réponse en لَـ : لَوْلَا الْبَرْدُ لَجَلَسْنَا فِي الْحَدِيقَةِ. »
- **Mots (4)** :
  - لَوْ | si (irréel) | L law
  - لَوْلَا | sans, s'il n'y avait pas | L lawolaA^ (lemme à confirmer)
  - لَـ (de réponse) | (alors) | préfixe, sans lemme
  - مَالٌ | argent, biens | L maAl ; pluriel أَمْوَالٌ non affiché
- **Modèles** :
  - لَوْ كَانَ الطَّرِيقُ قَصِيرًا لَوَصَلْنَا قَبْلَ الْمَسَاءِ. « Si le chemin avait été court, nous serions arrivés avant le soir. »
  - لَوْ دَرَسْتَ لَفَهِمْتَ الدَّرْسَ. « Si tu avais étudié, tu aurais compris la leçon. »
  - لَوْ كَانَ عِنْدِي مَالٌ لَسَافَرْتُ إِلَى دِمَشْقَ. « Si j'avais de l'argent, je partirais pour Damas. »
  - لَوْلَا الْبَرْدُ لَجَلَسْنَا فِي الْحَدِيقَةِ. « Sans le froid, nous nous serions assis dans le jardin. »
  - لَوْلَا سَلْمَى لَنَسِيتُ الْمِفْتَاحَ. « Sans Salmā, j'aurais oublié la clé. »
  - Contraste : إِنْ دَرَسْتَ فَهِمْتَ (possible) / لَوْ دَرَسْتَ لَفَهِمْتَ (n'a pas eu lieu).
- **Pièges** :
  - لَوْلَا + nom au nominatif, jamais à l'accusatif.
  - لَمَا (« alors… ne pas », réponse niée) ≠ لَمَّا (4.4) : seulement en aperçu.
  - ⚠ لَوْ jamais suivi de شَاءَ, رَأَى / تَرَى, أَنَّ, أَنْزَلَ, ni de كَانَ + فِيهِمَا / خَيْرًا / عَرَضًا / الْبَحْر.
  - ⚠ jamais مِدَاد, بَحْر, أَقْلَام ou شَجَرَة dans une phrase avec لَوْ : ce sont des images du Coran sur l'encre et les calames.
  - ⚠ jamais « لَوْ … مَا مَاتُوا », ni لَخَرَجْنَا (avec مَعَكُمْ).
  - ⚠ لَوْلَا jamais suivi de أَنْ, d'un pronom (لَوْلَا أَنْتَ, لَوْلَاكَ), ni de رِجَال, دُعَاء, رَهْط.
  - ⚠ مَالٌ jamais avec وَلَد, بَنُون, جَمَعَ, عَدَّ, مَدَّ, حُبّ / أَحَبَّ, آتَى, ni أَكْثَر / أَقَلّ + مَالًا.
- **Reporté** : لَوْلَا au sens de « pourquoi… ne pas » (+ verbe), très coranique, en région 5 ; لَوْ أَنَّ.

**4.3 « Il a dit que… » (Maison des messagers)**
- **Objectif** : rapporter une parole, une pensée, un ordre.
- **Règle** : « Pour rapporter une parole ou une pensée : أَنَّ + phrase nominale, sujet en -a (أَخْبَرَنِي أَنَّ الطَّرِيقَ طَوِيلٌ). Pour rapporter un ordre ou une demande : أَنْ + verbe au subjonctif (أَمَرَهُ أَنْ يَكْتُبَ). »
- **Mots (4)** :
  - أَخْبَرَ | informer, apprendre (une nouvelle) à | R xbr (forme IV) | يُخْبِرُ ; formes : أَخْبَرَ, أَخْبَرَتْ, أَخْبَرَنِي, أَخْبَرَنَا, يُخْبِرُ
  - ظَنَّ | penser, croire | L Zan~a | formes : ظَنَّ, ظَنَّتْ, ظَنَنْتُ, أَظُنُّ, يَظُنُّ ; pas de nom d'action affiché
  - ذَكَرَ | mentionner ; se rappeler | L *akara | formes : ذَكَرَ, ذَكَرَتْ, يَذْكُرُ ; aucun nom d'action affiché (ذِكْر a un sens religieux)
  - أَمَرَ | ordonner (à quelqu'un de) | L >amara | formes : أَمَرَ, أَمَرَتْ, يَأْمُرُ
- **Modèles** :
  - أَخْبَرَنِي بَاسِمٌ أَنَّ الْقَافِلَةَ وَصَلَتْ. « Bāsim m'a appris que la caravane était arrivée. »
  - ذَكَرَ نَدِيمٌ أَنَّ الرِّسَالَةَ طَوِيلَةٌ. « Nadīm a mentionné que la lettre était longue. »
  - ظَنَنْتُ أَنَّ الْبَابَ مَفْتُوحٌ. « Je croyais que la porte était ouverte. »
  - سَمِعْتُ أَنَّ التَّاجِرَ سَافَرَ إِلَى دِمَشْقَ. « J'ai entendu dire que le marchand était parti pour Damas. »
  - أَمَرَ التَّاجِرُ الْحَمَّالَ أَنْ يَحْمِلَ الْأَكْيَاسَ. « Le marchand a ordonné au porteur de porter les sacs. »
  - Direct → indirect : قَالَ بَاسِمٌ: «أَنَا مَشْغُولٌ.» → أَخْبَرَنَا بَاسِمٌ أَنَّهُ مَشْغُولٌ.
- **Pièges** :
  - Après قَالَ, toujours إِنَّ (3.31), jamais أَنَّ.
  - L'arabe garde le temps de la parole rapportée : أَخْبَرَنَا أَنَّهُ مَشْغُولٌ = « qu'il était occupé ».
  - أَنَا devient ـهُ (أَنَّهُ) ; pronoms collés à أَنَّ : ـهُ et ـهَا seulement (3.31).
  - ⚠ ظَنَّ jamais suivi de « أَنْ لَنْ », « أَنْ لَا », أَنِّي, أَنَّهُمْ ; jamais ظَنًّا / الظَّنّ ; jamais de sujet divin.
  - ⚠ ذَكَرَ jamais avec اللَّه, رَبّ, اسْم, نِعْمَة ; jamais اذْكُرْ / اذْكُرُوا, يَذْكُرُونَ, ذِكْرًا.
  - ⚠ أَمَرَ : sujet humain seulement ; jamais أَمَرْتُ, أُمِرْتُ, أَمَرْتَنِي, « مَا أَمَرَ… », وَأْمُرْ.
  - ⚠ Le mot رَسُولٌ reste exclu (B5 d'Intermédiaire 2) : on dit حَامِلُ الرِّسَالَةِ ou مُرْسِلٌ (déjà connu).
  - ⚠ Pas de خَاتَم ni de خَتَمَ (« sceau »).
- **Reporté** : أَنْ explicative (« كَتَبَ إِلَيْهِ أَنِ ارْجِعْ »), en région 5 ; أَنْ allégée (« عَلِمْتُ أَنْ قَدْ… »).

**4.4 Quand, avant, après (Maison des messagers)**
- **Objectif** : situer deux actions dans le temps.
- **Règle** : « حِينَ et لَمَّا (« quand, lorsque ») sont suivis d'une phrase au passé, puis vient la phrase principale : لَمَّا وَصَلْنَا، نِمْنَا. Après قَبْلَ أَنْ, le verbe est au subjonctif ; après بَعْدَ أَنْ, on emploie le plus souvent le passé. »
- **Mots (6)** :
  - حِينَ | quand, au moment où | L Hiyn
  - لَمَّا | lorsque (+ passé) | L lam~aA
  - مَتَى | quand ? | L mataY`
  - لَيْلٌ | nuit | L layol
  - انْتَهَى | se terminer, finir | L {ntahaY` (forme VIII) | formes : انْتَهَى, انْتَهَتْ, يَنْتَهِي
  - اسْتَيْقَظَ | se réveiller | R yqZ (forme X) | formes : اسْتَيْقَظَ, اسْتَيْقَظَتْ, اسْتَيْقَظْتُ, يَسْتَيْقِظُ
- **Modèles** :
  - لَمَّا وَصَلْنَا إِلَى الْمَدِينَةِ، كَانَ الْبَابُ مَفْتُوحًا. « Lorsque nous sommes arrivés à la ville, la porte était ouverte. »
  - حِينَ انْتَهَى الدَّرْسُ، خَرَجَ الطُّلَّابُ إِلَى الْحَدِيقَةِ. « Quand la leçon s'est terminée, les étudiants sont sortis dans le jardin. »
  - لَمَّا اسْتَيْقَظَ بَاسِمٌ، شَدَّ الْحِمْلَ عَلَى الْجَمَلِ. « Quand Bāsim s'est réveillé, il a attaché la charge sur le chameau. »
  - اكْتُبِ الْجَوَابَ قَبْلَ أَنْ تُسَافِرَ. « Écris la réponse avant de partir. »
  - رَجَعَ التَّاجِرُ إِلَى بَيْتِهِ بَعْدَ أَنْ بَاعَ الصُّوفَ. « Le marchand est rentré chez lui après avoir vendu la laine. »
  - مَتَى تَصِلُ الْقَافِلَةُ؟ — تَصِلُ فِي الْمَسَاءِ. « Quand la caravane arrive-t-elle ? — Elle arrive le soir. »
- **Pièges** :
  - لَمَّا + passé = « lorsque » ; لَمَّا + jussif = « pas encore » (5.4).
  - قَبْلَ / بَعْدَ (+ nom, 3.29) ≠ قَبْلَ أَنْ / بَعْدَ أَنْ (+ verbe).
  - ⚠ لَمَّا jamais précédé de فَـ ou de وَ dans ce niveau (« فَلَمَّا / وَلَمَّا » : 5.8).
  - ⚠ Verbes admis après لَمَّا et حِينَ : وَصَلَ, انْتَهَى, اسْتَيْقَظَ, كَتَبَ, فَهِمَ, جَلَسَ, نَامَ, اجْتَمَعَ, فَتَحَ (jamais avec des bagages). Jamais رَأَى, جَاءَ, بَلَغَ, أَتَى, ذَهَبَ, سَمِعَ, كَلَّمَ, نَسِيَ, سَكَتَ, ni رَجَعَ + أَب.
  - ⚠ حِينَ jamais avec وَضَعَ, تَقُومُ, ni « دَخَلَ الْمَدِينَةَ » ; jamais « إِلَى حِينٍ », « حَتَّى حِينٍ », حِينَئِذٍ.
  - ⚠ jamais « مِنْ قَبْلِ / مِنْ بَعْدِ أَنْ » ; jamais « قَبْلَ أَنْ تَقُومَ / يَأْتِيَ / يَرْتَدَّ », ni « بَعْدَ أَنْ جَاءَ ».
  - ⚠ مَتَى jamais avec هَٰذَا, هُوَ, وَعْد, نَصْر, فَتْح.
  - ⚠ لَيْل jamais avec نَهَار dans la même phrase, ni avec قَامَ, أَسْرَى / سَرَى, قِطْع ; jamais لَيْلًا ni « وَاللَّيْلِ » en tête.
  - ⚠ اسْتَيْقَظَ : jamais après un long sommeil compté en années, ni avec un chien ou une caverne.
  - ⚠ انْتَهَى : jamais فَانْتَهَى, انْتَهَوْا, مُنْتَهَى.
- **Reporté** : إِذْ (5.8) ; عِنْدَمَا (tournure plus tardive, non retenue) ; مُنْذُ ; les mots du temps (B9).

**4.5 Parce que, pour que (Maison des messagers)**
- **Objectif** : dire la cause et le but.
- **Règle** : « لِأَنَّ (« parce que ») est suivi d'une phrase nominale, sujet en -a : لِأَنَّ الطَّرِيقَ طَوِيلٌ. لِـ et حَتَّى (« pour que », « jusqu'à ce que ») mettent le verbe au subjonctif : جَلَسَ لِيَسْمَعَ ; حَتَّى suivi d'un nom veut dire « jusqu'à ». »
- **Mots (6)** :
  - لِأَنَّ | parce que | لِـ + أَنَّ, sans lemme propre
  - لِـ (+ verbe) | pour (que) | sens nouveau d'un mot connu
  - حَتَّى | jusqu'à ; jusqu'à ce que, pour que | L Hat~aY`
  - لِمَاذَا | pourquoi ? | لِـ + L maA*aA ; لِمَ, la forme courte, en aperçu
  - سَبَبٌ | cause, raison | L sabab
  - جَائِعٌ | qui a faim | R jwE
- **Modèles** :
  - لِمَاذَا تَأَخَّرْتَ؟ — لِأَنَّ الْجَمَلَ مَرِيضٌ. « Pourquoi es-tu en retard ? — Parce que le chameau est malade. »
  - لَبِسَ سَمِيرٌ ثَوْبًا مِنْ صُوفٍ لِأَنَّ الْبَرْدَ شَدِيدٌ. « Samīr a mis un vêtement de laine parce que le froid est vif. »
  - جَلَسَ بَاسِمٌ فِي الْمَجْلِسِ لِيَسْمَعَ الْقِصَّةَ. « Bāsim s'est assis dans l'assemblée pour écouter l'histoire. »
  - ذَهَبَ التَّاجِرُ إِلَى السُّوقِ لِيَبِيعَ الصُّوفَ. « Le marchand est allé au marché pour vendre la laine. »
  - عَمِلَ النَّجَّارُ حَتَّى الْمَسَاءِ. « Le menuisier a travaillé jusqu'au soir. »
  - طَلَبَ الطِّفْلُ الْخُبْزَ لِأَنَّهُ جَائِعٌ. « L'enfant a demandé du pain parce qu'il a faim. »
- **Pièges** :
  - لِأَنَّ + nom en -a ≠ لِـ + verbe en -a ≠ لِـ + nom au génitif (« à, pour », 2.15).
  - لِـ et حَتَّى + verbe : forme de هُوَ ou أَنَا dans les phrases ; le pluriel sans ن reste dans le tableau.
  - ⚠ حَتَّى jamais suivi de إِذَا, حِين, فَجْر, جَمَل, ni de بَلَغَ, رَأَى, عَلِمَ, سَمِعَ, وَضَعَ, جَاءَ, زَارَ, يَقُولَ, يَرْجِعَ.
  - ⚠ لِـ + verbe jamais avec عَلِمَ, سَكَنَ, رَكِبَ, أَكَلَ, تَعَارَفَ, حَمَلَ (au pluriel), قَالَ ; jamais لِئَلَّا, لِكَيْ, لِكَيْلَا.
  - ⚠ سَبَب : jamais سَبَبًا, بِسَبَبٍ (indéfini), أَسْبَاب, ni avec أَتْبَعَ ou مَدَّ.
  - ⚠ قَرَأَ jamais avec كِتَاب / كُتُب (règle de 3.22).
- **Reporté** : حَتَّى + passé, en aperçu seulement.

**4.6 « Il est venu en courant » : le ḥāl (Place des conteurs)**
- **Objectif** : dire dans quel état quelqu'un fait une action.
- **Règle** : « Le ḥāl dit dans quel état est quelqu'un pendant l'action ; il répond à كَيْفَ (« comment ? »). C'est un nom indéfini en -a, accordé avec la personne : رَجَعَتْ سَلْمَى فَرِحَةً. »
- **Mots (6)** :
  - حَالٌ | état ; (en grammaire) ḥāl | R Hwl
  - كَيْفَ | comment ? | L kayof
  - ضَحِكَ | rire | L à vérifier (DHk) | formes : ضَحِكَ, يَضْحَكُ ; participe ضَاحِكٌ (L DaAHik)
  - مَسْرُورٌ | content | L masoruwr
  - حَزِينٌ | triste | R Hzn
  - وَحْدَهُ | seul (lui seul) | L waHod ; formes : وَحْدَهُ, وَحْدَهَا, وَحْدِي
- **Modèles** :
  - رَجَعَ بَاسِمٌ مِنَ السُّوقِ فَرِحًا. « Bāsim est revenu du marché tout joyeux. »
  - دَخَلَ الطِّفْلُ الْبَيْتَ ضَاحِكًا. « L'enfant est entré dans la maison en riant. »
  - شَرِبْتُ الْمَاءَ بَارِدًا. « J'ai bu l'eau fraîche (alors qu'elle était fraîche). » (le ḥāl porte sur le complément)
  - جَلَسَ الشَّيْخُ وَحْدَهُ. « Le vieil homme s'est assis seul. »
  - دَخَلَ نَدِيمٌ الْمَجْلِسَ وَهُوَ يَحْمِلُ رِسَالَةً. « Nadīm est entré dans l'assemblée en portant une lettre. »
  - كَيْفَ رَجَعَتْ سَلْمَى؟ — رَجَعَتْ رَاكِبَةً. « Comment Salmā est-elle revenue ? — À dos de monture. »
- **Pièges** :
  - Ḥāl indéfini en -a ≠ adjectif défini : رَجَعَ الْحَارِسُ الْفَرِحُ (« le gardien joyeux ») / رَجَعَ الْحَارِسُ فَرِحًا (« joyeux, en revenant »).
  - Ḥāl ≠ complément direct : il répond à « comment ? », pas à « quoi ? ».
  - وَ du ḥāl (وَهُوَ…) ≠ وَ « et ».
  - ⚠ ḥāl jamais : خَائِفًا, قَائِمًا, وَحِيدًا, ضَعِيفًا, شَيْخًا, مَرَحًا, جَمِيعًا, صَفًّا, رُكْبَانًا, سِرَاعًا, رَاضِيَةً, فَرِحِينَ (pluriel), ni مَسْرُورًا avec أَهْل / انْقَلَبَ / كَانَ.
  - ⚠ ضَحِكَ : jamais ضَحِكَتْ, يَضْحَكُونَ, تَبَسَّمَ, ni avec بَكَى dans la même phrase ; jamais ضَاحِكَة avec وَجْه.
  - ⚠ وَحْدَهُ : sujet humain seulement ; jamais avec ذُكِرَ ni un nom divin.
  - ⚠ « وَهُوَ » + mot : jamais سَقِيم, كَظِيم, مُلِيم, مُحْسِن, ni يَعِظُهُ / يُحَاوِرُهُ ; ni حَمَلَ + كُتُب (ni âne chargé de livres).
  - ⚠ كَيْفَ jamais avec كَانَ, نَظَرَ / انْظُرْ, فَعَلَ, خُلِقَ, رَأَى.
  - ⚠ جَاءَ + ḥāl : jamais un pluriel en pleurs, ni تَمْشِي, ni رَجُل.
- **Reporté** : le ḥāl en phrase verbale sans وَ ; le participe des verbes défectueux (مَاشٍ).

**4.7 La précision : le tamyīz (Place des conteurs)**
- **Objectif** : préciser « en quoi » ou « de quoi » après كَمْ, un nombre, un comparatif ou un verbe.
- **Règle** : « Le tamyīz est un nom indéfini en -a qui précise de quoi l'on parle, après كَمْ, un nombre de 11 à 99, un comparatif ou certains verbes : كَمْ دِرْهَمًا؟ ، أَكْبَرُ سِنًّا. »
- **Mots (5)** :
  - تَمْيِيزٌ | (en grammaire) tamyīz, précision | R myz
  - كَمْ | combien ? | L kam
  - عِشْرُونَ | vingt | L Ei$oruwn ; le système des dizaines vient en 4.14
  - امْتَلَأَ | se remplir | L {mtala>o (forme VIII, hamza) | formes : امْتَلَأَ, امْتَلَأَتْ, يَمْتَلِئُ
  - سِنٌّ | âge (dans أَكْبَرُ سِنًّا) | R snn ; le lemme du Corpus a un autre sens (« dent »)
- **Modèles** :
  - كَمْ دِرْهَمًا فِي الْكِيسِ؟ — فِي الْكِيسِ عِشْرُونَ دِرْهَمًا. « Combien de dirhams y a-t-il dans la bourse ? — Il y a vingt dirhams. »
  - كَمْ طَالِبًا فِي الْمَدْرَسَةِ؟ « Combien d'étudiants y a-t-il à l'école ? »
  - سَمِيرٌ أَكْبَرُ سِنًّا مِنْ بَاسِمٍ. « Samīr est plus âgé que Bāsim. »
  - هَٰذَا الْجَمَلُ أَسْرَعُ مَشْيًا مِنَ الْحِمَارِ. « Ce chameau marche plus vite que l'âne. »
  - امْتَلَأَتِ السَّلَّةُ تَمْرًا. « Le panier s'est rempli de dattes. »
  - سَمِيرٌ أَكْثَرُ كُتُبًا مِنْ بَاسِمٍ. « Samīr a plus de livres que Bāsim. »
- **Pièges** :
  - Après كَمْ : un **singulier** en -a, contrairement au français (« combien de livres »).
  - Tamyīz (« en quoi ? ») ≠ ḥāl (« comment ? »).
  - عِشْرُونَ ne change pas selon le genre.
  - ⚠ jamais كَمْ مِنْ (كَمْ d'exclamation) ; jamais كَمْ + لَبِثَ / تَرَكَ / أَرْسَلَ / أَهْلَكَ.
  - ⚠ tamyīz jamais après أَحْسَنُ, أَشَدُّ, خَيْرٌ, أَقَلُّ, أَعَزُّ, أَهْدَى, ni après كَفَى, سَاءَ, كَبُرَتْ, حَسُنَ.
  - ⚠ jamais مَالًا, عَدَدًا, جَمْعًا, قَوْلًا, عَمَلًا, ni أَكْثَرُ مِنْكَ.
  - ⚠ jamais مِلْء, مُلِئَتْ, « هَلِ امْتَلَأْتِ », ni رَأْس + tamyīz.
  - ⚠ عِشْرُونَ jamais avec صَابِرُونَ ; سِنّ jamais seul ni au génitif (« بِالسِّنِّ »).
- **Reporté** : les mesures (رِطْلٌ زَيْتًا : mots absents du Corpus) ; كَمْ d'exclamation.

**4.8 « Il a frappé un coup » : le mafʿūl muṭlaq (Place des conteurs)**
- **Objectif** : renforcer un verbe, dire la manière ou le nombre de fois avec son nom d'action.
- **Règle** : « Le mafʿūl muṭlaq est le nom d'action du verbe lui-même, en -a : طَرَقَ الْبَابَ طَرْقًا. Seul, il insiste ; avec un adjectif ou un complément, il dit la manière ; au duel ou avec مَرَّةً, il compte. »
- **Mots (4)** :
  - مُطْلَقٌ | (en grammaire) absolu ; مَفْعُولٌ مُطْلَقٌ | R Tlq
  - مَرَّةٌ | fois | L mar~ap
  - جِدًّا | très (c'est un mafʿūl muṭlaq figé) | R jdd ; le lemme du Corpus (جَدّ) a un autre sens
  - طَرْقَةٌ | un coup (frappé à la porte) | R Trq ; nom « d'une fois » de طَرَقَ (moule فَعْلَة, dit dans la leçon)
- **Modèles** :
  - طَرَقَ بَاسِمٌ الْبَابَ طَرْقًا خَفِيفًا. « Bāsim a frappé doucement à la porte. »
  - طَرَقَ الْحَارِسُ الْبَابَ طَرْقَتَيْنِ. « Le gardien a frappé deux coups à la porte. »
  - فَرِحَ الطِّفْلُ فَرَحًا كَبِيرًا. « L'enfant s'est beaucoup réjoui. »
  - مَشَى بَاسِمٌ مَشْيًا سَرِيعًا. « Bāsim a marché d'un pas rapide. »
  - جَلَسَ سَمِيرٌ جُلُوسَ الْكَاتِبِ. « Samīr s'est assis comme un scribe. »
  - الطَّرِيقُ طَوِيلٌ جِدًّا. « Le chemin est très long. »
- **Pièges** :
  - On prend le nom d'action **de la fiche** (un seul par verbe, décision de 3.4).
  - Mafʿūl muṭlaq ≠ complément direct : طَرَقَ الْبَابَ (quoi ?) / طَرْقًا (comment ?).
  - فَعْلَة (« une fois ») ≠ فِعْلَة (« manière »), aperçu seulement.
  - ⚠ jamais : كَلَّمَ تَكْلِيمًا, مَدًّا, عَدًّا, حُبًّا, أَكْلًا, قَوْلًا, وَعْدًا, ذِكْرًا, صَبْرًا, شُكْرًا, نَظْرَةً, فَعْلَةً, ni un nom d'action répété (دَكًّا دَكًّا).
  - ⚠ jamais un nom d'action suivi de جَمِيلًا, بَعِيدًا, عَظِيمًا ou كَثِيرًا (« ذِكْرًا كَثِيرًا »), ni de وَاحِدَة (« صَيْحَةً وَاحِدَةً »).
  - ⚠ jamais صَيْحَة, نَفْخَة, غَرْفَة, قَبْضَة, بَغْتَة ; jamais « أَوَّلَ مَرَّةٍ », « مَرَّةً أُخْرَى », ni مَرَّتَيْنِ avec عَذَّبَ, أَجْر, أَفْسَدَ.
  - ⚠ نَامَ نَوْمًا طَوِيلًا seulement pour une nuit, jamais pour des années.
  - ⚠ ضَرَبَ et ضَرْبٌ jamais (B4).
- **Reporté** : شُكْرًا « merci » (formule de politesse, en 4.19, avec sa liste ⚠) ; les substituts du nom d'action (كُلَّ, بَعْضَ).

**4.9 « Il l'a fait par peur » : le mafʿūl li-aǧlih (Place des conteurs)**
- **Objectif** : dire le motif d'une action avec un nom d'action.
- **Règle** : « Le mafʿūl li-aǧlih est un nom d'action en -a, souvent un sentiment ou une intention, qui dit pourquoi l'on agit ; il répond à لِمَاذَا : بَكَى الطِّفْلُ خَوْفًا مِنَ الْكَلْبِ. »
- **Mots (4)** :
  - لِأَجْلِ | pour, à cause de ; مَفْعُولٌ لِأَجْلِهِ | L >ajol
  - فَعَلَ | faire | L faEala | formes : فَعَلَ, فَعَلَتْ, فَعَلْتُ, يَفْعَلُ, أَفْعَلُ
  - تِجَارَةٌ | commerce | L tija`rap
  - رِبْحٌ | gain, profit | R rbH
- **Modèles** :
  - بَكَى الطِّفْلُ خَوْفًا مِنَ الْكَلْبِ. « L'enfant a pleuré de peur du chien. »
  - قَدَّمَ التَّاجِرُ التَّمْرَ لِلضُّيُوفِ إِكْرَامًا لَهُمْ. « Le marchand a offert des dattes aux invités pour les honorer. »
  - سَافَرَ التَّاجِرُ إِلَى بَغْدَادَ طَلَبًا لِلرِّبْحِ. « Le marchand est parti pour Bagdad en quête de profit. »
  - لَبِسَ بَاسِمٌ ثَوْبَيْنِ خَوْفًا مِنَ الْبَرْدِ. « Bāsim a mis deux vêtements par crainte du froid. »
  - لِمَاذَا فَعَلْتَ ذَٰلِكَ؟ → **retiré** (« فَعَلْتَ » : voir pièges). À la place : لِمَاذَا سَافَرَ التَّاجِرُ؟ — طَلَبًا لِلتِّجَارَةِ. « Pourquoi le marchand est-il parti ? — Pour le commerce. »
- **Pièges** :
  - Mafʿūl li-aǧlih (pourquoi ?) ≠ ḥāl (comment ?) ≠ mafʿūl muṭlaq (même verbe).
  - On peut dire la même chose avec لِـ ou مِنْ : مِنَ الْخَوْفِ.
  - ⚠ jamais : خَوْفًا وَطَمَعًا, طَمَعًا, رَغَبًا, ابْتِغَاءَ, حَذَرَ, خَشْيَةَ, حَسَدًا, بَغْيًا, رِئَاءَ, حُبًّا ; jamais خَوْفًا avec دَعَا, يُرِي ou بَرْق ; jamais « مِنْ أَجْلِ ذَٰلِكَ ».
  - ⚠ Pas de motif religieux (prière, jeûne, aumône, pèlerinage).
  - ⚠ Pas de « se lever par respect pour quelqu'un » : c'est une question de pratique discutée par les savants, qu'on n'affirme pas.
  - ⚠ فَعَلَ : jamais à l'impératif ; jamais avec ـهُ, هَٰذَا, فَعْلَة ; jamais « فَعَلْتَ » ; jamais de sujet divin ; jamais « مَا لَا تَفْعَلُونَ ».
  - ⚠ تِجَارَة jamais avec لَهْو, بَيْع (dans la même phrase), رَأَى, تَرَكَ, تُنْجِي, « لَنْ تَبُورَ », رَبِحَتْ.
  - ⚠ « طَلَبُ الْعِلْمِ » est écarté : il rappelle un hadith.

**4.10 Sauf, excepté (Jardin des maximes, Hāla)**
- **Objectif** : exclure un élément ; dire « seulement » avec une négation.
- **Règle 1** : « Après une phrase complète et affirmative, le nom après إِلَّا est en -a : حَضَرَ الطُّلَّابُ إِلَّا سَمِيرًا. غَيْرُ prend ce même cas, et le nom qui le suit est au génitif : حَضَرَ الطُّلَّابُ غَيْرَ سَمِيرٍ. »
- **Règle 2** : « Après une négation, إِلَّا veut dire « seulement », et le nom garde le cas de sa fonction : مَا حَضَرَ إِلَّا بَاسِمٌ. »
- **Mots (6)** :
  - إِلَّا | sauf ; (après une négation) seulement | L <il~aA
  - غَيْرُ | autre que, sauf ; non- | L gayor
  - كُلٌّ | tout, tous (كُلُّ الطُّلَّابِ) | L kul~
  - أَحَدٌ | quelqu'un ; (avec négation) personne | L >aHad
  - حَضَرَ | être présent, venir (à une réunion) | L HaDara | يَحْضُرُ
  - اسْتِثْنَاءٌ | exception | R vny
- **Modèles** :
  - حَضَرَ الطُّلَّابُ إِلَّا سَمِيرًا. « Les étudiants sont venus, sauf Samīr. »
  - نَامَ الْمُسَافِرُونَ إِلَّا الْحَارِسَ. « Les voyageurs ont dormi, sauf le gardien. »
  - قَرَأْتُ الرَّسَائِلَ إِلَّا رِسَالَةَ هَالَةَ. « J'ai lu les lettres, sauf celle de Hāla. »
  - مَا فِي الْكِيسِ إِلَّا دِرْهَمٌ. « Il n'y a qu'un dirham dans la bourse. »
  - مَا حَضَرَ أَحَدٌ إِلَّا بَاسِمٌ. « Personne n'est venu, sauf Bāsim. »
  - أُرِيدُ ثَوْبًا غَيْرَ الثَّوْبِ الْأَحْمَرِ. « Je veux un autre vêtement que le rouge. »
- **Pièges** :
  - Le cas après إِلَّا dépend de la phrase : complète et affirmative → -a ; niée → cas de la fonction.
  - غَيْرُ se met lui-même au cas ; le nom qui suit est au génitif ; jamais الْغَيْر.
  - كُلُّ dans ce niveau : seulement avec un pluriel défini (كُلُّ الطُّلَّابِ) ou après lui (الرَّسَائِلَ كُلَّهَا).
  - ⚠ jamais لَا + nom + إِلَّا ; jamais إِلَّا suivi de : اللَّه, هُوَ, أَنَا, الَّذِينَ, مَنْ, مَا, أَنْ, قَلِيلًا, وَاحِدَة, يَوْمًا, عَشْرًا, خَمْسِينَ, امْرَأَتَهُ, ou un nom propre du Coran.
  - ⚠ jamais مَا / إِنْ + هَٰذَا / هُوَ / أَنْتَ / أَنْتُمْ + إِلَّا ; jamais مَسَاكِن + إِلَّا.
  - ⚠ غَيْرُ jamais avec un pronom (غَيْرُهُ), بِغَيْرِ, هَٰذَا (« غَيْرَ هَٰذَا »), عِلْم, حَقّ, حِسَاب, ni un participe passif.
  - ⚠ كُلّ jamais avec شَيْء, نَفْس, مَنْ, يَوْم, قَرْيَة, بَاب, مَكَان, ثَمَرَات, أُمَّة ; jamais كُلٌّ seul, كُلُّهُمْ, كُلَّمَا, « الْأَسْمَاءَ كُلَّهَا ».
  - ⚠ أَحَد jamais avec اللَّه, هُوَ, كُفُو, فَرَّقَ / بَيْنَ, مِنْكُمْ, أَحَدُكُمْ, أَحَدَنَا ; jamais « لَمْ يَكُنْ … أَحَدٌ ».
  - ⚠ حَضَرَ jamais avec الْمَوْت ni قِسْمَة ; jamais حَضَرُوهُ.
- **Reporté** : سِوَى ; كُلُّ + singulier indéfini (« chaque »), qui a sa propre liste ⚠.

**4.11 « Ô vous… » : l'appel (Jardin des maximes)**
- **Objectif** : appeler quelqu'un correctement.
- **Règle 1** : « Après يَا, un nom propre ou une personne précise prend -u sans tanwīn : يَا بَاسِمُ، يَا حَارِسُ. Un nom suivi d'un complément prend -a : يَا صَاحِبَ الْبَيْتِ، يَا أَبَا سَمِيرٍ. »
- **Règle 2** : « Devant un nom avec الْ, on ajoute أَيُّهَا (أَيَّتُهَا au féminin), et le nom reste en -u : يَا أَيُّهَا الطَّالِبُ. »
- **Mots (6)** :
  - أَيُّهَا / أَيَّتُهَا | (mot d'appel devant الْ) | L >ay~uhaA, >ay~atuhaA (une seule fiche)
  - صَاحِبٌ | compagnon ; propriétaire (صَاحِبُ الْبَيْتِ) | L SaAHib
  - نَادَى | appeler (à haute voix) | L naAdaY` | formes : نَادَى, نَادَتْ, يُنَادِي
  - نِدَاءٌ | appel ; (en grammaire) l'appel | L nidaA^'
  - حَاضِرٌ | présent ; الْحَاضِرُونَ : l'assistance | R HDr
  - زَائِرٌ | visiteur | R zwr
- **Modèles** :
  - يَا هَالَةُ، أَيْنَ الْمِفْتَاحُ؟ « Hāla, où est la clé ? »
  - يَا حَارِسُ، افْتَحِ الْبَابَ. « Gardien, ouvre la porte ! »
  - يَا صَاحِبَ الْقَافِلَةِ، مَتَى نَنْطَلِقُ؟ « Chef de caravane, quand partons-nous ? »
  - يَا أَبَا سَمِيرٍ، هَٰذِهِ رِسَالَتُكَ. « Père de Samīr, voici ta lettre. »
  - يَا أَيُّهَا الطَّالِبُ، اكْتُبِ الْجَوَابَ. « Étudiant, écris la réponse ! »
  - يَا أَيُّهَا الْحَاضِرُونَ، هَٰذِهِ قِصَّةُ التَّاجِرِ. « Assistance, voici l'histoire du marchand. »
  - نَادَى نَدِيمٌ بَاسِمًا. « Nadīm a appelé Bāsim. »
- **Pièges** :
  - يَا بَاسِمُ, jamais « يَا بَاسِمٌ ».
  - أَيُّهَا seulement devant الْ ; elle ne change jamais.
  - يَا + ـِي (يَا صَدِيقِي) : en aperçu.
  - ⚠ jamais يَا أَيُّهَا + النَّاسُ, الَّذِينَ, الَّذِي, النَّبِيُّ, الرَّسُولُ, الرُّسُلُ, الْإِنْسَانُ, الْمَلَأُ, الْعَزِيزُ, السَّاحِرُ, النَّمْلُ, الْكَافِرُونَ, الْمُؤْمِنُونَ, الْمُجْرِمُونَ, الْمُزَّمِّلُ, الْمُدَّثِّرُ ; jamais أَيَّتُهَا + الْعِيرُ / النَّفْسُ.
  - ⚠ jamais يَا قَوْمِ, يَا بُنَيَّ, يَا أَبَتِ, يَا أَبَانَا, يَا بَنِيَّ, يَا ابْنَ أُمَّ, يَا أُخْتَ, يَا أَهْلَ, يَا صَاحِبَيِ, يَا عِبَادِ, يَا رَبِّ ; jamais يَا + نَار / أَرْض / سَمَاء / جِبَال ; jamais يَا حَسْرَةً / وَيْلَتَى / أَسَفَى / بُشْرَى.
  - ⚠ نَادَى : jamais un père qui appelle son fils, ni un appel « sous » quelque chose (تَحْت, نَخْلَة), ni « dans les ténèbres », ni derrière des chambres ; jamais مُنَادٍ ; jamais avec un pronom collé.
  - ⚠ صَاحِب jamais avec un pronom (صَاحِبُهُ), ni avec الْحُوت ou السِّجْن ; jamais أَصْحَاب.
  - ⚠ Pas d'invités qui arrivent chez un hôte inquiet.
  - ⚠ اسْتَمِعُوا jamais : il rappelle l'écoute du Coran.
- **Reporté** : l'appel d'un indéfini (يَا رَجُلًا…) ; l'appel abrégé.

**4.12 Insister (Jardin des maximes)**
- **Objectif** : renforcer une affirmation ou une promesse.
- **Règle 1** : « قَدْ + passé dit qu'une action est bien faite : قَدْ وَصَلَتِ الْقَافِلَةُ ; قَدْ + inaccompli veut dire « parfois, peut-être » : قَدْ يَتَأَخَّرُ بَاسِمٌ. »
- **Règle 2** : « لَـ renforce l'attribut après إِنَّ (إِنَّ الطَّرِيقَ لَطَوِيلٌ). ـَنَّ, à la fin d'un inaccompli précédé de لَـ ou de لَا, en fait une promesse ou une défense ferme : لَأَكْتُبَنَّ. »
- **Mots (5)** :
  - قَدْ | (insiste sur le passé) ; parfois | L qad
  - لَـ (d'insistance) | vraiment | préfixe, sans lemme
  - تَوْكِيدٌ | insistance ; نُونُ التَّوْكِيدِ | L tawokiyd
  - طَالَ | être long, durer | L TaAla | formes : طَالَ, طَالَتْ, يَطُولُ
  - أَبَدًا | jamais (avec une négation) | L >abad
- **Modèles** :
  - قَدْ وَصَلَتِ الْقَافِلَةُ. « La caravane est bien arrivée. »
  - قَدْ يَتَأَخَّرُ بَاسِمٌ. « Il arrive que Bāsim soit en retard. »
  - إِنَّ الطَّرِيقَ لَطَوِيلٌ. « Le chemin est vraiment long. »
  - لَقَدْ فَهِمْتُ الدَّرْسَ. « J'ai vraiment compris la leçon. »
  - لَأَكْتُبَنَّ الرِّسَالَةَ غَدًا. « J'écrirai la lettre demain, sans faute. »
  - لَا تَتْرُكَنَّ الْبَابَ مَفْتُوحًا. « Ne laisse surtout pas la porte ouverte. »
  - لَنْ أَنْسَى هَٰذِهِ الْقِصَّةَ أَبَدًا. « Je n'oublierai jamais cette histoire. »
- **Formes avec ـَنَّ** : seulement أَنَا, نَحْنُ, أَنْتَ, هُوَ, avec des verbes sains (أَكْتُبَنَّ, نَحْفَظَنَّ, تَتْرُكَنَّ). La forme légère ـَنْ et les autres personnes : tableau seulement.
- **Pièges** :
  - قَدْ + passé ≠ قَدْ + inaccompli.
  - لَـ (insistance) ≠ لِـ (préposition) ≠ لَا.
  - Après إِنَّ, لَـ va sur l'attribut, jamais sur le sujet ; pas d'attribut en tête (règle de 3.31).
  - La phrase avec لَـ et ـَنَّ répond, en arabe classique, à un serment sous-entendu ; **on n'écrit jamais le serment** (5.1).
  - ⚠ قَدْ / لَقَدْ seulement avec : وَصَلَ, كَتَبَ, فَتَحَ, انْتَهَى, رَجَعَ, نَامَ, حَفِظَ, فَهِمَ, تَعَلَّمَ, أَصْلَحَ, بَاعَ, طَالَ (+ الطَّرِيقُ / السَّفَرُ), يَتَأَخَّرُ, يَنْسَى.
  - ⚠ jamais وَلَقَدْ ; jamais قَدْ / لَقَدْ avec أَفْلَحَ, جَاءَ, سَمِعَ, عَلِمَ, رَأَى / نَرَى, كَانَ, خَلَقَ, آتَى, أَرْسَلَ, صَدَقَ, عَدَّ, بَلَغَ, ni un sujet divin.
  - ⚠ ـَنَّ jamais avec أَمْلَأَ, قَطَّعَ, أَخْرَجَ, رَجَعَ (+ الْمَدِينَة), قَالَ, مَدَّ, كَانَ, حَسِبَ, أُوتِيَ ; jamais « لَا تَمُدَّنَّ », « لَا تَقُولَنَّ », « فَلَا تَكُونَنَّ ».
  - ⚠ jamais مَال et وَلَد ensemble.
  - ⚠ jamais لَئِنْ.
  - ⚠ أَبَدًا jamais avec دَخَلَ, خَرَجَ, انْقَلَبَ, قَامَ, خَالِدِين, « إِذًا أَبَدًا », « فِيهِ أَبَدًا ».
  - ⚠ طَالَ jamais suivi de عَلَيْهِمْ / عَلَيْكُمْ.
  - ⚠ Pas de maxime « إِنَّ … لَصَوْتُ… » (B6).
- **Reporté** : les formules de serment (5.1) ; إِنَّمَا (5.2).

**4.13 Relier les idées (Bureau des comptes, Hāla)**
- **Objectif** : relier deux phrases selon le sens.
- **Règle** : « فَـ relie deux actions qui se suivent aussitôt, ou une cause et sa suite ; ثُمَّ, deux actions séparées par un temps. بَلْ corrige (« non pas…, mais »), لَٰكِنْ oppose, et أَمَّا… فَـ met un mot en avant : أَمَّا بَاسِمٌ فَمَشْغُولٌ. »
- **Mots (4, plus les sens nouveaux de فَـ)** :
  - بَلْ | mais plutôt, au contraire | L bal
  - لَٰكِنْ | mais (léger) | L la`kin
  - أَمَّا… فَـ | quant à… | L >am~aA
  - أَوْ | ou | L >aw
- **Modèles** :
  - دَخَلَ نَدِيمٌ فَجَلَسَ. « Nadīm est entré et s'est aussitôt assis. »
  - قَرَأَ سَمِيرٌ الرِّسَالَةَ ثُمَّ كَتَبَ الْجَوَابَ. « Samīr a lu la lettre, puis il a écrit la réponse. »
  - مَا حَضَرَ سَمِيرٌ، بَلْ بَاسِمٌ. « Ce n'est pas Samīr qui est venu, mais Bāsim. »
  - لَمْ يَكْتُبْ سَمِيرٌ الرِّسَالَةَ، لَٰكِنْ كَتَبَتْهَا سَلْمَى. « Samīr n'a pas écrit la lettre, mais Salmā l'a écrite. »
  - أَمَّا بَاسِمٌ فَمَشْغُولٌ، وَأَمَّا سَمِيرٌ فَفِي الْمَدْرَسَةِ. « Quant à Bāsim, il est occupé ; quant à Samīr, il est à l'école. »
  - سَنُسَافِرُ غَدًا أَوْ بَعْدَ غَدٍ. « Nous partirons demain ou après-demain. »
- **Pièges** :
  - Après أَمَّا, فَـ est obligatoire.
  - أَمَّا ≠ إِمَّا ≠ أَمْ.
  - لَٰكِنْ (+ verbe ou nom au cas normal) ≠ لَٰكِنَّ (+ nom en -a).
  - بَلْ n'est employé qu'avec des verbes ou après مَا / لَمْ + verbe (jamais après لَيْسَ : le cas du nom qui suit y varie).
  - ⚠ أَمَّا jamais avec جِدَار, سَفِينَة, غُلَام, يَتِيم, سَائِل, مَنْ, الَّذِينَ, ni كَانَ dans la réponse.
  - ⚠ بَلْ jamais suivi d'un pronom (بَلْ هُوَ / هُمْ / أَنْتُمْ / نَحْنُ), de اللَّه, الْإِنْسَان, لَا, أَكْثَر, ni de قَالُوا, كَانُوا, كَذَّبُوا, عَجِبُوا, جَاءَ, فَعَلَهُ.
  - ⚠ وَلَٰكِنْ jamais suivi de لَا, كَانُوا, أَكْثَر, اللَّه, هُمْ.
  - ⚠ فَـ jamais en tête de : فَلَمَّا, فَإِذَا, فَانْطَلَقَا, فَوَجَدَا, فَأَصْبَحَ, فَنَظَرَ, فَتَبَسَّمَ, فَخَرَجَ (+ عَلَى / مِنْهَا), فَرَجَعَ (+ إِلَى قَوْمِهِ).
  - ⚠ Bureau des comptes : pas de marchands qui trichent à la balance (B5).
- **Reporté** : إِمَّا… وَإِمَّا ; أَمْ ; « أَمَّا بَعْدُ » (4.26) ; وَإِذْ, فَلَمَّا (5.8).

**4.14 Tous les nombres (Bureau des comptes)**
- **Objectif** : dire et écrire les nombres jusqu'à 1 000 avec le nom compté.
- **Règle 1 (3 à 10)** : « De 3 à 10, le nombre prend le genre inverse du singulier : ثَلَاثَةُ كُتُبٍ, mais ثَلَاثُ غُرَفٍ. »
- **Règle 2 (11 à 19)** : « 11 et 12 s'accordent avec le nom ; de 13 à 19, la 1re partie prend le genre inverse et عَشَرَ s'accorde : ثَلَاثَةَ عَشَرَ قَلَمًا, ثَلَاثَ عَشْرَةَ وَرَقَةً. »
- **Règle 3 (11 à 99)** : « De 11 à 99, le nom compté est un singulier indéfini en -a : عِشْرُونَ دِرْهَمًا. Les dizaines ne changent pas de genre ; l'unité vient d'abord : خَمْسَةٌ وَعِشْرُونَ دِرْهَمًا. »
- **Règle 4 (100 et 1 000)** : « مِائَةٌ et أَلْفٌ sont suivis d'un singulier au génitif : مِائَةُ دِرْهَمٍ, أَلْفُ دِينَارٍ. De 300 à 900 : ثَلَاثُمِائَةِ دِرْهَمٍ. »
- **Mots (5 fiches de nombres, plus les dizaines)** :
  - أَحَدَ عَشَرَ / إِحْدَى عَشْرَةَ | onze | L >aHad, <iHodaY, Ea$ar
  - اثْنَا عَشَرَ / اثْنَتَا عَشْرَةَ | douze | à vérifier (le Corpus montre les formes {vonayon et {vonatayon)
  - les dizaines ثَلَاثُونَ, أَرْبَعُونَ, خَمْسُونَ, سِتُّونَ, سَبْعُونَ, ثَمَانُونَ, تِسْعُونَ (عِشْرُونَ vu en 4.7) | L à vérifier (خَمْسِين, سِتِّين, ثَمَانِين trouvés). Elles s'enseignent comme une seule règle (unité + ـُونَ, -īna à l'accusatif et au génitif), comme les trois tanwīn en région 1.
  - مِائَةٌ | cent | L miA}ap. Écrite مِائَةٌ comme dans les textes classiques ; l'alif ne se prononce pas (miʾa). Remarque : « on écrit aussi مِئَة ».
  - أَلْفٌ | mille | L >alof
- **Modèles** :
  - فِي الْمَدْرَسَةِ ثَلَاثُ غُرَفٍ. « Il y a trois pièces à l'école. »
  - فِي الْكِيسِ خَمْسَةَ عَشَرَ دِرْهَمًا. « Il y a quinze dirhams dans la bourse. »
  - عِنْدَ التَّاجِرِ ثَلَاثُونَ جَمَلًا. « Le marchand a trente chameaux. »
  - كَتَبَ سَمِيرٌ خَمْسًا وَعِشْرِينَ رِسَالَةً. « Samīr a écrit vingt-cinq lettres. »
  - ثَمَنُ الْبِسَاطِ مِائَةُ دِرْهَمٍ. « Le prix du tapis est de cent dirhams. »
  - فِي الصُّنْدُوقِ أَلْفُ دِينَارٍ. « Il y a mille dinars dans le coffre. »
- **Noms comptés admis** (liste fermée) : دِرْهَم, دِينَار, كِتَاب, قَلَم, رِسَالَة, وَرَقَة, سَطْر, كَلِمَة, طَالِب, تَاجِر, جَمَل, كِيس, صُنْدُوق, بِسَاط, غُرْفَة, بَيْت, قَمِيص, ثَوْب.
- **Pièges** :
  - 3 à 10 : pluriel au génitif ; 11 à 99 : singulier en -a ; 100 et 1 000 : singulier au génitif.
  - De 11 à 19, le nombre finit toujours en -a, sauf اثْنَا / اثْنَيْ.
  - عَشْرَةَ (avec sukūn) au féminin, après 13 à 19 ; عَشْرُ وَرَقَاتٍ ≠ عَشَرَةُ كُتُبٍ.
  - Le « huit » féminin (ثَمَانِي, ثَمَانٍ) : tableau seulement, jamais exercé.
  - مِائَتَا دِرْهَمٍ (200) : en aperçu.
  - ⚠ aucun nombre avec un mot du temps (B9), ni avec سَمَاء, أَرْض, بَحْر, بَاب / أَبْوَاب, بَقَرَة, سُنْبُلَة, حَبَّة, عَيْن, كَوْكَب, نَجْم, كَلْب, طَيْر, رَجُل / رَهْط, مِسْكِين, شَاهِد / شُهَدَاء, جَلْدَة, ذِرَاع, مَلَك, آيَة, أَخ / إِخْوَة, نَقِيب.
  - ⚠ jamais : تِسْعَةَ عَشَرَ, تِسْعٌ وَتِسْعُونَ, ثَلَاثُ مِائَةٍ en deux mots, مِائَتَيْنِ / أَلْفَيْنِ avec غَلَبَ, عِشْرُونَ avec صَابِرُونَ, بِدِينَارٍ, « دَرَاهِمَ مَعْدُودَةٍ ».
  - ⚠ Pas de vente d'une personne.
- **Garde-fou** : أَحَدَ عَشَرَ et اثْنَا عَشَرَ (sous toutes leurs formes) se suivent dans le Coran ; le contrôle des paires les signalera sans doute → **point E1**.
- **Reporté** : au-delà de 1 000 (آلَاف) ; les nombres ordinaux ; les dates.

**Atelier des phrases (tout le niveau)** :
- relier deux phrases par إِذَا, لِأَنَّ, لَمَّا, حَتَّى ou فَـ (choix entre 3 ou 4) ;
- passer du discours direct au discours indirect (4.3) ;
- transformer « رَجَعَ بَاسِمٌ. بَاسِمٌ فَرِحٌ. » en « رَجَعَ بَاسِمٌ فَرِحًا. » ;
- ajouter un mafʿūl muṭlaq ou un tamyīz ;
- écrire un compte en toutes lettres (4.14).

### D. Prérequis manquants et comment les introduire

| Il faut | Pour | Introduit en |
| --- | --- | --- |
| فَـ (réponse de condition) | 4.1 | 4.1, sens limité (B2) ; tous les sens en 4.13 |
| لَـ (réponse) | 4.2 | 4.2 ; insistance en 4.12 |
| مَالٌ | 4.2 | 4.2 |
| مَتَى | 4.4 | 4.4 |
| لِمَاذَا | 4.5, 4.9 | 4.5 |
| كَيْفَ | 4.6 | 4.6 |
| كَمْ, عِشْرُونَ | 4.7, 4.14 | 4.7 |
| فَعَلَ | 4.9 | 4.9 |
| كُلٌّ, أَحَدٌ | 4.10, 4.14 | 4.10 |
| أَوْ | 4.13 | 4.13 |
| Nom féminin compté de 3 à 10 | 4.14 | 4.14, règle 1 (annoncé en 2.19) |
| Mots du temps (يَوْم, شَهْر, سَنَة, عَام, سَاعَة) | — | **Pas dans ce niveau** : 4.18 |
| إِلَيَّ, عَلَيَّ (pronoms collés irréguliers) | — | Évités dans les modèles ; à vérifier avant tout emploi |

### E. Points pour l'utilisateur

1. **Les nombres 11 et 12 face au contrôle des paires.**
   - Le journal (§16, 25/10/2026) dit : « toute paire signalée est remplacée ».
   - Or « أَحَدَ عَشَرَ » et « اثْنَا عَشَرَ » s'écrivent en deux mots qui se suivent dans le Coran. On ne peut pas dire « onze » ou « douze » autrement. Je ne peux pas contredire seul une règle du §16 : je te soumets donc la question.
   - **Recommandation** : une exception limitée.
     - Elle couvre le nom de ces deux nombres, sous toutes leurs formes (au masculin et au féminin, à tous les cas).
     - Elle s'applique seulement quand le nom compté vient de la liste fermée de 4.14 : jamais كَوْكَب, نَجْم, شَهْر, عَيْن, نَقِيب, أَخ.
     - Raison : le nom d'un nombre n'est pas un extrait.
     - 19, 99 et 300 en deux mots ne sont jamais employés : on n'en a pas besoin.
   - **Alternative** : pas d'exception. 4.14 enseigne alors 13 à 99 (sauf 19 et 99), 100 et 1 000, sans 11 ni 12, avec seulement une phrase en français : « 11 et 12 suivent une règle à part, vue plus tard ».
   - En attendant ta réponse, l'écran sur 11 et 12 est écrit, mais il n'est pas publié.
2. **Information sur le nom نَدِيم (aucune décision demandée).**
   - Dans les textes anciens, نَدِيم désigne le compagnon de veillée d'un prince, souvent aussi son compagnon de table.
   - « Compagnon de conversation » est exact mais incomplet. Je propose d'écrire « compagnon de veillée et de conversation » dans la proposition de région 4.
   - Le prénom reste valable. Les noms sont validés par toi (§8.2).

## Pourquoi

- **Cahier** : le plan suit le §5.8 (l. 340-357), avec le contenu de chaque leçon tel qu'il est écrit. Il suit aussi la proposition de région 4 (lieux et maîtres). L'audio reste suspendu (§16, 03/11).
- **Décisions respectées** :
  - §16 du 25/10 : garde-fou et paires. La seule exception envisagée est soumise à l'utilisateur (E1).
  - Intermédiaire 3 : liste fermée de formes pour les verbes irréguliers ; لَٰكِنْ avec petit alif ; فَـ gardé pour 4.1 et 4.13 ; liste des verbes sûrs pour la défense ; قَالَ suivi de إِنَّ.
  - Intermédiaire 1 et 2 : noms divins, رَسُولٌ exclu, pas de sujet divin.
  - Élémentaire 3 : impératifs de mouvement employés seuls.
  - 2.19 : le nom féminin compté de 3 à 10, annoncé « pour plus tard », est enseigné ici.
- **Grammaire** : arabe classique sûr.
  - Réponse de la condition avec فَـ dans les cas classiques. لَوْ / لَوْلَا avec لَـ.
  - أَنَّ / أَنْ dans le discours rapporté.
  - Ḥāl, tamyīz, mafʿūl muṭlaq, mafʿūl li-aǧlih. Exception avec إِلَّا et غَيْرُ (complète, affirmative ou niée).
  - Appel avec أَيُّهَا. قَدْ, لَـ et nūn d'insistance. Accord des nombres.
- **Prudence** :
  - On écarte ضَرَبَ ; on retarde les mots du temps et كُلُّ + singulier.
  - Les maximes sont construites et jamais attribuées.
  - Rien sur le fait de se lever pour honorer quelqu'un : c'est une question de pratique, on renvoie aux savants.

## Confiance

- **Haute** : les règles de grammaire, l'ordre des leçons, l'accord des nombres, les choix de prudence (B4 à B9).
- **Moyenne-haute** : les lemmes. Il reste à confirmer en SQL :
  - le lemme de ضَحِكَ (la base montre `DaHikato`) ;
  - les dizaines 30, 40, 70 et 90, et « douze » ;
  - les mots notés R n'ont pas de fréquence.
- **Moyenne** :
  - Le nūn d'insistance sans serment écrit : c'est correct en classique (serment sous-entendu), mais on le limite par prudence à quatre personnes et à des verbes sûrs.
  - Le sens de ظَنَّ (« penser, croire ») et de ذَكَرَ (« mentionner ; se rappeler ») : sens linguistiques seulement, avec des listes ⚠ strictes.
- **Suites ⚠** : citées de mémoire, la liste est incomplète ; le garde-fou reste la vraie protection.

## Résumé pour l'utilisateur

Le plan des leçons 4.1 à 4.14 est prêt.
- **Contenu** : environ 70 mots nouveaux pour construire de vraies phrases longues : « si », « si seulement », « il a dit que », « quand », « parce que », « sauf », l'appel (« ô… »), l'insistance, les mots qui relient les idées, et les nombres jusqu'à 1 000.
- **Prudence** : les tournures proches du Coran sont écartées ; les maximes du Jardin sont inventées et signalées « rédigé par IA ».
- **Une question t'attend** : peut-on écrire « onze » et « douze » (أَحَدَ عَشَرَ, اثْنَا عَشَرَ), qui sont aussi deux mots qui se suivent dans le Coran ? Ma recommandation : oui, avec des noms profanes seulement.

À enregistrer dans `/home/user/iqura/docs/relectures/decisions-avance-1.md`.

Références :
- `/home/user/iqura/docs/CAHIER_DES_CHARGES.md` (§5.8 l. 336-384, §16 du 25/10/2026 et du 12/11/2026)
- `/home/user/iqura/docs/PROPOSITION_REGION_4.md`
- `/home/user/iqura/docs/relectures/decisions-intermediaire-3.md`, `decisions-intermediaire-2.md`, `decisions-intermediaire-1.md` (B5)
- `/home/user/iqura/tools/build_content/vocab/mots.json` (vocabulaire connu, noms d'action des fiches)
- `/home/user/iqura/tools/build_content/vocab.py` (l. 31-35 et 368-401 : les nombres comptent comme mots pleins dans le contrôle des paires)
- `/home/user/iqura/tools/build_content/quran_guard.py`
- `/home/user/iqura/tools/build_content/lessons/etape2/19-compter.json` (l. 175 : nom féminin compté « pour plus tard »)
- `/home/user/iqura/assets/content/iqura_content.db`

---

# Décisions — doutes restants du relecteur, Avancé 1 (4.1 à 4.14)

Stade : région 4, leçons 4.1 à 4.14 ; acquis : régions 1 à 3, plus le plan d'Avancé 1 (`/home/user/iqura/docs/relectures/decisions-avance-1.md`).

## Décisions

1. **(4.1) إِذَا et إِنْ : on retire le lien vers le lemme.**
   - **Motif** : on fait comme pour le لَا de défense. Les lemmes `<in` et `<i*aA` regroupent dans le Corpus des emplois que la fiche n'enseigne pas (négation, forme allégée, surprise). Le nombre affiché serait donc trompeur.
   - **Correction** : sur les deux fiches, ni lemme ni nombre. Remarque à ajouter : « mot très fréquent ; le Corpus compte ensemble ses différents emplois ».
   - Confiance : haute.

2. **(4.4) لَمَّا reste « particule ».**
   - **Motif** : c'est l'avis de Sībawayh (« particule d'un fait qui en entraîne un autre »). D'autres grammairiens en font un adverbe de temps ; les deux avis existent, et « particule » est le plus courant dans l'enseignement.
   - Aucune correction.
   - Confiance : moyenne. Ce n'est qu'une étiquette, rien n'est affirmé dans la règle.

3. **(4.6) حَالٌ : on garde le genre « m » et on ajoute une remarque.**
   - **Remarque** : « s'emploie aussi au féminin : حَالٌ حَسَنَةٌ ».
   - **Motif** : en classique, le mot s'emploie aux deux genres, et le champ n'accepte qu'une valeur.
   - Confiance : haute.

4. **(4.7) كَمْ + pluriel : on remplace les distracteurs.**
   - **Motif** : on ne marque pas comme faute une forme que les grammairiens de Koufa admettaient.
   - **Correction** : les distracteurs deviennent كَمْ دِرْهَمٌ ? (nominatif) et كَمِ الدِّرْهَمَ ? (défini). Explication : « après كَمْ, un singulier indéfini en -a : كَمْ دِرْهَمًا ? ».
   - Confiance : haute.

5. **(4.8) فَعْلَة / فِعْلَة : le report est acté.**
   - Le moule فِعْلَة (la manière) n'est pas nécessaire pour ce niveau. Il va avec les noms d'une fois et de manière, à reprendre en 5.9 ou plus tard.
   - Confiance : haute.

6. **(4.9) On remplace mon modèle « قَدَّمَ التَّمْرَ لِضُيُوفِهِ إِكْرَامًا لَهُمْ ».**
   - **Motif** : des invités honorés par un hôte qui leur sert à manger, c'est assez proche d'un récit du Coran (les hôtes d'Abraham) pour l'écarter. La prudence passe avant tout.
   - **Nouveau modèle** : « حَمَلَ بَاسِمٌ كِيسَ الْمُعَلِّمِ إِكْرَامًا لَهُ. » (« Bāsim a porté le sac du maître pour l'honorer. »)
   - **Règle ajoutée** : إِكْرَامًا ne s'emploie jamais avec ضَيْف ni avec de la nourriture.
   - Confiance : haute.

7. **(4.10) غَيْرُ : la forme sans tanwīn est voulue.**
   - **Motif** : le mot est toujours en annexion, et les grammaires le citent ainsi.
   - **Remarque à ajouter** : « toujours suivi d'un nom au génitif ».
   - **Sens** : « autre que, sauf ; non- (devant un adjectif) ».
   - Aucun exemple « non- » avec un participe passif (règle du plan).
   - Confiance : haute.

8. **(4.11) أَيُّهَا passe en « nom ».**
   - **Motif** : le Corpus le classe comme nom (NN), et c'est exact (أَيُّ est le nom appelé, suivi de هَا).
   - **Remarque à ajouter** : « mot d'appel : toujours entre يَا et un nom avec الْ ; il ne change jamais ».
   - **Effet** : le mot comptera dans le contrôle des paires. C'est une sécurité de plus.
   - Confiance : moyenne-haute.

9. **(4.13) لَٰكِنْ sans وَ devant une phrase verbale : on garde.**
   - **Motif** : devant une phrase, لَٰكِنْ allégé ouvre une nouvelle phrase, avec ou sans وَ. Les deux sont classiques.
   - **Correction** : une remarque dans la leçon, « on trouve souvent وَلَٰكِنْ », sans exemple avec وَلَٰكِنْ (B5 du plan).
   - Confiance : haute.

10. **(4.14) Fiches « أَحَدَ عَشَرَ » et « اثْنَا عَشَرَ » seules : conforme.**
    - Le titre d'une fiche est le nom du nombre, ce que l'exception de l'utilisateur couvre.
    - **Condition** : l'exemple de chaque fiche contient un nom compté de la liste fermée.
    - Confiance : haute.

**Écarts au plan, actés :**
- **لَمَا absent de 4.2 : accepté.** Cela évite la confusion avec لَمَّا ; reporté en 5.4.
- **أَخْبَرَتْنِي ajouté aux formes de أَخْبَرَ : accepté.** Forme régulière, sans tournure du Coran.
- **« كَانَ الْبَرْدُ شَدِيدًا فَرَجَعَ التَّاجِرُ » : accepté.** C'est un فَـ de cause correct, sans tournure à risque.
- **4.14 sans 300 à 900 : accepté**, à une condition : aucune règle ne doit prétendre couvrir tous les nombres jusqu'à 1 000. Les centaines de 300 à 900 vont en 4.19 (au marché).
- **4.14 sans « écrire un compte en toutes lettres » : accepté** si la part de production de la leçon reste d'au moins 40 % (sinon, on rétablit cet exercice).

## Décisions pour l'utilisateur (fin du niveau Avancé 1)

1. Les leçons 4.1 à 4.14 enseignent les phrases longues : « si », « si seulement », « il a dit que », « quand », « parce que », « sauf », l'appel (« ô… »), l'insistance, les mots qui relient les idées, et les nombres.
2. Onze et douze sont écrits en toutes lettres, comme tu l'as décidé, et toujours avec un nom ordinaire (dirham, livre, lettre…).
3. Les nombres de 300 à 900 passent à la leçon du marché (4.19).
4. Les tournures trop proches du Coran sont écartées, et le verbe « frapper » (ضَرَبَ) n'est pas employé : on frappe à la porte avec un autre verbe.
5. Une phrase sur des invités honorés par un repas est remplacée, parce qu'elle rappelait de loin un récit du Coran.
6. Les maximes du Jardin sont inventées, signalées « rédigé par IA » et attribuées à personne.
7. Les mots « si » (إِذَا, إِنْ) n'affichent pas de nombre d'occurrences dans le Coran : ce nombre mélangerait plusieurs emplois.
8. Quelques retouches sur les fiches : « état » (حَالٌ) s'emploie aux deux genres ; أَيُّهَا est présenté comme un mot d'appel ; غَيْرُ veut aussi dire « non- ».
9. Dans la leçon sur « combien ? », les fausses réponses ne marquent plus comme faute une forme admise par certains grammairiens anciens.
10. Reports : les mots du temps (jour, mois, année, heure) en 4.18, « merci » (شُكْرًا) en 4.19, le « lamā » de la réponse niée en 5.4, les noms « d'une fois » et « de manière » plus tard.

À ajouter à `/home/user/iqura/docs/relectures/decisions-avance-1.md`. Aucun fichier modifié.

Mise en œuvre (13/11/2026) : toutes ces décisions sont appliquées dans les leçons et les fiches ; les rapports du relecteur sont dans `2026-11-13-avance-1.md`.
