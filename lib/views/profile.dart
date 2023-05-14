import 'package:flutter/material.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
import 'package:wheel/services/firebase_auth.dart';
import 'package:wheel/views/color.dart';
import 'package:wheel/views/profile_pages/editprofile.dart';
import 'package:wheel/views/profile_pages/help.dart';
import 'package:wheel/views/profile_pages/history.dart';
import 'package:wheel/views/profile_pages/settings.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'login.dart';

//
class Profile1 extends StatelessWidget {
  const Profile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
             const SizedBox(
                width: 120,
                height: 30,
                
              ),
              const SizedBox(height: 30),
              Text('Profile', style: TextStyle(color: Colors.black,fontSize: 40,)),
              Text('Profile@gmail.com',
                  style: TextStyle(color: Colors.black,fontSize: 15),),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>   EditProfilePage())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      side: BorderSide.none,
                      elevation: 0,
                      shape: const StadiumBorder()),
                  child: const Text('Edit Profile',
                      style: TextStyle(color: tdWhite)),
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 20),
              ProfileMenuWidget(
                title: 'Settings',
                icon: Icons.settings,
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
                },
              ),
              ProfileMenuWidget(
                title: 'History',
                icon: Icons.history,
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HistoryScreen()));
                },
              ),
              
              ProfileMenuWidget(
                title: 'Help',
                icon: Icons.question_mark,
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HelpScreen()));
                },
              ),
              const SizedBox(height: 20),
              ProfileMenuWidget(
                title: 'Logout',
                icon: Icons.logout,
                textColor: tdRed,
                onPress: () {
                  FireAuth.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.endIcon = true,
      this.textColor = Colors.white});
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
       
        child: Icon(
          icon,
          color: const Color.fromARGB(255, 0, 4, 3),
        ),
      ),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: Container(
        width: 30,
        height: 30,
       
        child: const Icon(
          LineAwesomeIcons.angle_right,
          size: 18.0,
          color: Color.fromARGB(255, 4, 0, 0),
        ),
      ),
    );
  }
}