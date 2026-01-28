import 'package:aezakmi_test_task/domain/repositories/auth_repository.dart';
import 'package:aezakmi_test_task/features/auth/screens/login_screen.dart';
import 'package:aezakmi_test_task/features/gallery/screens/gallery_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  final AuthRepository auth;

  const AuthGate({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoPageScaffold(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        final user = snapshot.data;

        if (user == null) return const LoginScreen();
        return const GalleryScreen();
      },
    );
  }
}
