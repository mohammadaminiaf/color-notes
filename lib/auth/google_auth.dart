import 'package:color_notes/constansts/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

      dummyUser = user;

      auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
