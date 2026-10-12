import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/duties_repository.dart';
import '../data/models/duties_models.dart';

/// Het dienstenoverzicht van team [teamId] (trainer): laden, van type
/// wisselen, verversen en alle beheeracties. Schrijven is nooit
/// optimistisch: na elk gelukt verzoek wordt het getoonde type opnieuw
/// opgehaald (de server bepaalt volgorde, tellers en rotaties).
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm of
/// formulier hem kan tonen.
class DutiesController extends AsyncNotifier<DutiesOverview> {
  DutiesController(this.teamId);

  final int teamId;

  /// De slug van het gekozen type; `null` = het eerste type.
  String? _type;

  DutiesRepository get _repository => ref.read(dutiesRepositoryProvider);

  @override
  Future<DutiesOverview> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers overzicht.
    ref.watch(authControllerProvider);
    return ref.watch(dutiesRepositoryProvider).fetch(teamId, type: _type);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout.
  Future<Object?> refresh() async {
    if (state.value == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      _set(await _repository.fetch(teamId, type: _type));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Naar type [slug]. Lukt het laden niet, dan blijft het vorige type staan
  /// en komt de fout terug.
  Future<Object?> selectType(String slug) async {
    if (state.value?.type == slug) return null;
    final previous = _type;
    _type = slug;
    try {
      _set(await _repository.fetch(teamId, type: slug));
      return null;
    } on Object catch (error) {
      _type = previous;
      return error;
    }
  }

  void _set(DutiesOverview overview) {
    if (!ref.mounted) return;
    _type = overview.type.isEmpty ? _type : overview.type;
    state = AsyncData(overview);
  }

  int? get _dutyTypeId => state.value?.dutyTypeId;

  Future<Object?> createGroup(String name, List<String> memberKeys) {
    final typeId = _dutyTypeId;
    if (typeId == null) return Future.value(StateError('Geen type'));
    return _write(
      () => _repository.createGroup(
        teamId,
        dutyTypeId: typeId,
        name: name,
        memberKeys: memberKeys,
      ),
    );
  }

  Future<Object?> updateGroup(
    int groupId,
    String name,
    List<String> memberKeys,
  ) => _write(
    () => _repository.updateGroup(
      teamId,
      groupId,
      name: name,
      memberKeys: memberKeys,
    ),
  );

  Future<Object?> deleteGroup(int groupId) =>
      _write(() => _repository.deleteGroup(teamId, groupId));

  /// Groep [groupId] één plek omhoog ([delta] `-1`) of omlaag (`1`).
  Future<Object?> moveGroup(int groupId, int delta) {
    final groups = state.value?.groups ?? const <DutyGroup>[];
    final ids = [for (final g in groups) g.id];
    final from = ids.indexOf(groupId);
    final to = from + delta;
    if (from < 0 || to < 0 || to >= ids.length) return Future.value();
    ids
      ..removeAt(from)
      ..insert(to, groupId);
    return _write(() => _repository.reorderGroups(teamId, ids));
  }

  Future<Object?> storeAssignments(DutyAssignmentDraft draft) =>
      _write(() => _repository.storeAssignments(teamId, draft));

  /// Verdeelt een wedstrijddienst. Geeft `(fout, melding)` terug.
  Future<(Object?, String?)> autoAssign() async {
    final typeId = _dutyTypeId;
    if (typeId == null) return (StateError('Geen type'), null);
    String? message;
    final error = await _write(() async {
      message = await _repository.autoAssign(teamId, typeId);
    });
    return (error, message);
  }

  Future<Object?> updateAssignment(
    int assignmentId,
    Map<String, Object?> changes,
  ) =>
      _write(() => _repository.updateAssignment(teamId, assignmentId, changes));

  Future<Object?> toggleDone(int assignmentId) =>
      _write(() => _repository.toggleDone(teamId, assignmentId));

  Future<Object?> deleteAssignment(int assignmentId) =>
      _write(() => _repository.deleteAssignment(teamId, assignmentId));

  /// Voert [request] uit en haalt daarna het overzicht opnieuw op. Een fout
  /// bij dat verversen telt niet als mislukte actie.
  Future<Object?> _write(Future<void> Function() request) async {
    try {
      await request();
    } on Object catch (error) {
      return error;
    }
    await refresh();
    return null;
  }
}

/// Het dienstenoverzicht per team-id. Geen automatische retry: het scherm
/// toont een fout met "Opnieuw proberen".
final dutiesControllerProvider =
    AsyncNotifierProvider.family<DutiesController, DutiesOverview, int>(
      DutiesController.new,
      retry: (retryCount, error) => null,
    );
