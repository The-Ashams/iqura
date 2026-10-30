# IQURA

Application **gratuite et open source** (GPL-3.0) pour apprendre l'arabe
littéraire classique, la langue du Coran, sous la forme d'un RPG 2D. Elle
prépare à la compréhension du Coran sans afficher aucun verset. Interface en français.
Plateformes : Android et Windows.

> **État : région 1 « Le Désert des Lettres » construite (leçons 0 à 14 et
> examen).** Données linguistiques : Quranic Arabic Corpus (racines, lemmes,
> fréquences). Détail : `docs/ETAT_DU_PROJET.md`.

Référence du projet : [`docs/CAHIER_DES_CHARGES.md`](docs/CAHIER_DES_CHARGES.md) (v3). État : [`docs/ETAT_DU_PROJET.md`](docs/ETAT_DU_PROJET.md).
L'ancien dossier d'architecture est archivé dans `docs/archive/`.

## Télécharger

Chaque envoi sur GitHub compile l'application (onglet **Actions**, workflow
« Compilation ») :

- `iqura-android` : `app-release.apk` à installer sur Android 7.0 ou plus
  récent (autoriser l'installation d'applications inconnues) ;
- `iqura-windows` : dossier à décompresser, puis lancer `iqura.exe`
  (Windows 10 ou 11, 64 bits).

Ces versions de test ne sont pas signées avec une clé de publication :
l'APK est signé avec une clé de débogage et l'exécutable Windows n'est pas
signé (Windows SmartScreen peut afficher un avertissement).

## Sauvegarde et transfert entre appareils

Voir [`docs/SAUVEGARDE_ET_EXPORT.md`](docs/SAUVEGARDE_ET_EXPORT.md).

## Compiler soi-même

Prérequis : Flutter 3.47.7 (stable), Python 3, et selon la cible le SDK
Android (avec Java 17 ou 21) ou Visual Studio 2022 (ou plus récent) avec « Développement
Desktop en C++ » (Windows uniquement).

```sh
python3 tools/build_content/build_content.py   # génère assets/content/
flutter pub get
flutter test
flutter build apk --release        # Android
flutter build windows --release    # Windows (sous Windows)
```

Sous Linux (dont les sessions Claude Code cloud), `tools/setup_cloud.sh`
installe Flutter et le SDK Android.

## Organisation du code

| Dossier | Contenu |
| --- | --- |
| `lib/ui/` | Écrans et widgets, sans logique métier |
| `lib/features/` | Logique des modules (profil, réglages, sauvegardes, transfert) |
| `lib/engines/` | Moteurs indépendants et testés seuls (synchronisation : HLC, format d'archive, fusion) |
| `lib/data/` | Accès aux bases `iqura_user.db` et `iqura_content.db` |
| `lib/core/` | Informations de l'application, chemins, dépendances partagées |
| `tools/build_content/` | Génération de la base de contenu |
| `test/` | Tests automatiques |

## Licences

Code : GPL-3.0 (`LICENSE`). Composants tiers : `THIRD_PARTY_LICENSES.md`.
