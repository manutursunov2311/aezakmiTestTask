import 'package:aezakmi_test_task/core/config/app_assets.dart';
import 'package:aezakmi_test_task/features/auth/screens/register_screen.dart';
import 'package:aezakmi_test_task/features/auth/widgets/ios_text_field.dart';
import 'package:aezakmi_test_task/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../core/di/service_locator.dart';
import '../../gallery/screens/gallery_screen.dart';
import '../store/login_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore _loginStore = getIt<LoginStore>();

  List<ReactionDisposer>? _disposers;

  @override
  void initState() {
    super.initState();

    _disposers = [
      reaction((_) => _loginStore.errorMessage, (String? message) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (message != null) _showErrorDialog(message);
        });
      }),
    ];
  }

  @override
  void dispose() {
    _disposers?.forEach((d) => d());
    super.dispose();
  }

  void _showErrorDialog(String message) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.errorTitle),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.ok),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  void _hideKeyboard() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      child: GestureDetector(
        onTap: _hideKeyboard,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppAssets.backgroundImage, fit: BoxFit.cover),
            ),

            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(flex: 1),

                              Text(
                                l10n.loginTitle,
                                style: GoogleFonts.pressStart2p(
                                  color: const Color(0xFFEEEEEE),
                                  fontSize: 20,
                                  height: 1.0,
                                  shadows: [
                                    const Shadow(
                                      color: Color(0xFF8924E7),
                                      offset: Offset(0, 0),
                                      blurRadius: 2,
                                    ),
                                    Shadow(
                                      color: const Color(
                                        0xFF8924E7,
                                      ).withOpacity(0.6),
                                      offset: const Offset(0, 0),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),

                              // Поле Email
                              Observer(
                                builder: (_) {
                                  return IosTextField(
                                    label: l10n.labelEmail,
                                    placeholder: l10n.phEmailLogin,
                                    onChanged: (val) =>
                                        _loginStore.setEmail(val),
                                  );
                                },
                              ),

                              const SizedBox(height: 16),

                              Observer(
                                builder: (_) {
                                  return IosTextField(
                                    label: l10n.labelPassword,
                                    placeholder: l10n.phPasswordLogin,
                                    isPassword: true,
                                    onChanged: (val) =>
                                        _loginStore.setPassword(val),
                                  );
                                },
                              ),

                              const Spacer(flex: 1),
                              const SizedBox(height: 20),

                              Observer(
                                builder: (_) {
                                  return Container(
                                    width: double.infinity,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.buttonGradStart,
                                          AppColors.buttonGradEnd,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: _loginStore.isLoading
                                          ? null
                                          : () {
                                              _hideKeyboard();

                                              final ok = _loginStore.validate();
                                              if (!ok) {
                                                final msg =
                                                    _loginValidationText(
                                                      l10n,
                                                      _loginStore
                                                          .validationErrorCode,
                                                    );
                                                if (msg != null) {
                                                  _showErrorDialog(msg);
                                                }
                                                return;
                                              }

                                              _loginStore.login();
                                            },
                                      child: _loginStore.isLoading
                                          ? const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              l10n.loginButton,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    l10n.registerButton,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _loginValidationText(
    AppLocalizations l10n,
    LoginValidationError? code,
  ) {
    switch (code) {
      case LoginValidationError.emailEmpty:
        return l10n.valEmailEmpty;
      case LoginValidationError.emailInvalid:
        return l10n.valEmailInvalid;
      case LoginValidationError.passwordEmpty:
        return l10n.valPasswordEmpty;
      case LoginValidationError.passwordInvalid:
        return l10n.valPasswordInvalid;
      case null:
        return null;
    }
  }
}
