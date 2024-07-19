import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

enum Status { success, failed }

class Auth {
  Auth.internal();
  static Auth instance = Auth.internal();
  get uid => FirebaseAuth.instance.currentUser!.uid;

  Future<Status> signIn(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Status.success;
    } on FirebaseAuthException catch (e) {
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
    return Status.failed;
  }

  Future<Status> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return Status.success;
    } on FirebaseAuthException catch (e) {
      log(e.code);
    } catch (e) {
      log(
        e.toString(),
      );
    }
    return Status.failed;
  }

  get isLogin => FirebaseAuth.instance.currentUser != null;

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
