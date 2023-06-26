import 'package:flutter/material.dart';
import 'package:notes_application/global/current_user_data.dart';
import 'package:notes_application/global/dimensions.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});

  final double height = Dimensions.screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: EdgeInsets.only(top: height / 40),
      height: height / 3.5,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ),
        builder: (BuildContext context, double value, Widget? child) {
          return Opacity(
            opacity: value,
            child: Padding(
              padding: EdgeInsets.only(top: value * height / 30),
              child: child,
            ),
          );
        },
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
            const SizedBox(
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
      ),
    );
  }
}
