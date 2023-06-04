import 'package:flutter/material.dart';
import 'package:notes_application/app_widgets/profile_widgets/profile_header.dart';
import 'package:notes_application/app_widgets/profile_widgets/profile_items.dart';
import 'package:notes_application/utils/auth.dart';
import 'package:notes_application/screens/login_screen.dart';
import 'package:notes_application/screens/profile_screens/edit_profile_screen.dart';
import 'package:notes_application/screens/profile_screens/settings_screen.dart';
import 'package:notes_application/global/current_user_data.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final String name = UserData.name;
  final String email = UserData.email;
  final String number = UserData.number;
  final String profileImageURL = UserData.profileImageURL;

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/always'));
    // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ProfileHeader(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(),
                    ),
                  );
                },
                child: ProfileItem(
                  const Icon(
                    Icons.person_outline,
                    // color: Colors.black,
                  ),
                  'Account',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SettingsScreen()),
                  );
                },
                child: ProfileItem(
                  const Icon(
                    Icons.settings_outlined,
                    // color: Colors.black,
                  ),
                  'Settings',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  signOut(context);
                },
                child: ProfileItem(
                    const Icon(
                      Icons.logout_outlined,
                      // color: Colors.black,
                    ),
                    'Log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
