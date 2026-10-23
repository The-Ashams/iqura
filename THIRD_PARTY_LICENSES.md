# Licences des composants tiers

IQURA est distribué sous licence **GPL-3.0** (voir `LICENSE`). Ce fichier
liste tout ce que l'application utilise qui n'a pas été écrit pour elle, avec
la licence et les points à surveiller.

Dernier audit : 20 octobre 2026 (phases 1 et 3).

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
| [flame](https://pub.dev/packages/flame) | 1.38.2 | MIT | flame-engine.org (vérifié) | 2 335 ♥, 146 k | Moteur 2D (scène de combat) | Ajouté le 23/10/2026 (jalon J1a). Dépendances : `ordered_set` (MIT, blue-fire.xyz), `vector_math`, `collection`, `meta`. |
| [audioplayers](https://pub.dev/packages/audioplayers) | 6.8.1 | MIT | blue-fire.xyz (vérifié, équipe de Flame) | 3 448 ♥, 1,5 M | Lecture des enregistrements des leçons | Ajouté le 23/10/2026. Implémentations officielles Android et Windows (`audioplayers_android`, `audioplayers_windows`, MIT). Tire `http` (BSD, dart.dev) et `synchronized` (MIT, tekartik.com) ; aucune lecture en ligne n'est utilisée par IQURA. |
| [url_launcher](https://pub.dev/packages/url_launcher) | 6.3.3 | BSD-3-Clause | flutter.dev (vérifié) | 8 188 ♥ | Ouvrir la messagerie pour « Signaler une erreur » | Ajouté le 23/10/2026. Sur Android, déclaration `SENDTO mailto` dans le manifeste ; aucune autre permission. |

Outils de développement (non embarqués) : `flutter_test` (SDK, BSD-3-Clause),
`flutter_lints` 6.0.0 (BSD-3-Clause, flutter.dev).

## Dépendances prévues pour les phases suivantes (pré-audit)

| Paquet | Licence | Éditeur | Remarques |
| --- | --- | --- | --- |
| [fsrs](https://pub.dev/packages/fsrs) 2.0.1 | MIT | ⚠️ **aucun éditeur vérifié** | Organisation officielle Open Spaced Repetition, mais peu utilisé (22 ♥, 13 k / 30 j) et dernière version en juin 2025. Phase 4 : relire le code avant adoption. |

## Outils de compilation (non embarqués)

| Outil | Licence | Remarques |
| --- | --- | --- |
| Android SDK, NDK, Gradle, plugin Android Gradle | Apache-2.0 (et conditions du SDK Android) | Téléchargés par `tools/setup_cloud.sh` et Gradle. |
| Actions GitHub `actions/checkout`, `actions/setup-java`, `actions/upload-artifact` | MIT | Actions officielles de GitHub. Aucune action tierce. |
| Python 3 (`sqlite3`, `unittest`) | PSF | Génération de la base de contenu. |

## Données intégrées

Fichiers copiés tels quels dans `tools/build_content/sources/` (copie verbatim
autorisée par leurs auteurs), vérifiés par SHA-256 (`sources.json`) et cités
dans l'application (Paramètres › Sources des données).

| Donnée | Source | Licence / conditions | Points de vigilance |
| --- | --- | --- | --- |
| Texte coranique Uthmani (version 1.1) et texte sans voyelles (recherche) | [Tanzil Project](https://tanzil.net) | CC BY 3.0 ; copie verbatim autorisée, **modification interdite** ; citer Tanzil avec un lien | Texte jamais modifié : empreinte SHA-256 vérifiée par les tests et à chaque démarrage. |
| Métadonnées (sourates, juzʾ, hizb, pages, prosternations) | Tanzil Project | CC BY | — |
| Traduction française de Muhammad Hamidullah (`fr.hamidullah`) | Diffusée par [Tanzil](https://tanzil.net/trans/) | **Usage non commercial uniquement** (conditions Tanzil) ; aucune licence publiée par l'éditeur | ⚠️ Tanzil n'indique pas l'édition exacte : la révision du Complexe Roi Fahd (2000) n'est pas confirmée. IQURA est gratuit, donc dans les conditions ; toute utilisation commerciale exigerait l'accord de l'éditeur. Traduction remplaçable. |
| Morphologie : segments, racines, lemmes, traits (version 0.4) | [Quranic Arabic Corpus](https://corpus.quran.com), Kais Dukes, Université de Leeds | GNU GPL ; copie verbatim autorisée, modification interdite ; citer la source avec un lien | Vérifié dans la notice du fichier (relevée par l'utilisateur le 21/10/2026) : conditions d'utilisation de la notice du fichier : usage autorisé « dans tout site web ou application », à condition de citer clairement la source avec un lien vers corpus.quran.com et de reproduire la notice dans les œuvres dérivées. Respecté : fichier conservé tel quel, source et lien dans Paramètres › Sources des données, notice reproduite mot pour mot sur le même écran. La FAQ du site parle d'un usage « de recherche », mais la notice du fichier, plus précise, autorise les applications. Téléchargé le 20/10/2026 avec l'adresse e-mail du porteur du projet (exigée par le site). |
| Table de translittération Buckwalter étendue | [Quranic Arabic Corpus](https://corpus.quran.com/java/buckwalter.jsp) | Documentation publique du Corpus | Recopiée dans `tools/build_content/buckwalter.py` pour convertir lemmes et racines en écriture arabe. |

## Polices

| Police | Version | Auteurs | Licence | Provenance | Vérifications |
| --- | --- | --- | --- | --- | --- |
| Amiri (Regular, Bold) | 1.002 | Khaled Hosny, Sebastian Kosch (projet [aliftype/amiri](https://github.com/aliftype/amiri)) | SIL Open Font License 1.1 (`assets/fonts/OFL-Amiri.txt`) | Dépôt officiel Google Fonts `google/fonts`, `ofl/amiri` (source : commit 04d40ee de aliftype/amiri) | Police de référence pour le naskh, maintenue depuis 2010, distribuée par Google Fonts. Couvre les 69 caractères du texte Tanzil (contrôlé). |
| Amiri Quran | 1.003 | Mêmes auteurs | SIL OFL 1.1 (`assets/fonts/OFL-AmiriQuran.txt`) | `google/fonts`, `ofl/amiriquran` (commit 480bb74) | Conçue pour le texte coranique. Couvre les 69 caractères du texte Tanzil (contrôlé). |
| Pixelify Sans (variable, 400 à 700) | — | Stefie Justprince ([eifetx/Pixelify-Sans](https://github.com/eifetx/Pixelify-Sans)) | SIL OFL 1.1 (`assets/fonts/OFL-PixelifySans.txt`) | `google/fonts`, `ofl/pixelifysans` (source : commit 39df74a), téléchargée le 22/10/2026, SHA-256 `9ba86cd0…89e8a5` | Textes du jeu (style pixel). Couvre le français ; **ne couvre pas** les lettres pointées de la translittération (ḥ, ṯ, ǧ, ṣ…) ni ʿ ʾ : Amiri les complète (police de secours). |

L'OFL autorise l'intégration dans une application GPL. Les noms de police réservés (« Amiri ») ne sont pas modifiés, puisque les fichiers sont copiés tels quels. Les licences sont affichées dans Paramètres › Licences des bibliothèques.

## Synthèse vocale (outil de génération, non embarqué)

Les enregistrements des leçons sont produits une fois par
`tools/build_audio/generate.py`, puis livrés comme fichiers audio. Le modèle
n'est pas intégré à l'application. Chaque enregistrement est marqué
« synthèse » dans la base de contenu et dans l'application.

| Composant | Version | Licence | Remarques |
| --- | --- | --- | --- |
| [Chatterbox Multilingual](https://huggingface.co/ResembleAI/chatterbox) (Resemble AI) : poids du modèle | révision HF `5bb1f6e` | MIT (fiche du modèle) | ⚠️ Données d'entraînement non publiées (« 0,5 M heures de données nettoyées ») ; la voix par défaut provient, selon la fiche, de « données librement disponibles sur Internet ». Les sorties ne font l'objet d'aucune restriction dans la licence. |
| [chatterbox-tts](https://pypi.org/project/chatterbox-tts/) | 0.1.7 | MIT | Code d'inférence. |
| [resemble-perth](https://pypi.org/project/resemble-perth/) | 1.0.1 | MIT | Filigrane inaudible ajouté par Chatterbox à chaque fichier : les enregistrements restent identifiables comme synthèse. |
| PyTorch, NumPy, soundfile | — | BSD | Dépendances de l'outil de génération. |

**Fichiers livrés** : 44 enregistrements MP3 des leçons 0 à 3 dans
`assets/audio/lecons/` (308 Ko), générés le 21/10/2026, listés avec leur
empreinte SHA-256 dans `tools/build_audio/clips.json`. Conversion MP3 par
ffmpeg (outil non embarqué ; le format MP3 n'est plus soumis à brevet).

Lecture dans l'application : `audioplayers` (ci-dessus), avec la mention
« synthèse » à côté de chaque bouton d'écoute.

## Graphismes

Pixel art **créé pour le projet** (aucun pack externe à ce jour) : décrit en
rectangles dans `tools/build_art/art/*.json`, converti en PNG par
`tools/build_art/build_art.py` (bibliothèque standard Python). Les scènes
« porte de la bibliothèque » et « Faille des Oubliés » et leurs personnages
reprennent les maquettes du 22/10/2026, réalisées pour IQURA. Licence : celle
du projet (GPL-3.0). Aucun personnage, monstre ni élément d'un jeu existant.

## Inventaire complet des paquets Dart

Généré le 23 octobre 2026 depuis `pubspec.lock` (`python3 tools/third_party/list_dart_packages.py`). Certains paquets ne servent
que sur d'autres plateformes (iOS, macOS, Linux, Web) et ne sont pas
embarqués dans l'APK ni dans l'exécutable Windows, par exemple `dbus`
(MPL-2.0, Linux uniquement) ou `file_picker_web`.

| Paquet | Version | Type | Licence (pub.dev) | Éditeur vérifié |
| --- | --- | --- | --- | --- |
| android_file_picker | 2.1.1 | transitive | mit | victorcarreras.dev |
| archive | 4.5.2 | direct main | mit | taosengine.com |
| args | 2.7.0 | transitive | bsd-3-clause | dart.dev |
| async | 2.13.1 | transitive | bsd-3-clause | dart.dev |
| audioplayers | 6.8.1 | direct main | mit | blue-fire.xyz |
| audioplayers_android | 5.3.0 | transitive | mit | blue-fire.xyz |
| audioplayers_darwin | 6.5.0 | transitive | mit | blue-fire.xyz |
| audioplayers_linux | 4.3.0 | transitive | mit | blue-fire.xyz |
| audioplayers_platform_interface | 7.2.0 | transitive | mit | blue-fire.xyz |
| audioplayers_web | 5.3.0 | transitive | mit | blue-fire.xyz |
| audioplayers_windows | 4.4.1 | transitive | mit | blue-fire.xyz |
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
| flame | 1.38.2 | direct main | mit | flame-engine.org |
| flutter | 0.0.0 | direct main | SDK Flutter (BSD-3-Clause) | flutter.dev |
| flutter_lints | 6.0.0 | direct dev | bsd-3-clause | flutter.dev |
| flutter_localizations | 0.0.0 | direct main | SDK Flutter (BSD-3-Clause) | flutter.dev |
| flutter_riverpod | 3.4.3 | direct main | mit | dash-overflow.net |
| flutter_test | 0.0.0 | direct dev | SDK Flutter (BSD-3-Clause) | flutter.dev |
| flutter_web_plugins | 0.0.0 | transitive | SDK Flutter (BSD-3-Clause) | flutter.dev |
| glob | 2.2.0 | transitive | bsd-3-clause | tools.dart.dev |
| hooks | 2.2.0 | transitive | bsd-3-clause | dart.dev |
| http | 1.6.0 | transitive | bsd-3-clause | dart.dev |
| http_parser | 4.1.2 | transitive | bsd-3-clause | dart.dev |
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
| ordered_set | 8.0.1 | transitive | mit | blue-fire.xyz |
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
| synchronized | 3.5.0 | transitive | mit | tekartik.com |
| term_glyph | 1.2.2 | transitive | bsd-3-clause | tools.dart.dev |
| test_api | 0.7.12 | transitive | bsd-3-clause | tools.dart.dev |
| typed_data | 1.4.0 | transitive | bsd-3-clause | dart.dev |
| url_launcher | 6.3.3 | direct main | bsd-3-clause | flutter.dev |
| url_launcher_android | 6.3.33 | transitive | bsd-3-clause | flutter.dev |
| url_launcher_ios | 6.4.2 | transitive | bsd-3-clause | flutter.dev |
| url_launcher_linux | 3.2.3 | transitive | bsd-3-clause | flutter.dev |
| url_launcher_macos | 3.2.6 | transitive | bsd-3-clause | flutter.dev |
| url_launcher_platform_interface | 2.3.2 | transitive | bsd-3-clause | flutter.dev |
| url_launcher_web | 2.4.3 | transitive | bsd-3-clause | flutter.dev |
| url_launcher_windows | 3.1.6 | transitive | bsd-3-clause | flutter.dev |
| uuid | 4.6.0 | direct main | mit | yuli.dev |
| vector_math | 2.4.0 | transitive | bsd-3-clause | flutter.dev |
| vm_service | 15.4.0 | transitive | bsd-3-clause | tools.dart.dev |
| web | 1.1.1 | transitive | bsd-3-clause | dart.dev |
| win32 | 6.4.0 | transitive | bsd-3-clause | halildurmus.dev |
| windows_file_picker | 2.0.1 | transitive | mit | victorcarreras.dev |
| xdg_directories | 1.1.0 | transitive | bsd-3-clause | flutter.dev |
| xml | 7.1.0 | transitive | mit | lukas-renggli.ch |
| yaml | 3.1.4 | transitive | mit | tools.dart.dev |
