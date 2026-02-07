import 'package:flutter/material.dart';

/// Placeholder — full implementation in Phase 3.1
class MainShellScreen extends StatelessWidget {
  const MainShellScreen({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}
