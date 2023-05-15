import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:wheel/services/firebase_auth.dart';
import 'package:wheel/views/profile_pages/add_ride.dart';
import 'package:wheel/views/trip.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
import 'package:wheel/views/screen1.dart';
import 'package:wheel/views/screen2.dart';
import 'package:wheel/views/screen3.dart';
import 'package:wheel/views/profile.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int myindex=0;
   List<Widget> widgetList =[
   Log(),
   AddRidePage(),
   Profile1(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children:widgetList,
        index: myindex,

      ),
      
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
             myindex=index;
          });
         },
         currentIndex: myindex,
        items:const [
           BottomNavigationBarItem(
            label: 'Log',
            icon: Icon(Icons.receipt_long),
            backgroundColor: Colors.white,
          ),
           BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
            backgroundColor: Colors.white,
          ),
           BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_2_rounded),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

