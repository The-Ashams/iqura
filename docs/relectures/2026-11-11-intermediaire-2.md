# Relecture : Intermédiaire 2 (leçons 3.11 à 3.21)

Agent : relecteur-arabe, du 07 au 11/11/2026. Une relecture par leçon, puis un passage après chaque série de corrections. Doutes tranchés par le conseiller (`decisions-intermediaire-2.md`).

| Leçon | Verdicts successifs |
| --- | --- |
| 3.11 | À corriger → Validé avec doutes |
| 3.12 | À corriger → Validé avec doutes |
| 3.13 | À corriger → Validé avec doutes |
| 3.14 | À corriger → Validé avec doutes |
| 3.15 | À corriger → Validé |
| 3.16 | Validé avec doutes → Validé avec doutes |
| 3.17 | À corriger → Validé avec doutes |
| 3.18 | À corriger → Validé avec doutes |
| 3.19 | À corriger → Validé avec doutes |
| 3.20 | À corriger → À corriger → Validé |
| 3.21 | À corriger → Validé avec doutes |
| Corrections après les décisions du conseiller (3.11, 3.12, 3.14, 3.16 à 3.19, fiches) | À corriger → Validé |

---

# Rapport de relecture — Leçon 3.11 « La forme I » (moteur-11)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/11-la-forme-i.json
- /home/user/iqura/tools/build_content/vocab/mots.json (8 fiches `moteur-11` : alima, amila, nazara, kabura, kathura, thaqula, buda, hasuna)
- Comparé avec : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (B et 3.11), les décisions d'Élémentaire 3 sur l'accord du verbe, et la base /home/user/iqura/assets/content/iqura_content.db (recherche de texte sur les lemmes)

Stade : région 3, leçon 3.11 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2 entières, leçons 3.1 à 3.10 (racine, فَاعِل / مَفْعُول, nom d'action, مَفْعَل / مِفْعَال, فَعِيل / فَعَّال, pluriels internes, أَفْعَلُ, nisba). Pas encore vus : بِـ, فَـ, عَنْ. Audio suspendu.

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [11-la-forme-i.json · mini_boss, « Complète : Le village s'est éloigné. » … الْقَرْيَةُ] Problème : le distracteur بَعُدَ est aussi une réponse juste. Le sujet الْقَرْيَةُ est un féminin qui n'est pas une personne, et le verbe est placé avant lui : en arabe classique, le verbe sans تْ est admis (بَعُدَ الْقَرْيَةُ). Le projet l'a déjà décidé en 2.23 (/home/user/iqura/docs/relectures/2026-10-27-elementaire-3-passages-suivants.md : « le masculin n'est plus proposé comme réponse fausse »). La question a donc deux réponses justes (F4). L'explication « Sujet féminin : بَعُدَتِ » est elle aussi trop absolue. | Correction proposée : remplacer le distracteur بَعُدَ par une forme fausse sans ambiguïté, par exemple يَبْعُدُ si la phrase reste au passé, ou une forme d'une autre personne. Écrire l'explication ainsi : « Avec un sujet féminin, on met d'habitude تْ : بَعُدَتِ الْقَرْيَةُ. » | Confiance : haute

## Mineur
- [11-la-forme-i.json · écran mots, question sur ثَقُلَ] Le distracteur « il est lourd (adjectif) » est flou : la fiche donne « être ou devenir lourd », et « il est lourd » peut donc traduire ثَقُلَ. La précision « (adjectif) » sauve la question de justesse. | Proposition : mettre « lourd » (pour ثَقِيلٌ) ou « le poids » (pour ثِقَلٌ). | Confiance : moyenne
- [11-la-forme-i.json · regle « Trois voyelles au passé »] « ثَقِيلٌ → ثَقُلَ » : la flèche laisse croire que le verbe vient de l'adjectif. Dans la tradition grammaticale, c'est l'adjectif qui se rattache au verbe. | Proposition : « ثَقُلَ ↔ ثَقِيلٌ » ou « ثَقُلَ, comme ثَقِيلٌ ». | Confiance : moyenne
- [mots.json · buda, exemple « بَعُدَتِ الْقَرْيَةُ. » = « Le village s'est éloigné. » ; même phrase au mini_boss] « S'est éloigné » fait croire à un déplacement, alors que la fiche donne « être loin ». | Proposition : « Le village était loin. » (ou « est devenu lointain »), dans la fiche comme dans la consigne du mini_boss. | Confiance : moyenne
- [mots.json · kabura, sens « devenir grand, grandir (une chose) »] Le dialogue emploie كَبُرَ pour un faucon (كَبُرَ الصَّقْرُ). Cet emploi est correct (كَبُرَ = grossir en taille), mais il contredit « (une chose) ». | Proposition : « devenir grand, grandir (en taille) ». La remarque sur كَبِرَ يَكْبَرُ (vieillir) reste. | Confiance : moyenne
- [11-la-forme-i.json · lecture, « عَلِمَ الطَّالِبُ الْجَوَابَ، وَكَتَبَ الْجَوَابَ. »] Répéter le complément n'est pas naturel. Si le pronom suffixe ـهُ est déjà acquis, « وَكَتَبَهُ » est meilleur. Sinon, laisser la phrase telle quelle. | Confiance : moyenne
- [mots.json · thaqula, buda] Ces deux fiches ne sont liées qu'à la racine (vql, bEd), sans lemme. Pourtant, la base contient bien les lemmes de forme I du Corpus : `vaqulato` (ثَقُلَتْ, vql, verbe, forme I) et `baEudato` (بَعُدَتْ, bEd, verbe, forme I). Leur nom est au passé conjugué, mais ce nom n'est jamais affiché (décision 4 d'Intermédiaire 1). Les relier donnerait une vraie fréquence. | Confiance : moyenne (je ne sais pas si le validateur accepte ces noms de lemmes)

## Doutes (à soumettre au conseiller, ne pas trancher)
- [mots.json · traduction des verbes] Les anciennes fiches de verbes donnent le passé à la 3e personne (دَخَلَ « il est entré », كَتَبَ « il a écrit »). Les nouvelles donnent l'infinitif (« savoir », « regarder »), comme le plan du conseiller. Ce n'est pas une erreur, mais le dictionnaire et le Grimoire mélangeront les deux usages. | Pistes : garder les deux et en faire une règle (verbes de forme I à partir de 3.11 à l'infinitif), ou harmoniser plus tard. | Confiance : moyenne
- [mots.json · alima, « savoir, apprendre (une chose) »] En français, « apprendre » veut dire à la fois recevoir et transmettre un savoir. Or عَلَّمَ (enseigner) arrive en 3.12. | Pistes : « savoir ; apprendre (une nouvelle) », ou « savoir, connaître ». | Confiance : moyenne
- [11-la-forme-i.json · atelier, distracteur « كَبُرَ الْمَدِينَةُ الْكَبِيرَةُ. »] La phrase est fausse comme traduction (elle ajoute « grande »), donc la question tient. Mais elle peut faire croire que le verbe au masculin devant الْمَدِينَةُ est une faute, ce qui contredit la décision de 2.23. | Piste : employer un distracteur où seul le sens est faux. | Confiance : moyenne

## Points vérifiés sans problème
- **A** : aucun verset ni suite coranique repérée. Aucune des tournures signalées ⚠ par le conseiller n'apparaît (كَبُرَتْ كَلِمَةً, عَمِلَ صَالِحًا, نَظَرَ + الْجَبَل / السَّمَاء, ثَقُلَتْ مَوَازِينُهُ, حَسُنَ…رَفِيقًا, قَلَّ + كَثُرَ ensemble). Ni sujet divin, ni impératif انْظُرْ, ni forme exclue (كَبَّرَ, أَحْسَنَ…). Aucun mot sur un monstre. Récits profanes.
- **B / E** : la base contient des lemmes de forme I du Corpus pour Ealima (عَلِمَ, Elm), Eamila (عَمِلَ, Eml), n~aZara (نَظَرَ, nZr ; c'est bien l'écriture du Corpus, le « à confirmer » du plan est levé), kabura (كَبُرَ, kbr), kavura (كَثُرَ, kvr) et Hasuna (حَسُنَ, Hsn). Les racines vql et bEd existent. Aucune fréquence n'est affichée dans la leçon.
- **C** : vocalisation complète et correcte. Cas justes. Liaison كَبُرَتِ الْمَدِينَةُ / بَعُدَتِ الْقَرْيَةُ juste. Verbe au singulier devant un pluriel (كَثُرَ التُّجَّارُ) juste. رَبَابُ sans tanwīn juste (nom propre féminin de plus de trois lettres). Inaccomplis justes : يَعْلَمُ, يَعْمَلُ, يَنْظُرُ, يَكْبُرُ, يَكْثُرُ, يَثْقُلُ, يَبْعُدُ, يَحْسُنُ, avec كَبِرَ يَكْبَرُ en aperçu. Noms d'action justes : عِلْمٌ, عَمَلٌ, نَظَرٌ, كَثْرَةٌ, ثِقَلٌ, بُعْدٌ, حُسْنٌ. Schèmes des fiches justes. Registre classique.
- **D** : traductions fidèles. Sens linguistiques seulement.
- **F** : la règle suit le plan (فَعُلَ : qualité ou état, toujours يَفْعُلُ, jamais de complément direct ; فَعِلَ fait le plus souvent يَفْعَلُ ; contre-exemples دَخَلَ يَدْخُلُ et رَجَعَ يَرْجِعُ, deux verbes connus). QCM à 3 choix. Les autres questions ont une seule réponse juste. Pas de بِـ, فَـ, عَنْ. Aucun exercice d'écoute. Translittérations Arabica des fiches justes (ʿalima, ʿamila, naẓara, kabura, kaṯura, ṯaqula, baʿuda, ḥasuna).
- **G** : `source_sens` « rédigé par IA » sur les 8 fiches ; statut de la leçon `ia_non_verifie`.

## Ce que je n'ai pas pu vérifier
- Le nombre d'occurrences des lemmes : le champ est binaire dans la base, et je n'avais pas de SQL. À contrôler par requête.
- L'affichage réel dans l'application des mentions « rédigé par IA » et « exemple construit ».
- Le contrôle anti-versets et le contrôle des mots connus : je les ai supposés réussis, comme annoncé. Je ne les ai pas relancés.

---

# Rapport de relecture — Leçon 3.11 « La forme I » (second passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/11-la-forme-i.json
- /home/user/iqura/tools/build_content/vocab/mots.json (les 8 fiches `moteur-11`)

Stade : région 3, leçon 3.11 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2 entières, leçons 3.1 à 3.10. Pas encore vus : بِـ, فَـ, عَنْ. Audio suspendu.

## Verdict : Validé avec doutes

## Bloquant
- Aucun.

## Important
- Aucun. Le point du premier passage est réglé. Au mini-boss, les choix sont maintenant بَعُدَتِ / بَعِيدَةٌ / يَبْعُدُ, avec la consigne « Le village était loin. ». Il n'y a plus qu'une réponse juste : يَبْعُدُ est faux par le temps (présent au lieu du passé), et l'explication le dit (« Passé ; avec un sujet féminin, on met d'habitude تْ »). Cela respecte la décision de 2.23.

## Mineur
- Aucun.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [mots.json · traduction des verbes : infinitif ou « il a… »] Ce doute est déjà soumis au conseiller, d'après ton message. Il reste ouvert. | Confiance : moyenne

## Points vérifiés sans problème
- **Corrections du premier passage, toutes vérifiées dans les fichiers** :
  - « le poids » remplace « il est lourd (adjectif) » : il n'y a plus qu'une réponse juste ;
  - la règle dit « ثَقُلَ, comme ثَقِيلٌ » ;
  - kabura : « devenir grand, grandir (en taille) », ce qui va avec كَبُرَ الصَّقْرُ ;
  - alima : « savoir, connaître (une chose) » ;
  - buda : « Le village était loin. » dans la fiche et au mini-boss ;
  - lecture : « عَلِمَ الطَّالِبُ الْجَوَابَ، وَكَتَبَهُ. ». Le pronom suffixe est acquis en 2.24 (« il l'a écrit »). La vocalisation est juste, et la réponse de la question (« il a su la réponse et l'a écrite ») est cohérente ;
  - atelier : le distracteur « كَبُرَتِ الْقَرْيَةُ. » est grammaticalement juste mais faux par le sens (village ≠ ville). Il n'y a plus de masculin présenté comme une faute ;
  - ordonner : la consigne dit maintenant « verbe, sujet, complément » ;
  - lemmes `vaqulato` (ثَقُلَ) et `baEudato` (بَعُدَ) reliés : dans la base, ce sont bien des lemmes de verbes de forme I, racines vql et bEd.
- **A** : aucune suite coranique repérée dans les nouvelles phrases (كَبُرَتِ الْقَرْيَةُ, وَكَتَبَهُ). Ni sujet divin, ni forme exclue.
- **C** : vocalisation et liaisons justes (كَبُرَتِ الْقَرْيَةُ, بَعُدَتِ الْقَرْيَةُ, وَكَتَبَهُ).
- **D, E, F, G** : sens et traductions cohérents. QCM à 3 choix, une seule réponse juste partout. Lemmes conformes à la base. `source_sens` « rédigé par IA » sur les 8 fiches.

## Ce que je n'ai pas pu vérifier
- Le nombre d'occurrences des lemmes : le champ est binaire, et je n'avais pas de SQL.
- Je n'ai pas relancé le contrôle anti-versets ni le contrôle des mots connus sur cette version. À relancer à la construction.

---

# Rapport de relecture — Leçon 3.12 « La forme II » (moteur-12)

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/12-la-forme-ii.json ; /home/user/iqura/tools/build_content/vocab/mots.json (fiches allama, fahhama, qattaa, farraqa, qaddama, haddatha, kallama). Référence : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (B et 3.12).
Stade : région 3, leçon 3.12 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.11 (racine, schèmes, فَاعِل/مَفْعُول, فَعَّال, pluriels, forme I فَعَلَ/فَعِلَ/فَعُلَ et voyelle de l'inaccompli).

## Verdict : À corriger

Aucun point bloquant. Il y a deux points importants : une consigne de l'exercice à remettre en ordre accepte deux ordres justes, et la règle clé du plan B3 manque.

## Bloquant
- Aucun.

## Important
- [12-la-forme-ii.json · atelier, exercice à remettre en ordre « Le boulanger a offert le pain aux invités. »] Problème : la consigne n'impose pas l'ordre des mots. Or « الْخَبَّازُ قَدَّمَ الْخُبْزَ لِلضُّيُوفِ » est juste en classique, et la même leçon emploie cet ordre (dialogue « الْمُعَلِّمُ عَلَّمَ… », mini-boss « الْمُعَلِّمُ … الطُّلَّابَ »). Cette réponse juste serait comptée fausse. Le cas a déjà été tranché en 2.20 et en 2.21 (relectures du 25 et du 26/10), et 3.1 fait déjà ainsi. | Correction proposée : « Écris dans l'ordre verbe, sujet, complément : « Le boulanger a offert le pain aux invités. » » | Confiance : haute.
- [12-la-forme-ii.json · écrans « regle »] Problème : le plan B3 demande la règle clé « répétée de 3.12 à 3.20 », et le plan 3.12 demande d'expliquer que مُعَلِّمٌ, mot déjà connu, est le participe de عَلَّمَ (renvoi à 3.20). La leçon n'en dit rien, alors que الْمُعَلِّمُ y revient sans cesse et que مُفَعِّل figure dans `schemes`. Je ne trouve cette règle dans aucune leçon de etape3. | Correction proposée : ajouter une phrase à l'écran « L'inaccompli en u », par exemple « Le mot مُعَلِّمٌ, que tu connais, vient de عَلَّمَ : مُ à la place du préfixe (leçon 3.20). » Ajouter la règle B3 complète si le conseiller la veut dès 3.12. | Confiance : moyenne (c'est un écart au plan, pas une erreur d'arabe).

## Mineur
- [mots.json · fahhama, farraqa, haddatha] Ces trois fiches ont seulement `racine`, donc aucune fréquence n'est affichée. Pourtant, la base contient bien un lemme de forme II pour chaque racine, sous une forme qui n'est pas celle du dictionnaire : `fah~amo` (فَهَّمْ, fhm, VII), `far~aqu` (فَرَّقُ, frq, VII), `tuHad~ivu` (تُحَدِّثُ, Hdv, VII). Le plan (A, « Forme des lemmes ») permet de relier ces lemmes, puisque seul le champ `ar` est affiché. | Proposition : `"lemme": "fah~amo"`, `"far~aqu"`, `"tuHad~ivu"`. Si tu choisis de garder la racine seule, il faut le signaler au conseiller, car le plan les marquait L. Le schème reste vérifié dans les deux cas.
- [12 · lecture, phrase 3] « حَدَّثَ الشَّيْخُ الضُّيُوفَ، وَيُكَلِّمُ الْمُسَافِرِينَ. » La phrase est grammaticale, mais elle mêle passé et présent dans un récit au passé (« a parlé… et parle »). | Proposition : « …، وَكَلَّمَ الْمُسَافِرِينَ. »
- [12 · regle « La shadda du milieu »] La règle parle d'action « plus forte » mais ne donne que des exemples de causatif (عَلَّمَ, فَهَّمَ). قَطَّعَ est cité sans sa base. | Proposition : ajouter « قَطَعَ « couper » → قَطَّعَ « couper en morceaux » », comme le prévoit la règle du plan. قَطَعَ est alors un mot nouveau, donné en aperçu.
- [12 · atelier, compléter « عَلَّمَتْ رَبَابُ الطُّلَّابَ الْكِتَابَةَ »] Le plan prévoit « deux compléments, en aperçu », mais l'explication ne le dit pas. | Proposition : « Sujet féminin : عَلَّمَتْ. عَلَّمَ peut avoir deux compléments : الطُّلَّابَ et الْكِتَابَةَ. »
- [12 · entraînement] « Comment dit-on « il enseigne » ? » (traduire) et « Lequel de ces mots veut dire « il enseigne » ? » (qcm) sont presque le même exercice, avec presque les mêmes choix. | Proposition : remplacer le second, par exemple par l'inaccompli de حَدَّثَ (يُحَدِّثُ / يَحْدُثُ / حَدَّثَ).
- [12 · `schemes`] تَفْعِيل est listé, mais aucun écran ne donne le nom d'action de la forme II. Le plan B1 veut la notation « forme II — فَعَّلَ / يُفَعِّلُ — nom d'action تَفْعِيل ». | Proposition : l'ajouter à la règle ou à l'objectif.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [12 · entraînement, compléter « Le vieil homme parle aux voyageurs », distracteur يَكْلِمُ] Ce qui me fait douter : كَلَمَ يَكْلِمُ (forme I, « blesser ») existe, à ma connaissance. Ce n'est pas une deuxième bonne réponse, puisque le sens ne colle pas. Mais un apprenant pourrait croire que ce mot n'existe pas, et le plan B4 parle de distracteurs « absents de notre dictionnaire ». | Pistes : garder ; ou remplacer par يَكْلَمُ, ou par كَلِمَةٌ. | Confiance : moyenne.
- [12 · lecture et fiche farraqa, « فَرَّقَ الْحَمَّالُ الْأَحْمَالَ » = « a séparé les charges »] Ce qui me fait douter : en contexte, « a réparti » serait plus naturel en français. Mais « répartir » ne figure pas dans le sens de la fiche (« séparer, disperser »). | Pistes : garder ; ou ajouter « répartir » au sens et retraduire. | Confiance : moyenne.

## Points vérifiés sans problème
- A : aucune suite coranique repérée. Les pièges ⚠ du plan sont évités : pas de بَيْنَ, de دِين, de يَد/أَيْدِي, de النَّاس, de الْإِنْسَان ni de « كَلَّمَ اللَّهُ ». Aucun sujet divin, aucun « nous » de majesté, aucun nom divin. Récit profane (cuisinier, boulanger, porteur).
- B/E : les lemmes Eal~ama, qaT~aEa, qad~ama et kal~ama existent dans la base en forme II avec la bonne racine (Elm, qTE, qdm, klm). Les racines fhm, frq et Hdv existent. Le schème فَعَّلَ est correct pour les sept fiches. Aucune fréquence n'est affirmée dans la leçon.
- C : vocalisation complète et correcte partout. Les cas sont justes (الطُّلَّابَ objet, رَبَابُ diptote sans tanwīn). Le verbe est au singulier devant un sujet pluriel (عَلِمَ الطُّلَّابُ), il s'accorde au féminin (عَلَّمَتْ رَبَابُ), et لِلضُّيُوفِ est correct. Les sept inaccomplis يُفَعِّلُ sont justes. Les noms d'action تَعْلِيمٌ, تَفْهِيمٌ, تَقْطِيعٌ, تَفْرِيقٌ, تَقْدِيمٌ, تَحْدِيثٌ et تَكْلِيمٌ sont corrects.
- D : les sens sont conformes au plan, actif traduit par actif. Les traductions du dialogue et des exemples sont fidèles.
- F : chaque QCM a 3 choix et une seule bonne réponse. J'ai vérifié en particulier le traduire de l'atelier, dont les deux distracteurs sont agrammaticaux, ainsi que les questions d'inaccompli de قَدَّمَ, de فَرَّقَ et de نَظَرَ. La règle « c'est une tendance » est présente avec ses contre-exemples (كَلَّمَ, حَدَّثَ), comme le demandent B7 et §5. Le piège يُعَلِّمُ ≠ يَعْلَمُ est traité. Aucun mot doublé dans la Forge. Pas de بِـ, فَـ ni عَنْ. Translittérations Arabica exactes (ʿallama, qaṭṭaʿa, ḥaddaṯa…).
- G : `source_sens` « rédigé par IA » sur les sept fiches.

## Ce que je n'ai pas pu vérifier
- Les fréquences : je n'ai lu la base qu'en recherche de texte, sans SQL.
- L'affichage de la source « exemple construit » dans l'application.
- L'audio est suspendu, il n'y a rien à vérifier de ce côté.

---

# Rapport de relecture — Leçon 3.12 « La forme II » (moteur-12), second passage

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/12-la-forme-ii.json ; /home/user/iqura/tools/build_content/vocab/mots.json (fiches fahhama, farraqa, haddatha). Plan suivi : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md.
Stade : région 3, leçon 3.12 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.11.

## Verdict : Validé avec doutes

Les huit corrections annoncées sont faites et justes. Elles n'introduisent aucune nouvelle erreur. Il reste un doute du premier passage, plus une remarque mineure.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- [12 · écran « L'inaccompli en u »] L'écran contient maintenant trois idées : l'inaccompli, le nom d'action تَفْعِيل et le participe مُعَلِّمٌ. Le cahier demande « un écran = une idée ». Les trois phrases sont exactes. Si c'est simple, tu peux déplacer « Le nom d'action suit تَفْعِيل (تَعْلِيمٌ)… » dans un petit écran à part ou dans l'écran « fin ». Sinon, ce n'est pas obligatoire.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [12 · lecture et fiche farraqa, « فَرَّقَ الْحَمَّالُ الْأَحْمَالَ » = « a séparé les charges »] Ce doute vient du premier passage et reste ouvert. En contexte, « a réparti les charges » serait plus naturel en français, mais « répartir » ne figure pas dans le sens de la fiche (« séparer, disperser »). | Pistes : garder ; ou ajouter « répartir » au sens de la fiche et retraduire la phrase et la question de lecture. | Confiance : moyenne.
- Le doute sur le distracteur يَكْلِمُ est réglé : il est remplacé par كَلِمَةٌ.

## Points vérifiés sans problème
- **A (respect du Coran)** : la phrase « حَدَّثَ الشَّيْخُ الضُّيُوفَ، وَكَلَّمَ الْمُسَافِرِينَ » et l'aperçu قَطَعَ ne touchent aucun piège ⚠ du plan. Aucun sujet divin, aucun nom divin.
- **C (forme de l'arabe)** :
  - قَطَعَ est bien vocalisé et figure dans l'aperçu.
  - يُعَلِّمُ, تَعْلِيمٌ, مُعَلِّمٌ et يُحَدِّثُ sont justes.
  - وَكَلَّمَ rend la phrase de lecture cohérente au passé.
- **D (sens et traductions)** : قَطَعَ « couper » → قَطَّعَ « couper en morceaux » et عَلِمَ « savoir » → عَلَّمَ « enseigner » sont exacts. « مُعَلِّمٌ remplace يُ par مُ » est exact pour la forme II.
- **E (données du corpus)** : les fiches fahhama, farraqa et haddatha sont reliées aux lemmes du corpus fah~amo, far~aqu et tuHad~ivu. Dans la base, ce sont bien des formes II, de racines fhm, frq et Hdv. Le schème فَعَّلَ reste vérifiable.
- **F (pédagogie)** :
  - L'exercice à remettre en ordre impose maintenant « verbe, sujet, complément » : une seule solution juste.
  - Le nouveau QCM sur l'inaccompli de حَدَّثَ (يُحَدِّثُ / حَدَّثَ / تَحْدِيثٌ) n'a qu'une bonne réponse, et le doublon a disparu.
  - Le distracteur كَلِمَةٌ n'est pas une bonne réponse.
  - L'explication des deux compléments de عَلَّمَ est exacte.
  - La règle clé du plan B3 (u à l'inaccompli, مُ au participe) est maintenant présente pour la forme II.
- **G (statuts et sources)** : « rédigé par IA » est inchangé sur les fiches.

## Ce que je n'ai pas pu vérifier
- Les fréquences : la base n'a été lue qu'en recherche de texte, sans SQL.
- L'affichage de la source « exemple construit » dans l'application.
- L'audio est suspendu, il n'y a rien à vérifier de ce côté.

---

# Rapport de relecture : leçon 3.13 « La forme III »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/13-la-forme-iii.json
- /home/user/iqura/tools/build_content/vocab/mots.json (8 fiches `moteur-13`, lignes 4713 à 4864)
- Pour comparer : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (A, B, C § 3.13), la leçon 3.12 et /home/user/iqura/assets/content/iqura_content.db (recherche de texte, pas de SQL)

Stade : région 3, leçon 3.13 (Intermédiaire 2, Rabāb, moulin). Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.12 (forme I et ses trois moules, forme II, فَاعِل / مَفْعُول, nom d'action, فَعَّال, pluriels internes). Ne sont pas encore enseignés : بِـ, فَـ, عَنْ.

## Verdict : À corriger

Il y a un seul point Important : un écart avec le plan du conseiller. Je n'ai trouvé aucune forme arabe fausse.

## Bloquant
- Aucun.

## Important
- [13-la-forme-iii.json · règle « Inaccompli et nom d'action » et règle « Une tendance »] Problème : le plan (§ 3.13 et principe B3) demande deux choses que la leçon ne fait pas :
  - expliquer مُسَافِرٌ, déjà connu (leçon fondations-07), comme participe actif de سَافَرَ ;
  - répéter la règle clé « préfixe en u pour II, III, IV… ; le participe actif remplace le préfixe par مُ et met i avant la dernière lettre ».
  
  La leçon dit seulement « la forme III prend u à l'inaccompli ». Or مُسَافِرٌ sert de distracteur (« il voyage ») et الْمُسَافِرُ revient dans l'atelier, et le moule مُفَاعِل figure dans `schemes` sans jamais être enseigné. 
  Correction proposée : ajouter une phrase à la règle « Inaccompli… » (ou un écran court), par exemple : « Le participe actif remplace يُ par مُ : يُسَافِرُ → مُسَافِرٌ « voyageur » (déjà connu). » | Confiance : haute (c'est un écart avec le plan, pas une erreur d'arabe).

## Mineur
- [13-la-forme-iii.json · entraînement, sens de فَارَقَ] Le distracteur « il a séparé » est très proche du sens de la fiche (« quitter, se séparer de »). Un apprenant peut croire qu'il y a deux bonnes réponses. Le piège est voulu (فَرَّقَ, vu en 3.12), mais l'explication ne le dit pas. Proposition : explication « فَارَقَ : « il a quitté ». « Séparer (des choses) », c'est فَرَّقَ (forme II). » Ou bien remplacer le distracteur par « il a dispersé ».
- [13-la-forme-iii.json · dialogue, réplique de Rabāb] « وَسَاعَدْتَ الشَّيْخَ؟ » : la question n'est marquée que par l'intonation. C'est possible, mais هَلْ est connu depuis fondations-10. Proposition plus classique et plus claire pour un débutant : « وَهَلْ سَاعَدْتَ الشَّيْخَ؟ ». Le français ne change pas.
- [13-la-forme-iii.json · règle 1, QCM du mini-boss, écran « fin »] « La personne est complément direct » est présenté comme une règle générale (QCM : « complément direct, sans مَعَ » face à « toujours après مَعَ »). C'est vrai pour les verbes de la leçon. Ce n'est pas une loi de la forme III : beaucoup de ses verbes se construisent avec une préposition. Proposition : « Avec ces verbes, la personne est complément direct, sans مَعَ », et le même « avec ces verbes » dans l'écran « fin ».

## Doutes (à soumettre au conseiller, ne pas trancher)
- [13-la-forme-iii.json · dialogue, « صَاحَبْتُ الشَّيْخَ إِلَى الْبَيْتِ »] Ce qui me fait douter : en arabe classique, صَاحَبَ veut surtout dire « être le compagnon de, fréquenter » (صَاحَبَهُ فِي السَّفَرِ). « Raccompagner quelqu'un jusqu'à » se dit plutôt مَشَى مَعَهُ ou شَيَّعَهُ. صَاحَبَ + إِلَى + lieu me paraît plus moderne que classique. | Pistes : garder la phrase ; ou dire « وَصَاحَبْتُ الشَّيْخَ فِي الطَّرِيقِ » (si طَرِيق est connu) ; ou reprendre la tournure de la lecture, « صَاحَبَ … الْقَافِلَةَ », sans إِلَى. La question de compréhension (« jusqu'à la maison ») serait à adapter. | Confiance : moyenne.
- [mots.json · قَابَلَ, « rencontrer »] Ce qui me fait douter : en arabe classique, قَابَلَ a surtout le sens de « faire face à, être en face de ; mettre en regard ». Pour « rencontrer », l'usage classique courant est لَقِيَ. Le sens « rencontrer (quelqu'un) » est surtout moderne. La fiche dit bien « rencontrer, faire face à », mais tous les exercices n'emploient que « rencontrer ». | Pistes : garder la fiche, mais mettre « rencontrer (face à face) » dans les exercices ; ou laisser tel quel, puisque le plan l'a validé. | Confiance : moyenne-faible.
- [13-la-forme-iii.json · entraînement « … الْقَافِلَةُ فِي الصَّبَاحِ » (تُسَافِرُ / يُسَافِرُ)] Ce qui me fait douter : الْقَافِلَةُ est un féminin non réel (مؤنث مجازي) placé juste après le verbe. La grammaire classique admet alors le masculin (يُسَافِرُ الْقَافِلَةُ), même si le féminin est préférable. Le choix يُسَافِرُ n'est donc pas faux à proprement parler. | Pistes : garder, si la règle simplifiée « sujet féminin → تـ » est une décision du projet ; sinon prendre un sujet féminin réel, ou un distracteur clairement faux (سَافَرَ convient déjà, يُسَافِرُ moins bien). | Confiance : moyenne.
- [13-la-forme-iii.json · atelier « ordonner »] « بَاسِمٌ جَالَسَ الشَّيْخَ » est aussi correct, mais seul l'ordre verbe-sujet-objet est accepté, et je n'ai trouvé aucun mécanisme de solutions multiples dans le dépôt. Ce n'est pas propre à cette leçon : c'est une limite du moteur. | Confiance : faible (impact pédagogique seulement).
- [mots.json · فَارَقَ, سَابَقَ, صَاحَبَ : pas de champ `lemme`] Le plan annonce « L faAraqa / saAbaqa / SaAHaba ». Ces chaînes n'existent pas dans iqura_content.db. Le Corpus y range ces verbes sous des formes conjuguées : `faAriqu`, `saAbiqu`, `tuSa`Hibo`. Les fiches ne donnent que la racine, ce qui est prudent : aucune fréquence n'est inventée. Est-ce voulu ? Faut-il les relier à ces lemmes, sachant qu'ils viennent de passages classés ⚠ par le plan ? | Confiance : moyenne.

## Points vérifiés sans problème
- **A** : aucun verset ni extrait. Les tournures ⚠ du plan sont évitées (pas d'impératif سَابِقُوا, pas de تُصَاحِبْنِي, pas de فِرَاق + بَيْن). سَابَقَ … إِلَى الْجِسْرِ est construit, sans écho que je reconnaisse. Aucun nom divin ni sujet divin, aucun sens religieux, récits profanes.
- **B, E** :
  - aucune fréquence affichée ;
  - les racines sfr, jls, ktb, sEd, frq, sbq, SHb, qbl sont cohérentes et toutes présentes dans le Corpus ;
  - les 8 fiches sont toutes de schème فَاعَلَ, et le schème est juste (substitution vérifiée) ;
  - inaccomplis يُفَاعِلُ corrects ;
  - noms d'action conformes au plan (مُفَاعَلَة, et فِرَاقٌ sur فِعَال).
- **C** :
  - vocalisation complète et juste partout : cas après le verbe (sujet au nominatif, objet à l'accusatif), صَدِيقَهُ, فَارَقَتِ الْقَافِلَةُ (kasra de liaison), بَاسِمٌ, رَبَابُ (diptote) ;
  - conjugaisons جَالَسْتُ, سَاعَدْتَ, صَاحَبْتُ, تُسَافِرُ, يُقَابِلُ correctes ;
  - hamzat al-waṣl et lettres solaires corrects, aucune lettre parasite.
- **D** : traductions fidèles. Les phrases modèles du plan sont reprises telles quelles. Les distracteurs de type فَاعِل / فَاعَلَ sont bien clairement faux.
- **F** :
  - tous les mots des phrases sont connus (أَحْمَال, مَجْلِس, جِسْر, صَرَّاف, قَافِلَة, سَعِيد, حَمَلَ, هَلْ vérifiés) ;
  - tous les QCM ont 3 choix et une seule bonne réponse (à part les deux doutes signalés) ;
  - le contre-exemple « tendance » (سَافَرَ) et le piège فَاعَلَ ≠ فَاعِل sont présents ;
  - aucun exercice d'écoute ;
  - les questions de révision portent sur 3.11 et 3.12, et leurs réponses sont justes.
- **F7** : translittérations des fiches exactes (sāfara, ǧālasa, kātaba, sāʿada, fāraqa, sābaqa, ṣāḥaba, qābala).
- **G** : `source_sens` = « rédigé par IA » sur les 8 fiches. Statut de la leçon : `ia_non_verifie`.

## Ce que je n'ai pas pu vérifier
- Les fréquences et les identifiants exacts des lemmes en SQL : je n'ai pu faire qu'une recherche de texte dans la base binaire.
- Le rendu à l'écran, et l'affichage effectif de la source « exemple construit » et de « rédigé par IA » dans l'application.

---

# Rapport de relecture : leçon 3.13 « La forme III » (second passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/13-la-forme-iii.json (relu en entier)
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches `moteur-13`, aujourd'hui lignes 4580 à 4731 environ)

Stade : région 3, leçon 3.13 (Intermédiaire 2). Acquis : régions 1 et 2, leçons 3.1 à 3.12.

## Verdict : Validé avec doutes

Toutes les corrections annoncées sont faites et justes. Je ne trouve plus d'erreur.

## Bloquant
- Aucun.

## Important
- Aucun. Le point du premier passage est corrigé : la règle 2 dit maintenant « مُسَافِرٌ, que tu connais, remplace يُ par مُ », avec مُسَافِرٌ parmi les exemples.

## Mineur
- Aucun nouveau.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [mots.json · قَابَلَ « rencontrer »] Le sens « rencontrer (quelqu'un) » me paraît surtout moderne ; le sens classique premier est « faire face à », et « rencontrer » se dit plutôt لَقِيَ. Vous gardez « rencontrer » parce que le plan du conseiller l'a validé : c'est un choix défendable. Je le laisse dans la liste des décisions de fin de niveau. | Confiance : moyenne-faible.
- [mots.json · فَارَقَ → `lemme: faAriqu`, سَابَقَ → `lemme: saAbiqu`] Ces deux chaînes figurent bien dans iqura_content.db. Mais la base est binaire et je n'ai pas pu y lire la racine, la forme (III) ni la fréquence rattachées à ces lemmes. `vocab.validate` fait foi : il faut confirmer que la construction a été relancée et passe avec ces deux champs. La fiche affichera alors la fréquence de ces formes du Corpus. | Confiance : moyenne.

## Points vérifiés sans problème
- Les corrections de la liste :
  - « Avec ces verbes, la personne est complément direct » : règle 1, QCM du mini-boss (devenu « Avec جَالَسَ, la personne est… ») et écran « fin » ;
  - dialogue « وَهَلْ سَاعَدْتَ الشَّيْخَ؟ », puis « نَعَمْ، وَصَاحَبْتُ الشَّيْخَ فِي الطَّرِيقِ. », avec une traduction fidèle (« en chemin ») ; la question est adaptée et n'a qu'une bonne réponse ; طَرِيقٌ est connu (fondations-03) ;
  - فَارَقَ : distracteur « il a aidé » ; l'explication oppose bien فَرَّقَ (forme II) ;
  - « La caravane voyage le matin » : مُسَافِرٌ remplace يُسَافِرُ, donc une seule bonne réponse, et mon doute sur l'accord avec un féminin non réel tombe ;
  - « ordonner » : la consigne impose l'ordre verbe, sujet, complément ; le doute sur les deux ordres possibles est levé.
- **A** : aucun verset ni tournure ⚠ ; aucune figure sacrée ; aucun sens religieux.
- **C** : vocalisation et cas exacts dans tous les passages modifiés (وَهَلْ, سَاعَدْتَ, صَاحَبْتُ, فِي الطَّرِيقِ, مُسَافِرٌ).
- **D, F** : traductions fidèles ; chaque QCM a 3 choix et une seule réponse juste ; règles courtes et justes ; aucun mot ni aucune notion qui n'ait pas déjà été enseigné.
- **G** : « rédigé par IA » sur les 8 fiches.

## Ce que je n'ai pas pu vérifier
- La racine, la forme et la fréquence des lemmes `faAriqu` et `saAbiqu` (pas de SQL possible) ; je n'ai pas non plus pu relancer la construction ni `vocab.validate` moi-même (je ne fais que lire les fichiers).

---

# Rapport de relecture — Leçon 3.14 « La forme IV » (moteur-14)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/14-la-forme-iv.json
- /home/user/iqura/tools/build_content/vocab/mots.json (8 fiches `moteur-14`, lignes 4865 à 5017)
- Comparés avec : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (§B, §3.14), /home/user/iqura/assets/content/iqura_content.db (lemmes)

Stade : région 3, leçon 3.14 (Intermédiaire 2, Rabāb, moulin). Notions supposées acquises : régions 1 et 2 (dont هَلْ en 2.10 et les pronoms compléments en 2.24), leçons 3.1 à 3.13 (formes I, II, III, élatif أَفْعَلُ). Audio suspendu.

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- **[14-la-forme-iv.json · atelier, exercice « ordonner » « Le palais a plu aux voyageurs. »]**
  - Problème : le moteur n'accepte qu'une solution (`solution`, unique dans `mini_donjon.py`). Or « الْقَصْرُ أَعْجَبَ الْمُسَافِرِينَ » est juste en classique. « أَعْجَبَ الْمُسَافِرِينَ الْقَصْرُ » l'est aussi : les cas montrent qui fait quoi. Une réponse juste serait donc comptée fausse. Le cas a déjà été corrigé en 2.20 et 2.21, et dans 3.1, 3.2 et 3.6.
  - Correction proposée : consigne « Écris dans l'ordre verbe, sujet, complément : « Le palais a plu aux voyageurs. » ». Ajouter à l'explication que les autres ordres se disent aussi.
  - Confiance : haute.
  - Remarque hors périmètre : 3.12 (« Le boulanger a offert le pain aux invités. ») et 3.13 (« Bāsim a tenu compagnie au vieil homme. ») ont la même consigne sans ordre imposé. À vérifier.
- **[14-la-forme-iv.json · règle « Trois moules qui se ressemblent »]** Le texte dit : « Et أَعْجَبَ « plaire à » ne fait rien faire : la forme est une tendance. »
  - Problème : cet exemple est mal choisi. En arabe, أَعْجَبَ est justement le factitif de عَجِبَ « s'étonner, s'émerveiller » : il veut dire « causer l'admiration », d'où « plaire ». Ce n'est pas un contre-exemple de « faire faire ». Le plan du conseiller prenait plutôt أَرْسَلَ, qui ne correspond à aucun verbe de forme I connu. Pour أَعْجَبَ, le plan signalait seulement que le sens s'inverse par rapport au français.
  - Correction proposée : « Mais la forme est une tendance : أَرْسَلَ « envoyer » ne vient d'aucun verbe simple connu. Dans أَعْجَبَ « plaire à », c'est la chose qui plaît qui est sujet. »
  - Confiance : moyenne à haute. L'origine factitive de أَعْجَبَ est classique, mais je ne peux pas la vérifier dans le dépôt.

## Mineur
- **[dialogue · « خَرَجَ الْجَمَلُ؟ » et « وَأَطْعَمْتَ الْجَمَلَ؟ »]**
  - Ce sont des questions oui/non sans particule. Le classique écrit met plutôt هَلْ ou أَ, et هَلْ est acquis depuis 2.10.
  - Proposition : « هَلْ خَرَجَ الْجَمَلُ؟ » et « وَهَلْ أَطْعَمْتَ الْجَمَلَ؟ ».
  - 3.13 a la même tournure (« وَسَاعَدْتَ الشَّيْخَ؟ »), donc à harmoniser si on corrige.
  - Confiance : moyenne.
- **[dialogue · traduction]** « فِي الصَّبَاحِ » est traduit « ce matin ». La traduction exacte est « le matin », comme pour « فِي الْمَسَاءِ » → « le soir ».
- **[lecture « L'hôte du moulin »]** Le récit n'est pas cohérent. L'introduction annonce « l'arrivée d'un invité », et les deux premières phrases parlent de « الضَّيْفَ » au singulier. La troisième passe à « الضُّيُوفَ » au pluriel (« أَطْعَمَ الطَّبَّاخُ الضُّيُوفَ، وَأَعْجَبَ الطَّعَامُ الضُّيُوفَ »), puis la quatrième revient à « الضَّيْفُ ». Proposition : mettre « الضَّيْفَ » dans la phrase 3 et adapter la question (« Le repas a-t-il plu à l'invité ? »), ou présenter dès le début plusieurs invités dont un seul est suivi.

## Doutes (à soumettre au conseiller, ne pas trancher)
- **[règle « Trois moules » et QCM « أَكْبَرُ, c'est… »]**
  - Ce qui me fait douter : vocalisé أَكْبَرُ, le mot est aussi la 1re personne de كَبِرَ يَكْبَرُ, « je vieillis ». Ce verbe a été vu en aperçu en 3.11 d'après le plan.
  - La règle présente أَكْبَرُ comme un élatif seulement. Le QCM reste à réponse unique, puisque « je vieillis » n'est pas proposé.
  - Pistes : ne rien changer, ou préciser « أَكْبَرُ (ici : plus grand) ».
  - Confiance : faible à moyenne sur l'utilité de corriger.
- **[mini-boss, révision قَطَّعَ]** Le distracteur « il a séparé » n'est pas tout à fait faux pour قَطَّعَ (couper, trancher en séparant). Piste : le remplacer par « il a présenté » ou « il a raconté ». Confiance : faible.

## Points vérifiés sans problème
- **A. Respect du Coran**
  - Aucun verset ni suite connue. Les exclusions B5 sont respectées : pas de sujet divin, pas de « nous » de majesté, pas de أَرْسَلْنَا ni de رَسُول, pas de أَخْرَجَ + الْأَرْض/مَاء.
  - Pas de أَدْخَلَ + جَنَّة, pas de أَكْرَمَنِ, pas de الْأَكْرَمُ, pas de أَعْجَبَ + كَثْرَة/حُسْن.
  - أَرْسَلَ a un sujet humain avec رِسَالَة. Le récit est profane et aucun nom sacré n'apparaît.
- **B/E. Données du corpus**
  - Lemmes présents dans la base, forme verbale IV : >axoraja, >aToEama, >arosala, >akorama, >aSolaHa, >aEojaba.
  - >udoxila (affiché أُدْخِلَ dans le Corpus) est le seul lemme verbal de forme IV de la racine dxl : le « à confirmer » du plan est levé.
  - أَجْلَسَ n'a que la racine jls (R), comme prévu par le plan.
- **C. Forme**
  - Vocalisation complète et juste : passés أَفْعَلَ, inaccomplis يُفْعِلُ, noms d'action إِفْعَال avec tanwīn.
  - Les cas sont justes : verbe en tête, sujet au nominatif, complément à l'accusatif. On a رِسَالَةً, الْمُسَافِرِينَ, إِلَى صَدِيقِهِ, et أَعْجَبَتْ est bien écarté avec الْقَصْرُ.
  - Hamza de la forme IV (أَ) correcte.
- **D. Sens**
  - Les sens des 8 fiches sont exacts et ce sont des sens linguistiques (أَصْلَحَ « réparer », sans glose religieuse).
  - Les exemples des fiches reprennent les modèles du plan et sont bien traduits.
- **F. Pédagogie**
  - Chaque QCM a 3 choix et une seule réponse juste : يُطْعِمُ/يَطْعَمُ, يُدْخِلُ/يَدْخُلُ, إِخْرَاجٌ/خُرُوجٌ/مَخْرَجٌ, les exercices à compléter dont le temps est fixé par la consigne, et التَّاجِرُ … رِسَالَةً avec « envoie ».
  - La Forge n'utilise que des racines saines et des formes de la liste.
  - La règle est conforme au plan : le u de l'inaccompli, le piège يُخْرِجُ ≠ يَخْرُجُ, et les moules أَفْعَلَ/أَفْعَلُ/أَكْتُبُ.
  - Translittérations conformes et cohérentes avec la convention du dépôt (pas de ʾ initial, comme « akbaru ») : aḫraǧa, adḫala, aǧlasa, aṭʿama, arsala, akrama, aṣlaḥa, aʿǧaba.
- **G. Statuts**
  - Toutes les fiches portent `source_sens` « rédigé par IA ».
  - La leçon a le statut `ia_non_verifie`, cohérent avec les autres leçons. L'affichage « rédigé par IA » relève du moteur.

## Ce que je n'ai pas pu vérifier
- Les fréquences des 8 lemmes : champ binaire, non lisible par recherche de texte. La leçon n'en affiche aucune.
- Le rendu à l'écran des mentions « rédigé par IA » et « exemple construit ».
- L'audio : suspendu.

---

# Rapport de relecture — Leçon 3.14 « La forme IV » (moteur-14), second passage

Fichier relu : /home/user/iqura/tools/build_content/lessons/etape3/14-la-forme-iv.json (dialogue, règles, lecture, atelier, mini-boss)
Stade : région 3, leçon 3.14 (Intermédiaire 2). Notions supposées acquises : régions 1 et 2 (هَلْ depuis 2.10), leçons 3.1 à 3.13.

## Verdict : Validé avec doutes

## Bloquant
- Aucun.

## Important
- Aucun. Les deux points Importants du premier passage sont corrigés.
  - **Exercice à remettre dans l'ordre** : la consigne dit maintenant « Écris dans l'ordre verbe, sujet, complément : … ». La seule solution acceptée (أَعْجَبَ الْقَصْرُ الْمُسَافِرِينَ) est donc la seule réponse juste.
  - **Règle 3** : le contre-exemple est maintenant أَرْسَلَ, « qui ne vient d'aucun verbe simple connu ». C'est exact et conforme au plan. أَعْجَبَ n'est plus présenté à tort comme un verbe qui ne fait rien faire.

## Mineur
- **[atelier · exercice à remettre dans l'ordre, explication]** Comme en 2.20 et 2.21, on pourrait ajouter une courte phrase : « L'arabe permet aussi l'ordre الْقَصْرُ أَعْجَبَ الْمُسَافِرِينَ. » L'apprenant saurait ainsi que l'autre ordre n'est pas faux. Facultatif.

## Doutes (à soumettre au conseiller, ne pas trancher)
- **[règle « Trois moules » · أَكْبَرُ]** Doute gardé tel quel, comme demandé. Vocalisé ainsi, أَكْبَرُ peut aussi être la 1re personne de كَبِرَ يَكْبَرُ, « je vieillis ». Le QCM reste à réponse unique. Confiance : faible à moyenne sur l'utilité de corriger.

## Points vérifiés sans problème
- **Dialogue (C, D)** :
  - « هَلْ خَرَجَ الْجَمَلُ؟ » et « وَهَلْ أَطْعَمْتَ الْجَمَلَ؟ » sont justes et entièrement vocalisés.
  - « فِي الصَّبَاحِ » est maintenant traduit « le matin ».
  - La question de compréhension a toujours une seule réponse juste.
- **Lecture (C, D, F)** :
  - الضَّيْفَ est au singulier partout et au bon cas : accusatif dans les phrases 1 à 3, nominatif « الضَّيْفُ » quand il est sujet dans la phrase 4.
  - Le récit est cohérent avec l'introduction (« un invité »).
  - La question « Le repas a-t-il plu à l'invité ? » est adaptée et a une seule réponse juste.
  - La répétition du nom est lourde mais grammaticale. Elle évite des pronoms compléments proches de suites sensibles (comme أَكْرَمَهُ).
- **Mini-boss (F)** : le distracteur « il a présenté » (le sens de قَدَّمَ) est plausible et clairement faux pour قَطَّعَ.
- **Respect du Coran (A)** : les corrections n'introduisent aucune suite sensible ni aucun mot exclu (B5).

## Ce que je n'ai pas pu vérifier
- Je n'ai pas relancé le garde-fou anti-versets ni le contrôle des mots connus sur cette version. À relancer à la construction : les mots sont connus, mais la vérification n'a pas été exécutée.
- Les fréquences des lemmes : le champ est binaire dans la base, je n'ai pas pu le lire.

---

# Rapport de relecture : leçon 3.15 « La forme V »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/15-la-forme-v.json
- /home/user/iqura/tools/build_content/vocab/mots.json (les 7 fiches `"lecon": "moteur-15"`)
- comparé avec /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (§B et plan de 3.15)
- données du corpus : /home/user/iqura/assets/content/iqura_content.db

Stade : région 3, leçon 3.15 (Intermédiaire 2, Rabāb, Salle des copistes). Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.14 (formes I à IV, préfixe en u ou en a, Forge). Décisions en vigueur : un verbe au masculin est admis devant un sujet féminin non réel ; consigne « dans l'ordre verbe, sujet, complément ».

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [15-la-forme-v.json · règle « Deux تَـ différents », texte] Problème : la phrase « تَعَجَّبَ « s'étonner » n'a pas de forme II connue : une tendance » se lit comme si la forme II n'existait pas en arabe. Or عَجَّبَ (« étonner quelqu'un », عَجَّبْتُهُ مِنَ الشَّيْءِ) existe dans les dictionnaires classiques (Lisān al-ʿArab). Le plan du conseiller dit seulement qu'aucune forme II n'est *connue de l'apprenant*. De plus, « une tendance » est trop elliptique pour un débutant. | Correction proposée : « Le sens « l'action revient sur le sujet » n'est qu'une tendance : pour تَعَجَّبَ « s'étonner », tu ne connais aucune forme II de départ. » Idéalement, mettre cette idée sur son propre écran ou dans la règle 1 : l'écran actuel mêle deux idées (voir Mineur). | Confiance : moyenne à haute (l'existence de عَجَّبَ vient de ma connaissance des dictionnaires, pas des données du dépôt : la base ne contient pas de forme II pour la racine ع ج ب, seulement les formes I et IV).

## Mineur
- [15-la-forme-v.json · règle « Deux تَـ différents »] Un écran = une idée : cet écran contient la distinction des deux تَـ **et** le contre-exemple de la tendance. Déplacer le contre-exemple (voir Important).
- [15-la-forme-v.json · règle « Inaccompli en a »] « garde a partout » est approximatif : يَتَعَلَّمُ se termine par u. Proposé : « L'inaccompli de la forme V a a sur le préfixe et avant la dernière lettre : يَتَعَلَّمُ (pas de u ni de i comme dans يُعَلِّمُ). » Cette formulation reprend la règle clé B3.
- [15-la-forme-v.json · entraînement, « Comment dit-on « il parle » ? »] Le distracteur يُكَلِّمُ a été traduit « parle (aux voyageurs) » en 3.12. Un apprenant peut donc hésiter. La bonne réponse reste défendable, car le sens est sans complément. Proposé : consigne « il parle (sans complément) », ou remplacer يُكَلِّمُ par un autre distracteur (ex. تَكَلَّمَ).
- [15-la-forme-v.json · mini-boss, révision « inaccompli de أَرْسَلَ »] Le distracteur يَرْسُلُ est une forme qui n'existe pas dans le dictionnaire du jeu. Il est plausible et marqué faux, mais selon B4, on ajoute à l'explication : « يَرْسُلُ : absent de notre dictionnaire ».
- [mots.json · taallama, takallama] Les fiches portent `"racine": "Elm"` et `"racine": "klm"`. Pourtant la base contient les lemmes de forme V `yataEal~amu` (يَتَعَلَّمُ, Elm, forme V) et `yatakal~amu` (يَتَكَلَّمُ, klm, forme V). Le plan les donnait comme « L », et le dépôt a déjà un précédent d'un lemme cité à l'inaccompli (`"lemme": "yaloEabo"`). Proposé : `"lemme": "yataEal~amu"` et `"lemme": "yatakal~amu"`, pour relier la fréquence. À confirmer avec `vocab.validate`.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [15-la-forme-v.json · lecture, « تَقَدَّمَ طَالِبٌ، وَتَحَدَّثَ مَعَ الشَّيْخِ. »] Ce qui me fait douter : تَحَدَّثَ مَعَ est très courant en arabe standard moderne. En prose classique, j'attends plutôt تَحَدَّثَ إِلَى, ou un sujet pluriel (تَحَدَّثُوا, « ils ont conversé »). Je ne suis pas sûr que مَعَ soit fautif. | Pistes : وَتَحَدَّثَ إِلَى الشَّيْخِ (إِلَى est connu), ou garder مَعَ si le conseiller le juge classique. | Confiance : faible à moyenne.

## Points vérifiés sans problème
- **A** (respect du Coran) :
  - aucune suite coranique repérée, aucun sujet divin, aucun « nous » de majesté ;
  - aucune forme exclue par B5 (تَكَبَّرَ, تَصَدَّقَ, تَقَبَّلَ…) ;
  - aucun des motifs ⚠ du plan (pas de تَفَرَّقُوا, de مَا تَقَدَّمَ, de يَتَذَكَّرُ الْإِنْسَانُ…) ;
  - récits profanes, aucun mot sur un monstre.
- **B / E** (données du corpus) :
  - تَقَدَّمَ (taqad~ama, qdm), تَفَرَّقَ (tafar~aqa, frq) et تَذَكَّرَ (ta*ak~ara, *kr) existent bien dans la base, en forme V ;
  - les racines Hdv et Ejb existent (fiches تَحَدَّثَ et تَعَجَّبَ en « R », conforme au plan) ;
  - schème تَفَعَّلَ juste sur les 7 fiches ;
  - inaccomplis et noms d'action (تَفَعُّل) justes.
- **C** (vocalisation, orthographe, grammaire) :
  - vocalisation complète et juste, accords justes : verbe en tête au singulier (تَعَلَّمَ الطُّلَّابُ, تَحَدَّثَ التُّجَّارُ), هُمْ تَعَلَّمُوا, تَقَدَّمَتِ الْقَافِلَةُ avec la voyelle de liaison ;
  - cas justes (فِي الْمَسَاءِ, قِصَّةً, بَاسِمٌ) ;
  - le distracteur fautif الضُّيُوفُ تَفَرَّقَ فِي الْمَسَاءُ est bien faux sur deux points.
- **D** (sens) : les sens de toutes les fiches sont justes, les traductions des exemples fidèles ; تَعَجَّبَ مِنْ est correct.
- **F** (pédagogie) :
  - tous les QCM ont 3 choix et une seule bonne réponse (la bonne réponse est l'index 0 partout) ;
  - les Forges utilisent des racines saines et non doublées, et uniquement des verbes de la liste ;
  - la consigne de l'exercice « ordonner » est conforme à la décision ;
  - les mots de la lecture sont tous connus (vérifié dans mots.json : قِصَّةٌ, مَجْلِسٌ, الْآنَ, ثُمَّ, كِتَابَةٌ, etc.) ;
  - les 7 mots nouveaux sont conformes au plan, ainsi que les modèles ;
  - un contre-exemple de la tendance est présent (B7), voir cependant le point Important sur sa formulation ;
  - translittérations Arabica justes (taʿallama, taḥaddaṯa, taḏakkara, taʿaǧǧaba…).
- **G** (statuts et sources) : `source_sens` « rédigé par IA » sur toutes les fiches ; le statut de la leçon est le code commun à toutes les leçons de l'étape 3.

## Ce que je n'ai pas pu vérifier
- Les fréquences (nombre d'occurrences) des lemmes : le champ est binaire dans la base, et je n'ai pas exécuté de SQL.
- L'affichage réel de la mention « rédigé par IA » et de la source des exemples dans l'application.
- Le résultat du garde-fou anti-versets et du contrôle des mots connus : je ne l'ai pas relancé, je me fie à ce que tu m'as indiqué.

---

# Rapport de relecture : leçon 3.15 « La forme V » (second passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/15-la-forme-v.json (écrans modifiés)
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches taallama et takallama)

Stade : région 3, leçon 3.15 (Intermédiaire 2). Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.14.

## Verdict : Validé

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- Aucun.

## Doutes (à soumettre au conseiller, ne pas trancher)
- Aucun. Le doute du premier passage (تَحَدَّثَ مَعَ) disparaît : la lecture dit maintenant تَحَدَّثَ إِلَى الشَّيْخِ.

## Points vérifiés sans problème
Les 7 corrections annoncées sont toutes en place et justes :
- **Nouvel écran « Une tendance » :**
  - Le texte est exact : « tu ne connais aucune forme II de départ » ne nie plus l'existence de عَجَّبَ, et « On vérifie toujours dans le dictionnaire » rejoint le cahier §5.
  - Le QCM (s'étonner / plaire à / se souvenir) n'a qu'une seule bonne réponse.
- **Écran « Deux تَـ différents » :**
  - Il ne porte plus qu'une idée.
  - « à l'inaccompli seulement » est juste pour le préfixe de personne (le تْ de كَتَبَتْ est une terminaison, pas un préfixe).
- **Règle de l'inaccompli :** la nouvelle formulation (a sur le préfixe et avant la dernière lettre, sans le u ni le i de يُعَلِّمُ) est exacte et reprend la règle clé B3.
- **QCM « il parle » :** le distracteur تَكَلَّمَ est un passé, donc il ne peut plus y avoir deux bonnes réponses.
- **Distracteur يَرْسُلُ :** l'explication dit maintenant qu'il est absent de notre dictionnaire, conforme à B4.
- **Lecture :** تَحَدَّثَ إِلَى الشَّيْخِ est bien vocalisé, et إِلَى est un mot déjà connu (mots.json).
- **Fiches :** `"lemme": "yataEal~amu"` et `"lemme": "yatakal~amu"` correspondent à des lemmes de forme V présents dans la base (racines Elm et klm).
- **Catégorie A (respect du Coran) :** aucune suite coranique ni aucun motif ⚠ du plan n'apparaît dans les passages modifiés.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas relancé la construction ni le garde-fou anti-versets : je me fie à ce que tu m'as indiqué (construction validée).
- Je n'ai relu que les écrans modifiés, avec une recherche ciblée. Je n'ai pas relu le reste du fichier ligne par ligne.
- Les fréquences des lemmes : le champ est binaire dans la base, et je n'ai pas exécuté de SQL.

---

# Rapport de relecture — Leçon 3.16 « La forme VI »

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/16-la-forme-vi.json ; /home/user/iqura/tools/build_content/vocab/mots.json (8 fiches `"lecon": "moteur-16"` : takaataba, taaarafa, taqaasama, tasaabaqa, tanaazaa, tashaabaha, tasaafaha, tamaarada). Plan comparé : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (§B et §3.16).
Stade : région 3, leçon 3.16 (Intermédiaire 2, Rabāb, Salle des copistes) ; notions supposées acquises : régions 1 et 2 (dont la conjugaison avec « nous », leçon 2.26, et le verbe en tête au singulier, 2.23), leçons 3.1 à 3.15 (formes I à V). Décisions en vigueur : Intermédiaire 1 et Élémentaire 3.

## Verdict : Validé avec doutes

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- [16-la-forme-vi.json · entraînement, « Complète : Les deux mots se ressemblent »] L'explication « Verbe en tête au passé ; avec un sujet féminin, on met d'habitude تْ » ne dit pas pourquoi تَتَشَابَهَانِ est faux. Le problème n'est pas le temps : c'est la terminaison du duel sur un verbe placé avant son sujet. Correction proposée : « Verbe en tête : singulier, sans terminaison de duel (pas تَتَشَابَهَانِ) ; avec un sujet féminin, on met d'habitude تْ : تَشَابَهَتِ. » | Confiance : haute.
- [16-la-forme-vi.json · mini-boss, « Quel est l'inaccompli de تَقَاسَمَ ? »] Les distracteurs تَقَاسَمَ (le mot de la question lui-même) et تَقَاسُمٌ ne sont pas plausibles. Proposition : يُقَاسِمُ et يَتَقَاسِمُ, deux pièges vus dans les leçons 3.13 et 3.15. | Confiance : haute.
- [16-la-forme-vi.json · questions « sens » sur تَقَاسَمَ, تَعَارَفَ et تَكَاتَبَ (entraînement et mini-boss)] La bonne réponse commence toujours par « ils » et les distracteurs par « il » : on trouve la réponse au seul pronom, sans connaître le mot. Proposition : mettre tous les choix au même pronom (par exemple « ils se sont partagé / ils ont divisé / ils se sont séparés »). | Confiance : haute.
- [16-la-forme-vi.json · règle « Compter le ā »] Cet écran contient deux idées : compter le ā (VI ou V), puis le verbe en tête au singulier. La règle « un écran = une idée » n'est donc pas respectée. Proposition : mettre la phrase sur l'accord dans l'écran « Les uns avec les autres », ou dans un écran à part. | Confiance : moyenne.
- [mots.json · tashaabaha + leçon] Le sens est donné de trois façons : « se ressembler » (fiche), « ils se sont ressemblé » (mini-boss), « Les deux mots se ressemblent » pour تَشَابَهَتِ (exemple, exercice). Le présent est défendable pour un verbe d'état, mais une harmonisation serait bienvenue (voir les Doutes). | Confiance : moyenne.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- [16-la-forme-vi.json · sens donnés sous la forme « ils … » pour un verbe au singulier (تَقَاسَمَ, تَعَارَفَ, تَكَاتَبَ, تَشَابَهَ, تَصَافَحَ, تَنَازَعَ)] Ce qui me fait douter : la forme affichée est à la 3e personne du masculin singulier. La leçon enseigne aussi que le verbe reste au singulier devant un sujet pluriel. Traduire تَقَاسَمَ seul par « ils se sont partagé » peut faire croire que la forme elle-même est plurielle, alors que l'atelier propose justement تَقَاسَمُوا comme piège. | Pistes : (a) garder ce choix, en ajoutant une phrase dans la règle : « تَقَاسَمَ seul = “il a partagé (avec d'autres)” ; avec un sujet pluriel après lui = “ils se sont partagé” » ; (b) donner le sens à l'infinitif, comme sur les fiches (« se partager »). | Confiance : moyenne.
- [16-la-forme-vi.json · traduire « ils font la course ensemble »] Le distracteur يُسَابِقُونَ (forme III, « ils font la course avec [quelqu'un] ») est presque juste. C'est seulement « ensemble » qui fait de يَتَسَابَقُونَ la meilleure réponse. Pour moi, il y a une seule bonne réponse, mais c'est limite pour un débutant. | Piste : remplacer par يَتَسَابَقُ ou يَسْبِقُونَ. | Confiance : moyenne (je ne pense pas qu'il y ait deux bonnes réponses).
- [mots.json · tashaabaha · exemple] La traduction au présent de تَشَابَهَتِ الْكَلِمَتَانِ (« se ressemblent ») est conforme au plan. Je laisse au conseiller le choix entre le présent d'état et « se sont ressemblé ». | Confiance : moyenne.

## Points vérifiés sans problème
- A : aucun verset ni aucune suite coranique repérée. Les mots des pièges ⚠ du plan n'apparaissent qu'isolés (يَتَنَازَعُونَ, تَشَابَهَ, تَقَاسَمَ, يَتَعَارَفُونَ) ; on ne trouve ni لِتَعَارَفُوا, ni تَشَابَهَ عَلَيْنَا, ni تَشَابَهَتْ قُلُوبُهُمْ, ni تَقَاسَمُوا بِاللَّهِ. Pas de sujet divin, pas de nom sacré, aucun sens religieux ; les récits sont profanes (enfants au pont, caravane).
- B/E : racines des fiches vérifiées dans `assets/content/iqura_content.db` : ktb, Erf (lemme `yataEaArafu`, VI), qsm (lemme `taqaAsamu`, VI), sbq (le Corpus n'a que les formes I, III et VIII : تَسَابَقَ est donc « R », comme le dit le plan), nzE (lemme `tana`zaEu`, VI), $bh (lemme `ta$a`baha`, VI), SfH (forme I seulement : « R »), mrD (« R »). Les fiches n'affichent aucune fréquence ni aucun lemme inventé.
- C : vocalisation complète et juste partout. Le moule تَفَاعَلَ / يَتَفَاعَلُ / تَفَاعُل et le schème تَفَاعَلَ des 8 fiches sont corrects, de même que les inaccomplis (يَتَكَاتَبُ, يَتَعَارَفُ, …) et les noms d'action en tanwīn. La kasra de liaison est bien là (تَشَابَهَتِ الْكَلِمَتَانِ). Le duel suit un verbe singulier (تَكَاتَبَ الصَّدِيقَانِ, تَصَافَحَ الرَّجُلَانِ). سَمِيرٌ prend bien le tanwīn. Le registre est classique et les caractères Unicode sont corrects.
- D : les sens sont exacts (تَمَارَضَ « faire semblant d'être malade », تَصَافَحَ « se serrer la main », etc.). Les traductions françaises sont justes, accords des participes compris (« se sont écrit », « se sont partagé », « se sont ressemblé »).
- F : chaque QCM n'a qu'une bonne réponse. Les distracteurs de production sont bien fautifs : تَكَاتَبُوا, تَصَافَحَا, تَتَشَابَهَانِ devant le sujet, تَقَاسَمُوا, et la phrase fautive de l'atelier. La Forge respecte B4/B5 (فرق, سبق, كتب, عرف, نزع, ذكر : racines saines, non doublées, non exclues). « nous » (نَتَكَاتَبُ, تَعَارَفْنَا) a été vu en 2.26. Les mots support sont connus (طِفْلٌ, جِسْرٌ, تَمْرٌ, مَرِيضٌ, صَدِيقٌ, كَلِمَةٌ, سَمِيرٌ). La tendance est nuancée (« souvent », « parfois »), avec le sens « faire semblant » donné comme autre valeur. La translittération Arabica des 8 fiches est exacte (takātaba, taʿārafa, taqāsama, tasābaqa, tanāzaʿa, tašābaha, taṣāfaḥa, tamāraḍa).
- G : les fiches portent « rédigé par IA » et la leçon le statut `ia_non_verifie`.

## Ce que je n'ai pas pu vérifier
- Les fréquences du Corpus (champ binaire non lisible par recherche de texte). Les fiches n'en affichent pas.
- L'affichage réel de la source des exemples (« exemple construit ») et du statut dans l'application.
- L'audio, suspendu.

---

# Rapport de relecture — Leçon 3.16 « La forme VI » (2e passage, après corrections)

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/16-la-forme-vi.json (tous les écrans corrigés, plus le reste de la leçon pour la cohérence).
Stade : région 3, leçon 3.16 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.15 ; décisions d'Intermédiaire 1 et d'Élémentaire 3.

## Verdict : Validé avec doutes

Les six corrections demandées sont faites et justes. Il ne reste aucun point Bloquant, Important ou Mineur. Deux doutes restent pour le conseiller.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- Aucun.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- [tout le fichier · sens donnés en « ils … » pour une forme au singulier] Ce doute est déjà transmis au conseiller. La règle 1 dit maintenant explicitement « le verbe en tête reste au singulier », ce qui diminue le risque de confusion. Confiance : moyenne.
- [entraînement et fiche tashaabaha · présent « se ressemblent » pour تَشَابَهَتِ] Déjà transmis au conseiller. Confiance : moyenne.

## Points vérifiés sans problème
- **Explication du duel** (« Complète : Les deux mots se ressemblent ») : elle donne maintenant la vraie raison, « singulier, sans terminaison de duel (pas تَتَشَابَهَانِ) », puis la règle du تْ. Elle est exacte et reste conforme à la décision d'Élémentaire 3 (« d'habitude »).
- **Inaccompli de تَقَاسَمَ** (mini-boss) : les choix sont يَتَقَاسَمُ, يَتَقَاسِمُ et تَقَاسُمٌ. Il n'y a qu'une bonne réponse. يَتَقَاسِمُ reprend le piège du i, plausible. Remplacer يُقَاسِمُ est acceptable, puisque le contrôle des mots connus l'a refusé.
- **Questions de sens** : تَقَاسَمَ (« ils se sont partagé / divisés / séparés »), تَعَارَفَ (« ils ont fait connaissance / ont su / se sont écrit ») et تَكَاتَبَ (« se sont écrit / serré la main / disputés ») ont maintenant tous leurs choix au même pronom. Le pronom ne révèle donc plus la réponse, et aucun distracteur n'est une seconde bonne réponse. « Se diviser » correspond à la forme VII et « se séparer » à تَفَرَّقَ : ce sont bien d'autres sens. Les accords français sont justes : « se sont divisés », « séparés » et « disputés » s'accordent, « se sont partagé » ne s'accorde pas.
- **Règle 1** : « Elle dit souvent une action réciproque ; le verbe en tête reste au singulier : تَكَاتَبَ الصَّدِيقَانِ » est juste, et l'exemple est bien vocalisé.
- **Règle « Compter le ā »** : elle ne contient plus qu'une idée (ā contre shadda, تَكَاتَبَ ≠ تَكَلَّمَ). Sa question ne change pas et reste juste.
- **« ils font la course ensemble »** : les choix sont يَتَسَابَقُونَ, تَسَابُقٌ et يَتَنَازَعُونَ. Il n'y a plus de distracteur presque juste.
- **A à G** : rien ne régresse par rapport au premier passage. Aucune suite coranique n'a été ajoutée, la vocalisation et la grammaire des passages modifiés sont correctes, et il n'y a pas de notion nouvelle hors des prérequis.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas relancé la construction ni le garde-fou anti-versets sur la version corrigée (je ne lance aucun outil d'écriture). Les mots ajoutés (يَتَقَاسِمُ, تَسَابُقٌ, les sens en « ils ») ne créent pas, à ma lecture, de suite de trois mots du Coran.
- Les fréquences du Corpus, comme au premier passage.

---

# Rapport de relecture — Leçon 3.17 « La forme VII »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/17-la-forme-vii.json
- /home/user/iqura/tools/build_content/vocab/mots.json (6 fiches « moteur-17 » : infataha, inqataa, inqasama, intalaqa, insarafa, inqalaba)
- Plan : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (B1 à B9, section 3.17)

Stade : région 3, leçon 3.17 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.16 (formes I à VI, règle « verbe en tête au singulier », masculin admis devant un féminin non réel). Le passif n'est vu qu'en 3.21.

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [17-la-forme-vii.json · lecture « Le départ du matin », phrase 1] « فِي الصَّبَاحِ، انْفَتَحَ بَابُ الْقَافِلَةِ. » Problème : « la porte de la caravane » n'a pas de sens, une caravane n'a pas de porte. En touchant les mots, l'apprenant reconstitue une phrase absurde. | Correction proposée : prendre un nom qui a une porte et qui est déjà connu, par ex. « فِي الصَّبَاحِ، انْفَتَحَ بَابُ الْبَيْتِ. » ou simplement « فِي الصَّبَاحِ، انْفَتَحَ الْبَابُ. » (à repasser au contrôle des mots connus et au garde-fou). | Confiance : haute.

## Mineur
- [17-la-forme-vii.json · règle « Sans complément direct »] « Son alif se lit i en début de phrase et disparaît après وَ ». C'est incomplet : l'alif de liaison tombe après **tout** mot lu sans pause, et la lecture le montre aussitôt avec « ثُمَّ انْطَلَقَتِ » (ṯumma -nṭalaqat), un cas que la règle ne couvre pas. | Correction proposée : « Son alif se lit i en début de phrase ; après un mot lu sans pause, il disparaît : وَانْطَلَقَ (wa-nṭalaqa), ثُمَّ انْطَلَقَتْ (ṯumma nṭalaqat). » Cette formulation reprend celle de B2 : à faire valider par le conseiller si l'on change la phrase type. | Confiance : haute sur le fait.
- [17-la-forme-vii.json · entrée, dialogue et question du dialogue] « Personne ne l'a ouverte ! », traduction « La porte s'est ouverte (personne ne l'a ouverte) » et bonne réponse « personne : elle s'est ouverte ». L'explication dit pourtant « on ne dit pas qui agit », ce qui est la règle juste. La forme VII ne dit pas « personne n'a agi » : en arabe classique, فَتَحْتُهُ فَانْفَتَحَ (« je l'ai ouverte et elle s'est ouverte ») est courant. L'apprenant risque de retenir « VII = sans auteur ». | Correction proposée : traduction « La porte s'est ouverte. » sans parenthèse ; réponse « on ne le dit pas : elle s'est ouverte » ; l'histoire du coup de vent peut rester dans la réplique d'entrée. | Confiance : haute.
- [17-la-forme-vii.json · règle « Le ن n'est pas dans la racine »] « انْطَلَقَ n'est le passif d'aucun verbe que tu connais ». Le mot « passif » est imprécis pour la forme VII (il s'agit d'un réfléchi ou d'un « ce qui arrive à ») et il crée une confusion avec le vrai passif de 3.21, pas encore vu. | Correction proposée : « انْطَلَقَ « partir » ne correspond à aucun verbe I que tu connais. » | Confiance : haute.
- [17-la-forme-vii.json · écran fin] « la forme VIII, avec un ت glissé dans la racine ». Le ت ne fait pas partie de la racine, alors que la leçon vient d'insister sur ce point pour le ن. | Correction proposée : « avec un ت glissé après la 1re lettre de la racine ». | Confiance : haute.
- [mots.json · insarafa] La fiche porte « racine »: "Srf » (statut R). Or le corpus du dépôt contient bien le lemme de forme VII : `{nSarafu` / ٱنصَرَفُ, racine Srf, forme VII (trouvé dans iqura_content.db). Le plan écrivait `{nSarafa`, une graphie qui n'existe pas dans les données. | Correction proposée : `"lemme": "{nSarafu"` à la place de `"racine": "Srf"`, si le validateur accepte ce lemme (fréquence à lire en SQL). | Confiance : moyenne (je n'ai lu l'entrée qu'en recherche de texte).

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- [17-la-forme-vii.json · lecture, phrase 1] « فِي الصَّبَاحِ، انْفَتَحَ » : faut-il dire « fī ṣ-ṣabāḥi nfataḥa » (liaison) ou « infataḥa » (pause marquée par la virgule) ? Les deux lectures se défendent. La règle de l'écran ne dit rien de la virgule ; c'est sans conséquence tant que l'audio est suspendu. | Pistes : le conseiller peut ajouter à B2 « après une pause, on reprend avec i ». | Confiance : moyenne.

## Points vérifiés sans problème
- A : aucun verset ni suite coranique repérée. Les pièges ⚠ du plan sont respectés : pas de « ثُمَّ انْصَرَفُوا », pas de « فَانْطَلَقَا » ni « انْطَلِقُوا », انْقَلَبَ n'est jamais suivi de إِلَى ou عَلَى, انْفَجَرَ est absent, aucun sujet divin. Aucun nom sacré, récit profane.
- B/E : les lemmes `{nTalaqa` (Tlq, VII), `{nqalaba` (qlb, VII) et `{nSarafu` (Srf, VII) sont présents dans la base. انْفَتَحَ, انْقَطَعَ et انْقَسَمَ n'ont pas de lemme de forme VII dans le corpus : le statut R (racine seule) est juste. Aucune fréquence n'est affichée dans la leçon.
- C : vocalisation complète et juste partout (انْطَلَقَتِ avec la kasra de liaison, يَنْفَتِحُ, تَنْفَتِحُ, انْفِعَال sans tanwīn comme schème, noms d'action انْفِتَاحٌ, انْقِطَاعٌ, انْقِسَامٌ, انْطِلَاقٌ, انْصِرَافٌ, انْقِلَابٌ). L'alif de liaison est écrit sans voyelle (B2). Accords justes : انْصَرَفَ الضُّيُوفُ au singulier en tête, انْقَلَبَ الصَّحْنُ au masculin, انْطَلَقَتِ الْقَافِلَةُ avec l'explication « d'habitude تْ », conforme à la décision d'Élémentaire 3.
- D : les sens sont exacts (s'ouvrir, se rompre ou s'interrompre, se diviser, partir, s'en aller ou se retirer, se retourner ou se renverser) ; aucune forme active n'est traduite par un passif ; les traductions des exemples sont fidèles.
- F : tous les QCM ont 3 choix et une seule bonne réponse ; les distracteurs sont plausibles (formes VI ou II, nom d'action, accompli au lieu de l'inaccompli, ن pris pour une lettre de la racine). L'exercice à ordonner a la bonne consigne (« verbe, sujet, complément ») et la tuile piège انْصَرَفُوا. La tendance et son contre-exemple sont donnés (B7). Les translittérations Arabica sont exactes (infataḥa, inqaṭaʿa, inqasama, inṭalaqa, inṣarafa, inqalaba, wa-nṭalaqa).
- G : chaque fiche porte « rédigé par IA » et le statut de la leçon est ia_non_verifie.

## Ce que je n'ai pas pu vérifier
- Les fréquences des lemmes : le champ est binaire dans la base, je n'ai fait que des recherches de texte.
- Le contrôle des mots connus et le garde-fou : je m'en remets à la construction, que je n'ai pas relancée.
- L'audio, suspendu.

---

# Rapport de relecture — Leçon 3.17 « La forme VII » (second passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/17-la-forme-vii.json (relu en entier)
- /home/user/iqura/tools/build_content/vocab/mots.json (fiche insarafa)

Stade : région 3, leçon 3.17 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.16. Le passif n'est vu qu'en 3.21.

## Verdict : Validé avec doutes

## Bloquant
- Aucun.

## Important
- Aucun. Le point du premier passage est corrigé : la phrase 1 de la lecture est maintenant « فِي الصَّبَاحِ، انْفَتَحَ بَابُ الْبَيْتِ. », correctement vocalisée (iḍāfa بَابُ الْبَيْتِ) et sensée.

## Mineur
- Aucun nouveau point. Les quatre corrections demandées sont faites :
  - règle de l'alif : « se lit i en début de phrase ; après un mot lu sans pause, il disparaît : وَانْطَلَقَ (wa-nṭalaqa) » ;
  - dialogue : « La porte s'est ouverte. » et réponse « on ne le dit pas : elle s'est ouverte », cohérente avec l'explication ;
  - « ne correspond à aucun verbe I que tu connais » : le mot « passif » a disparu ;
  - fin : « un ت glissé après la 1re lettre de la racine ».
- La fiche insarafa est reliée au lemme `{nSarafu`, présent dans la base (forme VII, racine Srf).
- La réplique d'entrée « Personne ne l'a ouverte ! » reste. Ce n'est pas une erreur : c'est un fait du récit (le coup de vent), et la règle ne le présente plus comme le sens de la forme VII.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [17-la-forme-vii.json · lecture, phrase 1] « فِي الصَّبَاحِ، انْفَتَحَ ». Après la virgule, lit-on avec liaison (« fī ṣ-ṣabāḥi nfataḥa ») ou après une pause (« infataḥa ») ? Les deux lectures se défendent. La nouvelle règle (« après un mot lu sans pause ») laisse les deux possibles, ce qui convient tant que l'audio est suspendu. | Pistes : préciser dans B2 « après une pause (virgule), on reprend avec i ». | Confiance : moyenne.

## Points vérifiés sans problème
- A : aucune suite coranique repérée, ni dans la nouvelle phrase ni ailleurs. Les pièges ⚠ du plan sont respectés : pas de « ثُمَّ انْصَرَفُوا », انْقَلَبَ n'est jamais suivi de إِلَى ou عَلَى, pas de انْفَجَرَ, aucun sujet divin.
- B/E : les lemmes `{nTalaqa`, `{nqalaba` et `{nSarafu` sont dans le corpus du dépôt ; ftH, qTE et qsm sont en statut R (racine seule), ce qui est justifié.
- C : vocalisation et accords justes dans tout le fichier (انْطَلَقَتِ الْقَافِلَةُ, انْصَرَفَ الضُّيُوفُ, انْقَلَبَ الصَّحْنُ) ; l'alif de liaison suit la convention B2.
- D : les sens et les traductions sont exacts, sans nuance inventée.
- F : tous les QCM ont 3 choix et une seule bonne réponse ; l'exercice à ordonner a la bonne consigne ; les translittérations Arabica sont exactes ; les nouvelles formulations ne font appel à aucune notion pas encore vue.
- G : chaque fiche porte « rédigé par IA » et le statut de la leçon est ia_non_verifie.

## Ce que je n'ai pas pu vérifier
- Les fréquences des lemmes : le champ est binaire dans la base.
- La construction (garde-fou et contrôle des mots connus) : je ne l'ai pas relancée, je m'appuie sur la validation que tu as annoncée.
- L'audio, suspendu.

---

# Rapport de relecture — Leçon 3.18 « La forme VIII »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/18-la-forme-viii.json
- /home/user/iqura/tools/build_content/vocab/mots.json (7 fiches "moteur-18" : ijtamaa, istamaa, intazara, iqtaraba, ikhtalafa, idtaraba, iddakhara)
- Fichiers de référence : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (B et 3.18), cahier §5 l. 305-310, base /home/user/iqura/assets/content/iqura_content.db

Stade : région 3, leçon 3.18 (Intermédiaire 2, Rabāb, Salle des copistes). Acquis : régions 1 et 2, leçons 3.1 à 3.17 (formes I à VII, alif de liaison B2). Pas encore vus : بِـ, فَـ, عَنْ.

## Verdict : À corriger

Deux points Important, tous deux faciles à corriger. Aucun point Bloquant, aucun point de la catégorie A.

## Bloquant
- Aucun.

## Important
- [18-la-forme-viii.json · écran règle « Compter les lettres »] Problème : le texte dit « اسْتَمَعَ est une forme VIII de س م ع, pas une forme X : un seul ت, après la 1re lettre ». Ce critère est faux : la forme X (اسْتَـ) n'a elle aussi qu'un seul ت. Ce qui décide, c'est que le س appartient à la racine : après اسْتَـ, il ne resterait que deux lettres (م ع). La leçon 3.19 donne d'ailleurs le bon critère (« on compte les lettres de la racine »). | Correction proposée : « اسْتَمَعَ est une forme VIII de س م ع, pas une forme X : le س est de la racine. Après اسْتَـ, il ne resterait que م ع, deux lettres. C'est افْتَعَلَ, avec un ت après la 1re lettre س. » | Confiance : haute.
- [18-la-forme-viii.json · ensemble de la leçon] Problème : le cahier §5 (l. 310) et le principe B7 du plan demandent que chaque leçon de forme rappelle que le sens de la forme est une tendance, avec un contre-exemple. Toutes les leçons 3.12 à 3.19 le font, mais pas 3.18 : elle ne donne ni valeur de sens pour la forme VIII, ni rappel « tendance », ni contre-exemple. | Correction proposée : ajouter une phrase à la règle 1 ou à l'écran « Compter les lettres », du type « Le sens de la forme VIII varie (جَمَعَ → اجْتَمَعَ « se réunir ») ; c'est une tendance : انْتَظَرَ « attendre » ne vient d'aucun verbe I que tu connais avec ce sens. » La valeur exacte à enseigner (réfléchi ? effort pour soi ?) est à faire trancher par le conseiller. | Confiance : haute sur le manque ; la formulation reste à valider.

## Mineur
- [écran « Le ت qui change »] Pour ادَّخَرَ, la règle dit seulement « il devient د ». Or le ذ de la racine disparaît lui aussi (ذ + ت → دّ). Ce n'est expliqué que dans une explication d'exercice et sur la fiche. Proposition : « Après د ذ ز, il devient د ; avec ذ, les deux se fondent en دّ : ذ خ ر → ادَّخَرَ. »
- [aperçu et règle 2 · اصْطَبَرَ] Le mot est montré deux fois sans aucun sens. Proposition : ajouter un sens linguistique général (« s'armer de patience »), à valider par le conseiller.
- [entraînement · sens de اخْتَلَفَ] « il a différé, été en désaccord » : au passé composé, « il a différé » se lit d'abord « il a reporté ». Proposition : « il a été différent ; il a été en désaccord ». Même remarque possible pour la fiche (« différer » à l'infinitif reste ambigu, mais moins).
- [lecture · phrase 4] « اخْتَلَفَ الطُّلَّابُ: « الْقِصَّةُ قَدِيمَةٌ؟ الْقِصَّةُ جَدِيدَةٌ؟ » » : c'est grammatical (question marquée par l'intonation), mais peu naturel en arabe classique. Si هَلْ est acquis, on peut écrire « هَلِ الْقِصَّةُ قَدِيمَةٌ؟ هَلْ هِيَ جَدِيدَةٌ؟ ». À faire vérifier par le contrôle des mots connus.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [entraînement · « Bāsim a attendu son ami à la porte », distracteur نَظَرَ] Ce qui me fait douter : en arabe classique, نَظَرَ suivi d'un complément direct, sans إِلَى, peut vouloir dire « attendre » (les lexiques donnent نَظَرَهُ comme synonyme de انْتَظَرَهُ). « نَظَرَ بَاسِمٌ صَدِيقَهُ » pourrait alors être une deuxième réponse juste. | Pistes : remplacer نَظَرَ par un autre distracteur (par ex. اجْتَمَعَ ou اقْتَرَبَ), ou garder si le conseiller juge cet emploi trop rare. | Confiance : moyenne.
- [atelier · « Les étudiants ont écouté l'histoire », distracteur سَمِعَ] Ce qui me fait douter : « سَمِعَ إِلَى » au sens de « prêter l'oreille » est attesté dans les lexiques classiques. سَمِعَ pourrait donc être juste devant إِلَى الْقِصَّةِ, d'autant que la consigne dit « ont écouté » et non « ont écouté attentivement ». | Pistes : remplacer سَمِعَ par انْتَظَرَ, ou écrire « ont écouté attentivement » dans la consigne. | Confiance : moyenne-faible.
- [entraînement · sens de اخْتَلَفَ, distracteur « il s'est disputé »] Ce qui me fait douter : il est proche d'« être en désaccord » ; un apprenant pourrait le juger juste. | Pistes : le remplacer par « il a rassemblé » ou « il s'est approché ». | Confiance : faible (probablement acceptable).

## Points vérifiés sans problème
- A : aucune suite coranique repérée (اقْتَرَبَتِ suivi de الْقَافِلَةُ et non de السَّاعَةُ ; pas de « ثُمَّ انْصَرَفُوا », de « اخْتَلَفُوا فِيهِ » ni de « فَاسْتَمِعُوا ») ; aucun sujet divin, aucun nom sacré ; récit profane ; اصْطَبَرَ n'apparaît que comme mot isolé ; le garde-fou est passé.
- B/E : les lemmes des fiches existent dans la base, tous en forme VIII et avec la bonne racine : {jotamaEu (jmE), {sotamaEa (smE), yantaZiru (nZr), {qotaraba (qrb), {xotalafa (xlf), tad~axiru (*xr). اضْطَرَبَ est donné en racine seule (Drb), sans lemme ni fréquence, comme le prévoit le plan. اعْتَرَفَ est bien retiré. Aucune fréquence n'est affichée.
- B8 : aucun schème sur les fiches de اضْطَرَبَ et ادَّخَرَ ; schème افْتَعَلَ sur les cinq autres. B2 : alif de liaison sans voyelle partout (وَانْتَظَرُوا, وَاضْطَرَبَ, ثُمَّ اسْتَمَعُوا).
- C : vocalisation complète et juste (cas, tanwīn, اقْتَرَبَتْ قَافِلَةٌ / اقْتَرَبَتِ الْقَافِلَةُ, ادِّخَارٌ, اضْطِرَابٌ) ; accords justes (verbe en tête au singulier, pluriel après un sujet déjà nommé : وَانْتَظَرُوا…اسْتَمَعُوا) ; إِلَى après اسْتَمَعَ, مِنْ après اقْتَرَبَ ; registre classique.
- D : les traductions des exemples, du dialogue et des fiches sont fidèles ; les sens sont linguistiques.
- F : chaque QCM a 3 choix et une seule réponse sûre (en dehors des doutes ci-dessus) ; l'exercice « ordonner » suit la consigne en vigueur (verbe, sujet, complément) ; l'assimilation n'est que lue, jamais forgée ; seules des racines saines sont forgées.
- F7 : translittérations conformes à la norme Arabica et à la vocalisation (iǧtamaʿa, istamaʿa, intaẓara, iqtaraba, iḫtalafa, iḍṭaraba, iddaḫara).
- G : le statut « ia_non_verifie » figure sur la leçon et « rédigé par IA » sur chaque fiche.

## Ce que je n'ai pas pu vérifier
- Les fréquences (champ binaire dans la base) ; elles ne sont de toute façon pas affichées dans cette leçon.
- Le taux de 95 % de mots connus et la présence de ثُمَّ, هَلْ, قِصَّة, قَافِلَة parmi les acquis : je me fie au contrôle automatique, qui est passé.
- Le texte du Coran n'est pas dans le dépôt : je n'ai repéré les suites coraniques que de mémoire ; le garde-fou fait foi.
- L'audio : suspendu.

---

# Rapport de relecture — Leçon 3.18 « La forme VIII » (second passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/18-la-forme-viii.json (écrans modifiés)
- /home/user/iqura/tools/build_content/vocab/mots.json (fiche ikhtalafa)

Stade : région 3, leçon 3.18 (Intermédiaire 2, Rabāb). Acquis : régions 1 et 2, leçons 3.1 à 3.17 ; هَلْ est enseigné depuis la leçon 2.10.

## Verdict : Validé avec doutes

Les deux points Important du premier passage sont corrigés, ainsi que les quatre Mineurs. Les trois doutes du premier passage sont levés par les nouveaux distracteurs. Il reste un Mineur et deux doutes, sur le nouvel écran « Une tendance ».

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- [écran « Une tendance » · contre-exemple] Le texte dit « انْتَظَرَ « attendre » ne correspond à aucun verbe I que tu connais ». Or l'apprenant connaît نَظَرَ « regarder » depuis la leçon 3.11, et la leçon elle-même lui fait trouver la racine ن ظ ر. Il peut y voir une contradiction. Proposition : « انْتَظَرَ « attendre » a la racine de نَظَرَ « regarder », mais son sens ne se devine pas à partir de نَظَرَ. » Autre solution : prendre un autre contre-exemple (voir les doutes).

## Doutes (à soumettre au conseiller, ne pas trancher)
- [écran « Une tendance » · valeur de sens] Ce qui me fait douter : « l'action revient sur le sujet ou se fait pour lui » résume des valeurs classiques de la forme VIII (réfléchi, action faite pour soi). La formule est défendable, mais simplifiée ; d'autres valeurs existent (réciproque, effort), et le coordinateur la soumet déjà au conseiller. | Pistes : garder la formule, ou la limiter à « revient souvent sur le sujet ». | Confiance : moyenne.
- [écran « Une tendance » · choix de انْتَظَرَ comme contre-exemple] Ce qui me fait douter : on peut comprendre « attendre » comme « regarder pour soi, guetter », ce qui irait dans le sens de la tendance au lieu de la contredire. Le contre-exemple serait alors faible. | Pistes : une formulation sur « le sens ne se devine pas », comme proposé au Mineur ; ou un autre verbe de la leçon, si le conseiller en juge un plus net. | Confiance : moyenne.

## Points vérifiés sans problème
- A : rien de nouveau à signaler. Les phrases modifiées (هَلِ الْقِصَّةُ قَدِيمَةٌ؟ هَلْ هِيَ جَدِيدَةٌ؟) ne rappellent aucun passage connu ; les gloses restent linguistiques (اصْطَبَرَ « s'armer de patience »).
- C : هَلِ porte bien la kasra de liaison devant الْقِصَّةُ, et هَلْ هِيَ جَدِيدَةٌ est juste. La règle du ت est maintenant exacte et complète (« avec ذ, les deux se fondent en دّ »). Le critère de « Compter les lettres » est juste (le س est de la racine ; après اسْتَـ il ne resterait que م ع) et cohérent avec la leçon 3.19.
- D : la fiche donne « être différent ; être en désaccord », et l'exercice « il a été différent, en désaccord » ; les deux concordent et ne sont plus ambigus.
- F4 : les distracteurs sont désormais sûrs, avec une seule réponse juste. انْتَظَرَ ne va pas avec إِلَى الْقِصَّةِ ; اقْتَرَبَ ne convient pas à « a attendu son ami » ; « il s'est approché » n'est pas un sens de اخْتَلَفَ. La QCM « Le sens d'une forme… » n'a qu'une bonne réponse.
- F5 : le rappel « tendance » et son contre-exemple, exigés par le cahier §5, sont présents ; un écran = une idée.
- B8 et E : inchangés (vérifiés au premier passage).

## Ce que je n'ai pas pu vérifier
- Le texte du Coran n'est pas dans le dépôt : je ne vérifie les suites coraniques que de mémoire ; le garde-fou fait foi et doit être relancé à la construction.
- Le taux de 95 % de mots connus après l'ajout de هَلْ et هِيَ : à confirmer par le contrôle automatique (هَلْ est vu en 2.10).
- L'audio : suspendu.

---

# Rapport de relecture : leçon 3.19 « La forme X »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/19-la-forme-x.json
- /home/user/iqura/tools/build_content/vocab/mots.json (8 fiches "moteur-19" : istakhraja, istatama, istafhama, istansakha, istakthara, istasghara, istahsana, istaqbala)
- Référence : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (B1 à B9 et plan 3.19)

Stade : région 3, leçon 3.19 (Intermédiaire 2, Rabāb, Tour du guet). Acquis supposés : régions 1 et 2, leçons 3.1 à 3.18 (formes I à VIII, dont أَخْرَجَ « faire sortir » en 3.14, قَابَلَ « rencontrer » en 3.13, فَهَّمَ en 3.12). Pronoms exercés : هُوَ, هِيَ, هُمْ, أَنَا.

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [19-la-forme-x.json · entraînement, exercice « sens » de اسْتَخْرَجَ] Problème : le distracteur « il a fait sortir » est aussi un sens juste de اسْتَخْرَجَ (extraire = faire sortir quelque chose de quelque part). La leçon veut l'opposer à أَخْرَجَ, mais en français la glose vaut pour les deux verbes : le QCM a donc deux réponses défendables. | Correction proposée : remplacer « il a fait sortir » par un sens sans lien, par exemple « il est entré » ou « il a écouté attentivement ». | Confiance : haute.
- [19-la-forme-x.json · entraînement, « Complète : Les hommes tirent l'eau du puits »] Problème : le distracteur يُخْرِجُ donne une phrase juste et de sens voisin (يُخْرِجُ الرِّجَالُ الْمَاءَ مِنَ الْبِئْرِ, « les hommes font sortir l'eau du puits »). La traduction « tirent » ne l'exclut pas vraiment : deux réponses défendables. | Correction proposée : remplacer يُخْرِجُ par يَخْرُجُ. Ce verbe est intransitif, il ne peut pas avoir الْمَاءَ pour complément, et c'est un bon piège de forme. | Confiance : haute.

## Mineur
- [19-la-forme-x.json · écran « mots », question sur اسْتَقْبَلَ] Le distracteur « il a rencontré » (sens de قَابَلَ) est proche de « aller au-devant de », le premier sens donné sur la fiche. Un apprenant qui vient de lire la fiche peut hésiter. Proposition : le remplacer par « il a refusé » ou « il a écouté ».
- [19-la-forme-x.json · règle « Inaccompli et nom d'action »] Trois idées sur un écran : l'inaccompli, le nom d'action et l'alif de liaison. Or les relectures précédentes ont demandé « un écran = une idée ». Proposition : déplacer la phrase sur l'alif dans un écran à part, ou la rappeler seulement dans l'explication d'un exercice.
- [19-la-forme-x.json · règle « Attention aux ressemblances »] Deux idées sur un écran : les fausses formes X (اسْتَمَعَ, اسْمٌ) et le sens qui n'est qu'une tendance (اسْتَقْبَلَ). Proposition : séparer les deux. Autre solution : garder le contre-exemple اسْتَقْبَلَ dans la règle 1, qui parle déjà du sens.
- [19-la-forme-x.json · question du dialogue] Le distracteur « il l'a achetée » n'est pas démenti par le dialogue : Bāsim dit seulement que le prix est élevé. C'est peu gênant, puisque la question porte sur ce qu'il « a pensé ». On peut le remplacer par « il l'a trouvée laide » si l'on veut un piège clair.
- [decisions-intermediaire-2.md · plan 3.19 / mots.json] Les identifiants de lemme du plan ne sont pas ceux des fiches : le plan donne {sotanosaxa et {sotakovara, les fiches donnent nasotansixu et {sotakovaro. Ce sont les fiches qui ont raison : la construction contrôle que le lemme existe dans le Corpus, et la chaîne « {sotanosax » est absente de assets/content/iqura_content.db. Il suffit de corriger le plan pour qu'il corresponde aux fiches.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [mots.json · istansakha, « faire copier »] Ce qui me fait douter : selon les dictionnaires classiques, اسْتَنْسَخَ peut vouloir dire « faire copier, demander une copie » mais aussi « copier » soi-même. Si le second sens est admis, le distracteur du mini-boss « il a écrit » s'en rapproche un peu. | Pistes : garder « faire copier » (conforme au plan) ; au besoin, remplacer « il a écrit » par « il a vendu ». | Confiance : moyenne.
- [atelier, ordonner · اسْتَفْهَمَ الطَّالِبُ الْمُعَلِّمَ] Ce qui me fait douter : la personne interrogée est mise en complément direct, sans عَنْ, et l'explication le dit. Cet usage me semble classique (اسْتَفْهَمَهُ : lui demander de faire comprendre), mais je ne l'ai pas vérifié dans une source du dépôt. | Confiance : moyenne à haute que c'est correct.

## Points vérifiés sans problème
- A : aucune suite coranique repérée, et les pièges ⚠ du plan sont évités (اسْتَطْعَمَ + أَهْل, اسْتَخْرَجَ + كَنْز, نَسْتَنْسِخُ مَا ; اسْتَكْثَرْتُ est employé sans لَـ et avec الثَّمَنَ). Aucune forme exclue (B5) : pas de أَحْسَنَ ni d'اسْتَكْبَرَ, pas de sujet divin. Les récits restent profanes, et اسْتِحْسَانٌ n'a pas de sens juridique.
- B et E : les lemmes des fiches L ({sotaxoraja, {sotaToEama, nasotansixu, {sotakovaro) sont contrôlés par la construction. Les fiches R (fhm, Sgr, Hsn, qbl) correspondent au plan, et toutes les racines sont pleines et non doublées.
- C : vocalisation complète et juste dans toutes les phrases : cas, لَكِنَّ suivi de l'accusatif, اسْتَحْسَنَتْ devant le sujet féminin réel سَلْمَى, verbe au singulier devant الرِّجَالُ, sujet indéfini فَقِيرٌ. L'alif de liaison est écrit sans voyelle (B2) et les schèmes sont sans tanwīn (B1). Registre classique.
- D : les traductions des dialogues, de la lecture et de l'atelier sont fidèles. Le sens des fiches est conforme au plan.
- F : chaque QCM a 3 choix, avec des distracteurs au même temps et au même pronom (sauf les deux points Importants ci-dessus). La règle de la tendance est donnée avec un contre-exemple (B7). Tous les mots des phrases sont déjà acquis, y compris le vocabulaire d'appui (طَعَامٌ, بِئْرٌ, كِيسٌ, قَمِيصٌ, ضَيْفٌ, قَدَّمَ, أَكْثَرُ, قَابَلَ, فَهَّمَ, أَخْرَجَ). Les questions de révision 3.17 et 3.18 sont justes (اقْتَرَبَ, انْصَرَفَ, انْتَظَرَ de moule افْتَعَلَ).
- F7 : les 8 translittérations sont exactes (istaḫraǧa, istaṭʿama, istafhama, istansaḫa, istakṯara, istaṣġara, istaḥsana, istaqbala).
- G : chaque fiche porte « rédigé par IA » dans source_sens.

## Ce que je n'ai pas pu vérifier
- Les nombres d'occurrences, la catégorie et la forme X dans le Corpus pour les 4 lemmes L. L'archive du Corpus est un ZIP que mes outils ne peuvent pas ouvrir ; j'ai seulement vu que les identifiants de lemme figurent dans la base générée.
- L'affichage réel de la mention « rédigé par IA » pour le statut ia_non_verifie de la leçon : je l'ai supposé conforme aux leçons précédentes.
- L'audio, qui est suspendu.

---

# Rapport de relecture : leçon 3.19 « La forme X » (second passage)

Fichier relu : /home/user/iqura/tools/build_content/lessons/etape3/19-la-forme-x.json. J'ai relu les écrans modifiés : dialogue, mots, les quatre règles, entraînement et mini-boss.
Stade : région 3, leçon 3.19 (Intermédiaire 2). Acquis supposés : régions 1 et 2, leçons 3.1 à 3.18.

## Verdict : Validé avec doutes

## Bloquant
- Aucun.

## Important
- Aucun. Les deux points du premier passage sont réglés :
  - le distracteur de اسْتَخْرَجَ est maintenant « il a écouté attentivement », qui n'a aucun lien de sens ;
  - يَخْرُجُ remplace يُخْرِجُ ; ce verbe est intransitif, il ne peut pas avoir الْمَاءَ pour complément, donc il ne reste qu'une réponse juste.

## Mineur
- [écran « Une tendance », question] Elle refait presque la question de l'écran « mots » sur le même mot : « Que veut dire اسْتَقْبَلَ ? », réponse « accueillir ». Ce n'est pas faux. On pourrait varier en demandant plutôt : « Lequel ne dit ni une demande ni un jugement ? », avec les choix اسْتَقْبَلَ / اسْتَطْعَمَ / اسْتَكْثَرَ. Les distracteurs actuels (« demander à recevoir », « trouver bon accueil ») sont des sens français, pas des formes arabes inventées : ils sont acceptables.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [atelier, ordonner · اسْتَفْهَمَ الطَّالِبُ الْمُعَلِّمَ] La personne interrogée est en complément direct, sans عَنْ. L'usage me semble classique (اسْتَفْهَمَهُ), mais je ne l'ai pas vérifié dans une source du dépôt. | Confiance : moyenne à haute que c'est correct.
- [mots.json · istansakha, « faire copier »] Ce sens est conforme au plan. Le sens « copier » soi-même existe peut-être aussi. Avec le nouveau distracteur « il a vendu », le QCM n'est plus ambigu ; seule la glose de la fiche reste à confirmer. | Confiance : moyenne.

## Points vérifiés sans problème
- **Corrections** : chacune est faite et ne crée pas d'erreur nouvelle.
  - Distracteurs « il a écouté » (écran mots) et « il l'a trouvée laide » (dialogue), plus « il a vendu » (mini-boss) : il ne reste qu'une réponse juste par question.
  - Règle « Inaccompli et nom d'action » : une seule idée. Les gloses « il extrait » et « extraction » sont justes, et la vocalisation de يَسْتَخْرِجُ et اسْتِخْرَاجٌ est correcte.
  - « Attention aux ressemblances » est réduit aux fausses formes X, et le nouvel écran « Une tendance » donne le contre-exemple demandé (B7) avec le renvoi au dictionnaire.
- **A** : rien de nouveau qui touche au Coran. Les pièges ⚠ du plan sont toujours évités.
- **C, D, F, G** : les points validés au premier passage restent valables (vocalisation, accords, traductions, prérequis, translittérations, « rédigé par IA » sur les fiches).

## Ce que je n'ai pas pu vérifier
- Les nombres d'occurrences et la forme X des lemmes dans le Corpus : l'archive est un ZIP que mes outils ne peuvent pas ouvrir. J'ai seulement vu que les identifiants de lemme figurent dans la base générée.
- Je n'ai pas vérifié que le plan a bien été corrigé (lemmes nasotansixu et {sotakovaro).
- L'audio, qui est suspendu.

---

# Rapport de relecture — Leçon 3.20 « Participes et noms d'action » (moteur-20)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/20-participes-et-noms-d-action.json
- /home/user/iqura/tools/build_content/vocab/mots.json (les 8 fiches `"lecon": "moteur-20"`)
- Comparé avec /home/user/iqura/docs/relectures/decisions-intermediaire-2.md (B1, B4, B5, §3.20)

Stade : région 3, leçon 3.20 (Intermédiaire 2). Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.19 (فَاعِل / مَفْعُول, nom d'action, formes II à X, pluriel de choses avec attribut au féminin singulier vu en 3.7).

## Verdict : À corriger

Aucun point Bloquant. Trois QCM ont une deuxième réponse défendable, et une phrase de la salle de lecture est ambiguë.

## Bloquant
- Aucun.

## Important
- [leçon · atelier, exercice 3 « Les maisons sont éparses »] Problème : le distracteur تَفَرَّقَتْ donne une phrase juste : الْبُيُوتُ تَفَرَّقَتْ (« les maisons se sont dispersées »). Le verbe au féminin singulier s'accorde bien avec un pluriel de choses. L'explication (« attribut au féminin singulier ») laisse donc croire à une faute d'accord qui n'existe pas. | Correction proposée : prendre un distracteur clairement faux, par exemple مُتَفَرِّقَانِ (duel), à côté de مُتَفَرِّقٌ. Éviter مُتَفَرِّقُونَ : le plan signale « مُتَفَرِّق + أَرْبَاب » (⚠). | Confiance : haute
- [leçon · atelier, exercice 1 « L'expéditeur de la lettre est un marchand »] Problème : le distracteur أَرْسَلَ الرِّسَالَةَ تَاجِرٌ. est grammatical. Il veut dire « Un marchand a envoyé la lettre », presque le même sens que la phrase française. Un apprenant qui le choisit n'a pas vraiment tort. | Correction proposée : mettre une phrase fausse par la forme, par exemple مُرْسَلُ الرِّسَالَةِ تَاجِرٌ… Non : مُرْسَل est exclu (B5). Proposer plutôt مُرْسِلٌ الرِّسَالَةِ تَاجِرٌ. (tanwīn devant un complément du nom), ou garder l'exercice en précisant dans la consigne « avec le participe ». | Confiance : moyenne
- [leçon · entraînement, sens de مُتَفَرِّقٌ] Problème : le distracteur « séparé de » est un sens possible de مُتَفَرِّق (séparé, dispersé). On risque deux réponses justes. | Correction proposée : remplacer « séparé de » par un sens nettement différent, par exemple « réuni » ou « apprenant ». | Confiance : moyenne
- [leçon · lecture, phrase 4] Problème : قَالَ الْمُتَعَلِّمُ: « هَلْ كَلِمَةُ اسْتِفْهَامٍ؟ ». Avec le point d'interrogation, هَلْ se lit naturellement comme la particule de question : « Est-ce un mot d'interrogation ? », phrase sans sujet. Le sens voulu (« هَلْ est un mot interrogatif ») se perd. Aucune traduction n'est donnée et aucune question ne vérifie cette phrase. | Correction proposée : en faire une affirmation où le mot cité est marqué : قَالَ الْمُعَلِّمُ: « هَلْ » كَلِمَةُ اسْتِفْهَامٍ. Il faut des guillemets ou une autre marque autour de هَلْ. Même remarque, moins grave, pour l'exemple de la fiche `istifham` (هَلْ كَلِمَةُ اسْتِفْهَامٍ.) : y mettre هَلْ entre guillemets. | Confiance : haute pour l'ambiguïté. Pour la marque typographique, c'est au conseiller de choisir.

## Mineur
- [leçon · règle « Les noms d'action »] « Chaque forme a son nom d'action » : la forme III en a deux (مُفَاعَلَة et فِعَال, tableau B1, avec فِرَاقٌ comme exemple). Proposé : « Chaque forme a un nom d'action régulier ».
- [leçon · règle « Moules voisins »] مُفْعَل (forme IV) est cité sans exemple, ce qui se comprend puisque مُرْسَل est exclu. L'écran contient aussi deux oppositions, donc deux idées. Proposé : garder seulement مُفْعِل ≠ مُفَعِّل (مُرْسِلٌ / مُعَلِّمٌ), ou donner un exemple sûr de مُفْعَل validé par le conseiller.
- [leçon · question « مُرْسِلٌ vient de quelle forme ? »] Seule la bonne réponse porte le verbe : « IV (أَرْسَلَ) ». Cela donne la réponse. Proposé : « IV », « II », « I », ou bien un verbe pour chaque choix (أَرْسَلَ / رَسَّلَ… à éviter si absent du dictionnaire ; plus simple : chiffres seuls).
- [leçon · mini-boss « L'apprenant est dans l'assemblée »] Le distracteur التَّعَلُّمَ est à l'accusatif : il est faux à la fois par le cas et par le sens. Acceptable, mais التَّعَلُّمُ ferait réfléchir sur le sens seul. Choix au conseiller.
- [leçon · mini-boss, sens de اسْتِفْهَامٌ] Le distracteur « explication donnée » est artificiel. « réponse » serait plus naturel.
- [mots.json · mursil] Thème « savoir » peu cohérent : « personnes » conviendrait, comme pour `musaid` et `mustami`.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [leçon · échauffement, sens de اسْتَقْبَلَ] Ce qui me fait douter : le distracteur « il a rencontré » est voisin de « aller au-devant de », le premier sens de la fiche (« aller au-devant de, accueillir »). | Pistes : mettre « il a envoyé » ou « il a compris ». | Confiance : moyenne.
- [leçon · lecture, phrase 3] فِي الْمَجْلِسِ، الْمُعَلِّمُ وَالْمُتَعَلِّمُ وَالْمُسْتَمِعُ. Le prédicat est placé en tête alors que les sujets sont définis. C'est permis, mais la virgule et l'ordre sont inhabituels pour un débutant. | Pistes : الْمُعَلِّمُ وَالْمُتَعَلِّمُ وَالْمُسْتَمِعُ فِي الْمَجْلِسِ. | Confiance : faible (ce n'est pas une faute).

## Points vérifiés sans problème
- A : aucun verset ni suite coranique repérée (le garde-fou est passé). Aucun nom divin, aucun sujet divin. Les exclusions de B5 sont respectées : ni مُعَلَّمٌ, ni مُرْسَل(ُونَ), ni مُسْتَمِعُونَ, ni مُسْتَمِعُهُمْ, ni مُخْتَلِف + أَلْوَان, ni مُرْسِل + النَّاقَة. Aucun « nous » de majesté. Monstres sans mots.
- B / E : les lemmes `murosil`, `musotamiE` et `m~uxotalif` sont bien présents dans iqura_content.db. Les autres fiches sont en racine seule (Elm, sEd, frq, qTE, fhm), comme le prévoit le plan. Les schèmes des 8 fiches sont justes (مُتَفَعِّل, مُفَاعِل, مُفْعِل, مُفْتَعِل, مُفَعَّل, اسْتِفْعَال). مُسْتَمِعٌ est bien rangé en forme VIII, avec le piège مُسْتَفْعِل en distracteur.
- C : vocalisation complète et juste (الِاسْتِمَاعُ avec kasra sur le lām, iḍāfa sans tanwīn, مُخْتَلِفَانِ au duel, مُتَفَرِّقَةٌ pour un pluriel de choses, conforme à la décision de 3.7). Alif de liaison sans voyelle (convention B2).
- D : les traductions des modèles sont fidèles. Les fiches correspondent au plan.
- F : tous les mots des phrases ont déjà été enseignés (تَاجِر, حَمَّال, لَحْم, مَجْلِس, قَرْيَة, طَرِيق, كَلِمَة, قَالَ, et les verbes des formes II à X de 3.12 à 3.19). Les distracteurs viennent aussi de mots connus (مُسَاعَدَةٌ, إِرْسَالٌ, اسْتَفْهَمَ, تَفَرَّقَ…). Les consignes d'ordre sont explicites (« sujet, attribut »). Les QCM ont 3 choix. Les distracteurs de conjugaison sont au même pronom. Les règles sont exactes et conformes à B3 (مُ + i = actif, مُ + a = passif).
- G : toutes les fiches portent « rédigé par IA ». L'audio est suspendu.

## Ce que je n'ai pas pu vérifier
- Les fréquences dans le Corpus (champ binaire, pas d'accès SQL).
- Le lemme exact de مُتَفَرِّق dans la base : la fiche s'en tient prudemment à la racine.
- L'affichage RTL des guillemets « » autour de l'arabe dans la salle de lecture.

---

# Rapport de relecture — Leçon 3.20 « Participes et noms d'action » (2e passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/20-participes-et-noms-d-action.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches `moteur-20`, en particulier `mursil` et `istifham`)

Stade : région 3, leçon 3.20 (Intermédiaire 2) ; notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.19 (formes II à X, accord de 3.7).

## Verdict : À corriger

Les 12 corrections demandées sont faites et justes. Mais la nouvelle phrase de l'écran « Moules voisins » contient une erreur.

## Bloquant
- Aucun.

## Important
- [leçon · règle « Moules voisins », texte] Problème : on lit « regarde le sukūn ou la shadda sur la 2e lettre de la racine ». C'est faux pour le sukūn. Dans مُرْسِلٌ, le sukūn est sur ر, la **1re** lettre de la racine ; la 2e, س, porte une kasra. La shadda de مُعَلِّمٌ est bien sur la 2e lettre (ل). Un apprenant qui suit la règle chercherait le sukūn au mauvais endroit. | Correction proposée : « Ne confonds pas مُفْعِل (مُرْسِلٌ, forme IV : sukūn sur la 1re lettre de la racine) et مُفَعِّل (مُعَلِّمٌ, forme II : shadda sur la 2e lettre de la racine). » Version plus simple : « regarde la lettre qui suit مُ : sukūn (مُرْسِلٌ) ou voyelle a suivie d'une shadda (مُعَلِّمٌ) ». | Confiance : haute

## Mineur
- Aucun.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [leçon · mini-boss « L'apprenant est dans l'assemblée »] Ce qui me fait douter : le distracteur est maintenant au nominatif, التَّعَلُّمُ. La phrase التَّعَلُّمُ فِي الْمَجْلِسِ est donc grammaticale (« l'apprentissage a lieu dans l'assemblée »). C'est la consigne française (« L'apprenant ») qui la rend fausse, par le sens. À mon avis c'est acceptable, puisque le but est de distinguer le sens. | Pistes : garder ; ou mettre الْمُعَلِّمُ à la place, faux par le sens et sans ambiguïté de forme. | Confiance : faible (ce n'est pas une erreur).

## Points vérifiés sans problème
- A : pas de suite coranique ajoutée. Les exclusions B5 restent respectées (مُتَفَرِّقُونَ évité, pas de مُرْسَل).
- C : مُرْسِلٌ الرِّسَالَةِ est bien une faute de forme (tanwīn devant un complément du nom), donc un bon distracteur. مُتَفَرِّقَانِ est faux par le nombre avec الْبُيُوتُ. La phrase 3 de lecture (الْمُعَلِّمُ وَالْمُتَعَلِّمُ وَالْمُسْتَمِعُ فِي الْمَجْلِسِ.) est correcte. La phrase 4 (قَالَ الْمُعَلِّمُ: « هَلْ » كَلِمَةُ اسْتِفْهَامٍ.) n'est plus ambiguë. L'exemple de la fiche `istifham` est mis à jour pareil.
- D / F : « réuni » (sens de مُتَفَرِّقٌ) et « il a compris » (sens de اسْتَقْبَلَ) sont des distracteurs nettement faux. Les choix « IV / II / I » ne donnent plus d'indice. « réponse » est un distracteur naturel. « un nom d'action régulier » est exact (la forme III a aussi فِعَال). L'écran « Moules voisins » ne porte plus qu'une idée. Le thème de `mursil` est « personnes ».
- G : « rédigé par IA » est conservé sur les fiches.

## Ce que je n'ai pas pu vérifier
- Les fréquences dans le Corpus (pas d'accès SQL).
- L'affichage RTL des guillemets « » autour de هَلْ.

---

# Rapport de relecture — Leçon 3.20 « Participes et noms d'action » (3e passage)

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/20-participes-et-noms-d-action.json (écran « Moules voisins », mini-boss « L'apprenant est dans l'assemblée »). Le reste de la leçon et les fiches `moteur-20` ont été validés au 2e passage.
Stade : région 3, leçon 3.20 (Intermédiaire 2). Notions supposées acquises : régions 1 et 2, leçons 3.1 à 3.19.

## Verdict : Validé

Les deux corrections demandées sont faites et justes. Plus rien n'est à corriger.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- Aucun.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- Aucun. Le doute du 2e passage sur le distracteur التَّعَلُّمُ est levé : الْمُعَلِّمُ le remplace.

## Points vérifiés sans problème
- C / F (règle « Moules voisins ») : la règle est maintenant exacte.
  - مُرْسِلٌ : ر, 1re lettre de la racine, porte bien un sukūn.
  - مُعَلِّمٌ : ل, 2e lettre de la racine, porte bien une shadda.
  - L'écran ne porte qu'une idée. La question « IV / II / I » ne donne pas la réponse.
- F (mini-boss) : le choix الْمُتَعَلِّمُ / تَعَلَّمَ / الْمُعَلِّمُ n'a qu'une seule bonne réponse. تَعَلَّمَ ne peut pas commencer la phrase avant فِي الْمَجْلِسِ sans sujet. الْمُعَلِّمُ est faux par le sens et reprend le piège du maître et de l'apprenant.
- A : aucune suite coranique ajoutée, exclusions B5 toujours respectées.

## Ce que je n'ai pas pu vérifier
- Les fréquences dans le Corpus (pas d'accès SQL).
- L'affichage RTL des guillemets « » autour de هَلْ dans la salle de lecture.

---

# Rapport de relecture : leçon 3.21 « La voix passive »

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/21-la-voix-passive.json
- /home/user/iqura/tools/build_content/vocab/mots.json (6 fiches `moteur-21` : majhul, malum, masnu, mazru, mafhum, matlub)
- Plan suivi : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md, section 3.21

Stade : région 3, leçon 3.21 (Intermédiaire 2, Rabāb, Tour du guet). Acquis supposés : régions 1 et 2, leçons 3.1 à 3.20 (formes II à X, participes, noms d'action, règle « préfixe en u pour II, III, IV »).

## Verdict : À corriger

Il y a deux points Important : deux règles sont fausses ou trompeuses. Aucun point Bloquant : rien en catégorie A, et aucune forme arabe fausse.

## Bloquant
- Aucun.

## Important
- **[21-la-voix-passive.json · écran « Aperçu : les autres formes », texte]**
  - Problème : « Les formes dérivées ont aussi un passif, qu'on reconnaît à son u ». C'est faux pour l'inaccompli des formes II et IV. L'actif يُقَدِّمُ et يُدْخِلُ commence déjà par u, et c'est justement la règle répétée de 3.12 à 3.20. À l'inaccompli, ce qui distingue le passif, c'est le **a avant la dernière lettre** (يُقَدَّمُ / يُقَدِّمُ, يُدْخَلُ / يُدْخِلُ). L'apprenant chercherait un u qui ne distingue rien.
  - Correction proposée : « Les formes dérivées ont aussi un passif. Au passé, il commence par u (قُدِّمَ, أُدْخِلَ, اسْتُخْرِجَ). À l'inaccompli, il garde u au début et met a avant la dernière lettre (يُقَدَّمُ, يُدْخَلُ, يُسْتَخْرَجُ). »
  - Confiance : haute.
- **[21-la-voix-passive.json · écran « Seulement avec un complément », texte et QCM « Peut-on mettre جَلَسَ au passif ? » → « non »]**
  - Problème : la règle est présentée comme absolue (« Le passif ne se fait qu'avec un verbe qui a un complément direct »). Elle est fausse en grammaire classique. Un verbe intransitif a un passif impersonnel, avec une préposition, un nom de temps ou de lieu, ou un nom d'action comme « sujet » (نَائِبُ الْفَاعِلِ) : مُرَّ بِهِ, جُلِسَ فِي الْمَجْلِسِ, سِيرَ يَوْمٌ (Alfiyya d'Ibn Mālik, chapitre du نائب الفاعل). Le plan du conseiller interdit seulement de *faire* le passif d'un intransitif dans les exercices ; il ne dit pas que ce passif n'existe pas. La réponse « non » ferait apprendre une règle fausse.
  - Correction proposée :
    - texte : « Dans cette leçon, on met au passif des verbes qui ont un complément direct (فَتَحَ, كَتَبَ…) : ce complément devient le sujet. Un verbe sans complément direct (جَلَسَ, ذَهَبَ) ne peut pas avoir ainsi un sujet au passif. »
    - QCM : « Peut-on dire جُلِسَ الرَّجُلُ ? » → « non : جَلَسَ n'a pas de complément direct qui puisse devenir sujet ».
    - Formulation exacte à faire valider par `conseiller-arabe`.
  - Confiance : haute (sur le fait grammatical).

## Mineur
- **[21-la-voix-passive.json · même écran]** Deux idées sur un écran : (1) passif seulement avec un complément direct, (2) on n'ajoute pas qui agit. La seconde est déjà dite sur l'écran « Le passé passif ». On peut la retirer ici, ou en faire un écran à part (« jamais مِنْ قِبَلِ »), ce qui rendrait visible le piège du plan.
- **[dialogue et lecture · cohérence du récit]** Dans le dialogue, la lettre est écrite *sur* le coffre (وَكُتِبَتْ رِسَالَةٌ عَلَى الصُّنْدُوقِ). Dans la lecture, elle est *dans* le coffre (فِي الصُّنْدُوقِ رِسَالَةٌ), puis gardée dedans. Proposition : dans le dialogue, « وَفِي الصُّنْدُوقِ رِسَالَةٌ » ou « وَتُرِكَتْ رِسَالَةٌ فِي الصُّنْدُوقِ » (تَرَكَ fait partie des verbes admis). Cela supprime aussi la suite كُتِبَتْ … عَلَى, proche du piège ⚠ « كُتِبَ + عَلَيْ… » (voir Doutes).
- **[mini-boss · QCM « nom d'action de la forme X », explication]** « اسْتِفْهَامٌ (leçon 3.20) » ne dit pas quelle est la bonne réponse. Proposition : « Forme X : اسْتِفْعَال, comme اسْتِفْهَامٌ (leçon 3.20). »
- **[écran « Aperçu : les autres formes »]** Le plan prévoit cet aperçu « dans un tableau seulement ». Il est ici en texte suivi, et la phrase contient six formes : un tableau à deux colonnes (passé / inaccompli) serait plus lisible.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- **[dialogue · وَكُتِبَتْ رِسَالَةٌ عَلَى الصُّنْدُوقِ]**
  - Ce qui me fait douter : le piège ⚠ du plan dit « كُتِبَ + عَلَيْ… (jamais) ». Ici, c'est عَلَى + un nom, séparé du verbe par رِسَالَةٌ. Ce n'est pas une suite coranique, et le garde-fou est passé.
  - Pistes : demander au conseiller si l'interdit couvre toute construction كُتِبَ … عَلَى, ou seulement عَلَيْكُمْ / عَلَيْهِمْ. La reformulation proposée en Mineur règle la question dans tous les cas.
  - Confiance : moyenne.
- **[entraînement · « Les fleurs sont semées dans le jardin »]**
  - Ce qui me fait douter : on sème des graines, et l'on plante des fleurs. زَرَعَ couvre les deux, mais en français « Les fleurs sont plantées » serait plus naturel.
  - Pistes : garder « semées » pour coller à la fiche مَزْرُوعٌ « semé, cultivé », ou mettre « plantées ».
  - Confiance : moyenne (point de style).

## Points vérifiés sans problème
- **A (respect du Coran)** :
  - aucune suite coranique repérée ;
  - aucun verbe à sujet divin ;
  - aucun des pièges ⚠ de la section 3.21 n'est repris : pas de أَبْوَاب ni السَّمَاء avec فُتِحَ, pas de حُمِلَ + الْأَرْض, pas de جُمِعَ, pas de الطَّالِبُ وَالْمَطْلُوبُ, pas de مَعْلُوم + كِتَاب / يَوْم…, pas de أُدْخِلَ + الَّذِينَ ;
  - aucune mention de مِنْ قِبَلِ ;
  - pas de monstre ni de nom sacré.
- **B et E (données du corpus)** :
  - lemmes `m~aEoluwm` et `maToluwb` : la construction vérifie leur présence dans la table `lemma` (vocab.py, l. 280 à 285) ;
  - racines jhl, SnE, zrE, fhm : vérifiées en table `root` ;
  - schème مَفْعُول : contrôlé par `check_scheme` ;
  - aucune fréquence affirmée.
- **C (forme)** :
  - vocalisation complète et correcte : فُتِحَ, كُتِبَتِ, يُصْنَعُ, تُزْرَعُ, يُفْهَمُ, قُدِّمَ / يُقَدَّمُ, أُدْخِلَ / يُدْخَلُ, اسْتُخْرِجَ / يُسْتَخْرَجُ, حُفِظَتْ, فُهِمَتِ ;
  - alif de liaison sans voyelle ;
  - accords justes : verbe en tête au singulier, féminin pour الرِّسَالَةُ, pluriel de choses تُزْرَعُ الْأَزْهَارُ ;
  - sujet au nominatif après le passif ;
  - registre classique.
- **D (sens)** :
  - traductions fidèles ; actif et passif bien distingués dans les choix ;
  - les phrases modèles du plan sont reprises telles quelles.
- **F (pédagogie)** :
  - tous les QCM ont 3 choix et une seule réponse juste ; distracteurs au même pronom ;
  - la consigne d'ordre est explicite (« verbe, sujet ») ;
  - les mots hors fiches sont déjà connus : حَارِسٌ, ضَيْفٌ, صُنْدُوقٌ, حَدِيدٌ, مَجْلِسٌ, زَهْرَةٌ, حَفِظَ, قَدَّمَ (3.12), أَدْخَلَ (3.14), اسْتَخْرَجَ (3.19), مُرْسِلٌ (3.20) ;
  - aucun verbe intransitif mis au passif ;
  - verbes de forme I tous dans la liste admise.
- **Fiches** :
  - translittération Arabica exacte : maǧhūlun, maʿlūmun, maṣnūʿun, mazrūʿun, mafhūmun, maṭlūbun ;
  - exemples justes ; النَّخْلُ (collectif) avec un adjectif au masculin, ce qui est admis.
- **G (statuts)** : statut `ia_non_verifie` et `source_sens` à « rédigé par IA » ; audio non concerné (suspendu).

## Ce que je n'ai pas pu vérifier
- Je n'ai pas interrogé directement la base SQLite (pas d'outil d'exécution) : l'existence des lemmes repose sur le contrôle de la construction, que tu dis avoir passé.
- Le rendu à l'écran : RTL, et texte de l'aperçu affiché en paragraphe ou en tableau.

---

# Rapport de relecture : leçon 3.21 « La voix passive » (2e passage)

Fichiers relus : /home/user/iqura/tools/build_content/lessons/etape3/21-la-voix-passive.json (écrans corrigés : dialogue, trois écrans de règle, entraînement, mini-boss)
Stade : région 3, leçon 3.21 (Intermédiaire 2) ; acquis supposés : régions 1 et 2, leçons 3.1 à 3.20.

## Verdict : Validé avec doutes

Les deux points Important du premier passage sont corrigés, ainsi que les points mineurs retenus. Il reste deux remarques mineures et un doute.

## Bloquant
- Aucun.

## Important
- Aucun.

## Mineur
- **[écran « Aperçu : les autres formes »]** La phrase « à l'inaccompli, il met a avant la dernière lettre » est juste pour les formes II et IV. Pour la forme X, le préfixe change aussi (يَسْتَخْرِجُ → يُسْتَخْرَجُ), et la règle ne le dit pas.
  - Proposition : « à l'inaccompli, il a u au début et a avant la dernière lettre (يُقَدَّمُ, يُدْخَلُ, يُسْتَخْرَجُ) ».
  - Confiance : haute.
- **[écran « Seulement avec un complément », titre]** Le titre reste absolu, alors que le texte dit maintenant « Ici ».
  - Proposition : « Un verbe avec complément direct ».
  - Confiance : moyenne (point de clarté seulement).

## Doutes (à soumettre au conseiller, ne pas trancher)
- **[règle et QCM sur جُلِسَ الرَّجُلُ]** La nouvelle formulation est juste : un verbe intransitif ne prend pas de sujet personnel au passif, et جُلِسَ الرَّجُلُ est fautif. Elle ne mentionne pas le passif impersonnel avec préposition (جُلِسَ فِي الْمَجْلِسِ), qui existe en arabe classique.
  - Pistes : le conseiller dit s'il suffit de le taire à ce stade, ce que je juge acceptable, ou s'il faut l'annoncer pour plus tard.
  - Confiance : moyenne.

## Points vérifiés sans problème
- **Aperçu** : au passé, les formes قُدِّمَ, أُدْخِلَ, اسْتُخْرِجَ commencent bien par u (le passé de la forme X se prononce ustuḫriǧa) ; à l'inaccompli, يُقَدَّمُ, يُدْخَلُ, يُسْتَخْرَجُ ont bien a avant la dernière lettre. La règle ne s'appuie plus sur un u qui existe aussi à l'actif.
- **Règle « complément direct »** : une seule idée par écran, et elle n'est plus fausse.
- **QCM جُلِسَ الرَّجُلُ** : une seule réponse juste, distracteurs plausibles, explication exacte.
- **Dialogue** : « لَا أَعْرِفُ. وَفِي الصُّنْدُوقِ رِسَالَةٌ. » est bien vocalisé. La traduction « Et il y a une lettre dans le coffre » est fidèle et concorde avec la lecture. La suite كُتِبَتْ … عَلَى a disparu.
- **Explication du mini-boss** : « Forme X : اسْتِفْعَال, comme اسْتِفْهَامٌ (leçon 3.20) » est claire.
- **Entraînement** : la consigne « Les fleurs sont plantées dans le jardin » correspond à la réponse تُزْرَعُ (pluriel de choses au féminin singulier).
- **Catégorie A** : aucune suite nouvelle proche d'un passage du Coran ; pas de مِنْ قِبَلِ.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas relancé la construction (garde-fou anti-versets, contrôle des mots connus) après ces modifications : il faut la refaire.
- Je n'ai pas vu le rendu à l'écran.

---

# Rapport de relecture : corrections d'Intermédiaire 2 après les décisions du conseiller (3.11 à 3.18, mots.json)

Fichiers relus (seulement les passages demandés, plus la vérification « aucun "ils" dans une question de sens » demandée par la décision 1) :
- /home/user/iqura/tools/build_content/lessons/etape3/11-la-forme-i.json
- /home/user/iqura/tools/build_content/lessons/etape3/12-la-forme-ii.json
- /home/user/iqura/tools/build_content/lessons/etape3/14-la-forme-iv.json
- /home/user/iqura/tools/build_content/lessons/etape3/16-la-forme-vi.json
- /home/user/iqura/tools/build_content/lessons/etape3/17-la-forme-vii.json
- /home/user/iqura/tools/build_content/lessons/etape3/18-la-forme-viii.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches farraqa, qaabala, tashaabaha, istansakha)
- Référence : /home/user/iqura/docs/relectures/decisions-intermediaire-2.md

Stade : région 3, leçons 3.11 à 3.21 (Intermédiaire 2). Notions supposées acquises : formes I à VIII, élatif (3.8), alif de liaison, accord du verbe placé en tête.

## Verdict : À corriger

## Bloquant
- Aucun.

## Important
- [18-la-forme-viii.json · révision, ligne 73-82, question de sens sur تَكَاتَبَ] Problème : les choix sont « ils se sont écrit / ils se sont serré la main / ils se sont disputés ». تَكَاتَبَ seul est la forme de « il », pas de « ils ». C'est l'erreur que la décision 1 corrige en 3.16, et elle demande de la vérifier dans toutes les leçons 3.11 à 3.21. | Correction proposée : passer à l'infinitif, comme en 3.16 : « s'écrire (l'un à l'autre) / se serrer la main / se disputer ». | Confiance : haute.
- [18-la-forme-viii.json · révision, ligne 541-551, question de sens sur تَقَاسَمَ] Problème : la réponse est « ils se sont partagé » et l'explication dit « تَقَاسَمَ veut dire « ils se sont partagé » ». C'est l'exemple même cité par la décision 1. Les mauvais choix mélangent aussi les styles (« il s'est divisé », « il a séparé »). | Correction proposée : « se partager / se diviser / séparer », avec l'explication « تَقَاسَمَ veut dire « se partager ». » | Confiance : haute.

## Mineur
- [11-la-forme-i.json · consigne « Comment dit-on « savoir (cité à la forme « il ») » ? »] Des guillemets dans des guillemets, eux-mêmes dans des guillemets : c'est difficile à lire. Il n'y a qu'une seule bonne réponse, puisque la parenthèse écarte عِلْمٌ (« le savoir »). | Proposition : « Comment cite-t-on le verbe « savoir » ? »
- [12 à 15 · questions de sens] Ces questions gardent « il a séparé », « il est devenu lourd », « il s'est dispersé ». C'est le cas juste avant l'écran de 3.11 qui annonce l'infinitif (ثَقُلَ « il est devenu lourd »). Ce n'est pas faux, car ce sont des formes de « il », et la décision 1 n'impose l'infinitif qu'aux fiches. Mais l'apprenant voit les deux styles se mélanger. On peut harmoniser plus tard, si l'utilisateur le souhaite.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- [17-la-forme-vii.json et 18-la-forme-viii.json · écarts avec le texte des décisions 6 et 7] Ce qui me fait douter :
  - Décision 6 : le texte en place n'a pas la précision « (une virgule où l'on s'arrête) » prévue par la décision.
  - Décision 7 : le texte en place n'a pas le lien avec la racine de نَظَرَ « regarder ».
  
  Les deux textes restent justes ; vous m'avez dit que ces versions sont les nouvelles décisions. | Pistes : il suffit de vérifier que le conseiller a bien accepté ces versions courtes, et de le noter dans decisions-intermediaire-2.md. | Confiance : haute que le contenu est juste.

## Points vérifiés sans problème
- A. Aucune suite coranique dans les passages relus, et aucun sujet divin. تَشَابَهَتِ الْكَلِمَتَانِ ne fait que deux mots. La construction est passée (garde-fou anti-versets, selon vous).
- C. Toutes les formes sont correctement vocalisées : عَلِمَ / يَعْلَمُ / عِلْمٌ, تَشَابَهَتِ (avec un kasra de liaison devant الْ), الْجَمَلُ أَكْبَرُ مِنَ الْحِمَارِ, وَانْطَلَقَ (wa-nṭalaqa), انْتَظَرَ صَدِيقَهُ, فَرَّقَ الْحَمَّالُ الْأَحْمَالَ, اسْتَنْسَخَ / يَسْتَنْسِخُ / اسْتِنْسَاخٌ. L'accord est juste : verbe en tête au singulier et au féminin devant un duel féminin.
- C/F. La règle de l'alif de liaison est exacte : on le lit i au début ou après une pause, et il tombe dans la liaison. Le contre-exemple de la forme VIII est exact, car انْتَظَرَ est transitif et sa racine est ن ظ ر.
- D. Les sens sont fidèles aux décisions :
  - en 3.16, تَقَاسَمَ, تَعَارَفَ, تَنَازَعَ, تَكَاتَبَ, تَشَابَهَ, تَصَافَحَ sont tous à l'infinitif, sans « ils » ;
  - « Les deux mots se ressemblaient » se trouve dans la consigne et dans la fiche, et l'ancienne traduction a disparu partout ;
  - farraqa : « séparer, disperser, répartir », avec l'exemple et la question du récit de 3.12 en accord (« il a réparti les charges ») ;
  - qaabala : « faire face à, rencontrer » ; istansakha : « faire copier, copier (un écrit) », exemple inchangé ;
  - en 3.15, فَرَّقَ « disperser » reste cohérent avec la fiche.
- F. Les QCM concernés n'ont qu'une seule bonne réponse. C'est vrai en particulier pour أَكْبَرُ, que la phrase rend sans ambiguïté, et pour les choix de 3.16.
- G. Les fiches modifiées portent toutes « rédigé par IA ».

## Ce que je n'ai pas pu vérifier
- Je n'ai pas relancé la construction ni le garde-fou ; je me fie à ce que vous m'avez dit.
- Je n'ai pas relu les autres passages des leçons. La recherche de questions de sens dont la réponse commence par « ils » ne visait que la réponse placée en premier (indice 0) ; elle couvre les leçons 3.11 à 3.21.

---

# Rapport de relecture : Intermédiaire 2, deuxième passage (corrections de 3.11, 3.17 et 3.18)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape3/11-la-forme-i.json (consigne, lignes 158-165)
- /home/user/iqura/tools/build_content/lessons/etape3/17-la-forme-vii.json (règle, ligne 163)
- /home/user/iqura/tools/build_content/lessons/etape3/18-la-forme-viii.json (échauffement, lignes 73-82 ; écran « Une tendance », ligne 160 ; révision, lignes 541-551)

Stade : région 3, leçons 3.11 à 3.21 (Intermédiaire 2). Notions supposées acquises : formes I à VIII, élatif, alif de liaison, accord du verbe placé en tête.

## Verdict : Validé

## Bloquant
- Aucun.

## Important
- Aucun. Les deux points Importants du premier passage sont corrigés :
  - تَكَاتَبَ : « s'écrire (l'un à l'autre) / se serrer la main / se disputer » ;
  - تَقَاسَمَ : « se partager / se diviser / séparer », avec l'explication « تَقَاسَمَ veut dire « se partager » ».

  Dans les deux questions, il n'y a qu'une seule bonne réponse.

## Mineur
- Aucun nouveau point. Le mélange « il a… » / infinitif dans les questions de 3.12 à 3.15 reste tel quel. C'est conforme à la décision 1 : on harmonisera plus tard, avec l'accord de l'utilisateur. Ce n'est pas une erreur.

## Doutes (à soumettre à l'utilisateur, ne pas trancher)
- Aucun. L'écart signalé au premier passage sur les décisions 6 et 7 est levé :
  - la règle de 3.17 contient la précision « (une virgule où l'on s'arrête) » ;
  - l'écran de 3.18 cite la racine de نَظَرَ, et son contre-exemple grammatical est juste (انْتَظَرَ صَدِيقَهُ, complément direct, rien ne revient sur le sujet).

## Points vérifiés sans problème
- A. Aucune suite coranique et aucun sujet divin dans les passages relus.
- C. La vocalisation est correcte : انْتَظَرَ صَدِيقَهُ, وَانْطَلَقَ, عَلِمَ / يَعْلَمُ / عِلْمٌ. La translittération wa-nṭalaqa correspond bien au mot.
- D/F. Les règles sont exactes :
  - l'alif se lit i au début ou après une pause, et il tombe dans la liaison ;
  - la forme VIII ne fait qu'une tendance, avec انْتَظَرَ comme contre-exemple.

  La nouvelle consigne de 3.11, « Comment cite-t-on le verbe « savoir » ? », est claire et n'a qu'une seule bonne réponse : عَلِمَ. يَعْلَمُ est l'inaccompli et عِلْمٌ est le nom.
- B/E. La recherche des questions de sens dont la réponse placée en premier commence par « ils » n'a rien trouvé d'autre que ces deux questions déjà corrigées, dans les leçons 3.11 à 3.21.

## Ce que je n'ai pas pu vérifier
- Je n'ai pas relancé la construction ni le garde-fou anti-versets après ces corrections. Il faut les relancer avant la fusion.
