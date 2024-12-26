import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<bool> isAdmin() async {
    final user = currentUser();
    if (user == null) return false;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.data()?['role'] == 'admin';
  }

  void signUp({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    if (email.isEmpty) {
      return;
    } else if (password.isEmpty) {
      onError("please enter password");
    }

    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection('users').doc(userCred.user!.uid).set({
        'email': email,
        'role': 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message!);
    } catch (e) {
      onError(e.toString());
    }
  }

  void signIn({
    required String email,
    required String password,
    required Function(Future<bool> isAdmin) onSuccess,
    required Function(String err) onError,
  }) async {
    if (email.isEmpty) {
      return;
    } else if (password.isEmpty) {
      onError("please enter password");
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      onSuccess(isAdmin());
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      onError(e.message!);
    } catch (e) {
      onError(e.toString());
    }
  }

  void signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
