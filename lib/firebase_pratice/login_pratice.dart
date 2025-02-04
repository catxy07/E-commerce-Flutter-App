import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/firebase_pratice/home_pratice.dart';
import 'package:firebase_testing/firebase_pratice/signup_pratice.dart';
import 'package:firebase_testing/my_firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPratice extends StatefulWidget {
  const LoginPratice({super.key});

  @override
  State<LoginPratice> createState() => _LoginPraticeState();
}

class _LoginPraticeState extends State<LoginPratice> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailcontroller,
            decoration: InputDecoration(
              hintText: "Enter Email id",
            ),
          ),
          TextField(
            controller: passcontroller,
            decoration: InputDecoration(hintText: "Enter password"),
          ),
          FilledButton(onPressed: () async{

            UserCredential? user = await loginWithEmail(email: emailcontroller.text, password:passcontroller.text);

            if(user!= null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePratice()));
            }
          }, child: Text("Login")),
          FilledButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignupPratice()));
          }, child: Text("Sign Up")),
          FilledButton(onPressed: () {}, child: Text("Sign With Google")),
        ],
      ),
    ));
  }
}
