import 'package:fluttertoast/fluttertoast.dart';
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
    try {
      final docRef = db.collection('users').doc(currentFirebaseUser!.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      if(data['name'] == null) {
        print('Name is null');
      }
      name = data['name'];
      if(data['email'] == null) {
        print('Email is null');
      }
      email = data['email'];
      if(data['number'] == null) {
        print('number is null');
      }
      number = data['number'];
      if(data['profileImageURL'] == null) {
        print('Profile Image URL is null');
      }
      profileImageURL = data['profileImageURL'];
      if (data['country'] != null) {
        country = data['country'];
      }
      if (data['state'] != null) {
        state = data['state'];
      }
      if (data['city'] != null) {
        city = data['city'];
      }
      history = data['history'];
      userDataSet = true;
    } catch(e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
