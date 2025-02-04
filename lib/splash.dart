import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    waitAndNav();

    return Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }

  void waitAndNav() async {
    Future.delayed(Duration(seconds: 2)).then((_) async {
      User? user = await FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }
}
