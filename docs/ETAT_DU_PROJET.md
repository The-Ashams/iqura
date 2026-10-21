# État du projet IQURA

Mis à jour le 21 octobre 2026, en fin de session. **À lire en début de session, à tenir à jour en fin de session.**
Référence : `docs/CAHIER_DES_CHARGES.md` (décisions : §12 et §13). Règles : `CLAUDE.md`.

Branche de travail : `claude/laughing-ramanujan-axcixk`. Pull request ouverte : [The-Ashams/iqura#2](https://github.com/The-Ashams/iqura/pull/2).

## 1. Terminé et testé

| Élément | Preuve |
| --- | --- |
| **J0 — Socle** : app Windows et Android, profil, base utilisateur, sauvegardes, export, import, fusion | Pull request n° 1 fusionnée. Transfert PC → Android validé par l'utilisateur. |
| **Pipeline coranique** : Tanzil Uthmani 1.1 (SHA-256 `351c2dcb…e189e` vérifié par les tests et à chaque démarrage), Quranic Arabic Corpus 0.4 aligné sur 100 % des 6 236 versets, traduction Hamidullah via Tanzil | Tests Python (`tools/build_content`) et Dart (`test/data`). |
| **Polices** Amiri et Amiri Quran (OFL), couverture des 69 caractères du texte Tanzil | Contrôlée par test. |
| **Translittération** Arabica et simplifiée, masquable | Tests du moteur ; les translittérations des leçons sont comparées au moteur. |
| **Adaptation au cahier v2** : navigation (Carte du monde, Cité, Grimoire, Sanctuaire, Paramètres), étape « Déchiffrer », animations désactivables | Tests d'interface. |
| **Leçons 0 à 3** de l'étape 1, sous forme de données contrôlées par le pipeline | Tests Python. **Contenu non validé par l'utilisateur** (voir §3). |
| **Décision n° 1 (audio)** : Chatterbox Multilingual ; outil `tools/build_audio/` (génération, coupure des sons parasites, livraison MP3) | Coupure validée à l'écoute par l'utilisateur sur 17 échantillons. Tests de la coupure. |
| **Audio des leçons 0 à 3** : 44 enregistrements (9 noms de lettres, 21 syllabes, 14 mots), MP3 mono 64 kbit/s, 308 Ko, tous obtenus au premier essai ; table `audio_clip` remplie (fichier, origine, synthèse = 1) | Le pipeline vérifie l'empreinte SHA-256 de chaque fichier et refuse un texte différent ou un enregistrement orphelin (tests). |

Tests locaux à la fin de la session (21/10/2026) :
- `python3 -m unittest discover -s tools/build_content` : 27 tests OK ;
- `python -m unittest discover -s tools/build_audio` : 6 tests OK ;
- `dart format lib test` : aucun changement ; `flutter analyze` : aucun problème ;
- `flutter test` : 83 tests OK.

Compilations GitHub Actions (tests, APK Android, exécutable Windows) : dernière compilation entièrement réussie sur `5d8b203` ([run 39668690267](https://github.com/The-Ashams/iqura/actions/runs/39668690267)). Pour les commits suivants, voir la pull request n° 2.

## 2. En cours, et où je me suis arrêté

- **Audio dans l'application** : les fichiers MP3 sont livrés (`assets/audio/lecons/`) et référencés par la table `audio_clip` de la base de contenu, avec leur origine et l'indication « synthèse ». **Aucun lecteur audio n'est encore intégré à l'application**, et aucun bouton « écouter » n'existe. Prochaine action : choisir et auditer un paquet Flutter de lecture audio (Android et Windows, hors ligne), puis l'écran de leçon.
- **Enregistrements des leçons non écoutés** : l'utilisateur a validé la coupure sur 17 textes de test, pas encore les 44 enregistrements des leçons. Aucun n'est marqué `"a_ecouter": true` dans `tools/build_audio/clips.json` (ce marqueur signale un enregistrement sans durée plausible après 5 essais).
- **Leçons 4 à 14 et boss de l'étape 1** : non commencées ; elles attendent la validation des leçons 0 à 3.

Pour régénérer l'audio : voir `CLAUDE.md`, section « Commandes ». L'environnement Python de synthèse n'est pas dans le dépôt (le conteneur de session est éphémère) : il faut le réinstaller, et le modèle (plusieurs Go) se retélécharge depuis `huggingface.co` et `us.aws.cdn.hf.co`.

## 3. Décisions en attente de l'utilisateur

1. **Validation des leçons 0 à 3** (aperçu : `python3 tools/build_content/preview_lessons.py SORTIE.html --etape 1 --jusqua 3`). Questions posées et sans réponse :
   - le tableau de translittération Arabica ;
   - le style simplifié ;
   - la place de ā / ī dans les leçons.
2. **Écoute des 44 enregistrements des leçons** (page d'écoute à produire en début de session suivante si l'utilisateur le souhaite).
3. **Décisions ouvertes du cahier §12**, à poser une à la fois, avec une recommandation :
   - n° 2 : univers et style graphique (prochaine question) ;
   - n° 3 : nom et scénario de l'Histoire ;
   - n° 4 : seuil « sourate prête à étudier » ;
   - n° 5 : récitateur par défaut ;
   - n° 6 : conversation avec une IA ;
   - n° 7 : mail aux auteurs du Quranic Arabic Corpus (à envoyer par l'utilisateur).
4. **Fusion de la pull request n° 2** dans `main`.

## 4. Prochaine étape prévue

1. Poser la décision ouverte n° 2 (univers et style graphique), avec une recommandation.
2. Obtenir la validation des leçons 0 à 3, puis rédiger les leçons 4 à 14 et le boss.
3. Intégrer la lecture audio dans l'application (paquet audité), avec la mention « synthèse ».
4. Suite de l'ordre de travail J1 (`CLAUDE.md`) : coquille du jeu, chapitre 1, Expédition, Sanctuaire (Al-Fātiḥa).

## 5. Problèmes connus

- **Schèmes** : absents du Quranic Arabic Corpus 0.4 ; aucune source ouverte fiable trouvée ; rien n'est inventé.
- **Traduction Hamidullah** : édition exacte non indiquée par Tanzil ; usage non commercial uniquement.
- **Quranic Arabic Corpus** : la FAQ parle d'un « usage de recherche » ; confirmation des auteurs souhaitable (décision n° 7).
- **Police du Mushaf** : le cahier cite KFGQPC Hafs ; IQURA utilise Amiri Quran (licence KFGQPC à auditer avant tout changement).
- **Chatterbox** : données d'entraînement et origine de la voix par défaut non publiées. Le modèle prononce parfois mal une voyelle longue isolée (بَا aussi court que بَ) : à juger à l'écoute.
- **Synthèse non reproductible en CI** : le modèle est trop lourd ; les MP3 sont donc versionnés, et la CI vérifie seulement leur empreinte.
- **Réseau de la session cloud** : `download-r2.pytorch.org` bloqué (PyTorch installé depuis PyPI) ; `github.com` et quelques sites de référence (Mendeley, Inalco, Brill) bloqués.
- **Compilation Windows** : uniquement via GitHub Actions (pas de Windows dans la session).
