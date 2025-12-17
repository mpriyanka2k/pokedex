import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/utils/commons/custom_button.dart';
import 'package:pokedex/core/utils/commons/custom_snackbar.dart';
import 'package:pokedex/core/utils/commons/custom_text_form_field.dart';
import 'package:pokedex/core/utils/validators.dart';
import 'package:pokedex/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ref.listen(authProvider, (prev, next) {
      if (next.error != null) {
        CustomSnackBar.show(
          context,
          message: next.error!,
          backgroundColor: colorScheme.error,
          icon: Icons.error_outline,
        );
      }

      if (next.isSuccess) {
        print("next.isSuccess = ${next.isSuccess}");
        CustomSnackBar.show(
          context,
          message: AppLocalizations.of(context)!.loginSuccessful,
          backgroundColor: colorScheme.primary,
          icon: Icons.check_circle_outline,
        );

        authNotifier.emailController.clear();
        authNotifier.passwordController.clear();
        context.go('/pokedex_list');
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            /// ---------- HEADER ----------
            Expanded(
              child: Container(
                // height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.primaryContainer],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/pokedex_logo.png",
                      height: 150.sp,
                      width: 200.sp,
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20.sp),
                    Container(
                      margin:  EdgeInsets.symmetric(horizontal: 20.sp),
                      padding:  EdgeInsets.symmetric(
                        horizontal: 24.sp,
                        vertical: 30.sp,
                      ),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20.r,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                             AppLocalizations.of(context)!.login,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                             SizedBox(height: 24.sp),

                            /// Email
                            CustomTextField(
                              controller: authNotifier.emailController,
                              hintText: AppLocalizations.of(context)!.email,
                              validator: (value) => Validators.validateEmail(
                                value,
                                message: AppLocalizations.of(context)!.pleaseEnterValidEmail
                              ),
                            ),
                             SizedBox(height: 16.sp),

                            /// Password
                            CustomTextField(
                              controller: authNotifier.passwordController,
                              hintText: AppLocalizations.of(context)!.password,
                              obscure: auth.isObscured,
                              isPassword: true,
                              onToggleVisibility:
                                  authNotifier.togglePasswordVisibility,
                              validator: (value) => Validators.validatePassword(
                                value,
                              AppLocalizations.of(context)!.pleaseEnterValidPassword,
                              ),
                            ),
                             SizedBox(height: 20.sp),

                            /// Login Button
                            CustomButton(
                              isLoading: auth.isLoading,
                              title: AppLocalizations.of(context)!.login,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  authNotifier.login();
                                }
                              },
                              backgroundColor: colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
