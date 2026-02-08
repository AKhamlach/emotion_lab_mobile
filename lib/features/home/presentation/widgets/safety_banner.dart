import 'package:flutter/material.dart';

import '../../../../shared/widgets/cards/emergency_help_card.dart';

class SafetyBanner extends StatelessWidget {
  const SafetyBanner({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return EmergencyHelpCard(onTap: onTap);
  }
}
