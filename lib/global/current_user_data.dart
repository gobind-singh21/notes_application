import 'package:notes_application/global/global.dart';

class UserData {
  static String name = "";
  static String email = "";
  static String number = "";
  static String profileImageURL = "";

  static fetchData() async {
    final docRef = db.collection('users').doc(currentFirebaseUser!.uid);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    name = data['name'];
    email = data['email'];
    number = data['number'];
    profileImageURL = data['profileImageURL'];
  }
}