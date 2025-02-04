import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/project_firebase/proj_main.dart';
import 'package:firebase_testing/project_firebase/proj_signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_pratice/fb_auth.dart';

class projLogin extends StatefulWidget {
  const projLogin({super.key});

  @override
  State<projLogin> createState() => _projLoginState();
}

class _projLoginState extends State<projLogin> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Enter Email'
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Enter Password'
                ),
              ),
              FilledButton(onPressed: () async{

                UserCredential? user = await loginWithEmail(email: emailController.text, password: passwordController.text);
                SharedPreferences share = await SharedPreferences.getInstance();
                await share.setString('user_id', user!.user!.uid);
                if(user != null){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>projMain()));
                }else{
                  print('failed to LOGIN');
                }

              }, child: Text('Login')),
              FilledButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>projSignUp()));
              }, child: Text('Go to signin')),
              // FilledButton(onPressed: (){
              //   GoogleSignInProvider  gs = GoogleSignInProvider();
              //   gs.signInWithGoogle();
              // }, child: Text("Google")),
            ],
          ),
        ),
      ),
    );
  }
}