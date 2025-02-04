import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_testing/firebase_pratice/flash.dart';
import 'package:flutter/material.dart';

class HomePratice extends StatefulWidget {
  const HomePratice({super.key});

  @override
  State<HomePratice> createState() => _HomePraticeState();
}

class _HomePraticeState extends State<HomePratice> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        body: Material(
      child: Center(
        child: user == null
            ? CircularProgressIndicator() // Show loading indicator while waiting for user data
            : Column(
                children: [
                  Text(
                    "Child is ${user!.uid}",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Email is ${user!.email}",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Flash()));
                      },
                      child: Text("Sign Out"))
                ],
              ),
      ),
    ));
  }
}
