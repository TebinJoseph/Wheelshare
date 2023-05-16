import 'package:flutter/material.dart';
import 'package:wheel/services/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isloading = false;
  final resetemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
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
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text(
                "Forgot your Password?",
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
              const Text("Enter your email to get help logging in.",style: TextStyle(color: Colors.white),),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: resetemail,
                decoration: const InputDecoration(
                    filled: true,
                    hintText: "Enter email ",
                    hintStyle: TextStyle(color:Color.fromARGB(255, 179, 176, 186)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isloading = true;
                  });
                  FireAuth.sendEmail(
                      email: resetemail.text.trim(), context: context);
                  setState(() {
                    _isloading = false;
                  });
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(300, 50)),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) =>  Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                child: _isloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Send Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}