/// Schéma d'articulation d'une lettre (décision du 03/11/2026 : chaque son
/// difficile garde une description écrite précise et son schéma
/// d'articulation, en attendant la phase audio).
///
/// Coupe de profil simplifiée de la bouche et de la gorge, tournée vers la
/// gauche : lèvres, dents, gencive, palais, voile du palais, luette, gorge,
/// langue. Le point d'articulation suit la zone de la fiche de la lettre
/// (table `articulation_zone`) ; pour les lettres emphatiques, une flèche
/// montre l'arrière de la langue qui se relève.
library;

import 'package:flutter/material.dart';

import 'pixel.dart';

/// Lettres emphatiques : l'arrière de la langue se relève (fiches des
/// lettres, leçons 5 et 6).
const Set<String> emphaticLetters = {'ص', 'ض', 'ط', 'ظ'};

/// Point d'articulation de chaque zone, dans un repère de 200 × 160.
const Map<String, Offset> articulationPoints = {
  'levres': Offset(30, 80),
  'levre_dents': Offset(39, 85),
  'langue_bout_dents': Offset(45, 81),
  'langue_bout_incisives_inf': Offset(46, 90),
  'langue_bout_racine': Offset(50, 74),
  'langue_bord_avant': Offset(55, 72),
  'langue_bout_gencive': Offset(56, 68),
  'langue_milieu': Offset(90, 60),
  'langue_cotes': Offset(108, 64),
  'langue_fond_avant': Offset(124, 63),
  'langue_fond': Offset(140, 72),
  'gorge_haut': Offset(153, 92),
  'gorge_milieu': Offset(156, 112),
  'gorge_fond': Offset(151, 138),
  'cavite': Offset(95, 78),
};

/// Légende courte du point, sous le schéma.
const Map<String, String> articulationLabels = {
  'levres': 'les deux lèvres',
  'levre_dents': 'lèvre inférieure contre les incisives du haut',
  'langue_bout_dents': 'bout de la langue au bord des incisives du haut',
  'langue_bout_incisives_inf': 'bout de la langue près des incisives du bas',
  'langue_bout_racine': 'bout de la langue à la racine des incisives du haut',
  'langue_bord_avant': 'bord avant de la langue contre la gencive',
  'langue_bout_gencive': 'bout de la langue contre la gencive',
  'langue_milieu': 'milieu de la langue contre le palais',
  'langue_cotes': 'côté de la langue contre les molaires du haut',
  'langue_fond_avant': 'fond de la langue, un peu en avant du voile',
  'langue_fond': 'fond de la langue contre le voile du palais',
  'gorge_haut': 'haut de la gorge',
  'gorge_milieu': 'milieu de la gorge',
  'gorge_fond': 'fond de la gorge',
  'cavite': 'toute la cavité de la bouche et de la gorge',
};

class ArticulationDiagram extends StatelessWidget {
  const ArticulationDiagram({
    super.key,
    required this.zoneId,
    this.emphatic = false,
  });

  final String zoneId;
  final bool emphatic;

  @override
  Widget build(BuildContext context) {
    final label = articulationLabels[zoneId];
    return Semantics(
      label:
          'Schéma d\'articulation : ${label ?? zoneId}'
          '${emphatic ? ', arrière de la langue relevé' : ''}',
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: AspectRatio(
              aspectRatio: 200 / 160,
              child: CustomPaint(
                painter: _ArticulationPainter(
                  point: articulationPoints[zoneId],
                  cavity: zoneId == 'cavite',
                  emphatic: emphatic,
                  line: GameColors.text,
                  tongue: GameColors.bad.withValues(alpha: 0.55),
                  mark: GameColors.accent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '● ${label ?? zoneId}'
            '${emphatic ? '\n↑ arrière de la langue relevé (lettre emphatique)' : ''}',
            textAlign: TextAlign.center,
            style: TextStyle(color: GameColors.accent, fontSize: 14),
          ),
          Text(
            'Schéma simplifié, de profil (la bouche à gauche) · rédigé par IA',
            textAlign: TextAlign.center,
            style: TextStyle(color: GameColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ArticulationPainter extends CustomPainter {
  _ArticulationPainter({
    required this.point,
    required this.cavity,
    required this.emphatic,
    required this.line,
    required this.tongue,
    required this.mark,
  });

  final Offset? point;
  final bool cavity;
  final bool emphatic;
  final Color line;
  final Color tongue;
  final Color mark;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 200, size.height / 160);
    final stroke = Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Cavité de la bouche et de la gorge (voyelles longues).
    if (cavity) {
      final air = Path()
        ..moveTo(40, 82)
        ..quadraticBezierTo(90, 64, 140, 76)
        ..lineTo(156, 100)
        ..lineTo(156, 136)
        ..lineTo(146, 136)
        ..quadraticBezierTo(120, 92, 46, 88)
        ..close();
      canvas.drawPath(air, Paint()..color = mark.withValues(alpha: 0.35));
    }

    // Profil : front, nez, lèvres, menton.
    final face = Path()
      ..moveTo(36, 10)
      ..lineTo(22, 44)
      ..lineTo(28, 50)
      ..lineTo(30, 70)
      ..quadraticBezierTo(24, 76, 30, 80)
      ..quadraticBezierTo(24, 84, 30, 92)
      ..lineTo(34, 120)
      ..quadraticBezierTo(60, 132, 110, 128);
    canvas.drawPath(face, stroke);

    // Dents du haut et du bas.
    final teeth = Paint()..color = line;
    canvas.drawRect(const Rect.fromLTWH(40, 74, 4, 8), teeth);
    canvas.drawRect(const Rect.fromLTWH(40, 86, 4, 7), teeth);

    // Gencive, palais dur, voile du palais et luette.
    final palate = Path()
      ..moveTo(42, 74)
      ..quadraticBezierTo(48, 66, 56, 66)
      ..quadraticBezierTo(90, 52, 124, 60)
      ..quadraticBezierTo(138, 64, 146, 74)
      ..quadraticBezierTo(150, 82, 147, 86);
    canvas.drawPath(palate, stroke);

    // Paroi du fond de la gorge et larynx.
    canvas.drawLine(const Offset(150, 52), const Offset(162, 64), stroke);
    canvas.drawLine(const Offset(162, 64), const Offset(162, 150), stroke);
    canvas.drawLine(const Offset(140, 150), const Offset(146, 132), stroke);
    canvas.drawLine(const Offset(146, 132), const Offset(156, 138), stroke);

    // Langue : pointe, dos, racine.
    final t = Path()
      ..moveTo(46, 94)
      ..quadraticBezierTo(46, 88, 54, 87)
      ..quadraticBezierTo(96, 76, 132, 84)
      ..quadraticBezierTo(150, 94, 148, 126)
      ..lineTo(132, 128)
      ..quadraticBezierTo(90, 112, 50, 102)
      ..close();
    canvas.drawPath(t, Paint()..color = tongue);
    canvas.drawPath(t, stroke..strokeWidth = 1.5);

    // Emphatiques : l'arrière de la langue se relève.
    if (emphatic) {
      final arrow = Paint()
        ..color = mark
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(const Offset(130, 100), const Offset(136, 80), arrow);
      canvas.drawLine(const Offset(136, 80), const Offset(130, 86), arrow);
      canvas.drawLine(const Offset(136, 80), const Offset(139, 87), arrow);
    }

    // Point d'articulation.
    final p = point;
    if (p != null && !cavity) {
      canvas.drawCircle(p, 6, Paint()..color = mark.withValues(alpha: 0.35));
      canvas.drawCircle(p, 3.5, Paint()..color = mark);
    }
  }

  @override
  bool shouldRepaint(_ArticulationPainter old) =>
      old.point != point ||
      old.cavity != cavity ||
      old.emphatic != emphatic ||
      old.line != line ||
      old.mark != mark;
}
