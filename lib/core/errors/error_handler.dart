import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import 'app_exceptions.dart';

abstract final class ErrorHandler {
  /// Initializes global error handling for Flutter framework errors
  /// and uncaught async errors.
  static void init() {
    FlutterError.onError = _handleFlutterError;
    PlatformDispatcher.instance.onError = _handlePlatformError;
  }

  static void _handleFlutterError(FlutterErrorDetails details) {
    // Log without sensitive data
    dev.log(
      'Flutter error: ${details.exceptionAsString()}',
      name: 'ErrorHandler',
      error: details.exception,
      stackTrace: details.stack,
    );

    if (kReleaseMode) {
      // In release mode, show a user-friendly error widget
      FlutterError.presentError(details);
    } else {
      // In debug mode, use the default handler for visibility
      FlutterError.dumpErrorToConsole(details, forceReport: true);
    }
  }

  static bool _handlePlatformError(Object error, StackTrace stack) {
    dev.log(
      'Uncaught error: $error',
      name: 'ErrorHandler',
      error: error,
      stackTrace: stack,
    );
    return true;
  }

  /// Returns a user-friendly message for known exception types.
  static String userMessage(Object error) {
    if (error is AppException) return error.message;
    return 'Something went wrong. Please try again.';
  }
}
