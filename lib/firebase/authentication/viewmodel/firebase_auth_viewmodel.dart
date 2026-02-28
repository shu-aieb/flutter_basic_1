import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_1/firebase/authentication/model/firebase_auth.dart';

class FirebaseAuthViewmodel {
  final MyFirebaseAuth _auth = MyFirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges;

  Future<void> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    await _auth.signUpWithEmail(email, password, name);
  }

  Future<void> logInWithEmail(String email, password) async {
    await _auth.logInWithEmail(email, password);
  }

  Future<void> loginWithGoogle() async {
    await _auth.googleAuth.signIn();
  }

  Future<void> logOut() async {
    await _auth.logOut();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[^A-Za-z0-9]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username cannot be empty';

    final uName = value.trim();

    if (uName.contains(' ')) return 'No whitespace allowed';

    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(uName)) {
      return 'No special characters allowed';
    }

    if (uName.contains(RegExp(r'[A-Z]'))) return 'No uppercase letters allowed';

    final firstChar = uName[0];
    if (RegExp(r'[0-9]').hasMatch(firstChar) || firstChar == '_') {
      return 'First character must be a lowercase letter';
    }

    return null; // Valid
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    final email = value.trim();
    final lastDotIndex = email.lastIndexOf('.');
    final lastAtSignIndex = email.lastIndexOf('@');

    if (email.contains(' ')) {
      return 'No whitespace allowed';
    }

    if (RegExp(r'[!#$%^&*(),?":{}|<>]').hasMatch(email)) {
      return 'No special characters allowed';
    }

    if (email.contains(RegExp(r'[A-Z]'))) {
      return 'No uppercase letters allowed';
    }

    if (lastAtSignIndex < 1 ||
        lastDotIndex < lastAtSignIndex + 2 ||
        lastDotIndex == email.length - 1) {
      return 'Invalid email format';
    }

    final firstChar = email[0];
    if (RegExp(r'[0-9]').hasMatch(firstChar) ||
        firstChar == '_' ||
        firstChar == '-') {
      return 'First character must be a lowercase letter';
    }

    return null; // Valid
  }
}
