import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/widgets/door_scaffold.dart';

/// Is [error] een ongeldige link (`404` onbekend, `410` verlopen/ingetrokken)?
bool isInvalidLinkError(Object error) =>
    error is NotFoundException ||
    (error is ApiException && error.statusCode == 410);

/// De tekst voor een fout op een publiek scherm. De server levert bij
/// 403/404/410/422 een Nederlandse zin; die gaat voor.
String joinErrorText(AppLocalizations l10n, Object error) {
  return switch (error) {
    NetworkException() => l10n.joinLoadError,
    ThrottledException() => l10n.joinThrottled,
    ServerException() => l10n.joinGenericError,
    ApiException(:final message?) when message.isNotEmpty => message,
    _ => l10n.joinGenericError,
  };
}

/// Ondertitel onder een [DoorHeadline].
class DoorSubtitle extends StatelessWidget {
  const DoorSubtitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, height: 1.35, color: DoorColors.ink),
    );
  }
}

/// Kleine grijze uitleg onderaan een deur-scherm.
class DoorFootnote extends StatelessWidget {
  const DoorFootnote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 13,
        height: 1.4,
        color: Color(0xB30C120D),
      ),
    );
  }
}

/// Tekstknop in inkt (de `DoorLink` van de PWA): terug, overslaan, …
class DoorLinkButton extends StatelessWidget {
  const DoorLinkButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: DoorColors.ink,
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
        ),
      ),
      child: Text(label),
    );
  }
}

/// Wit vlak met inktrand (de `DoorPanel` van de PWA), optioneel tikbaar.
class DoorPanel extends StatelessWidget {
  const DoorPanel({required this.child, this.onTap, super.key});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final panel = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: DoorColors.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DoorColors.ink, width: 2),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: DoorColors.ink,
        ),
        child: child,
      ),
    );
    if (onTap == null) return panel;
    return Semantics(
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: panel,
      ),
    );
  }
}

/// Een publiek scherm in de deur-stijl met een sluitknop linksboven (naar de
/// app; uitgelogd brengt de router je dan naar het loginscherm).
class JoinDoor extends StatelessWidget {
  const JoinDoor({required this.child, this.onClose, super.key});

  final Widget child;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DoorScaffold(
      leading: onClose == null
          ? null
          : IconButton(
              key: const Key('join-close'),
              tooltip: l10n.joinClose,
              color: DoorColors.ink,
              icon: const Icon(Icons.close_rounded),
              onPressed: onClose,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [child],
      ),
    );
  }
}

/// Laden: een spinner in inkt.
class JoinLoading extends StatelessWidget {
  const JoinLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(child: CircularProgressIndicator(color: DoorColors.ink)),
    );
  }
}

/// Een kop + uitleg + knoppen; voor "link werkt niet meer" en laadfouten.
class JoinMessage extends StatelessWidget {
  const JoinMessage({
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.secondaryLabel,
    this.onSecondary,
    super.key,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DoorHeadline(title),
        const SizedBox(height: 12),
        DoorSubtitle(message),
        if (actionLabel != null) ...[
          const SizedBox(height: 28),
          DoorButton(label: actionLabel!, onPressed: onAction),
        ],
        if (secondaryLabel != null) ...[
          const SizedBox(height: 8),
          DoorLinkButton(label: secondaryLabel!, onPressed: onSecondary),
        ],
      ],
    );
  }
}
