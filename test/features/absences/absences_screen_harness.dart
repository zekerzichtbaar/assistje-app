import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';

const absencesProfileRoute = 'GET /teams/3/profile';

/// Start ingelogd (team 3 met [features]) en opent [path] boven de agenda.
/// [screenKey] is de key van het scherm.
Future<(ProviderContainer, FakeHttpAdapter)> openAbsencesScreen(
  WidgetTester tester, {
  required String path,
  required String screenKey,
  required Map<String, bool> features,
  required void Function(FakeHttpAdapter http) setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [ApiFixtures.membership(features: features)],
    setup: setup,
  );
  unawaited(container.read(routerProvider).push(path));
  await pumpUntilFound(tester, find.byKey(ValueKey(screenKey)));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
