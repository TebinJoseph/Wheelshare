import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify your email"),
      ),
      body: Column(
        children: [
          Center(child: Text("Email send .Check your email for logging in ")),
        ],
      ),
    );
  }
}
