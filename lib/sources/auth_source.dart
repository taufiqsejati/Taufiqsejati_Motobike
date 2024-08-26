import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_session/d_session.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taufiqsejati_motobike/models/account.dart';

class AuthSource {
  static Future<String> signUp(
      String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Account account =
          Account(uid: credential.user!.uid, name: name, email: email);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(account.uid)
          .set(account.toJson());

      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      log(e.toString());
      return 'something wrong';
    } catch (e) {
      log(e.toString());
      return 'something wrong';
    }
  }

  static Future<String> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final accountDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(credential.user!.uid)
          .get();
      await editEmailOnly(email, Map.from(accountDoc.data()!));
      // await DSession.setUser(Map.from(accountDoc.data()!));
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      log(e.toString());
      return 'something wrong';
    } catch (e) {
      log(e.toString());
      return 'something wrong';
    }
  }

  static Future<String> changePassword(
      String currentPassword, String newPassword, String email) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Reauthenticate the user.
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user?.reauthenticateWithCredential(credential);

      // If reauthentication is successful, change the password.
      await user?.updatePassword(newPassword);

      // Password changed successfully.
      return 'success';
    } catch (e) {
      // Handle reauthentication errors and password change errors.
      return 'Error changing password: $e';
    }
  }

  static Future<String> resetEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.verifyBeforeUpdateEmail(newEmail);
      return 'success';
    } catch (e) {
      // Handle reauthentication errors and password change errors.
      return 'Error changing email: $e';
    }
  }

  static Future<String> editEmailName(
      String newEmail, String name, Account args) async {
    try {
      // await FirebaseFirestore.instance
      //     .collection('Users')
      //     .doc(args['uid'])
      //     .update({'email': email, 'name': name});
      // await DSession.setUser(Map.from({
      //   'email': email,
      //   'name': name,
      //   'uid': args['uid'],
      // }));
      User? user = FirebaseAuth.instance.currentUser;
      await editNameOnly(name, args);
      await user?.verifyBeforeUpdateEmail(newEmail);
      return 'success';
    } catch (e) {
      log(e.toString());
      return 'something wrong';
    }
  }

  static Future<void> editEmailOnly(String email, Map args) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(args['uid'])
          .update({'email': email});
      await DSession.setUser(Map.from({
        'email': email,
        'name': args['name'],
        'uid': args['uid'],
      }));
      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  static Future<String> editNameOnly(String name, Account args) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(args.uid)
          .update({'name': name});
      await DSession.setUser(
          {'email': args.email, 'name': name, 'uid': args.uid});
      return 'success';
    } catch (e) {
      log(e.toString());
      return 'something wrong';
    }
  }
}
