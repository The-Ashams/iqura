# Rapport de relecture — salles de lecture de la région 1 (avenant n° 1) et leçon 14

Agent : relecteur-arabe, 24/10/2026, 1er passage. Fichiers relus : `tools/build_content/lessons/etape1/00` à `14` (écrans « lecture »), leçon 14 (objectif, entrée, règle « Le petit zéro », aperçu).

## Verdict : À corriger

Aucun point bloquant.

## Important (tous corrigés)

1. **Leçon 14, inscription** : « لَهُۥ بِهِۦ » se suit dans le Coran (vérifié sur le Quranic Arabic Corpus du dépôt). → Nouvel ordre ذَٰلِكَ · بِهِۦ · جَآءَ · لَهُۥ · قَالُوا۟. Le garde-fou contrôle maintenant les inscriptions sur **2 mots voisins** (`quran_guard.PAIR`), avec un test.
2. **Leçon 14, entrée** : « les copistes ajoutent de petits signes » → « Dans le Mushaf, l'écriture porte de petits signes particuliers qui aident à bien lire. Apprenons à les reconnaître sur des mots isolés. »
3. **Leçon 14, règles sans exemple** : exemples ajoutés (لَهُۥ, بِهِۦ ; جَآءَ ; قَالُوا۟), montrés sans son (`sans_son`), en police Amiri Quran.
4. **Leçon 2, بَنَات sur l'enseigne de l'herboriste** : mot retiré ; inscription نَبَات · تِين.

## Mineur (corrigés quand c'était simple)

- جَآءَ affiché en Amiri : la salle de la leçon 14 porte `"mushaf": true` (police Amiri Quran pour tous ses mots). Corrigé.
- Objectif de la leçon 14 : « signes de l'écriture du Mushaf (…), et savoir que des signes de pause existent ». Corrigé.
- « Le petit zéro » : « Dans le Mushaf le plus répandu (édition de Médine) ». Corrigé.
- Leçon 12 : « Un scribe s'est exercé à écrire les fins de mots. » Corrigé.
- Notion absente de l'inscription : leçon 3, حُجِبَ ajouté (ḍamma comptée) ; leçon 9, آبَار ajouté (آ compté). Corrigés. Leçon 7 : aucun mot avec ف parmi les mots lus ; non corrigé.
- Leçon 7 : « Sur sa table, un copiste a écrit des mots. » Corrigé.
- Réponses presque toujours « 1 » : leçon 3, ب dans حَبِيب (réponse 2). Le reste n'est pas changé, car les mots de la région 1 sont courts.

## Doutes (soumis à conseiller-arabe)

1. Autres paires de mots voisins de la leçon 14 : réglé par le contrôle automatique sur 2 mots (aucune paire du Coran).
2. Leçon 13 : « الشَّمْس الْقَمَر » côte à côte rappelle le texte, même si ce n'est pas une suite du Coran.
3. Règle des petits wāw et yāʾ : la formule « quand on enchaîne avec le mot suivant » ne vaut pas partout (دَاوُۥدَ).
4. Faut-il signaler le zéro allongé ۠ ?

## Vérifié sans problème

- Aucun verset ni sourate.
- Codage exact des mots de l'aperçu.
- Vocalisation des inscriptions.
- Indices des questions « repérer » et sens.
- Toutes les réponses aux questions « compter ».
- Prérequis.
- Mention « Exemple construit · rédigé par IA ».
