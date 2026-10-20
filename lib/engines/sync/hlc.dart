/// Horloge logique hybride (HLC).
///
/// Sert à dater chaque modification d'une ligne pour la fusion entre
/// appareils : la modification la plus récente l'emporte, et deux appareils
/// ne produisent jamais deux dates identiques (l'identifiant d'appareil
/// départage).
///
/// Forme texte : `MMMMMMMMMMMMMMM:CCCC:appareil`
/// (millisecondes sur 15 chiffres, compteur hexadécimal sur 4 caractères).
/// Comparer deux textes HLC revient à comparer les dates.
class Hlc implements Comparable<Hlc> {
  const Hlc(this.millis, this.counter, this.node)
    : assert(millis >= 0),
      assert(counter >= 0 && counter <= maxCounter);

  static const int maxCounter = 0xFFFF;

  final int millis;
  final int counter;
  final String node;

  static final RegExp _pattern = RegExp(r'^(\d{15}):([0-9a-f]{4}):(.+)$');

  static Hlc parse(String text) {
    final m = _pattern.firstMatch(text);
    if (m == null) {
      throw FormatException('HLC invalide', text);
    }
    return Hlc(int.parse(m[1]!), int.parse(m[2]!, radix: 16), m[3]!);
  }

  static bool isValid(String text) => _pattern.hasMatch(text);

  @override
  int compareTo(Hlc other) {
    final byTime = millis.compareTo(other.millis);
    if (byTime != 0) return byTime;
    final byCounter = counter.compareTo(other.counter);
    if (byCounter != 0) return byCounter;
    return node.compareTo(other.node);
  }

  @override
  String toString() =>
      '${millis.toString().padLeft(15, '0')}:'
      '${counter.toRadixString(16).padLeft(4, '0')}:$node';

  @override
  bool operator ==(Object other) =>
      other is Hlc &&
      other.millis == millis &&
      other.counter == counter &&
      other.node == node;

  @override
  int get hashCode => Object.hash(millis, counter, node);
}

/// Horloge d'un appareil. Non persistante : l'appelant sauvegarde [last].
class HlcClock {
  HlcClock(this.node, {Hlc? last, int Function()? now})
    : _last = last ?? Hlc(0, 0, node),
      _now = now ?? (() => DateTime.now().millisecondsSinceEpoch);

  final String node;
  final int Function() _now;
  Hlc _last;

  Hlc get last => _last;

  /// Nouvelle date pour une modification locale.
  Hlc tick() {
    final wall = _now();
    if (wall > _last.millis) {
      _last = Hlc(wall, 0, node);
    } else {
      _last = _next(_last.millis, _last.counter);
    }
    return _last;
  }

  /// Avance l'horloge après avoir vu une date venue d'un autre appareil,
  /// pour que les prochaines modifications locales soient plus récentes.
  void receive(Hlc remote) {
    final wall = _now();
    final maxMillis = [
      wall,
      _last.millis,
      remote.millis,
    ].reduce((a, b) => a > b ? a : b);
    if (maxMillis == wall && wall > _last.millis && wall > remote.millis) {
      _last = Hlc(wall, 0, node);
    } else if (_last.millis == remote.millis && maxMillis == remote.millis) {
      final c = _last.counter > remote.counter ? _last.counter : remote.counter;
      _last = _next(maxMillis, c);
    } else if (maxMillis == _last.millis) {
      _last = _next(maxMillis, _last.counter);
    } else {
      _last = _next(maxMillis, remote.counter);
    }
  }

  Hlc _next(int millis, int counter) {
    if (counter >= Hlc.maxCounter) {
      // Compteur saturé : on avance d'une milliseconde.
      return Hlc(millis + 1, 0, node);
    }
    return Hlc(millis, counter + 1, node);
  }
}
