import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static Future<User?> registerAccount({
    required String name,
    required String image,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return user;
  }

  static Future<User?> signInAccount(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided');
        }
      }
    }

    return user;
  }

  static Future<User?> updateAccount(
      {required String name,
      required String image,
      required String email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      user = auth.currentUser;
      await user!.updatePhotoURL(image);
      await user.updateEmail(email);
      await user.updateDisplayName(name);
      await user.reload();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
