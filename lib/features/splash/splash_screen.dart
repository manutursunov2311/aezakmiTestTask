import 'dart:async';
import 'package:aezakmi_test_task/core/config/app_assets.dart';
import 'package:aezakmi_test_task/core/di/service_locator.dart';
import 'package:aezakmi_test_task/domain/repositories/auth_repository.dart';
import 'package:aezakmi_test_task/features/auth/auth_gate.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (_) => AuthGate(auth: getIt<AuthRepository>())),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImage),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}