import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../l10n/generated/app_localizations.dart';
import '../session/models/team_membership.dart';
import 'nav_items.dart';

/// Het label van [item] in het menu.
String navLabel(AppLocalizations l10n, NavItem item) => switch (item) {
  NavItem.onboarding => l10n.navOnboarding,
  NavItem.agenda => l10n.navAgenda,
  NavItem.players => l10n.navPlayers,
  NavItem.team => l10n.navTeam,
  NavItem.duties => l10n.navDuties,
  NavItem.stats => l10n.navStats,
  NavItem.hallOfFame => l10n.navHallOfFame,
  NavItem.poule => l10n.navPoule,
  NavItem.fines => l10n.navFines,
  NavItem.savings => l10n.navSavings,
  NavItem.wheel => l10n.navWheel,
  NavItem.messages => l10n.navMessages,
  NavItem.agreements => l10n.navAgreements,
  NavItem.settings => l10n.navSettings,
  NavItem.feedback => l10n.navFeedback,
  NavItem.profile => l10n.navProfile,
};

/// Het (kortere) label van [item] in de tabbalk.
String tabLabel(AppLocalizations l10n, NavItem item) =>
    item == NavItem.stats ? l10n.tabStats : navLabel(l10n, item);

/// Menu-icoon (Phosphor, duotone; fill als actief) — als `navItems.ts`.
IconData navIcon(NavItem item, {required bool active}) => active
    ? switch (item) {
        NavItem.onboarding => PhosphorIconsFill.rocket,
        NavItem.agenda => PhosphorIconsFill.soccerBall,
        NavItem.players || NavItem.team => PhosphorIconsFill.users,
        NavItem.duties => PhosphorIconsFill.flag,
        NavItem.stats => PhosphorIconsFill.chartBar,
        NavItem.hallOfFame => PhosphorIconsFill.ranking,
        NavItem.poule => PhosphorIconsFill.listNumbers,
        NavItem.fines => PhosphorIconsFill.coins,
        NavItem.savings => PhosphorIconsFill.piggyBank,
        NavItem.wheel => PhosphorIconsFill.confetti,
        NavItem.messages => PhosphorIconsFill.megaphone,
        NavItem.agreements => PhosphorIconsFill.scroll,
        NavItem.settings => PhosphorIconsFill.gear,
        NavItem.feedback => PhosphorIconsFill.chatCircleDots,
        NavItem.profile => PhosphorIconsFill.user,
      }
    : switch (item) {
        NavItem.onboarding => PhosphorIconsDuotone.rocket,
        NavItem.agenda => PhosphorIconsDuotone.soccerBall,
        NavItem.players || NavItem.team => PhosphorIconsDuotone.users,
        NavItem.duties => PhosphorIconsDuotone.flag,
        NavItem.stats => PhosphorIconsDuotone.chartBar,
        NavItem.hallOfFame => PhosphorIconsDuotone.ranking,
        NavItem.poule => PhosphorIconsDuotone.listNumbers,
        NavItem.fines => PhosphorIconsDuotone.coins,
        NavItem.savings => PhosphorIconsDuotone.piggyBank,
        NavItem.wheel => PhosphorIconsDuotone.confetti,
        NavItem.messages => PhosphorIconsDuotone.megaphone,
        NavItem.agreements => PhosphorIconsDuotone.scroll,
        NavItem.settings => PhosphorIconsDuotone.gear,
        NavItem.feedback => PhosphorIconsDuotone.chatCircleDots,
        NavItem.profile => PhosphorIconsDuotone.user,
      };

/// Tab-icoon, als `BottomNav.tsx`: agenda = kalender, stats = de bal van de
/// sport (`sport.field_variant`), ranking, poule. De Mij-tab heeft geen icoon
/// maar een avatar (zie de tabbalk).
IconData tabIcon(TeamMembership m, NavItem item, {required bool active}) {
  if (item == NavItem.agenda) {
    return active
        ? PhosphorIconsFill.calendarBlank
        : PhosphorIconsDuotone.calendarBlank;
  }
  if (item == NavItem.stats) {
    return switch (m.sport['field_variant']) {
      'hockey' =>
        active ? PhosphorIconsFill.hockey : PhosphorIconsDuotone.hockey,
      'volleyball' =>
        active ? PhosphorIconsFill.volleyball : PhosphorIconsDuotone.volleyball,
      // Phosphor kent geen korfbal; de basketbal is de dichtste buur.
      'korfball' =>
        active ? PhosphorIconsFill.basketball : PhosphorIconsDuotone.basketball,
      _ =>
        active ? PhosphorIconsFill.soccerBall : PhosphorIconsDuotone.soccerBall,
    };
  }
  return navIcon(item, active: active);
}

/// Initialen (max. twee) voor een avatar zonder foto.
String initials(String name) {
  final parts = name.split(' ').where((p) => p.isNotEmpty).take(2);
  final result = parts.map((p) => p[0]).join().toUpperCase();
  return result.isEmpty ? '?' : result;
}
