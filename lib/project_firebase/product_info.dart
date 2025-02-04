import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_testing/project_firebase/product_fav.dart';
import 'package:firebase_testing/project_firebase/product_home.dart';
import 'package:firebase_testing/project_firebase/product_home_list.dart';
import 'package:firebase_testing/project_firebase/product_info.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductInfo extends StatefulWidget {
  final Map<String, dynamic> productData;

  const ProductInfo({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  List<DocumentSnapshot> products = [];

  @override
  // void initState() {
  //   super.initState();
  //   fetchproduct();
  //
  // }
  // Future<void> fetchproduct() async {

  //     final database =
  //     await FirebaseFirestore.instance.collection('data').get();
  //     setState(() {
  //        products = database.docs;
  //     });
  //   } catch (e) {
  //     print("Error from fetch: $e");
  //   }
  // }

  // void listForRealtimeUpdate() {
  //   FirebaseFirestore.instance
  //       .collection('data')
  //       .snapshots()
  //       .listen((realTime) {
  //     setState(() {
  //       products = realTime.docs;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 145,
                  width: 25,
                ),
                Container(
                    padding: EdgeInsets.only(),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.00),
                          topRight: Radius.circular(10.00)),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_left,
                        size: 32,
                      ),
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => productHome()));
                        Navigator.pop(context);
                      },
                    )),
                SizedBox(
                  width: 95,

                ),
                Container(
                    child: Text(
                  "For you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
                SizedBox(
                  width: 60,
                ),
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 450,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // final position = products[index];
                  // final productData = products.data() as Map<String, dynamic>;
                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 380,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image:
                            AssetImage(widget.productData['imagePath'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(right: 175),
                  child: Text(
                    widget.productData['productNama'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 135),
                  child: Text(widget.productData['Descripition'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 290, top: 40),
                  child: Text("\$ " + widget.productData['price'] + ".00",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 380,
                  height: 70,
                  decoration: BoxDecoration(),
                  child: FilledButton(
                    onPressed: () {},
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
