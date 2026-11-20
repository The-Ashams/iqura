# Relectures du niveau Classique avancé 2 (leçons 5.8 à 5.13)

Rapports de l'agent relecteur-arabe, recopiés tels quels. Plan du conseiller : decisions-classique-avance-2.md.

Le 1er passage de 5.8 et 5.9 (5.8 bloqué : question sur وَإِذْ au combat ; 5.9 à corriger) a été corrigé le 17/11/2026 ; son texte n'a pas été conservé (redémarrage de la session).

# Rapport de relecture : leçons 5.8 « La narration classique » et 5.9 « Les formes verbales en contexte » (2e passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape5/08-la-narration-classique.json
- /home/user/iqura/tools/build_content/lessons/etape5/09-les-formes-verbales-en-contexte.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches idh, baynama, haka, rawi, aqbala, adraka, istataa, aqama, tafakkara, l. 11218-11406)
- Pour référence : /home/user/iqura/docs/relectures/decisions-classique-avance-2.md (0.a, B, C 5.8 et 5.9), B1 à B8 de decisions-classique-avance-1.md, /home/user/iqura/tools/build_content/quran_guard.py

Stade : région 5, leçons 5.8 et 5.9 (Classique avancé 2). Notions supposées acquises : régions 1 à 4 et leçons 5.1 à 5.7 ; لَمَّا et حِينَ (4.4), ثُمَّ et فَـ (4.13), discours rapporté (4.3), formes II à X (3.12 à 3.21), verbes faibles (3.22 à 3.26), subjonctif (3.29).

## Verdict
- **5.8 : Bloqué.** Il reste un seul point, dans l'exemple de la fiche رَاوٍ (catégorie A, confiance moyenne). La correction est simple. Toutes les autres corrections du 1er passage sont bonnes.
- **5.9 : Validé avec doutes.**

## Bloquant
- [mots.json · fiche `rawi`, exemple, l. 11283] **Problème** : l'exemple est « قَالَ الرَّاوِي: كَانَ فِي الْمَدِينَةِ تَاجِرٌ. ». La suite « كَانَ فِي الْمَدِينَةِ » reprend les trois premiers mots d'un verset (an-Naml 27:48, qui commence par « وَكَانَ فِي الْمَدِينَةِ … »), avec le même cadre de récit (« il y avait dans la ville… »). Seul le وَ manque.
  - Le garde-fou ne la voit pas : il compare des mots entiers après normalisation, et « وكان » n'est pas « كان ».
  - Cette tournure n'apparaît nulle part ailleurs dans le dépôt.
  - **Correction proposée** : « قَالَ الرَّاوِي: كَانَ فِي السُّوقِ تَاجِرٌ. » (« Le narrateur dit : il y avait au marché un marchand. »). C'est déjà la tournure du mini-boss, et elle est hors Coran.
  - **Confiance** : haute pour le verset, moyenne pour la qualification « extrait ». À soumettre au conseiller s'il faut trancher ; la correction ne coûte rien.

## Important
- Aucun.

## Mineur
- [5.8 · échauffement 2] « … انْتَهَى الدَّرْسُ خَرَجَ بَاسِمٌ » avec les choix لَمَّا / لَمْ / إِنْ. La phrase « إِنِ انْتَهَى الدَّرْسُ خَرَجَ بَاسِمٌ » est grammaticale (condition avec deux passés). Seule la consigne française permet de trancher, et « إِنْ » ne porterait pas la kasra de liaison devant انْتَهَى.
  - Proposé : remplacer إِنْ par لَنْ ou إِذَنْ.
- [5.8 · échauffement 3] Le distracteur كَتَبَ rend « كَتَبَ التَّاجِرُ: « أَيْنَ الْمِفْتَاحُ؟ » » possible (« le marchand écrivit… »). Seule la consigne (« a dit ») tranche, c'est le même défaut que سَأَلَ, en plus faible.
  - Proposé : نَامَ ou رَجَعَ.
- [5.8 · mini-boss « Réponse de لَمَّا, sans فَـ » et 5.9 · mini-boss, révision identique] La consigne élimine elle-même le distracteur فَـ : la question ne teste plus que le passé contre l'inaccompli.
  - Proposé : « Réponse de لَمَّا : « Bāsim sortit » ». La règle reste dans l'explication.
- [5.8 · lecture « Le chameau étonnant »] Le récit fait environ 52 mots ; le plan (C 5.8) prévoyait 60 à 80 mots. On peut ajouter une phrase, par exemple après فَضَحِكَ سَمِيرٌ, en respectant les listes ⚠.
- [mots.json · fiche `baynama`, remarque] « suivi d'une phrase nominale » ne s'accorde pas avec la règle de la leçon (« le plus souvent »).
  - Proposé : « suivi le plus souvent d'une phrase nominale ; … ».
- [5.9 · règle « Trouver la forme »] La liste des lettres ajoutées oublie le ت glissé de la forme VIII, prévu dans le plan (C 5.9, règle 1).
  - Proposé : « (أَ, تَـ, انْـ, le ت glissé, اسْتَـ, ā, shadda) ».

## Doutes (à soumettre au conseiller, ne pas trancher)
- [5.8 et 5.9 · mini-boss, portée de B6] **Ce qui me fait douter** : le point B6 interdit au combat « une phrase de récit ».
  - Le mini-boss de 5.8 garde un fragment de récit : « كَانَ فِي السُّوقِ … » (تَاجِرٌ), c'est-à-dire « il y avait au marché un marchand », une ouverture de conte.
  - Celui de 5.9 garde des phrases complètes au passé : « تَفَكَّرَ بَاسِمٌ فِي الْجَوَابِ، ثُمَّ كَتَبَهُ. », « … زُهَيْرٌ فِي دِمَشْقَ شَهْرًا », « Dans أَقْبَلَتِ الْقَافِلَةُ… ».
  - Aucune ne contient بَيْنَمَا, إِذْ, لَمَّا ni وَإِذْ, et aucune n'est coranique.
  - **Pistes** :
    1. Lire B6 comme « pas de phrase construite avec les outils du récit de 5.8 (بَيْنَمَا… إِذْ, فَلَمَّا, قَالَ…) ». Dans ce cas, tout est conforme.
    2. Le lire largement. Il faut alors réduire ces questions à des mots seuls.
  - **Confiance** : moyenne (les phrases simples sont admises dans les mini-boss des niveaux précédents).
- [5.8 · dialogue « وَمَاذَا بَعْدَ ذَٰلِكَ؟ »] **Ce qui me fait douter** : la tournure rappelle de loin « فَمَاذَا بَعْدَ الْحَقِّ » (Yūnus 10:32). Elle n'a qu'un mot en commun avec le verset, plus un mot proche (وَمَاذَا contre فَمَاذَا), donc ce n'est pas un extrait.
  - **Pistes** : garder ; ou, par prudence, « وَمَاذَا حَدَثَ بَعْدَ ذَٰلِكَ؟ » si حَدَثَ est connu.
  - **Confiance** : je penche pour « conforme » (haute).

## Points vérifiés sans problème
- **A (respect du Coran)** :
  - plus de question sur وَإِذْ au mini-boss ; وَإِذْ n'apparaît que seul, sur l'écran de règle « formule », sans exercice ni carte, avec le renvoi aux grammairiens et aux ouvrages ;
  - إِذْ est toujours au milieu de la phrase, suivi seulement de وَصَلَ / وَصَلَتْ avec un sujet nommé ;
  - فَلَمَّا n'est suivi que de وَصَلَ, وَصَلَتْ ou جَلَسَ ; ثُمَّ, de رَجَعَ, قَالَ ou عَلَّمَ avec un sujet nommé dans la phrase ;
  - قَالَ est toujours suivi d'un nom (الرَّاوِي, بَاسِمٌ, زُهَيْرٌ) ; il n'y a plus de فَقَالَ لِلتَّاجِرِ sans nom ;
  - aucune scène de la liste B3 (le جَمَل est un chameau, pas une chamelle) ;
  - أَقْبَلَ, أَدْرَكَ, اسْتَطَاعَ, أَقَامَ et تَفَكَّرَ respectent leurs listes ⚠ (أَدْرَكَ دِمَشْقَ n'apparaît que comme distracteur, sans risque) ;
  - aucun nom divin ni de prophète ; les récits sont signalés « construits, rédigés par IA ».
- **B et D (sens)** : sens linguistiques seulement. Les traductions sont fidèles, en particulier « tandis que…, voilà que… », « puis, lorsque… », « allèrent à sa rencontre » et « s'est appliqué à ».
- **C (forme)** :
  - vocalisation complète et cas justes : تَاجِرًا après أَنَّ ; اسْمُهُ سَمِيرٌ en qualificatif ; جَمَلٌ, nom de كَانَ avec لَهُ placé avant ; لِسَمِيرٍ ; دِمَشْقَ (diptote) ; وَصَلَتِ الْقَافِلَةُ, أَقْبَلَتِ الْقَافِلَةُ (kasra de liaison) ;
  - les deux compléments de عَلَّمَ : أَخَاهُ الْكِتَابَةَ, et عَلَّمَهَا أَخَاهُ avec le pronom attaché d'abord ;
  - رَاوٍ / رَاوِيًا sont justes dans la remarque de la fiche ;
  - la règle des répliques (قَالَ / قَالَتْ / قُلْتُ, puis فَقَالَ ou de nouveau قَالَ, et la phrase sur les guillemets) est juste ;
  - le distracteur لَنْ de l'échauffement 1 est sans ambiguïté.
- **E (données)** :
  - formes verbales justes : IV pour أَقْبَلَ, أَدْرَكَ, أَقَامَ ; V pour تَفَكَّرَ ; X pour اسْتَطَاعَ ;
  - racines justes : ق ب ل, د ر ك, ط و ع, ق و م, ف ك ر ;
  - les remarques de racine portent l'avertissement ; celle de أَقْبَلَ est corrigée (« celle de قَبْلَ et de اسْتَقْبَلَ ») ;
  - aucune fréquence n'est affichée.
- **F (pédagogie)** :
  - tous les mots des textes sont connus (جَمَل, سُوق, نَخْلَة, حَدِيقَة, عَجِيب, أَخْبَرَ, ضَحِكَ, جَالِس, مُخْتَلِف, أَصَبْتَ…), et Samīr est un personnage déjà présent ;
  - les QCM ont 3 choix et une seule bonne réponse (hors les mineurs ci-dessus) ;
  - le nom « Montagnes » est conforme à region3.json (« Les Montagnes du Moteur ») ;
  - le distracteur « séjourner » est en place ; le modèle de l'atelier ecrire de 5.9 est juste ;
  - la translittération al-rāwī, baynamā, iḏ, ḥakā, istaṭāʿa suit la norme et l'usage du dépôt (al-yawma).
- **G (statuts et sources)** : « rédigé par IA » est présent sur les fiches, et « récit / texte construit, rédigé par IA » sur les lectures.

## Ce que je n'ai pas pu vérifier
- Les lemmes du Corpus (<i*, >aqobala, >adoraka, {sotaTaAEa, >aqaAma, et surtout yatafak~aru, marqué « à confirmer » dans le plan). La source du Corpus n'est pas présente dans tools/build_content/sources/ (seul sources.json s'y trouve), et la base iqura_content.db n'est pas lisible par recherche de texte. À confirmer par `vocab.validate` ou en SQL.
- Le passage réel du garde-fou sur ces fichiers (je ne l'ai pas exécuté).
- L'audio est suspendu : rien à vérifier.
---

# Rapport de relecture — Leçons 5.10, 5.11 et 5.12 (Classique avancé 2, 1er passage)

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape5/10-le-vocabulaire-par-themes-1.json
- /home/user/iqura/tools/build_content/lessons/etape5/11-le-vocabulaire-par-themes-2.json
- /home/user/iqura/tools/build_content/lessons/etape5/12-un-mot-plusieurs-sens.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches samaa, qamar, bahr, rih, matar, fajr, aata, sabr, sidq, kadhib, amin, hadith, ayn, lisan ; et, pour comparer, les fiches existantes de رَأْسٌ, أَخَذَ, لَوْلَا)
- Plan : /home/user/iqura/docs/relectures/decisions-classique-avance-2.md (B, C 5.10 à 5.12)
- Pour vérifier : `DIVINE_NAMES` dans /home/user/iqura/tools/build_content/vocab.py, et la ligne 459 du cahier (le mini-boss est un combat).

Stade : région 5, leçons 5.10 à 5.12 ; notions supposées acquises : régions 1 à 4, leçons 5.1 à 5.9.

## Verdicts
- **5.10 : Validé avec doutes**
- **5.11 : Bloqué** (un point A3 au mini-boss ; deux points Important)
- **5.12 : À corriger** (deux points Important)

## Bloquant
- [5.11 · mini_boss, question « آمِين (avec ā) et أَمِينٌ… »] Problème : آمِين est le mot d'une formule religieuse. Il apparaît ici dans une question de combat. Le mini-boss est un combat (cahier l. 459), et la règle A3 interdit toute formule sacrée dans une question de combat. Le plan ne prévoyait آمِين que dans la remarque de la fiche. Le mot est aussi mal vocalisé : آمِين au lieu de آمِينَ. | Correction proposée : retirer cette question du mini-boss. On peut la mettre sur l'écran de règle « Dire une qualité », sans exercice, ou s'en tenir à la remarque de la fiche. La remplacer par une autre question sur les mots de la leçon (par exemple كَذِبٌ). | Confiance : moyenne-haute.

## Important
- [5.11 · dialogue « أَعْطَانِي نَدِيمٌ قَلَمًا جَدِيدًا! », modèle de l'atelier « أَعْطَانِي صَدِيقِي كِتَابًا. », formes de la fiche aata (« أَعْطَانِي »)] Problème : la liste ⚠ du plan pour أَعْطَى dit « sans pronom collé ». Le texte est grammaticalement juste, mais il s'écarte de la liste ⚠ sans l'avoir fait valider. | Correction proposée : « أَعْطَى نَدِيمٌ بَاسِمًا قَلَمًا جَدِيدًا. » (ou « Nadīm a donné un calame neuf à Bāsim » dans la réplique de Hāla), « أَعْطَى صَدِيقِي زُهَيْرًا كِتَابًا. », et retirer « أَعْطَانِي » des formes de la fiche. Sinon, soumettre l'écart à `conseiller-arabe`. | Confiance : haute sur l'écart au plan.
- [5.11 · entraînement et mini_boss, question « حَدِيثٌ », distracteur « nouvelle »] Problème : il peut y avoir deux réponses justes. Dans les dictionnaires classiques, حَدِيث veut aussi dire « nouvelle, information » (sens voisin de خَبَر). « nouvelle » fait aussi penser à l'adjectif حَدِيثٌ « nouveau », que le plan range parmi les pièges. | Correction proposée : remplacer « nouvelle » par un distracteur sans ambiguïté, par exemple « mensonge » ou « lettre » (au mini-boss, « lettre » est déjà proposé, donc prendre « mensonge » ou « patience, endurance »). | Confiance : moyenne-haute.
- [5.12 · règle « لَوْلَا : nom ou verbe ? »] Problème : le texte dit « لَوْلَا + verbe au passé… un reproche ou une invitation ». Chez les grammairiens (par exemple Ibn Hišām, *Muġnī*, à l'entrée لولا), لَوْلَا suivi du **passé** exprime le reproche ou le regret (توبيخ / تنديم). L'incitation ou l'invitation (تحضيض / عرض) vient avec l'**inaccompli**. Tous les exemples de la leçon sont au passé : « invitation » est donc inexact. | Correction proposée : « لَوْلَا + verbe au passé, à la 2e personne, veut dire « pourquoi n'as-tu pas… ? » : un reproche. » | Confiance : moyenne-haute. Si besoin, faire confirmer par `conseiller-arabe` quand la source sera lue.
- [5.12 · lecture phrase 3 « أَخَذَ بَاسِمٌ الْقَلَمَ، ثُمَّ أَخَذَ يَكْتُبُ الرِّسَالَةَ. » et atelier « أَخَذَ الْقَلَمَ، ثُمَّ … يَكْتُبُ. »] Problème : deux listes ⚠ du plan ne sont pas respectées. Pour ثُمَّ, il faut « seulement suivi d'un verbe de la Cité et d'un sujet nommé ». Pour أَخَذَ au sens de « se mettre à », il faut un « sujet humain nommé ». Ici, après ثُمَّ, le sujet n'est pas nommé, et dans l'atelier il n'y a aucun sujet nommé. | Correction proposée : en lecture, « أَخَذَ بَاسِمٌ الْقَلَمَ، ثُمَّ أَخَذَ بَاسِمٌ يَكْتُبُ الرِّسَالَةَ. » (répétition acceptable dans un exemple) ; dans l'atelier, « أَخَذَ بَاسِمٌ الْقَلَمَ، ثُمَّ … بَاسِمٌ يَكْتُبُ. » Sinon, faire valider l'écart par `conseiller-arabe`. Le garde-fou de 3 mots reste le vrai contrôle. | Confiance : haute sur l'écart au plan, moyenne sur le risque réel.

## Mineur
- [5.10 · entraînement, consigne « Il pleut, Bāsim reste à la maison à cause de la pluie. »] Le français est au présent, alors que l'arabe dit بَقِيَ (passé). | Correction : « Bāsim est resté à la maison à cause de la pluie. »
- [5.10 · règle « Ce que tu connais déjà »] Le plan prévoyait de revoir aussi ثَمَرَة, بَرْد, أُسْبُوع, عَصْر. Ils sont absents ; on peut les ajouter si l'écran le permet.
- [5.12 · règle « Le contexte choisit », « deux mots écrits pareil (إِنْ et إِنَّ) »] Une fois vocalisés, ces deux mots ne s'écrivent plus pareil. | Correction : « deux mots qui s'écrivent pareil sans voyelles (إِنْ et إِنَّ) ».
- [5.12 · mini_boss « لَوْلَا …! » → « لَوْلَا سَأَلْتَ! »] La liste ⚠ demande « un complément concret ou un nom propre ». | Correction : « لَوْلَا سَأَلْتَ زُهَيْرًا! », avec la consigne « Pourquoi n'as-tu pas interrogé Zuhayr ! ».
- [mots.json · fiches رَأْسٌ et لَوْلَا] Après 5.12, la fiche (et le dictionnaire) ne donnent toujours que « tête ; sommet » et « sans, s'il n'y avait pas » ; la remarque de لَوْلَا dit encore « suivi d'un nom en -u ». En touchant لَوْلَا dans « لَوْلَا انْتَظَرْتَ بَاسِمًا! », on lit donc un sens faux pour la phrase. | Correction : ajouter les sens vus en 5.12 aux fiches (« chef (d'un groupe) » ; « + passé à la 2e personne : pourquoi n'as-tu pas… ? »), sans nouvelle carte, si le schéma le permet. Même remarque, moins gênante, pour أَخَذَ « se mettre à ».
- [mots.json · kadhib, "theme": "qualites" ; règle de 5.11 « Une qualité se dit avec un nom (… et son contraire كَذِبٌ) »] Le mensonge n'est pas une qualité. | Correction : « une qualité ou un défaut ».

## Doutes (à soumettre au conseiller, ne pas trancher)
- [5.10 · mini_boss « À quel thème appartient قَمَرٌ ? » : « la nature (le ciel) » / « le temps »] Ce qui me fait douter : la lune sert à compter les mois, et un apprenant peut défendre « le temps ». | Pistes : remplacer le distracteur « le temps » par « la maison » ou « les qualités ». | Confiance : moyenne.
- [5.12 · modèle de l'atelier « شَرِبْنَا مِنْ عَيْنِ مَاءٍ. »] Ce qui me fait douter : « boire à une source » rappelle des images coraniques (عَيْنًا يَشْرَبُ بِهَا…, تُسْقَى مِنْ عَيْنٍ…), que la liste ⚠ de عَيْن cherche à éviter (« يَشْرَبُ بِهَا »). Aucune suite de 3 mots ne me semble reprise. | Pistes : « وَجَدَتِ الْقَافِلَةُ عَيْنَ مَاءٍ قَرِيبَةً. » (modèle du plan). | Confiance : moyenne-basse.
- [5.12 · dialogue « عَيْنٌ وَعَيْنٌ: كَلِمَةٌ وَاحِدَةٌ، وَمَعْنَيَانِ! »] Ce qui me fait douter : la liste ⚠ dit « عَيْن : jamais avec un nombre, ni au duel ». Or la phrase contient وَاحِدَةٌ et un duel (مَعْنَيَانِ), même s'ils ne portent pas sur عَيْن, et « عَيْنٌ وَعَيْنٌ » se lit presque comme un duel. La grammaire est juste (مَعْنَيَانِ est le duel correct de مَعْنًى). | Pistes : garder, ou « لِعَيْنٍ مَعْنَيَانِ » / « كَلِمَةُ عَيْنٍ لَهَا مَعْنَيَانِ ». | Confiance : moyenne-basse.
- [Écart au plan : كَرِيمٌ remplacé par كَذِبٌ] Le retrait se justifie : كريم fait partie de `DIVINE_NAMES` (vocab.py l. 224). كَذِبٌ figurait dans la réserve du plan ; on ne trouve nulle part كَذِبًا, mais seulement الْكَذِبَ (défini), ce qui respecte la liste ⚠. En revanche, le thème « décrire quelqu'un » perd une qualité positive au profit d'un défaut. À faire valider par `conseiller-arabe` comme écart, sans autre réserve linguistique de ma part.

## Points vérifiés sans problème
- A : aucun verset ni scène du Coran (B3) repéré. Les paires interdites de B4 (سَمَاء/مَطَر, سَمَاء/أَرْض, شَمْس/قَمَر, أَخَذَ/رَأْس, لِسَان/صِدْق ou عَرَبِيّ, رِيح/سَفِينَة) ne figurent jamais dans une même phrase. Aucune forme interdite par les listes ⚠ de 5.10 (pas de سَمَاوَات, رِيَاح, مَطَرًا, وَالْفَجْرِ, بِحَار). Les règles « sens général / renvoi aux commentateurs » sont bien formulées. Aucun sens religieux n'est affirmé ; les remarques de سَمَاءٌ et de حَدِيثٌ sont neutres.
- C : vocalisation complète et correcte des phrases et des choix. Accords justes : féminin de رِيح, سَمَاء, عَيْن ; masculin de بَحْر, لِسَان. Double accusatif de أَعْطَى juste. Annexions justes (صَبْرُ بَاسِمٍ, رَأْسُ التُّجَّارِ, حَدِيثُ زُهَيْرٍ), ainsi que le sujet de كَانَ (حَدِيثُ … طَوِيلًا). لَوْلَا + nom au nominatif avec لَ dans la réponse ; أَخَذَ + inaccompli sans أَنْ (verbe de commencement) ; إِذَنْ نَبْقَى (subjonctif virtuel) ; مَعْنَيَانِ. Graphie : hamza, ة, ى correctes.
- D : les traductions sont fidèles. Les nouveaux sens (عَيْن « source », لِسَان « langue parlée », رَأْس « chef », أَخَذَ « se mettre à ») sont des sens classiques sûrs, marqués « rédigé par IA ».
- E : les lemmes des fiches correspondent au plan (samaA^', qamar, baHor, riyH, m~aTar, fajor, >aEoTaY`, Sabor, Sidoq, ka*ib, >amiyn, Hadiyv, Eayon, lisaAn). Le genre des noms est juste.
- F : QCM à 3 choix, une seule réponse juste (sauf « nouvelle », voir plus haut). Les mots employés dans les phrases (سَبَب, قَافِلَة, تَاجِر, مَرِيض, طِفْل, شَرِبَ, عَجِيب, انْتَظَرَ, سَافَرَ, مَكَان…) sont présents dans mots.json. La translittération suit la convention du dépôt (hamza initiale omise : aʿṭā, amīnun ; ṯ, ḏ, ǧ, ḥ, ṣ, ṭ justes).
- G : statut ia_non_verifie, « rédigé par IA » sur chaque fiche et sur les récits et exemples construits (« Récit construit », « Portrait construit », « Exemples construits »).

## Ce que je n'ai pas pu vérifier
- Les nombres d'occurrences et l'existence des lemmes m~aTar, ka*ib et yatafak~aru dans la base du Corpus. Je n'ai pas d'accès SQL, et la base n'est pas lisible en texte. Le contrôle `vocab.validate` du pipeline fait foi.
- Le garde-fou des 3 mots (`quran_guard.py`) et la règle des 95 % de mots connus : je ne les ai pas exécutés. Il faut lancer `python3 tools/build_content/build_content.py`.
- Les sources de dictionnaire de 5.12 (Lisān al-ʿArab, al-Qāmūs, Ibn ʿAqīl, Muġnī), non encore lues. La mention « rédigé par IA » est donc la bonne.
- L'audio, suspendu.