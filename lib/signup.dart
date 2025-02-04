import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';
import 'login.dart';
import 'my_firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                }else{
                  print('failed to signup');
                }
              },
              child: Text('Sign Up'),
            ),
            FilledButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            }, child: Text('Go to Log In'))
          ],
        ),
      ),
    );
  }
}