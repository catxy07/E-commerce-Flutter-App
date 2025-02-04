import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/splash.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: user == null
            ? CircularProgressIndicator() // Show loading indicator while waiting for user data
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User ID: ${user!.uid}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${user!.email}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                // Handle logout logic
                await FirebaseAuth.instance.signOut();
                // After logging out, navigate back to the login screen or any other screen
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) =>
                        Splash())); // Assuming you have a login screen
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}