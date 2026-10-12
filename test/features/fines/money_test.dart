import 'package:assistje/features/fines/application/money.dart';
import 'package:flutter_test/flutter_test.dart';

/// Vervangt harde spaties zodat de verwachtingen leesbaar blijven.
String _plain(String s) => s.replaceAll(' ', ' ');

void main() {
  test('formatCents: euro, nl_NL', () {
    expect(_plain(formatCents(250)), '€ 2,50');
    expect(_plain(formatCents(375000)), '€ 3.750,00');
    expect(_plain(formatCents(0)), '€ 0,00');
  });

  test('formatSignedCents: plus of min ervoor', () {
    expect(_plain(formatSignedCents(4500)), '+ € 45,00');
    expect(_plain(formatSignedCents(-1250)), '− € 12,50');
  });

  test('centsToInput', () {
    expect(centsToInput(250), '2,50');
    expect(centsToInput(100), '1,00');
    expect(centsToInput(5), '0,05');
  });

  test('parseEuroToCents: zoals een Nederlander typt', () {
    expect(parseEuroToCents('2,50'), 250);
    expect(parseEuroToCents('2.50'), 250);
    expect(parseEuroToCents('2,5'), 250);
    expect(parseEuroToCents('3'), 300);
    expect(parseEuroToCents('€ 3'), 300);
    expect(parseEuroToCents('1.250,00'), 125000);
    expect(parseEuroToCents('1.250'), 125000);
    expect(parseEuroToCents('-12,50'), -1250);
    expect(parseEuroToCents(',50'), 50);
    expect(parseEuroToCents(''), isNull);
    expect(parseEuroToCents('abc'), isNull);
    expect(parseEuroToCents('2,505'), isNull);
  });
}
