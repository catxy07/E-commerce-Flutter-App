import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_testing/project_firebase/product_home.dart';

class ProductOrder extends StatefulWidget {
  const ProductOrder({super.key});

  @override
  State<ProductOrder> createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {
  List<DocumentSnapshot> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('products').get();
    setState(() {
      products = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(height: 145, width: 25),
              Container(
                height: 35,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_left, size: 25),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const productHome()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 110),
              const Text("Order", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
            ],
          ),

        ],
      ),
    );
  }
}
