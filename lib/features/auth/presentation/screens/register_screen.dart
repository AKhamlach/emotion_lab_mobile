import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_form_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(RegisterRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
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

        return Scaffold(
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
                  child: AutofillGroup(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const AuthHeader(
                            title: 'Create account',
                            subtitle: 'Start your emotional wellness journey',
                          ),
                          AuthFormField(
                            label: 'Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            prefixIcon: Icons.email_outlined,
                            validator: Validators.email,
                          ),
                          AuthFormField(
                            label: 'Password',
                            controller: _passwordController,
                            isPassword: true,
                            autofillHints: const [AutofillHints.newPassword],
                            prefixIcon: Icons.lock_outline,
                            validator: Validators.password,
                          ),
                          AuthFormField(
                            label: 'Confirm password',
                            controller: _confirmPasswordController,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.newPassword],
                            prefixIcon: Icons.lock_outline,
                            validator: (value) => Validators.confirmPassword(
                              value,
                              _passwordController.text,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing8),
                          PrimaryButton(
                            label: 'Create Account',
                            onPressed: _handleRegister,
                            isLoading: isLoading,
                          ),
                          const SizedBox(height: AppDimensions.spacing12),
                          Text(
                            'By creating an account, you agree to our Terms of Service and Privacy Policy.',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.appColors.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const AuthDivider(),
                          SocialLoginButtons(
                            onGoogleTap: () => context.showSnackBar(
                              'Google login coming soon',
                            ),
                            onAppleTap: () => context.showSnackBar(
                              'Apple login coming soon',
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: context.textTheme.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.goNamed(RouteNames.login),
                                child: const Text('Log In'),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimensions.spacing24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
