import 'package:firebase_auth/firebase_auth.dart';

class MyFirebaseAuth {
  static MyFirebaseAuth? _instance;

  MyFirebaseAuth._internal();

  static MyFirebaseAuth get instance {
    _instance ??= MyFirebaseAuth._internal();
    return _instance!;
  }

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);

      //If you need to search for users by username later, or store extra data (like a bio, profile picture, or RxInt points), you should store the username in a Firestore collection.

      // await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      //   'username': username,
      //   'email': email,
      //   'createdAt': DateTime.now(),
      // });

      print(
        '/////// Signup Success - ${userCredential.user?.displayName} ////////',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logInWithEmail(String email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('/////// Login Success ////////');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
