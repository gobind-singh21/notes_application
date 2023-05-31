import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/text_widgets/heading_text.dart';

class ProfileHeader extends StatelessWidget {
  final String _profileImageUrl;
  final String _name;
  final String _email;
  ProfileHeader(this._name, this._email, this._profileImageUrl);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              _profileImageUrl,
              height: height / 8,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeadingText(_name, height / 45, null, Colors.black),
              HeadingText(_email, height / 55, null, Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}
