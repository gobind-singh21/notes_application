import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:notes_application/global/global.dart';

class ProfileHeader extends StatelessWidget {
  final String _profileImageUrl;
  final String _name;
  final String _email;
  ProfileHeader(this._name, this._email, this._profileImageUrl);

  // Future<Widget>? loadImageFromFirebase(String imageUrl) async {
  //   final http.Response response = await http.get(Uri.parse(imageUrl));
  //   final ImageProvider imageProvider = MemoryImage(response.bodyBytes);
  //   return Image(image: imageProvider);
  // }
  // var downloadUrl;
  // Future<String> getImageUrl() async {
  //   // try {
  //   final firebase_storage.Reference ref =
  //       firebase_storage.FirebaseStorage.instance.refFromURL(
  //           "gs://rental-system-9422a.appspot.com/users/${currentFirebaseUser!.uid}/profile_images/profile.jpg");
  //   // .child(currentFirebaseUser!.uid)
  //   // .child("profile_images")
  //   // .child("profile");
  //   String downloadUrl = await ref.getDownloadURL();
  //   return downloadUrl;
  //   // } catch (e) {
  //   //   return null;
  //   // }
  // }

  // String downloadUrl = "";
  // Future<void> fetchImage() async {
  //   downloadUrl = await getImageUrl();
  // }

  @override
  Widget build(BuildContext context) {
    // getImageUrl();
    // print(downloadUrl);
    // print(_profileImageUrl);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: width / 8,
            child: Image.network(
              _profileImageUrl,
              scale: 2.0,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: height / 45,
                ),
              ),
              Text(
                _email,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: height / 55,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
