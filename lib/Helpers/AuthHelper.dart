import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gif_app/AppRouter/AppRouter.dart';

class AuthHelper {
  static AuthHelper instance = AuthHelper._();
  AuthHelper._();

  SignUp(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppRouter.showAlertDialog('The password provided is too weak.');
        showDialog(
          context: AppRouter.navKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              content: Text('The password provided is too weak.'),
            );
          },
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: AppRouter.navKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              content: Text('The account already exists for that email.'),
            );
          },
        );

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  SignIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: AppRouter.navKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              content: Text('No user found for that email.'),
            );
          },
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: AppRouter.navKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              content: Text('Wrong password provided for that user.'),
            );
          },
        );

        print('Wrong password provided for that user.');
      }
    }
  }

  SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  ResetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
