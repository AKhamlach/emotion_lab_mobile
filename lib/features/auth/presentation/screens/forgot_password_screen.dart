import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/auth_form_field.dart';
import '../widgets/auth_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendReset() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(ForgotPasswordRequested(
          email: _emailController.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final resetSent = state is PasswordResetSent ? state : null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Reset Password'),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppDimensions.maxContentWidth,
                  ),
                  child: resetSent != null
                      ? _buildSuccessState(context, resetSent.email)
                      : _buildForm(isLoading),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForm(bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(
            title: 'Forgot password?',
            subtitle:
                "Enter your email and we'll send you a link to reset your password.",
          ),
          AuthFormField(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.email],
            prefixIcon: Icons.email_outlined,
            validator: Validators.email,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          PrimaryButton(
            label: 'Send Reset Link',
            onPressed: _handleSendReset,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, String email) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spacing48),
        Icon(
          Icons.mark_email_read_outlined,
          size: 80,
          color: context.appColors.successGreen,
        ),
        const SizedBox(height: AppDimensions.spacing24),
        Text(
          'Check your inbox',
          style: context.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacing12),
        Text(
          'We sent a password reset link to\n$email',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.appColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacing32),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back to Login'),
        ),
      ],
    );
  }
}
