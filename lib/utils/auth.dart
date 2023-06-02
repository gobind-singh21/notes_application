import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/global/global.dart';
// import 'package:notes_application/models/user_class.dart';
import 'package:notes_application/screens/home_screen.dart';
// import 'package:notes_application/screens/login_screen.dart';

class Auth {
  void setUserData(
      {required String name,
      required String email,
      required String number,
      required String profileImageURL}) {
    UserData.email = email;
    UserData.name = name;
    UserData.number = number;
    UserData.profileImageURL = profileImageURL;
    UserData.userDataSet = true;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final docRef = db.collection('users').doc(userCredential.user!.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        currentFirebaseUser = fAuth.currentUser;
        profileImagePath =
            'users/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
        Fluttertoast.showToast(msg: 'Login successful');
        setUserData(
          name: data['name'],
          email: data['email'],
          number: data['number'],
          profileImageURL: data['profileImageURL'],
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'No record found',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String number,
    required File? pickedFile,
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      currentFirebaseUser = fAuth.currentUser;
      profileImagePath =
          'users/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
      // print("Error here");
      final path = profileImagePath;
      // print("Error here");
      final ref = FirebaseStorage.instance.ref().child(path);
      // print("Error here");
      final uploadTask = ref.putFile(pickedFile!);
      // print("Error here");
      final snapshot = await uploadTask.whenComplete(() {});
      // print("Error here");
      final profileImageURL = await snapshot.ref.getDownloadURL();
      // print("Error here");
      Fluttertoast.showToast(msg: 'created');
      // print("Error here");
      final users = db.collection('users');
      final userData = <String, dynamic>{
        'id': userCredential.user!.uid,
        'email': email,
        'name': name,
        'number': number,
        'profileImageURL': profileImageURL,
      };
      await users.doc(userCredential.user!.uid).set(userData);
      setUserData(
        name: name,
        email: email,
        number: number,
        profileImageURL: profileImageURL,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> updateUserInformation({
    required String email,
    required String name,
    required String number,
    required String oldImageUrl,
    File? profileImage,
  }) async {
    String profileImageURL = oldImageUrl;
    if (profileImage != null) {
      final String path = profileImagePath;
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(profileImage);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      profileImageURL = urlDownload;
    }
    try {
      await currentUser?.updateEmail(email);
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
    DocumentReference docRef = db.collection('users').doc(currentUser!.uid);
    final userData = <String, dynamic>{
      'id': currentUser!.uid,
      'email': email,
      'name': name,
      'number': number,
      'profileImageURL': profileImageURL,
    };
    await docRef.update(userData);

    setUserData(
      name: name,
      email: email,
      number: number,
      profileImageURL: profileImageURL,
    );
    Fluttertoast.showToast(msg: 'Profile updated successfully!');
  }
}
