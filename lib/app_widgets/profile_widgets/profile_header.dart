import 'package:flutter/material.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/global/dimensions.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader();
  final double height = Dimensions.screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: height / 40),
      height: height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              UserData.profileImageURL,
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
                UserData.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: height / 45,
                ),
              ),
              Text(
                UserData.email,
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
