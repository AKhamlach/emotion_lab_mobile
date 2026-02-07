import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class EmotionLabApp extends StatefulWidget {
  const EmotionLabApp({super.key});

  @override
  State<EmotionLabApp> createState() => _EmotionLabAppState();
}

class _EmotionLabAppState extends State<EmotionLabApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Emotion Lab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _appRouter.router,
    );
  }
}
