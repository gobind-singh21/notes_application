import 'package:flutter/material.dart';
import 'package:notes_application/models/user_class.dart';
import 'package:notes_application/screens/profile_screen.dart';
import 'package:notes_application/screens/search_screen.dart';
import 'package:notes_application/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  void moveToProfileScreen() {
    final docRef = db.collection('users').doc(currentFirebaseUser!.uid);
    docRef.get().then((DocumentSnapshot doc) {
      final userData = doc.data() as Map<String, dynamic>;
      EndUser user = EndUser(
        userData['name'],
        userData['email'],
        userData['number'],
        userData['profileImageURL'],
        userData['history'],
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileScreen(user)));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight / 7.45,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(108, 93, 93, 93),
          offset: Offset(0, screenHeight / 296),
          blurRadius: 4,
        )
      ], color: Colors.white),
      child: Padding(
        padding: EdgeInsets.only(
            left: screenWidth / 30,
            top: screenHeight / 15,
            right: screenWidth / 30,
            bottom: screenHeight / 120),
        child: Row(
          children: [
            InkWell(
              onTap: () => moveToProfileScreen(),
              child: Container(
                height: screenHeight / 20,
                width: screenHeight / 20,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(screenWidth / 60),
                ),
                child: Icon(
                  Icons.person,
                  size: screenHeight / 40,
                  // color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth / 36,
                  right: screenWidth / 36,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Country",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight / 40,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "City",
                          style: TextStyle(
                            fontSize: screenHeight / 60,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: screenHeight / 45,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Container(
                height: screenHeight / 20,
                width: screenHeight / 20,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(screenWidth / 60),
                ),
                child: Icon(
                  Icons.search,
                  size: screenHeight / 40,
                  // color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
