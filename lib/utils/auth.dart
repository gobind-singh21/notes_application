import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_application/global/global.dart';
import 'package:notes_application/screens/home_screen.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
            .catchError((msg) {
      Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
      return null;
    }))
        .user;
    final docRef = db.collection('users').doc(firebaseUser!.uid);
    docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Login successful');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Fluttertoast.showToast(
          msg: 'No record found',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    });
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required String number,
      required String? urlDownload,
      required BuildContext context}) async {
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
            .catchError((msg) {
      Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
      return null;
    }))
        .user;
    Fluttertoast.showToast(msg: 'created');
    final users = db.collection('users');
    final userData = <String, dynamic>{
      'id': firebaseUser!.uid,
      'email': email,
      'name': name,
      'number': number,
      'profileImageURL': urlDownload
    };

    users.doc(firebaseUser.uid).set(userData);
    currentFirebaseUser = firebaseUser;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<void> signOut() async {
    currentFirebaseUser = null;
    await _firebaseAuth.signOut();
  }
}
