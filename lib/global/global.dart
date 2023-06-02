import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:notes_application/models/user_class.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
String profileImagePath =
    'users/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
// EndUser? currentUserInfo;

// set CurrentUser(EndUser temp) {
//   currentUserInfo = temp;
// }
