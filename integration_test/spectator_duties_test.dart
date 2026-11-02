// e2e-rol: spectator
//
// Flow 7: een toeschouwer opent de Diensten-pagina vanuit Meer.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app.dart';
import 'support/waits.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('toeschouwer opent Diensten vanuit Meer', (tester) async {
    await startSignedIn(tester, role: 'spectator');
    await openFromMore(tester, 'menu-dutyOverview');

    final title = await waitFor(
      tester,
      find.byKey(const ValueKey('placeholder-title')),
    );
    expect(
      find.descendant(
        of: title,
        matching: find.text('Diensten'),
        matchRoot: true,
      ),
      findsOneWidget,
    );
  });
}
