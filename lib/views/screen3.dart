import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wheel/views/trip.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 24, 23, 23),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Color(0x0fe6e5ed), Color(0xfff4f0f4)],
          // )
        ),
        child:  Column( 
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            ElevatedButton(onPressed: () {
              
                }, child: Text('Logout')),
          ],
        ),

      ),
      
    );
  }
}