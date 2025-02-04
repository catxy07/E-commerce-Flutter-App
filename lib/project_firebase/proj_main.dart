import 'package:firebase_testing/project_firebase/product_fav.dart';
import 'package:firebase_testing/project_firebase/product_home.dart';
import 'package:firebase_testing/project_firebase/product_order.dart';
import 'package:firebase_testing/project_firebase/user_id.dart';
import 'package:flutter/material.dart';

class projMain extends StatefulWidget {
  const projMain({super.key});

  @override
  State<projMain> createState() => _projMain();
}

class _projMain extends State<projMain> {
  int index = 0;
  List<Widget> screen = <Widget>[
    productHome(),
    ProductOrder(),
    productFav(),
    userId()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,

        selectedItemColor: Colors.white,
        onTap: (int e) {
          setState(() {
            index = e;
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border, color: Colors.black,), label: "Order"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, color: Colors.black,), label: "Favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: "Profile"),
        ],
      ),
    );
  }
}
