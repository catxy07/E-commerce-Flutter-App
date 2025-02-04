import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/project_firebase/proj_login.dart';
import 'package:firebase_testing/project_firebase/proj_main.dart';
import 'package:flutter/material.dart';

class projFlash extends StatefulWidget {
  const projFlash({super.key});

  @override
  State<projFlash> createState() => _projFlashState();
}

class _projFlashState extends State<projFlash> {
  @override
  Widget build(BuildContext context) {
    TwoSec();
    return Scaffold(
      body: Material(
        child: Center(
          child: Text("RITS",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void TwoSec() async {
    Future.delayed(Duration(seconds: 2)).then((_) async {
      User? user = await FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => projMain()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => projLogin()));
      }
    });
  }
}
