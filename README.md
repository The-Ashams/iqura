# IQURA

Application **gratuite et open source** (GPL-3.0) pour apprendre l'arabe et
l'arabe coranique, sous la forme d'un RPG 2D. Interface en français.
Plateformes : Android et Windows.

> **État : version 0.1.0 en développement.** Phase 1 (socle) terminée.
> Les données coraniques (texte Tanzil, traduction Hamidullah, morphologie du
> Quranic Arabic Corpus) sont intégrées et vérifiées. Le MVP se concentre sur
> l'apprentissage de l'arabe en cinq étapes (Lire, Grammaire, Verbes, Racines,
> Vocabulaire) ; le lecteur coranique complet viendra après. Les espaces
> Carte, Grimoire, Sanctuaire et Héros sont encore affichés comme « Pas encore
> disponible ».

Dossier d'architecture : [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

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
