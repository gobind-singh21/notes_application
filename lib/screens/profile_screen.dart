import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/profile_widgets/profile_header.dart';
import 'package:notes_application/app_widgets/profile_widgets/profile_items.dart';
import 'package:notes_application/utils/auth.dart';
import 'package:notes_application/global/global.dart';
import 'package:notes_application/screens/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_application/models/user_class.dart';
import 'package:notes_application/screens/profile_screens/edit_profile_screen.dart';
import 'package:notes_application/screens/profile_screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final EndUser _user;
  const ProfileScreen(this._user, {super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(_user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String errorMessage = "";
  // final docRef = db.collection('users').doc(currentFirebaseUser!.uid);
  EndUser _user;
  _ProfileScreenState(this._user);

  // _ProfileScreenState() {
  //   final docRef = db.collection('users').doc(currentFirebaseUser!.uid);
  //   docRef.get().then((DocumentSnapshot doc) {
  //     final userData = doc.data() as Map<String, dynamic>;
  //     user = EndUser(
  //       userData['name'],
  //       userData['age'],
  //       userData['email'],
  //       userData['phoneNumber'],
  //       userData['urlDownload'],
  //       userData['history'],
  //     );
  //   });
  // }

  Future<void> signOut() async {
    try {
      await Auth().signOut();
      Navigator.popUntil(context, ModalRoute.withName('/anything'));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ProfileHeader(
            _user.getName(),
            _user.getEmail(),
            _user.getProfileImage(),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            ),
            child: ProfileItem(
              Icon(Icons.person_outline),
              'Account',
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            ),
            child: ProfileItem(
              Icon(Icons.settings_outlined),
              'Settings',
            ),
          ),
          InkWell(
            onTap: () {
              Auth().signOut();
              Navigator.popUntil(context, ModalRoute.withName('/someRoute'));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: ProfileItem(Icon(Icons.logout_outlined), 'Log out'),
          )
        ],
      ),
    ));
  }
}
