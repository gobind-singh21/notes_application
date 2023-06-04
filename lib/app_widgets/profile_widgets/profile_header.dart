import 'package:flutter/material.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/global/dimensions.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});
  final double height = Dimensions.screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: height / 40),
      height: height / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(height),
            child: Image.network(
              UserData.profileImageURL,
              height: height / 8,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            UserData.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height / 45,
              // color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            UserData.email,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height / 55,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
