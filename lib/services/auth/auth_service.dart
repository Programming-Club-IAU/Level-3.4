import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of FirebaseAuth
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // login with email and password
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseauth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // add a new user document in firestore
      _firestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          },
          SetOptions(
            merge: true,
          ));

      return userCredential;

      // catch FirebaseAuthException
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseauth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // create a new user document in firestore
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;

      // catch FirebaseAuthException
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Logout function
  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }
}
