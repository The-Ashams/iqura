import 'package:flutter_test/flutter_test.dart';
import 'package:iqura/engines/sync/hlc.dart';

void main() {
  group('Hlc', () {
    test('texte et analyse sont réciproques', () {
      const h = Hlc(1729450000123, 0x2a, 'appareil-A');
      expect(h.toString(), '001729450000123:002a:appareil-A');
      expect(Hlc.parse(h.toString()), h);
    });

    test("l'ordre du texte suit l'ordre des dates", () {
      final values = [
        const Hlc(5, 0, 'b'),
        const Hlc(10, 0, 'a'),
        const Hlc(10, 1, 'a'),
        const Hlc(10, 1, 'b'),
        const Hlc(100000, 0, 'a'),
      ];
      for (var i = 0; i < values.length - 1; i++) {
        expect(values[i].compareTo(values[i + 1]), lessThan(0));
        expect(
          values[i].toString().compareTo(values[i + 1].toString()),
          lessThan(0),
        );
      }
    });

    test('refuse un texte invalide', () {
      expect(() => Hlc.parse('12:00:x'), throwsFormatException);
      expect(Hlc.isValid('001729450000123:002a:x'), isTrue);
      expect(Hlc.isValid('001729450000123:002A:x'), isFalse);
    });
  });

  group('HlcClock', () {
    test('strictement croissante même si l’horloge murale recule', () {
      var wall = 1000;
      final clock = HlcClock('A', now: () => wall);
      final a = clock.tick();
      final b = clock.tick();
      wall = 900; // recul de l'heure système
      final c = clock.tick();
      wall = 2000;
      final d = clock.tick();
      expect(a.compareTo(b), lessThan(0));
      expect(b.compareTo(c), lessThan(0));
      expect(c.compareTo(d), lessThan(0));
      expect(d, const Hlc(2000, 0, 'A'));
    });

    test('après réception, la date locale suivante est plus récente', () {
      final clock = HlcClock('A', now: () => 1000);
      const remote = Hlc(5000, 7, 'B');
      clock.receive(remote);
      expect(clock.tick().compareTo(remote), greaterThan(0));
    });

    test('compteur saturé : passage à la milliseconde suivante', () {
      final clock = HlcClock(
        'A',
        last: const Hlc(1000, Hlc.maxCounter, 'A'),
        now: () => 1000,
      );
      expect(clock.tick(), const Hlc(1001, 0, 'A'));
    });
  });
}
