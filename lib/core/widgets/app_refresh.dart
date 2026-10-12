import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Pull-to-refresh met het native gevoel per platform.
///
/// - iOS/macOS: [CupertinoSliverRefreshControl] bovenaan een bouncende
///   [CustomScrollView].
/// - Android en de rest: [RefreshIndicator] in de teamkleur.
///
/// Geef de inhoud als [slivers]; de scrollview is altijd scrollbaar zodat
/// verversen ook werkt als de lijst kort of leeg is.
class AppRefresh extends StatelessWidget {
  const AppRefresh({
    super.key,
    required this.onRefresh,
    required this.slivers,
    this.controller,
    this.padding,
  });

  final Future<void> Function() onRefresh;
  final List<Widget> slivers;
  final ScrollController? controller;

  /// Padding rond alle slivers (bijv. ruimte voor de zwevende tabbar).
  final EdgeInsets? padding;

  List<Widget> get _content => padding == null
      ? slivers
      : [
          SliverPadding(
            padding: padding!,
            sliver: SliverMainAxisGroup(slivers: slivers),
          ),
        ];

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final cupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (cupertino) {
      return CustomScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: onRefresh),
          ..._content,
        ],
      );
    }

    final t = AssistjeTokens.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: t.primary,
      backgroundColor: t.surface,
      child: CustomScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: _content,
      ),
    );
  }
}
