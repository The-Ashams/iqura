/// Licences des ressources embarquées (hors paquets Dart, que Flutter
/// enregistre lui-même), affichées dans « Licences des bibliothèques ».
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void registerBundledLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(const [
      'Police Amiri',
    ], await rootBundle.loadString('assets/fonts/OFL-Amiri.txt'));
    yield LicenseEntryWithLineBreaks(const [
      'Police Amiri Quran',
    ], await rootBundle.loadString('assets/fonts/OFL-AmiriQuran.txt'));
    yield LicenseEntryWithLineBreaks(const [
      'Police DotGothic16',
    ], await rootBundle.loadString('assets/fonts/OFL-DotGothic16.txt'));
  });
}
