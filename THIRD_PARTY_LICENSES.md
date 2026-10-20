# Licences des composants tiers

IQURA est distribué sous licence **GPL-3.0** (voir `LICENSE`). Ce fichier
liste tout ce que l'application utilise qui n'a pas été écrit pour elle, avec
la licence et les points à surveiller.

Dernier audit : 20 octobre 2026 (phase 1).

## Méthode d'audit

Pour chaque dépendance directe : licence, éditeur vérifié sur pub.dev,
popularité (mentions « j'aime », téléchargements sur 30 jours), score pub.dev,
date de dernière version, dépôt source. L'inventaire complet (dépendances
transitives comprises) est produit par
`python3 tools/third_party/list_dart_packages.py`.

Toutes les licences rencontrées (MIT, BSD-3-Clause, Apache-2.0, MPL-2.0) sont
compatibles avec la GPL-3.0.

## Dépendances directes de l'application (phase 1)

| Paquet | Version | Licence | Éditeur | Popularité (30 j) | Rôle | Remarques |
| --- | --- | --- | --- | --- | --- | --- |
| Flutter SDK (+ `flutter_localizations`) | 3.47.7 | BSD-3-Clause | Google (flutter.dev) | — | Interface, Android, Windows | Le moteur inclut des composants tiers (Skia, HarfBuzz, ICU…) ; leurs licences sont affichées dans l'application (Paramètres › Licences des bibliothèques). |
| [sqlite3](https://pub.dev/packages/sqlite3) | 3.7.1 | MIT | simonbinder.eu (vérifié) | 465 ♥, 3,0 M | Accès SQLite | Embarque SQLite (domaine public). Les binaires SQLite sont téléchargés à la compilation depuis les releases GitHub du paquet et vérifiés par SHA-256 par le paquet lui-même. |
| [path_provider](https://pub.dev/packages/path_provider) | 2.1.6 | BSD-3-Clause | flutter.dev (vérifié) | 5 571 ♥, 9,4 M | Dossier de l'application | Paquet officiel Flutter. |
| [path](https://pub.dev/packages/path) | 1.9.1 | BSD-3-Clause | dart.dev (vérifié) | 1 744 ♥, 11,7 M | Chemins de fichiers | Paquet officiel Dart. |
| [archive](https://pub.dev/packages/archive) | 4.5.2 | MIT | loki3d.com (vérifié) | 904 ♥, 17,4 M | Lecture/écriture ZIP | La décompression est bornée par la taille déclarée de chaque fichier (protection contre les « zip bombs »), vérifié dans le code source 4.5.2. |
| [crypto](https://pub.dev/packages/crypto) | 3.0.7 | BSD-3-Clause | dart.dev (vérifié) | 1 892 ♥, 13,5 M | SHA-256 | Paquet officiel Dart. |
| [uuid](https://pub.dev/packages/uuid) | 4.6.0 | MIT | yuli.dev (vérifié) | 2 735 ♥, 16,9 M | UUID v7 | — |
| [file_picker](https://pub.dev/packages/file_picker) | 13.1.0 | MIT | victorcarreras.dev (vérifié) | 4 953 ♥, 4,5 M | Choisir où enregistrer / quel fichier importer | ⚠️ **Changement de mainteneur** : le dépôt est passé de `miguelpruivo/flutter_file_picker` à `vicajilau/flutter_file_picker`, et le paquet est désormais découpé en sous-paquets (`android_file_picker`, `windows_file_picker`…) du même éditeur. Aucune permission Android ajoutée (vérifié dans l'APK). À surveiller. |
| [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) | 3.4.3 | MIT | dash-overflow.net (vérifié) | 2 915 ♥, 3,8 M | Gestion d'état | Score pub.dev 140/160 (points de documentation), sans incidence. |

Outils de développement (non embarqués) : `flutter_test` (SDK, BSD-3-Clause),
`flutter_lints` 6.0.0 (BSD-3-Clause, flutter.dev).

## Dépendances prévues pour les phases suivantes (pré-audit)

| Paquet | Licence | Éditeur | Remarques |
| --- | --- | --- | --- |
| [flame](https://pub.dev/packages/flame) 1.38.2 | MIT | flame-engine.org (vérifié) | 2 334 ♥, 142 k téléchargements / 30 j. Moteur 2D (phase 6). |
| [fsrs](https://pub.dev/packages/fsrs) 2.0.1 | MIT | ⚠️ **aucun éditeur vérifié** | Organisation officielle Open Spaced Repetition, mais peu utilisé (22 ♥, 13 k / 30 j) et dernière version en juin 2025. Phase 4 : relire le code avant adoption. |

## Outils de compilation (non embarqués)

| Outil | Licence | Remarques |
| --- | --- | --- |
| Android SDK, NDK, Gradle, plugin Android Gradle | Apache-2.0 (et conditions du SDK Android) | Téléchargés par `tools/setup_cloud.sh` et Gradle. |
| Actions GitHub `actions/checkout`, `actions/setup-java`, `actions/upload-artifact` | MIT | Actions officielles de GitHub. Aucune action tierce. |
| Python 3 (`sqlite3`, `unittest`) | PSF | Génération de la base de contenu. |

## Données et ressources

Aucune donnée coranique, linguistique, audio, police ou graphique n'est
encore intégrée (phase 1). Les sources prévues et leurs doutes de licence
sont décrits dans `docs/ARCHITECTURE.md` §3.

## Inventaire complet des paquets Dart

Généré le 20 octobre 2026 depuis `pubspec.lock`. Certains paquets ne servent
que sur d'autres plateformes (iOS, macOS, Linux, Web) et ne sont pas
embarqués dans l'APK ni dans l'exécutable Windows, par exemple `dbus`
(MPL-2.0, Linux uniquement) ou `file_picker_web`.

| Paquet | Version | Type | Licence (pub.dev) | Éditeur vérifié |
| --- | --- | --- | --- | --- |
| android_file_picker | 2.1.1 | transitive | mit | victorcarreras.dev |
| archive | 4.5.2 | direct main | mit | loki3d.com |
| args | 2.7.0 | transitive | bsd-3-clause | dart.dev |
| async | 2.13.1 | transitive | bsd-3-clause | dart.dev |
| boolean_selector | 2.1.2 | transitive | bsd-3-clause | tools.dart.dev |
| characters | 1.4.1 | transitive | bsd-3-clause | dart.dev |
| clock | 1.1.3 | transitive | apache-2.0 | tools.dart.dev |
| code_assets | 2.1.0 | transitive | bsd-3-clause | dart.dev |
| collection | 1.19.1 | transitive | bsd-3-clause | dart.dev |
| cross_file | 0.3.5+5 | transitive | bsd-3-clause | flutter.dev |
| crypto | 3.0.7 | direct main | bsd-3-clause | dart.dev |
| dbus | 0.8.0 | transitive | mpl-2.0 | canonical.com |
| fake_async | 1.3.3 | transitive | apache-2.0 | dart.dev |
| ffi | 2.2.0 | transitive | bsd-3-clause | dart.dev |
| ffi_leak_tracker | 0.1.2 | transitive | bsd-3-clause | halildurmus.dev |
| file | 7.0.1 | transitive | bsd-3-clause | tools.dart.dev |
| file_picker | 13.1.0 | direct main | mit | victorcarreras.dev |
| file_picker_darwin | 2.3.2 | transitive | mit | victorcarreras.dev |
| file_picker_linux | 2.0.2 | transitive | mit | victorcarreras.dev |
| file_picker_platform_interface | 4.2.0 | transitive | mit | victorcarreras.dev |
| file_picker_web | 4.2.0 | transitive | mit | victorcarreras.dev |
| fixnum | 1.1.1 | transitive | bsd-3-clause | dart.dev |
| flutter | 0.0.0 | direct main | SDK Flutter (BSD-3-Clause) | flutter.dev |
| flutter_lints | 6.0.0 | direct dev | bsd-3-clause | flutter.dev |
| flutter_localizations | 0.0.0 | direct main | SDK Flutter (BSD-3-Clause) | flutter.dev |
| flutter_riverpod | 3.4.3 | direct main | mit | dash-overflow.net |
| flutter_test | 0.0.0 | direct dev | SDK Flutter (BSD-3-Clause) | flutter.dev |
| flutter_web_plugins | 0.0.0 | transitive | SDK Flutter (BSD-3-Clause) | flutter.dev |
| glob | 2.2.0 | transitive | bsd-3-clause | tools.dart.dev |
| hooks | 2.2.0 | transitive | bsd-3-clause | dart.dev |
| intl | 0.20.3 | transitive | bsd-3-clause | dart.dev |
| jni | 1.1.0 | transitive | bsd-3-clause | dart.dev |
| jni_flutter | 1.0.4+1 | transitive | bsd-3-clause | dart.dev |
| jni_util | 1.0.0 | transitive | bsd-3-clause | dart.dev |
| leak_tracker | 11.0.2 | transitive | bsd-3-clause | tools.dart.dev |
| leak_tracker_flutter_testing | 3.0.10 | transitive | bsd-3-clause | flutter.dev |
| leak_tracker_testing | 3.0.2 | transitive | bsd-3-clause | tools.dart.dev |
| lints | 6.1.0 | transitive | bsd-3-clause | dart.dev |
| listen | 1.0.1 | transitive | bsd-3-clause | flutter.dev |
| logging | 1.3.0 | transitive | bsd-3-clause | dart.dev |
| matcher | 0.12.20 | transitive | bsd-3-clause | dart.dev |
| material_color_utilities | 0.13.0 | transitive | apache-2.0 | material.io |
| meta | 1.19.0 | transitive | bsd-3-clause | dart.dev |
| native_toolchain_c | 0.19.5 | transitive | bsd-3-clause | labs.dart.dev |
| objective_c | 9.6.2 | transitive | bsd-3-clause | dart.dev |
| package_config | 3.0.0 | transitive | bsd-3-clause | tools.dart.dev |
| path | 1.9.1 | direct main | bsd-3-clause | dart.dev |
| path_provider | 2.1.6 | direct main | bsd-3-clause | flutter.dev |
| path_provider_android | 2.3.1 | transitive | bsd-3-clause | flutter.dev |
| path_provider_foundation | 2.6.0 | transitive | bsd-3-clause | flutter.dev |
| path_provider_linux | 2.2.2 | transitive | bsd-3-clause | flutter.dev |
| path_provider_platform_interface | 2.1.3 | transitive | bsd-3-clause | flutter.dev |
| path_provider_windows | 2.3.0 | transitive | bsd-3-clause | flutter.dev |
| petitparser | 7.1.0 | transitive | mit | lukas-renggli.ch |
| platform | 3.2.0 | transitive | bsd-3-clause | dart.dev |
| plugin_platform_interface | 2.1.8 | transitive | bsd-3-clause | flutter.dev |
| posix | 6.5.2 | transitive | mit | onepub.dev |
| process | 5.0.6 | transitive | bsd-3-clause | tools.dart.dev |
| pub_semver | 2.2.1 | transitive | bsd-3-clause | tools.dart.dev |
| record_use | 1.1.1 | transitive | bsd-3-clause | dart.dev |
| riverpod | 3.4.3 | transitive | mit | dash-overflow.net |
| sky_engine | 0.0.0 | transitive | SDK Flutter (BSD-3-Clause) | flutter.dev |
| source_span | 1.10.2 | transitive | bsd-3-clause | tools.dart.dev |
| sqlite3 | 3.7.1 | direct main | mit | simonbinder.eu |
| stack_trace | 1.12.2 | transitive | bsd-3-clause | tools.dart.dev |
| state_notifier | 1.0.0 | transitive | mit | dash-overflow.net |
| stream_channel | 2.1.4 | transitive | bsd-3-clause | tools.dart.dev |
| string_scanner | 1.4.1 | transitive | bsd-3-clause | tools.dart.dev |
| term_glyph | 1.2.2 | transitive | bsd-3-clause | tools.dart.dev |
| test_api | 0.7.12 | transitive | bsd-3-clause | tools.dart.dev |
| typed_data | 1.4.0 | transitive | bsd-3-clause | dart.dev |
| uuid | 4.6.0 | direct main | mit | yuli.dev |
| vector_math | 2.4.0 | transitive | bsd-3-clause | flutter.dev |
| vm_service | 15.4.0 | transitive | bsd-3-clause | tools.dart.dev |
| web | 1.1.1 | transitive | bsd-3-clause | dart.dev |
| win32 | 6.4.0 | transitive | bsd-3-clause | halildurmus.dev |
| windows_file_picker | 2.0.1 | transitive | mit | victorcarreras.dev |
| xdg_directories | 1.1.0 | transitive | bsd-3-clause | flutter.dev |
| xml | 7.1.0 | transitive | mit | lukas-renggli.ch |
| yaml | 3.1.4 | transitive | mit | tools.dart.dev |
