import 'package:assistje/core/api/cache_for.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  late int fetches;
  late DateTime now;

  FutureProvider<int> counter(Duration staleAfter) =>
      FutureProvider.autoDispose<int>((ref) async {
        ref.cacheFor(const Duration(minutes: 5), staleAfter: staleAfter);
        return ++fetches;
      });

  setUp(() {
    fetches = 0;
    now = DateTime(2026, 11, 6, 12);
    cacheClock = () => now;
  });
  tearDown(() => cacheClock = DateTime.now);

  test('bewaart data na loslaten en ruimt na de termijn op', () async {
    final provider = counter(const Duration(hours: 1));
    final container = ProviderContainer();
    addTearDown(container.dispose);

    var sub = container.listen(provider, (_, _) {});
    await _settle();
    expect(sub.read().value, 1);
    sub.close();
    now = now.add(const Duration(minutes: 2));
    await _settle();

    // Terug binnen de termijn: zelfde data, geen nieuwe fetch.
    sub = container.listen(provider, (_, _) {});
    await _settle();
    expect(sub.read().value, 1);
    expect(fetches, 1);
    sub.close();
    await _settle();
    expect(container.exists(provider), isTrue);

    // Te lang weg: bij de volgende opruimronde weg.
    now = now.add(const Duration(minutes: 6));
    sweepExpiredCache();
    await _settle();
    expect(container.exists(provider), isFalse);
  });

  test(
    'verouderd: oude stand meteen zichtbaar, daarna stil ververst',
    () async {
      final provider = counter(Duration.zero);
      final container = ProviderContainer();
      addTearDown(container.dispose);

      var sub = container.listen(provider, (_, _) {});
      await _settle();
      sub.close();
      now = now.add(const Duration(seconds: 1));
      await _settle();

      sub = container.listen(provider, (_, _) {});
      expect(sub.read().value, 1);
      await _settle();
      container.read(provider);
      await _settle();
      expect(fetches, 2);
      expect(container.read(provider).value, 2);
      sub.close();
    },
  );
}
