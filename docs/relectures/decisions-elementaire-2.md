# Décisions du conseiller : niveau Élémentaire 2 (leçons 2.11 à 2.20)

Agent : conseiller-arabe, 25/10/2026. Plan de langue demandé avant l'écriture du niveau. Les paires coraniques citées le sont de mémoire : le garde-fou de construction fait foi.

## Plan de langue du niveau Élémentaire 2 (leçons 2.11 à 2.20, « Le marché »)

Question : notion, mots, phrases modèles et pièges pour chaque leçon de 2.11 à 2.20, et les décisions de principe du niveau.
Stade : région 2, leçons 2.11 à 2.20. Acquis : les lettres et les signes de la région 1, et les mots lus en région 1 (`elements.mots`, que la construction compte comme connus : كِتَاب، بَاب، عَلَى، دَار، خُبْز، مَدِينَة, etc.). S'y ajoutent les 2.1 à 2.10 : nom, verbe et particule ; genre ; défini et indéfini ; هَٰذَا et ذَٰلِكَ ; phrase nominale ; pronoms isolés ; adjectif ; questions. Le vocabulaire de `vocab/mots.json` est acquis. Les décisions de `decisions-elementaire-1.md` s'appliquent, dont la n° 2 : aucune phrase verbale avant 2.21.

Sources lues : cahier §5 (l. 242-255) et §16 ; `decisions-elementaire-1.md` ; `PROPOSITION_REGION_2.md` ; `vocab/mots.json` ; `lessons.py`, `fondations.py`, `vocab.py`.
Lemmes : vérifiés par une recherche de texte dans `assets/content/iqura_content.db` (lignes du type `xayoTخَيْطxyTN`). Ce n'est pas une requête SQL : la construction devra confirmer (`vocab.validate` échoue si un lemme manque).
Paires coraniques : citées de mémoire, **non vérifiées**. Le garde-fou de construction tranche.

## Décision

### A. Plan par leçon

Notations :
- « L » = lemme trouvé dans la base ;
- « R » = racine seule montrée, sans fréquence (règle de 2.1-2.10) ;
- « — » = ni lemme ni racine dans le Corpus ;
- ⚠ = suite à ne jamais écrire.

**2.11 Où est-il ? (Souk, Salmā)**
- **Règle** : « Après فِي، عَلَى، مِنْ، إِلَى, le nom finit par i : فِي الْبَيْتِ ; s'il est indéfini, par -in : فِي بَيْتٍ. Tu as vu en leçon 12 que la fin d'un mot change : la leçon suivante explique pourquoi. »
- **Remarque d'une ligne** : مِنْ devant l'article devient مِنَ (مِنَ الْقَرْيَةِ).
- **Mots (8)** :
  - عَلَى « sur », particule, L EalaY` ;
  - سُوقٌ « marché », nom féminin (« parfois masculin en arabe classique »), pluriel أَسْوَاقٌ, R swq. Pas de lemme : le lemme s~uwq du Corpus a un autre sens (tiges, jambes). Le mot n'entre dans aucun exercice d'accord, comme طَرِيقٌ ;
  - بَابٌ « porte », m., pl. أَبْوَابٌ, L baAb ;
  - كِتَابٌ « livre », m., pl. كُتُبٌ, L kita`b ;
  - خُبْزٌ « pain », m., L xuboz ;
  - زَيْتٌ « huile », m., L zayot ;
  - لَحْمٌ « viande », m., pl. لُحُومٌ, L laHom ;
  - سَلَّةٌ « panier », f., pl. سِلَالٌ, R sll, avec l'avertissement sur les racines.
- **Modèles** :
  - الْخُبْزُ فِي السَّلَّةِ. « Le pain est dans le panier. »
  - الْكِتَابُ عَلَى الْكُرْسِيِّ. « Le livre est sur la chaise. »
  - التَّاجِرُ مِنَ الْقَرْيَةِ. « Le marchand est du village. »
- **Pièges** :
  - ne pas nommer les cas avant 2.12 ;
  - إِلَى a besoin d'un verbe de mouvement. Avant 2.21, il n'apparaît que dans la réponse brève d'un dialogue (« إِلَى السُّوقِ. »), comme une formule ;
  - ⚠ « مَا فِي الْأَرْضِ », « مَنْ فِي/عَلَى الْأَرْضِ », « فِي السَّمَاءِ » : ne jamais employer الْأَرْض ni السَّمَاء après une préposition dans ce niveau.

**2.12 Les fins de mots**
- **Règle** : « Un nom a trois fins selon son rôle : -u quand il est sujet ou attribut (nominatif, مَرْفُوعٌ), -i après une préposition (génitif, مَجْرُورٌ), -a dans d'autres rôles, vus avec les verbes (accusatif, مَنْصُوبٌ). »
- Les termes arabes sont en aperçu. L'accusatif est montré dans un tableau (بَابٌ، بَابًا، بَابٍ), sans exercice.
- **Mots (8)** :
  - ثَمَنٌ « prix », m., pl. أَثْمَانٌ, L vaman ;
  - ذَهَبٌ « or », m., L *ahab ;
  - فِضَّةٌ « argent (métal) », f., L fiD~ap ;
  - حَدِيدٌ « fer », m., L Hadiyd ;
  - دِينَارٌ « dinar », m., pl. دَنَانِيرُ, L diynaAr ;
  - دِرْهَمٌ « dirham », m., pl. دَرَاهِمُ, R drhm. Le lemme du Corpus est le pluriel (dara`him) : on ne le relie pas ;
  - كَثِيرٌ « nombreux, abondant », adj., كَثِيرَةٌ, L kaviyr ;
  - قَلِيلٌ « peu nombreux, rare », adj., قَلِيلَةٌ, L qaliyl.
- **Modèles** (le même mot en -u puis en -i) :
  - الدِّينَارُ مِنَ الذَّهَبِ. « Le dinar est en or. »
  - الدِّرْهَمُ مِنَ الْفِضَّةِ. « Le dirham est en argent. »
  - الْحَدِيدُ كَثِيرٌ فِي الْقَرْيَةِ. « Le fer abonde au village. »
- **Pièges** :
  - ذَهَبٌ (or) et ذَهَبَ (il est allé) ont le même squelette. C'est un bon exercice de voyelles, mais la recherche du sens au toucher doit afficher les deux sens ; sinon, on reporte ذَهَبٌ ;
  - tanwīn accusatif : -an s'écrit avec un alif (بَابًا), sauf après ة (فِضَّةً) ;
  - ⚠ ثَمَن ne se place jamais à côté de قَلِيل, sous aucune forme (« ثَمَنًا قَلِيلًا » est très fréquent dans le Coran). Le squelette avec alif peut échapper au garde-fou ;
  - ⚠ « الْحَدِيدُ فِيهِ » (à surveiller en 2.15) ; ⚠ « مِنْ ذَهَبٍ » ou « مِنْ فِضَّةٍ » à la suite de أَسَاوِر, آنِيَة, قَوَارِير, سُقُف.

**2.13 « La porte de la maison » (iḍāfa)**
- **Règle** : « Pour dire « la porte de la maison », on met deux noms côte à côte. Le premier n'a ni article ni tanwīn ; le second finit par i : بَابُ الْبَيْتِ. »
- **Encadré** : تَحْتَ et فَوْقَ se construisent comme un premier terme : تَحْتَ الْكُرْسِيِّ.
- **Mots (6)** :
  - تَحْتَ « sous », L taHot ;
  - فَوْقَ « au-dessus de », L fawoq. Ces deux mots sont des noms de lieu (étiquette LOC dans le Corpus) ;
  - بَائِعٌ « vendeur », m., forme بَائِعَةٌ, R byE. Pluriel non affiché (deux pluriels possibles) ;
  - كِيسٌ « sac, bourse », m., pl. أَكْيَاسٌ, — ;
  - مِفْتَاحٌ « clé », m., pl. مَفَاتِيحُ, R ftH ;
  - صُنْدُوقٌ « coffre », m., pl. صَنَادِيقُ, —.
- **Modèles** :
  - بَابُ الْبَيْتِ كَبِيرٌ. « La porte de la maison est grande. »
  - كِيسُ التَّاجِرِ فِي الصُّنْدُوقِ. « La bourse du marchand est dans le coffre. »
  - الْمِفْتَاحُ تَحْتَ الْكِيسِ. « La clé est sous la bourse. »
  - Aussi : بَيْتُ سَلْمَى قَرِيبٌ مِنَ السُّوقِ.
- **Pièges** :
  - le premier terme prend la fin de son rôle (بَابُ ici) ;
  - pas d'épithète après une iḍāfa (بَابُ الْبَيْتِ الْكَبِيرُ est ambigu) : attribut seulement ;
  - pas de chaîne de trois noms ;
  - ⚠ أُمُّ الْكِتَابِ et أُمُّ الْقُرَى : les deux mots sont sur des fiches. ⚠ أَهْلُ…, ابْنُ السَّبِيلِ, يَوْمُ…, لَحْمُ طَيْرٍ, صَاحِبُ/أَصْحَابُ… : aucun nom divin, de prophète ou de lieu sacré en second terme.

**2.14 Mon livre, ton livre (Échoppe du tisserand)**
- **Règle** : « Pour dire « mon, ton, son », on colle un petit pronom à la fin du nom, qui perd l'article et le tanwīn : ثَوْبِي، ثَوْبُكَ، ثَوْبُكِ، ثَوْبُهُ، ثَوْبُهَا، ثَوْبُنَا. ة devient ت : إِبْرَتِي. »
- Exercices au singulier et avec نَا seulement. كُمْ، كُنَّ، هُمْ، هُنَّ et les formes du duel sont dans un tableau, à reconnaître.
- **Mots (6)** :
  - نَسَّاجٌ « tisserand », m., pl. نَسَّاجُونَ, forme نَسَّاجَةٌ, — ;
  - خَيْطٌ « fil », m., pl. خُيُوطٌ, L xayoT ;
  - صُوفٌ « laine », m., R Swf. Le lemme du Corpus est le pluriel أَصْوَاف : on ne le relie pas ;
  - حَرِيرٌ « soie », m., L Hariyr ;
  - قَمِيصٌ « chemise, tunique », m., pl. قُمْصَانٌ, L qamiyS ;
  - إِبْرَةٌ « aiguille », f., pl. إِبَرٌ, — (à vérifier).
- **Modèles** :
  - هَٰذَا ثَوْبِي. « Ceci est mon vêtement. »
  - خَيْطُكَ طَوِيلٌ. « Ton fil est long. »
  - إِبْرَتُهَا صَغِيرَةٌ. « Son aiguille est petite. »
- **Pièges** :
  - -ī recouvre la voyelle du cas (ثَوْبِي dans tous les cas) ;
  - seulement le nom au nominatif ici : -hi vient en 2.15 ;
  - pas de أَبٌ ni de أَخٌ avec un suffixe (أَبُوهُ، أَخِيهِ : les « cinq noms ») ;
  - ⚠ « هَٰذَا أَخِي » (Coran 12:90 et 38:23), « هَٰذَا كِتَابُنَا » ; éviter قَمِيصُهُ ;
  - pas d'épithète après un nom à suffixe.

**2.15 Avec moi, sur lui**
- **Règle 1** : « Les mêmes pronoms se collent aux prépositions : لِي، لَكَ، لَكِ، لَهُ، لَهَا، لَنَا ; فِيهِ ; عَلَيْهِ ; مِنْهُ ; إِلَيْهِ ; مَعِي ; عِنْدِي. Après i, ī ou ay, -hu devient -hi : فِيهِ، عَلَيْهِ، فِي كِيسِهِ. »
- **Règle 2** : « لِي + nom indéfini = « j'ai » ; quand le sujet est indéfini, le lieu passe devant : فِي الْغُرْفَةِ كُرْسِيٌّ (« il y a »). »
- **Mots (5)** :
  - لِـ « à, pour », particule, sans lemme (comme وَ) ;
  - مَعَ « avec », L maE ;
  - عِنْدَ « chez, auprès de », L Eind. Ces deux mots sont des noms de lieu ;
  - صَدِيقٌ « ami », m., pl. أَصْدِقَاءُ, L Sadiyq ;
  - قِطْعَةٌ « morceau, pièce », f., pl. قِطَعٌ, R qTE.
- **Modèles** :
  - لِي قَمِيصٌ جَدِيدٌ. « J'ai une chemise neuve. »
  - الصُّنْدُوقُ كَبِيرٌ، وَفِيهِ صُوفٌ. « Le coffre est grand et il contient de la laine. »
  - الْإِبْرَةُ فِي كِيسِهِ. « L'aiguille est dans sa bourse. »
- **Pièges** :
  - لَ prend une fatḥa devant les pronoms, sauf لِي ;
  - عَلَى et إِلَى deviennent عَلَيْ‑ et إِلَيْ‑ ;
  - فِيَّ، عَلَيَّ، مِنِّي : aperçu seulement ;
  - لِـ + nom (لِلتَّاجِرِ) : aperçu seulement ;
  - ⚠ « فِيهَا حَرِيرٌ », « فِيهَا عَيْنٌ », « فِيهَا/فِيهِمَا فَاكِهَةٌ », « لَا رَيْبَ فِيهِ » ;
  - ⚠ ne jamais écrire « ذَٰلِكَ الْكِتَابُ » ;
  - ⚠ « مَعِيَ رَبِّي », « لِي عَمَلِي », « مَا لِي », « مَنْ عَلَيْهَا », « لَهُ مَا » ;
  - pour demander un prix, la formule permise est « مَا ثَمَنُهُ؟ ». Pas de كَمْ.

**2.16 Le duel (Maison de Salmā)**
- **Règle** : « Pour deux, on ajoute -āni (sujet, attribut) ou -ayni (après une préposition) ; ة devient ت : سَرِيرَانِ، فِي السَّلَّتَيْنِ، وِسَادَتَانِ. L'adjectif suit au duel : جَدِيدَتَانِ. »
- On mentionne que -ayni sert aussi pour l'accusatif, vu plus tard.
- **Mots (6)** :
  - يَدٌ « main », f., pl. أَيْدٍ, L yad ;
  - سَقْفٌ « plafond, toit », m., pl. سُقُفٌ, L saqof ;
  - سَرِيرٌ « lit », m., R srr. Pluriel non affiché (أَسِرَّةٌ ou سُرُرٌ) ;
  - جِدَارٌ « mur », m., pl. جُدُرٌ, L jidaAr ;
  - وِسَادَةٌ « coussin », f., pl. وَسَائِدُ, — (à vérifier) ;
  - مَطْبَخٌ « cuisine », m., pl. مَطَابِخُ, — (à vérifier).
- **Modèles** :
  - الْخُبْزُ فِي السَّلَّتَيْنِ. « Le pain est dans les deux paniers. »
  - فِي الْغُرْفَةِ سَرِيرَانِ. « Il y a deux lits dans la chambre. »
  - الْوِسَادَتَانِ جَدِيدَتَانِ. « Les deux coussins sont neufs. »
- **Pièges** :
  - le ن du duel tombe dans une iḍāfa (يَدَا) : aperçu, jamais en exercice ;
  - هَٰذَانِ et هَاتَانِ : aperçu ;
  - ⚠ « يَدَا… », « يَدَاهُ » ; ⚠ duels de عَيْن، جَنَّة، بَحْر، زَوْج، أُخْت، رَجُل, à ne pas employer ;
  - ⚠ « سُقُفًا مِنْ فِضَّةٍ » ; ⚠ « السَّقْفُ مِنْ فَوْقِهِمْ » ;
  - « fenêtre » (نَافِذَةٌ) est écarté : son usage classique n'est pas sûr.

**2.17 Les pluriels réguliers**
- **Règle** : « Pluriel masculin des personnes : -ūna (sujet, attribut), -īna après une préposition : خَبَّازُونَ، مَعَ الْخَبَّازِينَ. Pluriel féminin : ة devient -āt (-ātun, et -ātin après une préposition) : مُعَلِّمَاتٌ. »
- On contraste le ن : -āni (duel) et -ūna (pluriel).
- L'accord en nombre (cahier §5.6, décision de 2.9) se pratique ici, avec des personnes seulement.
- **Mots (7)** :
  - خَبَّازٌ « boulanger », R xbz ;
  - خَيَّاطٌ « tailleur », R xyT ;
  - حَدَّادٌ « forgeron », R Hdd ;
  - نَجَّارٌ « menuisier », — ;
  - pour ces quatre noms : m., pluriel en -ūna, forme féminine en ة ;
  - فَرِحٌ « joyeux », adj., فَرِحَةٌ, L fariH ;
  - مَشْغُولٌ « occupé », adj., مَشْغُولَةٌ, R $gl ;
  - هَٰؤُلَاءِ « ceux-ci, celles-ci (personnes) », nom (démonstratif).
- **Modèles** :
  - الْخَبَّازُونَ فِي السُّوقِ. « Les boulangers sont au marché. »
  - نَحْنُ مُسَافِرُونَ. « Nous sommes des voyageurs. »
  - التَّاجِرُ مَعَ الْخَيَّاطِينَ. « Le marchand est avec les tailleurs. »
  - Aussi : الْبَنَاتُ فَرِحَاتٌ.
- **Pièges** :
  - تَاجِرٌ fait تُجَّارٌ, pas -ūna : tout nom de personne ne prend pas -ūna ;
  - les adjectifs déjà connus (كَبِير، صَغِير…) ont un pluriel brisé au masculin : ils n'ont **pas** d'accord masculin pluriel dans ce niveau. Au féminin, -āt est correct (صَغِيرَاتٌ) ;
  - le ن tombe dans une iḍāfa : aperçu ;
  - ⚠ « لَهُ كَاتِبُونَ », « كَاتِبِينَ », « هَٰؤُلَاءِ بَنَاتِي », « وَهُمْ نَائِمُونَ » ; pas de pluriels à sens religieux (مُؤْمِنُونَ…).

**2.18 Les pluriels internes**
- **Règle 1** : « Beaucoup de noms changent de voyelles au pluriel, sans terminaison : كِتَابٌ → كُتُبٌ. Ce pluriel s'apprend avec le mot. »
- **Règle 2** : « Un pluriel de choses ou d'animaux s'accorde comme un féminin singulier : هَٰذِهِ كُتُبٌ، الْكُتُبُ جَدِيدَةٌ. »
- On montre quatre formes à l'aide de pluriels déjà affichés, racine en couleur, **sans la notation فعل**, réservée aux schèmes de la région 3 (§16 du 22/10) :
  - أَقْلَامٌ، أَوْلَادٌ، أَنْهَارٌ، أَبْوَابٌ ;
  - رِجَالٌ، جِبَالٌ، ثِيَابٌ ;
  - بُيُوتٌ، لُحُومٌ، خُيُوطٌ ;
  - كُتُبٌ.
- **Mots (6)** :
  - ضَيْفٌ « invité, hôte », pl. ضُيُوفٌ, L Dayof ;
  - جَارٌ « voisin », pl. جِيرَانٌ, L jaAr ;
  - سَيْفٌ « épée », pl. سُيُوفٌ, — (à vérifier) ;
  - حِمَارٌ « âne », pl. حَمِيرٌ, L HimaAr ;
  - كَلْبٌ « chien », pl. كِلَابٌ, L kalob ;
  - نَجْمٌ « étoile », pl. نُجُومٌ, L n~ajom ;
  - tous masculins. كَلْبٌ et نَجْمٌ, lus en région 1, reçoivent leur fiche.
- **Modèles** :
  - هَٰذِهِ أَقْلَامٌ جَدِيدَةٌ. « Ce sont des calames neufs. »
  - السُّيُوفُ قَدِيمَةٌ. « Les épées sont anciennes. »
  - الضُّيُوفُ فِي بَيْتِ سَلْمَى. « Les invités sont dans la maison de Salmā. »
- **Pièges** :
  - les pluriels sans tanwīn (دَرَاهِمُ، مَفَاتِيحُ، كَرَاسِيُّ، صَنَادِيقُ، أَصْدِقَاءُ، وَسَائِدُ) restent sur les fiches et ne vont jamais après une préposition dans ce niveau ;
  - كِبَارٌ et les autres pluriels d'adjectifs pour des personnes : aperçu au plus ;
  - ⚠ « هَٰؤُلَاءِ ضَيْفِي », « ضَيْفِ إِبْرَاهِيمَ », « صَوْتُ الْحَمِيرِ », « مَثَلُ الْكَلْبِ/الْحِمَارِ », « كَلْبُهُمْ » ;
  - ⚠ « أَمْوَالٌ » ou « الْمَالُ » suivi de أَوْلَادٌ ou الْبَنُونَ.

**2.19 Compter jusqu'à 10 (Balance du changeur)**
- **Règle** : « 1 et 2 viennent après le nom, comme des adjectifs : كِتَابٌ وَاحِدٌ، كِتَابَانِ. De 3 à 10, le nombre vient avant un pluriel indéfini qui finit par i : ثَلَاثَةُ كُتُبٍ. Avec un nom masculin, le nombre a un ة. »
- En aperçu, sans exercice : « avec un nom féminin, c'est l'inverse : ثَلَاثُ غُرَفٍ ».
- **Mots (10)**, tous des noms (nombres), lemmes trouvés :
  - وَاحِدٌ (formes وَاحِدَةٌ) ; اثْنَانِ (formes اثْنَتَانِ) ;
  - ثَلَاثَةٌ، أَرْبَعَةٌ، خَمْسَةٌ، سِتَّةٌ، سَبْعَةٌ، ثَمَانِيَةٌ، تِسْعَةٌ، عَشَرَةٌ ;
  - lemmes : wa`Hid, {vonayon, vala`vap, >arobaE, xamosap, sit~ap, saboE, vama`niyap, tisoE, Ea$arap.
- **Modèles** :
  - لِي ثَلَاثَةُ أَقْلَامٍ. « J'ai trois calames. »
  - فِي السُّوقِ خَمْسَةُ تُجَّارٍ. « Il y a cinq marchands au marché. »
  - ثَمَنُ الْقَمِيصِ دِرْهَمَانِ. « Le prix de la chemise est de deux dirhams. »
- **Pièges** :
  - en exercice, seulement des noms masculins dont le pluriel prend le tanwīn : أَقْلَام، كُتُب، تُجَّار، بُيُوت، أَكْيَاس، سُيُوف ;
  - l'argent se compte de 1 à 2 seulement (دِرْهَمٌ وَاحِدٌ، دِينَارَانِ), car دَرَاهِمُ et دَنَانِيرُ n'ont pas de tanwīn ;
  - pas de ثَمَانٍ, ni de عَشْرٌ, ni de nombre au-delà de 10, ni de كَمْ suivi d'un accusatif ;
  - اثْنَانِ commence par un alif sans voyelle ;
  - ⚠ « طَعَامٌ وَاحِدٌ », « بَابٍ وَاحِدٍ », « سَبْعَةُ أَبْوَابٍ », « سِتَّةِ/ثَلَاثَةِ/أَرْبَعَةِ أَيَّامٍ », « أَرْبَعَةُ أَشْهُرٍ », « ثَلَاثَةٌ… كَلْبُهُمْ », « إِلَٰهٌ وَاحِدٌ », « زَوْجَيْنِ اثْنَيْنِ ». Ni يَوْم ni شَهْر avec un nombre.

**2.20 « Il n'est pas… »**
- **Règle** : « Pour nier une phrase nominale, on emploie لَيْسَ (لَيْسَتْ avec un sujet féminin). L'attribut prend alors la fin -a : الْبَيْتُ لَيْسَ كَبِيرًا. »
- On commence par un attribut avec préposition, qui ne change pas de fin, puis un adjectif en -an.
- **Mots (6)** :
  - لَيْسَ, verbe (étiquette V dans le Corpus, L l~ayosa), formes لَيْسَتْ ;
  - صَرَّافٌ « changeur », m., pl. صَرَّافُونَ, R Srf ;
  - مِيزَانٌ « balance », m., pl. مَوَازِينُ, L miyzaAn, avec le sens général seulement ;
  - كِفَّةٌ « plateau (de balance) », f., pl. كِفَفٌ, racine à vérifier ;
  - ثَقِيلٌ « lourd », adj., L vaqiyl ;
  - خَفِيفٌ « léger », adj., L xafiyf.
- **Modèles** :
  - الدِّينَارُ لَيْسَ فِي الْكِيسِ. « Le dinar n'est pas dans la bourse. »
  - الذَّهَبُ لَيْسَ خَفِيفًا. « L'or n'est pas léger. »
  - الْكِفَّةُ لَيْسَتْ ثَقِيلَةً. « Le plateau n'est pas lourd. »
- **Pièges** :
  - كَبِيرًا s'écrit avec un alif, mais ثَقِيلَةً sans ;
  - on ne nie pas une phrase nominale avec لَا ;
  - لَسْتُ, لَسْتَ, etc. attendent 2.22 ;
  - pas de construction avec بِـ (لَيْسَ بِـ…) ;
  - ⚠ « مَا لَيْسَ لِي/لَكَ », « لَيْسَ لَكَ بِهِ », « لَيْسَ كَـ… », « أَلَيْسَ » et « أَلَسْتُ », « لَيْسَ الْبِرُّ » ;
  - ⚠ « قَوْلًا ثَقِيلًا », « يَوْمًا ثَقِيلًا », « خِفَافًا وَثِقَالًا », « الْكَيْلُ وَالْمِيزَانُ », « الْمِيزَانُ بِالْقِسْطِ ».

### B. Décisions de principe (10)

1. **Mots de la région 1 réemployés** (كِتَابٌ، بَابٌ، عَلَى، كَلْبٌ، نَجْمٌ) : ils reçoivent une fiche à leur premier emploi dans une phrase, et comptent parmi les mots nouveaux de cette leçon.
2. **Cas** :
   - 2.11 : la fin en i est présentée comme une observation (lien avec la leçon 12), sans nom de cas ;
   - 2.12 : les trois cas sont nommés ; l'accusatif reste dans un tableau jusqu'à 2.20 (seul emploi : après لَيْسَ) ;
   - les mots sans tanwīn (diptotes) ne sont jamais au génitif dans ce niveau ;
   - سَلْمَى ne change pas. رَاشِدٌ, بَاسِمٌ et سَمِيرٌ se déclinent.
3. **تَحْتَ، فَوْقَ، مَعَ، عِنْدَ** : fiche « nom (de lieu), employé comme une préposition ». C'est cohérent avec la décision n° 5 et avec l'étiquette LOC du Corpus. Leur fatḥa ne change pas dans ce niveau.
4. **Épithète interdite** après une iḍāfa et après un nom à suffixe (ambiguïté) : attribut seulement. L'épithète définie (ثَوْبِي الْجَدِيدُ) est reportée.
5. **Suffixes** :
   - exercices au singulier et avec نَا ; le reste en tableau ;
   - -hi enseigné en 2.15 ;
   - أَبٌ et أَخٌ ne prennent pas de suffixe avant la région 3 (« cinq noms ») ;
   - « il y a / avoir » (لِي كِتَابٌ، فِي الْغُرْفَةِ كُرْسِيٌّ) est enseigné en 2.15.
6. **Duel et pluriels** :
   - la chute du ن dans une iḍāfa est en aperçu seulement ; هَٰذَانِ et هَاتَانِ aussi ;
   - هَٰؤُلَاءِ entre en 2.17 ;
   - pluriel de personnes : accord au pluriel ; pluriel de choses : féminin singulier (règle en 2.18) ;
   - pas d'adjectif à pluriel brisé pour des personnes dans ce niveau.
7. **Nombres, « accord simplifié »** :
   - liste de 1 à 10 sous la forme avec ة ;
   - en exercice, noms masculins seulement : 1-2 après le nom, 3-10 suivis d'un pluriel indéfini en i ;
   - l'inversion au féminin est en aperçu ;
   - pas de كَمْ suivi d'un accusatif ; formule permise : « مَا ثَمَنُهُ؟ ».
8. **لَيْسَ** :
   - la fiche dit « verbe », comme le Corpus, avec la remarque « verbe figé : il nie une phrase nominale ; pas de présent ni de futur » ;
   - ce n'est pas une contradiction avec la décision n° 2 : en grammaire arabe, la phrase avec لَيْسَ reste une phrase nominale (لَيْسَ fait partie de la famille de كَانَ). Il n'y a ni action ni agent ;
   - on n'emploie que لَيْسَ et لَيْسَتْ, sujet nom placé **avant** (الْبَيْتُ لَيْسَ كَبِيرًا), ce qui évite aussi لَيْسَتِ + article ;
   - le maître dit : « c'est un verbe un peu spécial ; les vrais verbes commencent en 2.21 ».
9. **Lemmes** :
   - pas de lien quand le lemme du Corpus a un autre sens (s~uwq ≠ « marché ») ou est un pluriel (dara`him, >aSowaAf, mafaAtiH, surur) : racine seule, sans fréquence ;
   - noms classiques absents du Corpus (نَسَّاج، نَجَّار، كِيس، صُنْدُوق) : rien n'est montré ;
   - مِيزَان, نَار et les autres mots à charge religieuse : sens général seulement.
10. **Versets** : pour chaque leçon, la liste des ⚠ ci-dessus est à éviter. Toute phrase passe le garde-fou des 3 mots et l'avertissement des paires. Un avertissement de paire entraîne un remplacement, sans discussion.

### C. Points techniques pour Claude Code (pas des questions de langue)

- `vocab.unknown` ne retire que l'article et un préfixe d'une lettre. Il ne reconnaîtra donc pas :
  - ثَوْبِي, إِبْرَتُهَا, فِيهِ (suffixes) ;
  - سَرِيرَانِ (duel) ;
  - خَبَّازِينَ (pluriel) ;
  - خَفِيفًا (alif du tanwīn) ;
  - ة → ت.
  Il faut l'étendre, ou déclarer ces formes, avant 2.14.
- ذَهَبٌ et ذَهَبَ ont la même clé : le sens au toucher doit afficher les deux.

## Pourquoi

Le plan suit le cahier (l. 242-255) et ne contredit aucune décision du §16 ni de `decisions-elementaire-1.md`. Il respecte notamment l'absence de verbe actif avant 2.21, les pluriels exercés en 2.17-2.18, les mots à double genre écartés des accords et les schèmes réservés à la région 3. Chaque phrase modèle n'emploie que des mots acquis ou introduits dans la leçon, et aucun verbe sauf لَيْسَ. Les choix grammaticaux sont ceux de l'arabe classique courant : iḍāfa, suffixes avec -hi après i, accord des pluriels de choses au féminin singulier, polarité des nombres, et لَيْسَ suivi d'un attribut en -a. Là où une forme demande une règle pas encore vue (diptotes, cinq noms, nombres au féminin, ن qui tombe), la solution prudente est retenue : aperçu ou évitement. Les lemmes viennent de la base du dépôt, aucun n'est donné de mémoire.

## Confiance

Moyenne dans l'ensemble, haute sur les règles de grammaire. Ce qui reste incertain :
- **Paires et suites coraniques** : citées de mémoire. La liste n'est pas exhaustive ; le garde-fou fait foi.
- **Lemmes** : trouvés par recherche de texte, pas par SQL. À confirmer à la construction.
- **Racines non vérifiées** : إِبْرَة, وِسَادَة, مَطْبَخ, كِفَّة, سَيْف, كِيس.
- **Pluriels laissés hors fiche** (choix multiples) : بَائِع, سَرِير.
- **Genre double en classique** : سُوق (fiche « féminin, parfois masculin », hors accords). عَسَل et مِلْح sont écartés pour cette raison.
- **نَافِذَة** est écartée : je ne peux pas garantir son usage classique.

## Résumé pour l'utilisateur

Plan du marché prêt : 68 mots nouveaux (5 à 10 par leçon), des phrases sans verbe, « il n'est pas » (لَيْسَ) présenté comme un mot de négation un peu spécial, et les formes difficiles (nombres au féminin, pluriels sans tanwīn) seulement montrées, pas encore exercées.


## Doutes des relectures de 2.11 à 2.13 (25/10/2026)

1. **Fiche « livre »** : l'exemple « هَٰذَا كِتَابٌ جَدِيدٌ. » devient « الْكِتَابُ قَدِيمٌ. ». Dans le Coran, « هَٰذَا كِتَابٌ » renvoie au Livre lui-même. Ce n'est pas une règle générale.
2. **إِلَى أَيْنَ؟** est gardé comme formule figée, sans verbe, avec sa réponse إِلَى السُّوقِ. Aucun autre emploi de إِلَى avant 2.21.
3. **Tanwīn (2.12)** : « la plupart des noms » ; on ajoute que quelques noms, comme دَرَاهِمُ, n'en prennent jamais. L'exemple isolé دِرْهَمٍ est remplacé par فِي بَيْتٍ.
4. **Écoute** : on n'oppose jamais -un et -in sur un mot isolé. L'exercice de 2.12 porte sur فِضَّةٌ / حَدِيدٌ / ذَهَبٌ.
5. **فَوْقَ** = « au-dessus de » seulement. Remarque sur la fiche : « عَلَى : posé sur ; فَوْقَ : plus haut que ».
6. **صُنْدُوقٌ** est gardé avec une ḍamma, sans variante affichée.

## Doutes des relectures de 2.14 à 2.20 (25/10/2026)

7. **2.14** : la question de sens sur ثَوْبُهُمْ, posée après que le sens est donné, relève de la reconnaissance (compatible avec la décision n° 5). Aucune de ces formes n'entre dans un exercice à compléter, à ordonner ou à traduire avant d'être enseignée.
8. **2.16** : la chute du ن du duel dans une iḍāfa n'est pas montrée ; elle sera enseignée avec celle du pluriel en -ūna, quand l'iḍāfa sera reprise.
9. **2.18** : distracteur ذَٰلِكَ confirmé (هَٰؤُلَاءِ se rencontre pour des choses en classique) ; traduction « Voici des voisins, et voici des invités. »
10. **2.19** : un nombre peut suivre le nom comme épithète (كُتُبٌ ثَلَاثَةٌ) ; les distracteurs sont au mauvais cas ou au singulier, faux sans discussion.
11. **2.20** : la phrase « On ne nie pas une phrase nominale avec لَا » reste retirée ; explication ajoutée : « Ici, لَا seul voudrait dire « non » ».

## Liste de fin de niveau (Élémentaire 2, 10 points au plus)

1. Après فِي، عَلَى، مِنْ, le nom finit par « i » ; مِنْ devient مِنَ devant « al- » ; إِلَى seulement dans « إِلَى أَيْنَ؟ — إِلَى السُّوقِ. », en attendant les verbes.
2. Les trois cas sont nommés en 2.12 ; la fin en « a » reste dans un tableau jusqu'à لَيْسَ ; les mots sans « n » final (دَرَاهِمُ) ne viennent jamais après une préposition dans ce niveau.
3. Jamais d'adjectif collé derrière « la porte de la maison » ni derrière « mon/ton… » ; seulement « … est grand ».
4. On s'exerce avec « mon, ton, son, notre » ; « votre, leur » et les formes pour deux sont montrés pour être reconnus ; « père » et « frère » ne prennent pas encore ces terminaisons.
5. Le « n » du duel qui tombe (« les deux portes de la maison ») n'est pas encore montré.
6. Les personnes s'accordent au pluriel ; les choses et les animaux au féminin singulier (« les livres sont neufs » : الْكُتُبُ جَدِيدَةٌ).
7. Compter jusqu'à 10 avec une règle simplifiée (noms masculins) ; le féminin est seulement montré ; l'argent se compte jusqu'à 2.
8. لَيْسَ est présenté comme « un verbe un peu spécial » ; dans la leçon le sujet vient d'abord, l'autre ordre est signalé comme juste.
9. La fréquence dans le Coran n'est affichée que si le mot du Corpus a le même sens ; sinon, racine seule. « Fenêtre », « miel » et « sel » sont écartés pour l'instant ; « marché » n'entre dans aucun exercice d'accord.
10. Plusieurs phrases trop proches de versets ont été remplacées (« ceci est un livre neuf », « ceci est de l'eau », « et ils sont joyeux ») ; le contrôle automatique repère maintenant aussi les paires pronom + mot.
