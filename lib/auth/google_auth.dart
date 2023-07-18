import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final auth = FirebaseAuth.instance;
    try {
      final user = await googleSignIn.signIn();
      final googleAuth = await user!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      auth.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }
}
