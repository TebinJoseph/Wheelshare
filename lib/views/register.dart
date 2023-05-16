import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wheel/services/firebase_auth.dart';
import 'package:wheel/views/emailverfication.dart';
import 'package:wheel/views/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // ignore: unused_field
  bool _isloading = false;
  signuphere() async {
    _isloading = true;
    String s = await FireAuth.signUp(
        emailController: _emailController.text.trim(),
        passwordController: _passwordController.text.trim());
    final user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
    if (s == "success") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerificationScreen()),
      );
    } else {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: Color.fromARGB(255, 24, 23, 23),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  //controller: _emailController,
                  decoration: const InputDecoration(
                      filled: true,
                      hintText: "Name",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 179, 176, 186)),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      filled: true,
                      hintText: "Enter email ",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 179, 176, 186)),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      filled: true,
                      hintText: "Enter password",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 179, 176, 186)),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    signuphere();
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 50)),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
                  child: const Text("Sign up"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
