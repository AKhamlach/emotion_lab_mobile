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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(LoginRequested(
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
                            title: 'Welcome back',
                            subtitle: 'Log in to continue your journey',
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
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            prefixIcon: Icons.lock_outline,
                            validator: Validators.password,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  context.pushNamed(RouteNames.forgotPassword),
                              child: const Text('Forgot password?'),
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacing8),
                          PrimaryButton(
                            label: 'Log In',
                            onPressed: _handleLogin,
                            isLoading: isLoading,
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
                                "Don't have an account? ",
                                style: context.textTheme.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.goNamed(RouteNames.register),
                                child: const Text('Sign Up'),
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
