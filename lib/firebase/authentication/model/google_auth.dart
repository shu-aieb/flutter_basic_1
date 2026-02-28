import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static final GoogleAuth _instance = GoogleAuth._internal();

  factory GoogleAuth() {
    return _instance;
  }

  GoogleAuth._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  /// Always check Google sign in initialization before use
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();
    try {
      final account = await _googleSignIn.authenticate(scopeHint: ['email']);
      return account;

      // final GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleSignInAccount!.authentication;
      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleSignInAuthentication.accessToken,
      //   idToken: googleSignInAuthentication.idToken,
      // );
      // await _auth.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      print(
        'Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details} error: $e',
      );
      rethrow;
    } catch (error) {
      print('Unexpected Google Sign-In error: $error');
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> attemptSilentSignIn() async {
    await _ensureGoogleSignInInitialized();

    try {
      final result = _googleSignIn.attemptLightweightAuthentication();
      if (result is Future<GoogleSignInAccount?>) {
        return await result;
      } else {
        return result as GoogleSignInAccount?;
      }
    } catch (error) {
      print('Silent sign-in failed: $error');
      return null;
    }
  }

  GoogleSignInAuthentication getAuthTokens(GoogleSignInAccount account) {
    return account.authentication;
  }

  Future<String?> getAccessTokenForScopes(List<String> scopes) async {
    await _ensureGoogleSignInInitialized();

    try {
      final authClient = _googleSignIn.authorizationClient;

      // Try to get existing authorization
      var authorization = await authClient.authorizationForScopes(scopes);

      if (authorization == null) {
        // Request new authorization from user
        authorization = await authClient.authorizeScopes(scopes);
      }

      return authorization?.accessToken;
    } catch (error) {
      print('Failed to get access token for scopes: $error');
      return null;
    }
  }

  // Manage user state manually
  GoogleSignInAccount? _currentUser;
  GoogleSignInAccount? get currentUser => _currentUser;

  bool get isSignedIn => _currentUser != null;

  Future<void> signIn() async {
    try {
      _currentUser = await signInWithGoogleFirebase();
      //_notifyUserChanged();
    } catch (error) {
      _currentUser = null;
      rethrow;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    _currentUser = null;
    await _auth.signOut();
    //_notifyUserChanged();
  }

  Future<GoogleSignInAccount> signInWithGoogleFirebase() async {
    await _ensureGoogleSignInInitialized();

    // Authenticate with Google
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    // Get authorization for Firebase scopes if needed
    final authClient = _googleSignIn.authorizationClient;
    final authorization = await authClient.authorizationForScopes(['email']);

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    // Update local state
    //_currentUser = googleUser;

    return googleUser;
  }
}
