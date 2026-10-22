# État du projet IQURA

Mis à jour le 22 octobre 2026. **À lire en début de session, à mettre à jour à chaque étape importante et avant la fin d'une session.**
Référence : `docs/CAHIER_DES_CHARGES.md` (**v3 du 22 octobre 2026**, référence unique). Règles : `CLAUDE.md`. Anciennes versions : `docs/archive/`.

Branche de travail : `claude/laughing-ramanujan-axcixk` (repartie de `main` après la fusion de la pull request n° 3).

**Jalon en cours : J1a, tranche verticale** (cahier §13). **Étape 1 terminée le 22/10/2026** (liste A1 à A7 acceptée, points du §3 tranchés). **Étape en cours : 2, noms des lieux et personnages de la région 1 et découpage en lieux, à proposer à l'utilisateur.**

## 1. Ce qui existe déjà (gardé, cahier §0.1 point 4)

| Élément | Preuve |
| --- | --- |
| **Socle J0** : app Windows et Android, profil, base utilisateur, sauvegardes, export, import, fusion, CI | Pull request n° 1 fusionnée ; transfert PC → Android validé par l'utilisateur |
| **Pipeline coranique** : Tanzil Uthmani 1.1 vérifié par SHA-256 (tests et démarrage), Quranic Arabic Corpus 0.4 aligné sur 100 % des 6 236 versets, traduction Hamidullah via Tanzil, notice du Corpus affichée dans l'application | Tests Python et Dart |
| **Polices** Amiri et Amiri Quran (OFL) | Couverture du texte Tanzil contrôlée par test |
| **Translittération** Arabica et simplifiée, masquable | Tests du moteur |
| **Outil audio** Chatterbox avec coupure automatique et contrôle de durée selon la longueur des voyelles | Coupure validée à l'écoute ; 8 tests |
| **Audio des leçons 0 à 3** : 44 MP3, dont تَ, يَ et نَابَ corrigés et validés à l'écoute le 22/10/2026 | Empreintes SHA-256 vérifiées par le pipeline |
| **Leçons 0 à 3** (ancien format, fiches de cours) | Tests Python ; à refaire au format mini-donjon (voir §2) |
| **Maquettes** « Histoire — La porte de la bibliothèque » et « Expédition — Combat contre l'Oubli » | Base de référence du style (cahier §8.1) ; [page des maquettes](https://claude.ai/artifact/9CuoZib7eH4rfxH7eBNLFd), hors dépôt |

Derniers résultats : tests locaux du 22/10/2026 (Python : contenu et audio OK ; Flutter : 83 tests OK ; `flutter analyze` sans remarque) ; compilations GitHub Actions réussies (tests, APK, Windows) sur `80f8d48`, dernier commit de la pull request n° 3.

## 2. Ce qui doit changer pour suivre le cahier v3 (cahier §0.1 point 5)

### A. Modifications fortes ou suppressions — **acceptées par l'utilisateur le 22/10/2026**

| N° | Existant | Changement prévu | Raison (cahier) |
| --- | --- | --- | --- |
| A1 | Leçons 0 à 3 : fiches de cours (sections de texte, puis exercices) | Réécriture complète au format mini-donjon : écrans d'entrée, échauffement, découverte, éléments, règle, entraînement, salle d'étude, mini-boss, fin. Nouveau format de données, nouveaux contrôles du pipeline, nouveaux tests. Les textes utiles sont repris. | §6, §5.5 point 9 |
| A2 | Leçon 0 : texte suivi de questions à **2 choix**, contrôle final à **75 %** | Énigme de déchiffrage ; questions à 3 ou 4 choix ; 80 % | §5.5 points 5, 6, 8 |
| A3 | Contenu des leçons 0 à 3 | Corrections : alif (retirer « ou à une voyelle »), نَجَا (« il s'est sauvé, il a échappé »), ح (le « ahh » soufflé), décomposition de la leçon 0 de droite à gauche, nouveaux mots بَاب, بَنَات, نَبَات, ثَابِت, تَاج, جَنَاح, حَبِيب | §5.5 points 1 à 4 et 7 |
| A4 | 44 enregistrements audio | Ceux des éléments retirés sont supprimés ; ceux des nouveaux mots sont générés puis soumis à l'écoute | Conséquence de A1 à A3 |
| A5 | Coquille actuelle : 5 espaces « Pas encore disponible » (Carte, Cité, Grimoire, Sanctuaire, Paramètres) | Remplacée par la coquille du jeu en pixel art (carte à étapes, dialogue, combat, Cité, Grimoire, Sanctuaire). Profil, Paramètres, sauvegarde, export et import sont gardés. | §8, §13.1 point 3 |
| A6 | Page d'aperçu des leçons (`preview_lessons.py`) | Adaptée au nouveau format, ou remplacée par le jeu lui-même | Conséquence de A1 |
| A7 | `docs/HISTOIRE.md` : *La Bibliothèque oubliée*, Madīnat al-Ḥikma, l'archiviste, l'apprenti copiste | Gardé comme proposition ; noms définitifs et lieux de la région 1 (« Le Désert des Lettres ») à revalider à l'étape 2 | §8.2, §13.1 point 2 |

### B. Ajouts (rien n'est supprimé)

| N° | Ajout | Cahier |
| --- | --- | --- |
| B1 | Base utilisateur, nouvelle version avec migration : cartes et états FSRS (passif et actif séparés), progression par écran, ressources, équipement, enchantement, séries, enregistrements (sur l'appareil, exclus de l'export par défaut) ; export, import et fusion étendus | §4, §6.3, §8.6, §10 |
| B2 | Base de contenu : fréquences des lemmes (calculées à partir du Corpus), lieux, dialogues, monstres, objets ; liste d'environ 100 mots de la région 1 (choisis par script, soumise à l'utilisateur) | §5.5, §12 |
| B3 | Paquets Flutter, chacun audité avant ajout : Flame, FSRS, lecture audio, enregistrement micro | §3.3, §12 |
| B4 | Réglages : vitesse audio, nouveaux mots par jour (5 à 30, 15 par défaut), chronomètre, mode « apprentissage seul » | §4, §6.2, §8.3 |
| B5 | Bouton « Signaler une erreur » sur chaque fiche | §3.2 |
| B6 | Graphismes pixel art : packs libres audités ou créations | §8.1 |

## 3. Points ambigus ou contradictoires (à poser un par un, cahier §0.2)

1. **Mention des contenus IA** : le v3 écrit « rédigé par IA — non vérifié » (§3.2, §10, §11, §14, §15), alors que l'utilisateur a demandé « rédigé par IA » le 21/10/2026. **Tranché le 22/10/2026 : « rédigé par IA »** ; cahier corrigé.
2. **Licence du Quranic Arabic Corpus** : le v3 indique « licence GNU, non commercial » et un mail à envoyer ; la notice du fichier (relevée par l'utilisateur le 21/10/2026) dit GNU GPL et autorise l'usage « dans tout site web ou application », sans mention « non commercial ». **Tranché le 22/10/2026 : cahier corrigé d'après la notice, mail facultatif.**
3. **Schèmes** : le v3 les attribue au Corpus (« via QUL si besoin ») ; la version 0.4 n'en contient pas. QUL est à examiner (contenu et licence) avant de s'y fier. **Tranché le 22/10/2026 : QUL sera examiné avant la région 3 ; rien n'est inventé d'ici là.**
4. **Traduction** : « révision du Complexe Roi Fahd (2000) » n'est pas confirmée par Tanzil. **Tranché le 22/10/2026 : « édition non précisée » ; cahier corrigé.**
5. **Police du Mushaf** : le v3 cite KFGQPC Hafs ; IQURA utilise Amiri Quran ; la licence de KFGQPC est à auditer avant tout changement. **Tranché le 22/10/2026 : Amiri Quran pour J1a ; audit de KFGQPC avant la leçon 14.**
6. **« Signaler une erreur »** dans une application hors ligne : par quel moyen (fichier exporté, mail préparé, autre) ? **Tranché le 22/10/2026 : mail prérempli envoyé par le joueur depuis sa messagerie ; adresse : contact@edelwa.com.**
7. **Sort de racine** : « débloqué en région 3 ; familles simples avant » (§8.5) : la commande existe-t-elle dès la région 1 sous une forme simple ? **Tranché le 22/10/2026 : forme simple dès la leçon 7, forme complète en région 3.**

Changements du v3 notés sans question, car le v3 fait foi : option IA décidée « à partir de J4, désactivée par défaut » (l'utilisateur avait dit « décider à J4 » le 21/10) ; noms de l'Histoire à revalider en J1a.

## 4. Prochaine étape

1. Fait : accord sur la liste du §2 et réponses aux points du §3.
2. En cours, cahier §13.1 point 2 : proposer les noms des lieux et personnages de la région 1 et son découpage en 8 à 12 lieux.

## 5. Problèmes connus

- **Audio dans l'application** : les MP3 sont livrés, mais aucun lecteur n'est encore intégré (paquet à auditer).
- **Chatterbox** : données d'entraînement et origine de la voix par défaut non publiées ; une voyelle brève isolée peut être allongée, et un mot tronqué n'est pas détecté automatiquement : l'écoute de l'utilisateur reste nécessaire.
- **Synthèse non reproductible en CI** (modèle trop lourd) : les MP3 sont versionnés et la CI vérifie leur empreinte.
- **Réseau de la session cloud** : `download-r2.pytorch.org`, `github.com` et quelques sites de référence bloqués.
- **Compilation Windows** : uniquement via GitHub Actions.
- **Maven Central** refuse parfois les téléchargements (erreur 429) pendant la compilation de l'APK ; une nouvelle compilation passe.
