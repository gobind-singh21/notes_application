import 'package:notes_application/global/global.dart';

class UserData {
  static String name = "";
  static String email = "";
  static String number = "";
  static String profileImageURL = "";
  static String country = "Country";
  static String state = "State";
  static String city = "City";
  static List<dynamic> history = [];
  static bool userDataSet = false;

  static fetchData() async {
    final docRef = db.collection('users').doc(currentFirebaseUser!.uid);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    name = data['name'];
    email = data['email'];
    number = data['number'];
    profileImageURL = data['profileImageURL'];
    if(data['country'] != null) {
      country = data['country'];
    }
    if(data['state'] != null) {
      state = data['state'];
    }
    if(data['city'] != null) {
      city = data['city'];
    }
    history = data['history'];
    userDataSet = true;
  }
}
