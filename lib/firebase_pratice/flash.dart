import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/firebase_pratice/home_pratice.dart';
import 'package:firebase_testing/firebase_pratice/login_pratice.dart';
import 'package:firebase_testing/homescreen.dart';
import 'package:flutter/material.dart';

class Flash extends StatefulWidget {
  const Flash({super.key});

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Center(
          child: Text("Mehta Info"),
        ),
      ),
    );


  }
  void waitAndSwitch(){
   Future.delayed(Duration(seconds: 2)).then((_) async{
     User? user = await FirebaseAuth.instance.currentUser;

     if(user!= null){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePratice()));
     }
     else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPratice()));
     }
   });
  }
}
