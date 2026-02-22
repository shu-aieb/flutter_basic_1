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
}
