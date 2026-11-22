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
---

# Rapport de relecture : leçons 5.8 à 5.12 (Classique avancé 2), passage ciblé sur les corrections

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape5/08-la-narration-classique.json
- /home/user/iqura/tools/build_content/lessons/etape5/09-les-formes-verbales-en-contexte.json
- /home/user/iqura/tools/build_content/lessons/etape5/10-le-vocabulaire-par-themes-1.json
- /home/user/iqura/tools/build_content/lessons/etape5/11-le-vocabulaire-par-themes-2.json
- /home/user/iqura/tools/build_content/lessons/etape5/12-un-mot-plusieurs-sens.json
- /home/user/iqura/tools/build_content/vocab/mots.json : fiches de 5.8 à 5.12 (baynama, haka, rawi, aata, sabr, sidq, kadhib, amin, hadith, ayn, lisan), et akhadha (l. 6549), ras (l. 6612), lawla (l. 7619)
- Pour vérifier, les listes ⚠ du plan : /home/user/iqura/docs/relectures/decisions-classique-avance-2.md (C 5.8 à 5.12)

Stade : région 5, leçons 5.8 à 5.12. Notions supposées acquises : régions 1 à 4 et leçons 5.1 à 5.7, puis chaque leçon relue.

## Verdict, par leçon
- **5.8 : Validé avec doutes.** Il ne reste que le doute B6, déjà soumis au conseiller.
- **5.9 : Validé avec doutes.** Même doute B6.
- **5.10 : Validé.**
- **5.11 : À corriger.** Il reste un point Important, que j'avais manqué au 1er passage. La correction tient en un mot.
- **5.12 : Validé avec doutes.** Deux mineurs et un doute sur les fiches.

## Bloquant
- Aucun.

## Important
- [5.11 · lecture « Portrait de Nadīm », phrase 2 : « أَعْطَى بَاسِمًا قَلَمًا جَدِيدًا. »] **Problème** : la liste ⚠ de أَعْطَى demande un « sujet humain nommé ». Ici le sujet n'est pas exprimé (Nadīm est sous-entendu depuis la phrase 1). C'est le même genre d'écart que celui de « ثُمَّ أَخَذَ يَكْتُبُ », corrigé en 5.12. La grammaire est juste, et je ne vois aucune suite de 3 mots du Coran.
  - Je l'avais manqué au 1er passage. Je le signale maintenant par souci de cohérence avec le reste du niveau.
  - **Correction proposée** : « أَعْطَى نَدِيمٌ بَاسِمًا قَلَمًا جَدِيدًا. » (la phrase existe déjà dans le dialogue). Autre solution : faire valider l'écart par `conseiller-arabe`.
  - **Confiance** : haute sur l'écart au plan, faible sur le risque réel.

## Mineur
- [5.11 · « apercu »] « أَصْدِقَائِهِ » ne se trouve plus nulle part dans la leçon : c'est un reste d'une version précédente. Comme `lessons.py` (l. 158) ajoute les formes de l'aperçu aux mots « connus », cette forme compte comme connue sans avoir été montrée. **Correction** : la retirer de « apercu ».
- [5.12 · mini-boss « لَوْلَا … زُهَيْرًا! », distracteur تَسْأَلُ] « لَوْلَا تَسْأَلُ زُهَيْرًا! » est aussi de l'arabe juste : avec l'inaccompli, لَوْلَا pousse à agir (« pourquoi ne demandes-tu pas à Zuhayr ? »). Seule la consigne au passé départage, comme pour les mineurs du 1er passage. **Correction** : remplacer تَسْأَلُ par un distracteur qui ne fait pas une phrase, par exemple « سُؤَالٌ » (un nom indéfini, sans réponse en لَـ). Ou garder tel quel, puisque la consigne départage.
- [5.12 · atelier, consigne « Il a pris le calame, puis s'est mis à écrire. »] L'arabe dit maintenant بَاسِمٌ deux fois, mais le français dit « Il ». **Correction** : « Bāsim a pris le calame, puis s'est mis à écrire. »
- [5.12 · échauffement 2, رَأْسٌ] Le choix juste et l'explication disent « tête ; sommet », alors que la fiche dit maintenant « tête ; sommet ; chef (d'un groupe) ». C'est défendable (on y révise ce qui est connu avant d'apprendre le nouveau sens). On peut écrire dans l'explication : « (connu) ; un nouveau sens arrive ».

## Doutes (à soumettre au conseiller, ne pas trancher)
- [mots.json · fiches `lawla` (leçon cite-02), `akhadha` et `ras` (leçon moteur-22)] **Ce qui me fait douter** : les nouveaux sens vus en 5.12 sont maintenant écrits dans les fiches elles-mêmes. Or ces fiches appartiennent aux leçons 4.2 et 3.22, et le schéma de mots.json n'a pas de champ pour un sens ajouté plus tard. Un apprenant de 4.2 voit donc déjà « + passé : pourquoi… ne pas ? » sur la carte لَوْلَا, avant d'avoir vu la notion (point F1). C'est moi qui avais proposé cet ajout « si le schéma le permet » : il ne le permet pas.
  - **Pistes** :
    1. Garder : la fiche sert de référence, et la remarque dit « (vu en 5.12) ».
    2. Ajouter au schéma un champ du type « sens ajoutés avec leur leçon », que l'application n'afficherait qu'à partir de cette leçon.
    3. Revenir aux anciens sens et ne mettre les nouveaux que dans la remarque.
  - **Confiance** : moyenne. L'effet pédagogique est faible, mais l'ordre des notions n'est pas respecté.
- Les doutes B6 et كَرِيمٌ → كَذِبٌ sont chez le conseiller : je n'ai pas d'élément nouveau.

## Points vérifiés sans problème
- **A (respect du Coran)** :
  - la fiche رَاوٍ dit maintenant « كَانَ فِي السُّوقِ تَاجِرٌ » : il n'y a plus de reprise de 27:48 ;
  - plus de آمِين dans le combat de 5.11 ; il ne reste que dans la remarque de la fiche أَمِينٌ, comme prévu ;
  - la nouvelle phrase de la lecture de 5.8 (« فَقَالَ سَمِيرٌ: « جَمَلِي يَعْمَلُ فِي اللَّيْلِ، وَيَنَامُ فِي النَّهَارِ. » ») ne reprend aucune suite connue du Coran ;
  - listes ⚠ respectées : « ثُمَّ رَجَعَ بَاسِمٌ » (verbe de la Cité, sujet nommé), قَالَ / فَقَالَ toujours suivis d'un nom, فَلَمَّا + وَصَلَ / جَلَسَ ;
  - en 5.12 : أَخَذَ « se mettre à » a partout un sujet nommé et n'est suivi que de يَكْتُبُ ou يَقْرَأُ ; لَوْلَا n'est suivi que de انْتَظَرْتَ ou سَأَلْتَ, avec un nom propre ; عَيْن n'apparaît jamais avec حَدِيقَة, نَهْر, un nombre ou un duel (مَعْنَيَانِ est le duel de مَعْنًى) ; رَأْس apparaît sans فَوْقَ.
- **C (forme)** :
  - vocalisation et cas justes dans toutes les phrases corrigées : أَعْطَى نَدِيمٌ بَاسِمًا قَلَمًا جَدِيدًا, أَعْطَى صَدِيقِي زُهَيْرًا كِتَابًا, لَوْلَا سَأَلْتَ زُهَيْرًا, عَيْنَ مَاءٍ قَرِيبَةً (accord au féminin), كَلِمَةُ عَيْنٍ لَهَا مَعْنَيَانِ ;
  - les distracteurs لَنْ et نَامَ de 5.8 sont sans ambiguïté.
- **D (sens)** :
  - « لَوْلَا + passé : un reproche » est juste (sans « invitation ») ;
  - « s'écrivent pareil sans voyelles » est juste ;
  - les consignes au passé de 5.10 sont justes ;
  - la remarque « un défaut : كَذِبٌ » est juste ;
  - les fiches رَأْسٌ, أَخَذَ et لَوْلَا sont justes sur le fond.
- **F (pédagogie)** :
  - les consignes « Réponse de لَمَّا : … » ne dévoilent plus la règle du فَـ ;
  - « ت glissé » est ajouté en 5.9 ;
  - la fiche بَيْنَمَا dit « le plus souvent » ;
  - la révision de 5.10 est complète (ثَمَرَة, بَرْد, أُسْبُوع, عَصْر) ;
  - le distracteur « la maison » pour قَمَرٌ ne prête plus à confusion ;
  - le distracteur « mensonge » pour حَدِيثٌ ne prête plus à confusion ;
  - le récit de 5.8 fait environ 59 mots, c'est-à-dire la limite basse du plan.
- **G (statuts et sources)** : « rédigé par IA » figure sur les fiches et sur les récits construits.

## Ce que je n'ai pas pu vérifier
- Je n'ai exécuté ni le garde-fou des 3 mots ni le contrôle des 95 % de mots connus : il faut lancer `python3 tools/build_content/build_content.py`.
- Les lemmes et les fréquences du Corpus : je n'ai pas d'accès à la base. C'est `vocab.validate` qui fait foi.
- L'audio est suspendu.
Suite donnée (20/11/2026) : point Important de 5.11 corrigé (أَعْطَى نَدِيمٌ…), mineurs corrigés ; décisions du conseiller appliquées (combat de 5.8 sans ouverture de conte ; fiches لَوْلَا et رَأْسٌ complétées : piste 1, la remarque dit « vu en 5.12 »).

---

# Rapport de relecture : leçon 5.13 « Mots proches, sens distincts » et retouches de 5.8, 5.11, 5.12

Fichiers relus :
- /home/user/iqura/tools/build_content/lessons/etape5/13-mots-proches-sens-distincts.json
- /home/user/iqura/tools/build_content/vocab/mots.json (fiches qaada, qawl, farq, mutaradif)
- /home/user/iqura/docs/sources/durra-thorbecke-1871-p143.txt
- /home/user/iqura/docs/sources/alfiyya-sacy-1833-p3.txt
- /home/user/iqura/docs/relectures/decisions-classique-avance-2.md (plan de 5.13, point d)
- Retouches : /home/user/iqura/tools/build_content/lessons/etape5/08-la-narration-classique.json, 11-le-vocabulaire-par-themes-2.json, 12-un-mot-plusieurs-sens.json
- Lemmes et racines cherchés dans /home/user/iqura/assets/content/iqura_content.db

Stade : région 5, leçon 5.13 (Classique avancé 2). Acquis supposés : régions 1 à 4, leçons 5.1 à 5.12 (dont جَلَسَ, وَقَفَ, قَامَ, نَامَ, اسْتَيْقَظَ, كَلَام, كَلِمَة, جُمْلَة, بَعْض, تَاجِر, حَدِيقَة, طَوِيل, l'impératif, لَيْسَ + accusatif, أَخَذَ + inaccompli).

## Verdict par leçon
- **5.13 : À corriger** (2 points Importants, pas de Bloquant).
- **5.8 (retouches du mini-boss) : Validé.**
- **5.11 (retouches) : Validé.**
- **5.12 (retouches) : Validé.**

Je n'ai trouvé aucun point de la catégorie A dans les quatre fichiers.

## Bloquant
- Aucun.

## Important
- [5.13 · règle « قَوْلٌ et كَلَامٌ », mini-boss (explication « Un seul mot ne donne pas un sens complet »), lecture d'Ibn Mālik (QCM 1, choix « un seul mot »)] **Problème** : la règle dit « un seul mot est déjà un قَوْلٌ, mais pas un كَلَامٌ ». Or le texte que l'apprenant vient de lire donne justement comme exemple de كَلَامٌ un seul mot : كَاسْتَقِمْ (« comme istaqim »). Le verbe contient son sujet (« toi ») et donne donc un sens complet. Formulée ainsi, la règle contredit la source affichée à l'écran juste avant, et elle fait apprendre une règle fausse. **Correction proposée** :
  - règle : « Selon Ibn Mālik, le كَلَامٌ est un énoncé qui donne un sens complet (même d'un seul mot, comme اسْتَقِمْ, où le verbe contient « toi ») ; le قَوْلٌ est plus général. Un nom seul comme كِتَابٌ est un قَوْلٌ, mais pas un كَلَامٌ. » ;
  - explication du mini-boss : « كِتَابٌ seul ne donne pas un sens complet. » ;
  - dans le QCM 1 de la lecture, remplacer le distracteur « un seul mot » par, par exemple, « un nom sans verbe » ou « une suite de sons sans sens ».

  Confiance : haute.
- [mots.json · qaada, champ fr, repris dans les exercices « sens » de l'entraînement et du mini-boss] **Problème** : le sens de base de la fiche est « s'asseoir (en venant de la station debout) ». La fiche présente ainsi comme sens du mot la nuance d'un seul auteur (al-Ḫalīl, rapporté par al-Ḥarīrī). Cela contredit la règle de la leçon (« dans l'usage courant, les deux s'emploient souvent l'un pour l'autre ») et le point d du plan (« on dit qui parle »). Dans le dictionnaire et en révision, la fiche affichera cette nuance sans son auteur. **Correction proposée** :
  - fr : « s'asseoir » ;
  - la nuance reste dans la remarque, déjà correcte et attribuée ;
  - dans les trois exercices « sens », la bonne réponse devient « s'asseoir » (les distracteurs « se lever », « dormir », « s'arrêter, se tenir debout » restent valables).

  Confiance : haute.

## Mineur
- [5.13 · lecture d'Ibn Mālik, note] Il est écrit « Ce sont les deux premiers vers ». En réalité, on lit le premier vers et la moitié du deuxième : le second hémistiche وَكِلْمَةٌ بِهَا كَلَامٌ قَدْ يُؤَمّْ, présent dans la transcription, est omis sans « (…) ». Proposition : « le premier vers et le début du deuxième », et ajouter « (…) » à la fin de la phrase 3 et du champ edition, comme pour al-Ḥarīrī.
- [5.13 · lecture d'al-Ḥarīrī, traduction 2] نَائِمًا est traduit « couché ». Le texte dit « qui dort », et les exercices construits jouent sur اسْتَيْقَظَ (« se réveiller »). Proposition : « à celui qui dort (…) », et dans la règle « quand on était endormi (couché) ».
- [5.13 · source d'al-Ḥarīrī] La mention « vocalisation complétée par IA, relue » laisse croire à une vérification humaine. La forme prévue par le plan est « voyelles ajoutées, rédigé par IA ».
- [5.13 · dialogue] الْخَلِيلَ employé seul peut faire penser au surnom d'un prophète (al-Ḫalīl). Proposition : à la première mention en français, écrire « al-Ḫalīl ibn Aḥmad, le grammairien ». La lecture donne déjà le nom complet.
- [5.13 · dialogue] فِي الْكَلَامِ est traduit « Dans l'usage ». Dans une leçon qui donne à كَلَامٌ son sens technique, la tournure peut prêter à confusion. Cela reste acceptable ; « Quand on parle, oui » serait plus fidèle.
- [mots.json · mutaradif] nature « nom » : مُتَرَادِفٌ est un participe actif de forme VI, employé comme adjectif ou nom. « adjectif » serait plus juste.
- [5.13 · lecture d'al-Ḥarīrī, lexique] Le lexique gagnerait à inclure الِانْتِقَالُ (« le passage ») et الْقُعُودُ / الْجُلُوسُ (noms d'action de قَعَدَ / جَلَسَ), sur lesquels portent les questions. Même remarque pour الْكَلِمُ (« les mots », collectif) dans la lecture d'Ibn Mālik.

## Doutes (à soumettre au conseiller, ne pas trancher)
- [5.13 · attribution « selon Ibn Mālik : un nom seul est un قَوْلٌ »] Le vers dit seulement وَالْقَوْلُ عَمّْ. Que le قَوْلٌ couvre aussi la كَلِمَة seule est la lecture des commentateurs, Ibn ʿAqīl en tête. Le plan prévoyait de lire ce commentaire, et il n'a pas été lu. La déduction est raisonnable (« son unité est la kalima, et le qawl est général »), mais elle dépasse un peu la lettre du texte lu. Pistes : formuler « le qawl est plus général : il comprend aussi le mot seul (lecture habituelle des commentateurs) », ou lire Ibn ʿAqīl (éd. Dieterici 1851). Confiance : moyenne.
- [5.13 · coupure de « أَوْ سَاجِدًا »] La coupure est signalée par « (…) » et expliquée dans la note. Le sens du passage n'est pas faussé : la règle de fond (« du bas vers le haut ») reste intacte. Je la juge défendable. Couper « وَلِهَٰذَا قِيلَ لِمَنْ أُصِيبَ بِرِجْلِهِ مُقْعَدٌ » est aussi correct et signalé. Confiance : moyenne (choix éditorial à confirmer).
- [5.13 · règle « قَعَدَ et جَلَسَ »] « Dans l'usage courant, les deux s'emploient souvent l'un pour l'autre » n'est pas dit tel quel par la source. Le texte l'implique seulement par « وَيَقُولُونَ لِلْقَائِمِ: اجْلِسْ ». Acceptable avec « rédigé par IA », mais c'est une affirmation non sourcée. Confiance : moyenne.

## Points vérifiés sans problème
- **A** :
  - aucune suite coranique repérée (vérifié notamment autour de « لِمَنْ كَانَ », où aucune suite de trois mots n'est reprise) ;
  - اسْتَقِمْ n'apparaît que comme exemple de grammairien, sans contexte religieux ;
  - aucun nom divin ni sens exégétique ; récits profanes.
- **B, E** : lemmes qaEada et qawol, racines frq et rdf présents dans la base. Il existe aussi un lemme faroq, mais au sens de « séparer » : le choix de la racine seule, avec avertissement, est cohérent. Aucune fréquence n'est affichée.
- **Lectures comparées aux transcriptions** :
  - al-Ḥarīrī : texte conforme mot pour mot, coupures « (…) » placées exactement, fin d'extrait avant « ومنه سميت نجد » correcte ;
  - voyelles ajoutées justes : الْخَلِيلُ بْنُ أَحْمَدَ (ibn sans alif, أَحْمَدَ diptote), أَنْ يُقَالَ (subjonctif), إِلَى normalisé ;
  - Ibn Mālik : conforme à l'édition ; la lecture عَمّْ est signalée.
- **C** :
  - vocalisation complète et correcte ;
  - accusatifs justes : وَلَيْسَ كَلَامًا ; لَيْسَ كُلُّ لَفْظَيْنِ مُتَقَارِبَيْنِ مُتَرَادِفَيْنِ ;
  - مَا الْفَرْقُ بَيْنَ… : distracteurs بَيْنُ et الْفَرْقَ bien fautifs ;
  - impératif اقْعُدْ correct (يَقْعُدُ).
- **D** : traductions fidèles, sauf « couché » (voir Mineur). La paraphrase de chaque nuance est attribuée (« selon al-Ḫalīl, rapporté par al-Ḥarīrī » ; « certains l'expliquent » pour بَعْضُهُمْ).
- **F** :
  - QCM à 3 choix, une seule bonne réponse dans chaque cas (dans « «الْكِتَابُ جَدِيدٌ» … », قَوْلٌ est bien absent des choix) ;
  - prérequis présents (اسْتَيْقَظَ en cite-04, بَعْض en sens-05, تَاجِر, حَدِيقَة, طَوِيل) ;
  - phrases modèles de l'Atelier justes et vocalisées ;
  - translittérations qaʿada, qawlun, farqun, mutarādifun correctes.
- **G** : sources et pages affichées. Exemples marqués construits / rédigés par IA.
- **5.8** :
  - كَانَ بَاسِمٌ جَالِسًا فِي الْحَدِيقَةِ : attribut à l'accusatif, distracteurs justes ;
  - حَكَيْتُ الْقِصَّةَ : accompli 1re personne d'un défectueux, correct, distracteurs حَكَتْ / يَحْكِي valables.
- **5.11** : أَعْطَى نَدِيمٌ بَاسِمًا قَلَمًا جَدِيدًا (deux compléments à l'accusatif), cohérent dans le dialogue, la lecture et le QCM ; aperçu limité aux noms propres.
- **5.12** :
  - لَوْلَا سَأَلْتَ زُهَيْرًا avec les distracteurs السُّؤَالُ / سُؤَالٌ : une seule réponse possible ;
  - consigne « Bāsim a pris le calame, puis s'est mis à écrire » cohérente ;
  - explication de رَأْسٌ à l'échauffement juste.

## Ce que je n'ai pas pu vérifier
- Les fac-similés eux-mêmes (archive.org). J'ai comparé la leçon aux transcriptions du dépôt, pas aux images.
- Le nombre d'occurrences des lemmes (aucun n'est affiché) ; leur présence seule a été confirmée.
- Le passage du garde-fou `quran_guard.py` : je ne l'ai pas exécuté.
- Le commentaire d'Ibn ʿAqīl, qui n'a pas été lu (voir Doutes).