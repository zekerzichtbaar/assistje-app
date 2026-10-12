import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/agreements_controller.dart';
import '../data/models/agreements_models.dart';
import 'widgets/agreement_form_sheet.dart';
import 'widgets/agreements_ui.dart';
import 'widgets/intro_sheet.dart';

/// Teamafspraken (`Pages/Agreements/Index` in de PWA): introtekst, daarna
/// één kaart per categorie. De trainer (`can_manage`) voegt toe, wijzigt
/// (tik op een afspraak) en bewerkt de intro; anderen lezen alleen.
class AgreementsScreen extends ConsumerStatefulWidget {
  const AgreementsScreen({super.key});

  @override
  ConsumerState<AgreementsScreen> createState() => _AgreementsScreenState();
}

class _AgreementsScreenState extends ConsumerState<AgreementsScreen> {
  AgreementsController _controller(int teamId) =>
      ref.read(agreementsControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showAgreementsError(
        context,
        AppLocalizations.of(context).agreementsLoadError,
        error,
      );
    }
  }

  Future<void> _openForm(
    int teamId,
    AgreementsOverview overview, {
    Agreement? agreement,
  }) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller(teamId);
    var deleted = false;
    final done = await showAgreementFormSheet(
      context,
      agreement: agreement,
      categories: overview.categories,
      onSave: (draft) => agreement == null
          ? controller.createAgreement(draft)
          : controller.updateAgreement(agreement.id, draft),
      onDelete: agreement == null
          ? null
          : () async {
              final error = await controller.deleteAgreement(agreement.id);
              deleted = error == null;
              return error;
            },
    );
    if ((done ?? false) && mounted) {
      showAgreementsSuccess(
        context,
        deleted
            ? l10n.agreementsDeleted
            : agreement == null
            ? l10n.agreementsCreated
            : l10n.agreementsSaved,
      );
    }
  }

  Future<void> _editIntro(int teamId, AgreementsOverview overview) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final done = await showIntroSheet(
      context,
      intro: overview.introText,
      onSave: _controller(teamId).updateIntro,
    );
    if ((done ?? false) && mounted) {
      showAgreementsSuccess(context, l10n.agreementsSaved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(agreementsControllerProvider(teamId));
    final overview = async.value;

    final List<Widget> content;
    if (overview != null) {
      content = _content(teamId, overview);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('agreements-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.agreementsLoadError,
            description: agreementsErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('agreements-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('agreements-loading'),
            children: [
              Skeleton(height: 72, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 4),
            ],
          ),
        ),
      ];
    }

    final canManage = overview?.canManage ?? false;

    return Scaffold(
      key: const ValueKey('agreements-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        l10n.navAgreements,
                        // Zelfde key als de placeholder: de shell-tests lezen
                        // de schermtitel via `placeholder-title`.
                        key: const Key('placeholder-title'),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: t.ink,
                        ),
                      ),
                    ),
                  ),
                  if (canManage && overview != null)
                    IconButton.filled(
                      key: const ValueKey('agreements-add'),
                      tooltip: l10n.agreementsAdd,
                      style: IconButton.styleFrom(
                        backgroundColor: t.primary,
                        foregroundColor: t.primaryContrast,
                      ),
                      icon: const Icon(PhosphorIconsBold.plus, size: 18),
                      onPressed: () => _openForm(teamId, overview),
                    ),
                ],
              ),
            ),
          ),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(int teamId, AgreementsOverview overview) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final canManage = overview.canManage;
    final intro = overview.introText;

    return [
      if (intro != null)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: AppCard(
              key: const ValueKey('agreements-intro'),
              padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      intro,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: t.inkSoft,
                      ),
                    ),
                  ),
                  if (canManage)
                    IconButton(
                      key: const ValueKey('agreements-intro-edit'),
                      tooltip: l10n.agreementsIntroEdit,
                      visualDensity: VisualDensity.compact,
                      color: t.muted,
                      icon: const Icon(
                        PhosphorIconsBold.pencilSimple,
                        size: 16,
                      ),
                      onPressed: () => _editIntro(teamId, overview),
                    ),
                ],
              ),
            ),
          ),
        ),
      if (overview.isEmpty)
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('agreements-empty'),
            icon: PhosphorIconsDuotone.scroll,
            title: l10n.agreementsEmptyTitle,
            description: canManage
                ? l10n.agreementsEmptyManage
                : l10n.agreementsEmptyMember,
            action: canManage
                ? PrimaryButton(
                    key: const ValueKey('agreements-add-first'),
                    label: l10n.agreementsAddFirst,
                    onPressed: () => _openForm(teamId, overview),
                  )
                : null,
          ),
        )
      else
        SliverList.builder(
          itemCount: overview.groups.length,
          itemBuilder: (context, index) {
            final group = overview.groups[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _GroupCard(
                group: group,
                onEdit: canManage
                    ? (agreement) =>
                          _openForm(teamId, overview, agreement: agreement)
                    : null,
              ),
            );
          },
        ),
      if (canManage && intro == null && !overview.isEmpty)
        SliverToBoxAdapter(
          child: OutlinedButton(
            key: const ValueKey('agreements-intro-add'),
            style: OutlinedButton.styleFrom(
              foregroundColor: t.muted,
              side: BorderSide(color: t.line),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
              ),
            ),
            onPressed: () => _editIntro(teamId, overview),
            child: Text(l10n.agreementsIntroAdd),
          ),
        ),
    ];
  }
}

/// Eén categorie: kop met icoon, daaronder de afspraken.
class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group, this.onEdit});

  final AgreementGroup group;
  final void Function(Agreement agreement)? onEdit;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final onEdit = this.onEdit;
    return AppCard(
      key: ValueKey('agreements-group-${group.key}'),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Semantics(
              header: true,
              child: Row(
                children: [
                  Icon(
                    agreementCategoryIcon(group.key),
                    size: 14,
                    color: t.muted,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      group.label.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: t.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (final (index, item) in group.items.indexed) ...[
            if (index > 0)
              Divider(height: 1, indent: 16, endIndent: 16, color: t.lineSoft),
            InkWell(
              key: ValueKey('agreement-${item.id}'),
              onTap: onEdit == null ? null : () => onEdit(item),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: t.ink,
                            ),
                          ),
                          if (item.body case final body?
                              when body.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                body,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: t.muted,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (onEdit != null) ...[
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          PhosphorIconsBold.pencilSimple,
                          size: 16,
                          color: t.muted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
