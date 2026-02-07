import 'package:flutter/material.dart';

/// Placeholder — full implementation in Phase 5.3
class BuddyChatScreen extends StatelessWidget {
  const BuddyChatScreen({required this.buddyId, super.key});

  final String buddyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Buddy Chat: $buddyId')),
    );
  }
}
