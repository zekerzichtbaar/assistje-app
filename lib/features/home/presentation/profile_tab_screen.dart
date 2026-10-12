import 'package:flutter/widgets.dart';

import '../../profile/presentation/profile_screen.dart';

/// De Mij-tab. De router kent deze klasse; het echte scherm woont in
/// `lib/features/profile`.
class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) => const ProfileScreen();
}
