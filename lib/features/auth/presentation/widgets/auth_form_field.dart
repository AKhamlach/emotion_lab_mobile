import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';

class AuthFormField extends StatefulWidget {
  const AuthFormField({
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.prefixIcon,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final IconData? prefixIcon;

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacing16),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && _obscure,
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                  tooltip: _obscure ? 'Show password' : 'Hide password',
                )
              : null,
        ),
      ),
    );
  }
}
