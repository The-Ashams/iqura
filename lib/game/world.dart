/// Le monde du jeu, lu dans la base de contenu (tools/build_content/world/).
library;

class Region {
  const Region({
    required this.id,
    required this.number,
    required this.name,
    required this.skill,
    required this.adversary,
    required this.mapImage,
  });

  final String id;
  final int number;
  final String name;
  final String skill;
  final String adversary;
  final String mapImage;
}

class Place {
  const Place({
    required this.id,
    required this.regionId,
    required this.number,
    required this.name,
    required this.description,
    required this.mapX,
    required this.mapY,
    required this.sceneImage,
    required this.groundY,
    required this.inVerticalSlice,
    required this.lessons,
    required this.links,
  });

  final String id;
  final String regionId;
  final int number;
  final String name;

  /// Rédigée par IA.
  final String description;

  /// Position sur la carte de la région (pixels d'une image 160 × 90).
  final int mapX;
  final int mapY;
  final String? sceneImage;

  /// Hauteur du sol dans la scène (pixels d'origine), où se tiennent les
  /// personnages.
  final int? groundY;

  /// Lieu construit pour la tranche verticale (jalon J1a).
  final bool inVerticalSlice;

  /// Numéros des leçons de l'étape jouées dans ce lieu.
  final List<int> lessons;
  final List<String> links;
}

class GameCharacter {
  const GameCharacter({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.role,
    required this.sprite,
    required this.places,
  });

  final String id;
  final String name;
  final String nameAr;
  final String role;
  final String? sprite;
  final List<String> places;
}

/// Fiche d'une lettre (description rédigée par IA).
class LetterCard {
  const LetterCard({
    required this.letter,
    required this.name,
    required this.nameAr,
    required this.joinsLeft,
    required this.zone,
    required this.pronunciation,
  });

  final String letter;
  final String name;
  final String nameAr;
  final bool joinsLeft;
  final String zone;
  final String pronunciation;
}

/// Syllabe ou mot vocalisé d'une leçon, avec sa translittération.
class ReadingItem {
  const ReadingItem({
    required this.arabic,
    required this.translit,
    required this.lessonOrdinal,
    this.word = false,
  });

  final String arabic;
  final String translit;
  final int lessonOrdinal;

  /// Mot (sinon syllabe).
  final bool word;
}

/// Verset lu dans la base vérifiée (texte Tanzil, traduction).
class VerseText {
  const VerseText({
    required this.surah,
    required this.ayah,
    required this.arabic,
    required this.translation,
  });

  final int surah;
  final int ayah;
  final String arabic;
  final String translation;
}

/// Un mot d'un verset (texte Tanzil vérifié).
class QuranToken {
  const QuranToken({required this.id, required this.text});

  /// « sourate:verset:mot ».
  final String id;
  final String text;
}
