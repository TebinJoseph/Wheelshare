import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheel/views/home.dart';
import 'package:wheel/views/password.dart';
import 'package:wheel/views/profile_pages/editprofile.dart';
import 'package:wheel/views/register.dart';
import 'package:wheel/views/trip.dart';
import 'package:wheel/services/firebase_auth.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:mini/models/login_tiles.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  FireAuth authController = Get.find<FireAuth>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//commit
class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isloading = false;
  signinhere() async {
    _isloading = true;
    String s = await FireAuth.signIn(
        emailController: _emailController.text.trim(),
        passwordController: _passwordController.text.trim());
    if (s == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else if (s == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
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
      appBar: AppBar(
        title: Center(child: Text("WheelShare")),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 24, 23, 23),
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Color(0x0fe6e5ed), Color(0xfff4f0f4)],
            // )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 180,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx5) {
                              return ResetPassword();
                            },
                          ),
                        );

                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      )),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  signinhere();
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(300, 50)),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.yellow),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                child: _isloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 0.3,
                  )),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Or continue with"),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 0.3,
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
             
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a member?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx2) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Register Now",
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
