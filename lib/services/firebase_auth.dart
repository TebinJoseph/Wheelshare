import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wheel/services/firebasefunctions.dart';
import 'package:wheel/views/home.dart';
import 'package:wheel/views/profile_pages/editprofile.dart';
import 'package:get/get.dart';

class FireAuth extends GetxController {
  String userUid = '';
  static String s = "wrong";
  static final _firebaseAuth = FirebaseAuth.instance;
  static Future<String> signIn(
      {required String emailController,
      required String passwordController,
      t}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
      s = "success";
    } on FirebaseAuthException catch (e) {
      s = e.code.toString();
    }
    return s;
  }

  static Future<String> signUp(
      {required String emailController,
      required String passwordController,required name}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController, password: passwordController);
      await FirebaseAuth.instance.currentUser!.updateEmail(emailController);
      await FirestoreServices.saveUser(
          emailController,name, userCredential.user!.uid);
      s = "success";
    } on FirebaseAuthException catch (e) {
      s = e.toString();
    }
    return s;
  }

  static Future sendEmail({required String email, context}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email send")));
    } on FirebaseAuthException catch (e) {
      String? err = e.message;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email not send $err")));
    }
  }

  static Future logout() async {
    await _firebaseAuth.signOut();
  }

  decideRoute() {
    //Check user login
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      //Check whether user profile exists?
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.exists) {
          Get.to(HomeScreen());
        } else {
          Get.to(EditProfilePage());
        }
      });
    }
  }
}
