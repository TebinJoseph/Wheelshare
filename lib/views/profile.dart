import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 24, 23, 23),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  width: 120,
                  height: 30,
                ),
                const SizedBox(height: 30),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading...');
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return Text('No data found.');
                      }
                      if (snapshot.hasData) {
                        var userData = snapshot.data!.data() as Map;
                        String name = userData['name'];
                        String email = userData['email'];
                        String data = "";
                        return Column(children: [
                          data ==''
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/foodproject-cfd0e.appspot.com/o/user%2Fprofileimages%2Fprofile-icon-9.png?alt=media&token=d2d64964-f3d5-4d40-bacf-4baed7b1275b'),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(data),
                                ),
                          Text(
                            name,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            email,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ]);
                      } else
                        return Container();
                    }),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()));
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
                const SizedBox(height: 50),
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
                const SizedBox(
                  height: 20,
                ),
                ProfileMenuWidget(
                  title: 'Logout',
                  icon: Icons.logout,
                  textColor: tdRed,
                  onPress: () {
                    FireAuth.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
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
          color: Colors.white,
        ),
      ),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: Container(
        width: 30,
        height: 30,
        child: const Icon(
          LineAwesomeIcons.angle_right,
          size: 18.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
