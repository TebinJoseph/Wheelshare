import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wheel/services/firebase_auth.dart';
import 'package:wheel/views/home.dart';
import 'package:wheel/views/login.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     FireAuth authController = Get.put(FireAuth() );
    authController.decideRoute();
   
      return MaterialApp(
        home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
          //edit
        }
      },
    ));
  }
}
