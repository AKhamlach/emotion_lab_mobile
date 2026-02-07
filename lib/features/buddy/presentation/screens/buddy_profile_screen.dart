import 'package:flutter/material.dart';

/// Placeholder — full implementation in Phase 5.4
class BuddyProfileScreen extends StatelessWidget {
  const BuddyProfileScreen({required this.buddyId, super.key});

  final String buddyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Buddy Profile: $buddyId')),
    );
  }
}
