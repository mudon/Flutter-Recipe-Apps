import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;

  static Stream<User?> get userStream => _auth.userChanges();

  static bool get isEmailVerified => user?.emailVerified ?? false;

  static Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((credential) {
        credential.user?.sendEmailVerification();
        credential.user?.updateDisplayName(fullName);
      });
    } catch (e) {
      // Detailed error handling
      print('Error during registration: $e');
      rethrow;
    }
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Detailed error handling
      print('Error during login: $e');
      rethrow;
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }
}
