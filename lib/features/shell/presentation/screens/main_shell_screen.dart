import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../widgets/bottom_nav_bar.dart';

class MainShellScreen extends StatelessWidget {
  const MainShellScreen({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    RouteNames.homePath,
    RouteNames.chatPath,
    RouteNames.buddyPath,
    RouteNames.settingsPath,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i])) return i;
    }
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    context.go(_tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}
