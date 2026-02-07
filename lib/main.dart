import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/errors/error_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorHandler.init();
  runApp(const EmotionLabApp());
}
