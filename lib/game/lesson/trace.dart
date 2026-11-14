/// Tracé guidé (cahier v3 §6.4) : la lettre est décrite par des traits,
/// chacun une suite de points dans un carré de 100 × 100. La vérification
/// est tolérante et ne sanctionne jamais : elle dit seulement si le geste a
/// suivi les points dans l'ordre.
library;

import 'dart:math';
import 'dart:ui';

/// Traits d'une lettre (points de 0 à 100).
typedef Strokes = List<List<Offset>>;

/// Vrai si chaque trait de l'utilisateur ([user], mêmes coordonnées) passe
/// près de chaque point du trait guide correspondant, dans l'ordre. Un trait
/// guide d'un seul point (point diacritique) demande seulement de toucher
/// près de ce point. [tolerance] : distance admise, en unités du carré.
bool traceMatches(Strokes guide, Strokes user, {double tolerance = 16}) {
  if (user.length != guide.length) return false;
  for (var s = 0; s < guide.length; s++) {
    final g = guide[s];
    final u = user[s];
    if (u.isEmpty) return false;
    var at = 0;
    for (final p in g) {
      // Cherche, à partir de la position atteinte, un point du geste assez
      // proche de ce point guide : l'ordre est ainsi respecté.
      var found = false;
      while (at < u.length) {
        if ((u[at] - p).distance <= tolerance) {
          found = true;
          break;
        }
        at++;
      }
      if (!found) return false;
    }
  }
  return true;
}

/// Ramène des points de l'écran (carré de côté [size]) au carré 100 × 100.
List<Offset> toUnit(List<Offset> points, double size) => [
  for (final p in points)
    Offset(
      max(0, min(100, p.dx * 100 / size)),
      max(0, min(100, p.dy * 100 / size)),
    ),
];
