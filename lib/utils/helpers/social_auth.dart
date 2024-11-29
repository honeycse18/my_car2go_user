import 'dart:developer';

import 'package:car2gouser/screens/auth/login_screen.dart';
import 'package:car2gouser/screens/zoom_drawer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SocialAuth {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const ZoomDrawerScreen();
          } else {
            return const LoginScreen();
          }
        });
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser =
          // await GoogleSignIn(scopes: <String>["email"]).signIn();
          await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
