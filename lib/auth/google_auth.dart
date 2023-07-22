import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/models/user.dart';

class GoogleAuth {
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User user = User(
        email: googleUser.email,
        displayName: googleUser.displayName,
        profilePicUrl: googleUser.photoUrl,
      );

      // sign up with firebase
      await auth.signInWithCredential(credential);

      // post user to firestore
      await firestore.collection('users').doc(auth.currentUser!.uid).set(
            user.toMap(),
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> signOut() async {
    try {
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
