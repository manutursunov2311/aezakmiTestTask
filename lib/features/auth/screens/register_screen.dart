import 'package:aezakmi_test_task/core/config/app_assets.dart';
import 'package:aezakmi_test_task/core/di/service_locator.dart';
import 'package:aezakmi_test_task/features/auth/store/register_store.dart';
import 'package:aezakmi_test_task/features/gallery/screens/gallery_screen.dart';
import 'package:aezakmi_test_task/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart' show Observer;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import '../../../core/theme/app_colors.dart';
import 'package:aezakmi_test_task/features/auth/widgets/ios_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void _hideKeyboard() => FocusScope.of(context).unfocus();

  final RegisterStore _registerStore = getIt<RegisterStore>();

  List<ReactionDisposer>? _disposers;

  @override
  void initState() {
    super.initState();

    _disposers = [
      reaction((_) => _registerStore.errorMessage, (String? message) {
        if (message != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorDialog(message);
          });
        }
      }),

      reaction((_) => _registerStore.isSuccess, (bool success) {
        if (success) {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (_) => const GalleryScreen()),
            (route) => false,
          );
        }
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
                                l10n.registerTitle,
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

                              Observer(
                                builder: (_) {
                                  return IosTextField(
                                    label: l10n.labelName,
                                    placeholder: l10n.phName,
                                    onChanged: (val) =>
                                        _registerStore.setName(val),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              Observer(
                                builder: (_) {
                                  return IosTextField(
                                    label: l10n.labelEmail,
                                    placeholder: l10n.phEmailLogin,
                                    onChanged: (val) =>
                                        _registerStore.setEmail(val),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              Observer(
                                builder: (_) {
                                  return IosTextField(
                                    label: l10n.labelPassword,
                                    placeholder: l10n.phPasswordRegister,
                                    isPassword: true,
                                    onChanged: (val) =>
                                        _registerStore.setPassword(val),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              Observer(
                                builder: (_) {
                                  return IosTextField(
                                    label: l10n.labelConfirmPassword,
                                    placeholder: l10n.phConfirmPassword,
                                    isPassword: true,
                                    onChanged: (val) =>
                                        _registerStore.setConfirmPassword(val),
                                  );
                                },
                              ),
                              const Spacer(),

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
                                      onPressed: _registerStore.isLoading
                                          ? null
                                          : () {
                                              _hideKeyboard();

                                              final ok = _registerStore
                                                  .validate();
                                              if (!ok) {
                                                final msg =
                                                    _registerValidationText(
                                                      l10n,
                                                      _registerStore
                                                          .validationErrorCode,
                                                    );
                                                if (msg != null) {
                                                  _showErrorDialog(msg);
                                                }
                                                return;
                                              }

                                              _registerStore.register();
                                            },
                                      child: _registerStore.isLoading
                                          ? const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              l10n.registerButton,
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

  String? _registerValidationText(
    AppLocalizations l10n,
    RegisterValidationError? code,
  ) {
    switch (code) {
      case RegisterValidationError.nameEmpty:
        return l10n.valNameEmpty;
      case RegisterValidationError.emailInvalid:
        return l10n.valEmailInvalid;
      case RegisterValidationError.passwordInvalid:
        return l10n.valPasswordInvalid;
      case RegisterValidationError.confirmEmpty:
        return l10n.valConfirmPasswordEmpty;
      case RegisterValidationError.mismatch:
        return l10n.valPasswordsMismatch;
      case null:
        return null;
    }
  }
}
