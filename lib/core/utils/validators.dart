import '../constants/app_constants.dart';

abstract final class Validators {
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$',
  );

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.passwordMinLength) {
      return 'Password must be at least ${AppConstants.passwordMinLength} characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final error = Validators.password(value);
    if (error != null) return error;
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? maxLength(String? value, int max,
      [String fieldName = 'This field']) {
    if (value != null && value.length > max) {
      return '$fieldName must be $max characters or fewer';
    }
    return null;
  }
}
