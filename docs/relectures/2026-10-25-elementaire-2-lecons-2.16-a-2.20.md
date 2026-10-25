# Relecture : leçons 2.16 à 2.20 (Élémentaire 2), 1er passage

Agent : relecteur-arabe, 25/10/2026. Une relecture par leçon.

| Leçon | Verdict |
| --- | --- |
| 2.16 Le duel | À corriger (1 Important) |
| 2.17 Les pluriels réguliers | Bloqué (1 Bloquant, 1 Important) |
| 2.18 Les pluriels internes | À corriger (1 Important) |
| 2.19 Compter jusqu'à dix | À corriger (2 Importants) |

## Point bloquant (corrigé)

- **2.17, dialogue** : « وَهُمْ فَرِحُونَ » est une fin de verset (pronom + adjectif). Le contrôle automatique ne signalait que les paires de deux mots pleins ; il signale maintenant aussi les paires pronom ou démonstratif + mot plein (`vocab.quran_pair_warnings`, test mis à jour). La réplique devient « هَٰؤُلَاءِ خَبَّازُونَ مِنَ الْقَرْيَةِ. ». Le contrôle élargi a aussi trouvé « هَٰذَا مَاءٌ » (exemple de la fiche « eau », leçon 2.1) : remplacé par « الْمَاءُ فِي الْبَيْتِ. ».

## Points importants (tous corrigés)

1. **2.16, aperçu** : « يَدَاهُ », forme que le conseiller interdit, figurait dans la liste d'aperçu (jamais affichée). Comme l'aperçu compte ensuite comme « connu », une leçon future aurait pu l'écrire sans alerte. Il est retiré.
2. **2.17, lecture** : « هُمْ فَرِحُونَ. », proche de la même suite, devient « الْبَنَاتُ فَرِحَاتٌ. ».
3. **2.18, affichage** : la flèche → entre deux mots arabes risquait de s'afficher à l'envers (pluriel → singulier). Elle est remplacée par « كِتَابٌ, pluriel كُتُبٌ » et par des phrases.
4. **2.19, lemmes** : أَرْبَعَةٌ, سَبْعَةٌ et تِسْعَةٌ étaient reliés aux lemmes sans ة (أَرْبَع، سَبْع، تِسْع), qui sont d'autres lemmes du Corpus. Ils sont reliés à `>arobaEap`, `saboEap` et `tisoEap` (vérifiés par requête dans la base).
5. **2.19, règle** : « avec un nom masculin » pouvait tromper après 2.18 (الْكُتُبُ s'accorde au féminin). La règle dit maintenant « si le **singulier** est masculin (كِتَابٌ) ».

## Points mineurs (corrigés)

- **2.16**
  - La question de l'écran « À reconnaître » porte maintenant sur هَاتَانِ (féminin) / هَٰذَانِ (masculin).
  - Lecture : une chambre et une cuisine (on sait de quelle chambre on parle) ; « les deux portes » au lieu de « les deux murs ».
- **2.17**
  - Aperçu « خَبَّازُو » retiré (jamais affiché).
  - « Le pluriel **régulier** d'un sujet masculin… ».
  - Explication : « En arabe classique, تَاجِرٌ fait تُجَّارٌ ».
  - حَدَّادٌ et نَجَّارٌ restent sans forme féminine (métiers rarement féminins).
- **2.18**
  - « changent de forme à l'intérieur (voyelles, lettres ajoutées) ».
  - جِيرَانٌ : « le ن fait partie du mot, ce n'est pas le ن du duel ».
  - ضَيْفٌ = « invité » seulement (« hôte » est ambigu en français).
  - Doutes faibles levés par prudence : distracteur هَٰؤُلَاءِ remplacé par ذَٰلِكَ ; « هَٰؤُلَاءِ جِيرَانٌ » d'abord, pour s'éloigner de « هَٰؤُلَاءِ ضَيْفِي ».
- **2.19**
  - Exemple de اثْنَانِ : « Il y a **bien** deux lits ».
  - Doute (le nombre peut suivre le nom comme épithète) levé par prudence : les distracteurs « تُجَّارٌ خَمْسَةٌ »… sont remplacés par des formes au mauvais cas (« خَمْسَةُ تُجَّارٌ »).

## Doutes soumis au conseiller

- 2.16 : faut-il montrer en aperçu la chute du ن du duel dans une iḍāfa, avec un exemple sans يد ? En attendant : non montré.
