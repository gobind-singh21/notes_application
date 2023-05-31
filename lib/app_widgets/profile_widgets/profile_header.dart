import 'package:flutter/material.dart';
import 'package:notes_application/global/dimensions.dart';

class ProfileHeader extends StatelessWidget {
  final String _profileImageUrl;
  final String _name;
  final String _email;
  ProfileHeader(this._name, this._email, this._profileImageUrl);
  final double height = Dimensions.screenHeight;

  @override
  Widget build(BuildContext context) {
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
