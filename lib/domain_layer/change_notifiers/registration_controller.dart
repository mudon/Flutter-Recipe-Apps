import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;
  bool get isRegisterMode => _isRegisterMode;
  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;
  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _username = '';
  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String get username => _username.trim();

  String _email = '';
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> authenticateWithEmailAndPassword(
      {required BuildContext context}) async {
    isLoading = true;
    try {
      if (_isRegisterMode) {
        // Register user
        await AuthService.register(
          fullName: username,
          email: email,
          password: password,
        );

        // Wait for email verification
        while (AuthService.user != null && !AuthService.isEmailVerified) {
          await Future.delayed(const Duration(seconds: 5));
          await AuthService.user?.reload();
        }

        // Optional: Notify user to verify email
        if (AuthService.user != null && !AuthService.isEmailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please verify your email before logging in.'),
            ),
          );
        }

        if (AuthService.user != null && AuthService.isEmailVerified) {
          final userId = AuthService.user?.uid;
          final userEmail = AuthService.user?.email;
          DirectFirebase.firestoreDatabase.collection("user").doc(userId).set({
            "userId": userId,
            "avatarImg": "",
            "createdPosts": [],
            "email": userEmail,
            "name": username,
            "savedPosts": [],
          });
        }
      } else {
        // Login user
        await AuthService.login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      // Provide specific error messages
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        default:
          errorMessage = 'An unexpected error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    } catch (e) {
      // Handle any other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred.'),
        ),
      );
    } finally {
      isLoading = false;
    }
  }
}
