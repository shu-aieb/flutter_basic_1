import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_1/firebase/authentication/model/firebase_auth.dart';
import 'package:flutter_basics_1/firebase/authentication/pages/firebase_auth_page.dart';
import 'package:flutter_basics_1/firebase/authentication/splash.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final MyFirebaseAuth _auth = MyFirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return Splash();
          } else {
            return FirebaseAuthPage();
          }
        },
      ),
    );
  }
}
