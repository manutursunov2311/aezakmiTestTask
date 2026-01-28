import 'package:firebase_auth/firebase_auth.dart' show User;

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password, String name);
  User? get currentUser;
}