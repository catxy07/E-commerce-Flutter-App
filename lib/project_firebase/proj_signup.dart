import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/project_firebase/proj_login.dart';
import 'package:firebase_testing/project_firebase/proj_main.dart';
import 'package:flutter/material.dart';

import '../firebase_pratice/fb_auth.dart';

class projSignUp extends StatefulWidget {
  const projSignUp({super.key});

  @override
  State<projSignUp> createState() => _projSignUpState();
}

class _projSignUpState extends State<projSignUp> {
  @override


    final _usernameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async{
                  // Handle signup logic here
                  final username = _usernameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  // For now, print the inputs
                  print('Username: $username');
                  print('Email: $email');
                  print('Password: $password');



                  UserCredential? user = await signUpWithEmail(email: email, password: password);
                  if(user != null){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>projMain()));
                  }else{
                    print('failed to signup');
                  }
                },
                child: Text('Sign Up'),
              ),
              FilledButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>projLogin()));
              }, child: Text('Go to Log In'))
            ],
          ),
        ),
      );
    }
  }