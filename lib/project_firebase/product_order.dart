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
  int m = 50;
  Map<String, int> productCount = {};
  @override
  void initState() {
    super.initState();
    fetchproduct();
    listForRealtimeUpdate();
  }

  Future<void> fetchproduct() async {
    try {
      final database =
          await FirebaseFirestore.instance.collection('cart').get();
      setState(() {
        products = database.docs;
        for (var product in products) {
          productCount.putIfAbsent(product.id, () => 1); // Ensure all products have a count
        }
      });

    } catch (e) {
      print("Error from fetch: $e");
    }
  }



  void _increment(String productID) {
    setState(() {
      productCount[productID] = (productCount[productID] ?? 1) + 1;
    });
  }

  void _decrement(String productID) {
    setState(() {
      if(productCount[productID]! > 1 ){
        productCount[productID] = (productCount[productID] ?? 1) -1;
      }
    });
  }

  void listForRealtimeUpdate() {
    FirebaseFirestore.instance
        .collection('data')
        .snapshots()
        .listen((realTime) {
      setState(() {
        products = realTime.docs;
        for (var product in products) {
          productCount.putIfAbsent(product.id, () => 1); // Ensure all products have a count
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.arrow_back_ios, size: 20),
                ),
              ),
            ),
            SizedBox(
              width: 100,
            ),
            Text("Order",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
          ],
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final productcount = productCount[product.id] ?? 1;
          final a = product['price'];
          int price = int.parse(a);
          // final product = products[index];
          // final productData = product.data() as Map<String, dynamic>;
          // return Card(
          //   child: SizedBox(
          //     height: 400,
          //     child: Column(
          //       children: [
          //         Container(
          //           width: 200,
          //           height: 170,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8.0),
          //             image: DecorationImage(
          //               image: AssetImage(
          //                   productData['imagePath'] ?? ''),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //         Text(
          //           productData['productNama'] ?? 'Unknown Product',
          //           style: const TextStyle(
          //             fontSize: 21,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         const SizedBox(height: 5),
          //         Text(
          //           productData['Descripition'] ??
          //               'No description available',
          //           style: const TextStyle(
          //             fontSize: 14,
          //             color: Colors.grey,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // );
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  // color: Colors.black,
                  padding: EdgeInsets.only(right: 10),
                  width: 130,
                  height: 150,
                  child: Image.asset(
                    product['imagePath'] ?? "",
                    // width: 280,
                    // height: 250,
                  ),
                ),
                // SizedBox(width: 10,), // SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: Text(
                        product['productNama'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        product['Descripition'],
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              _decrement(product.id);

                            },

                            child: Text(
                              "-",
                              style: TextStyle(fontSize: 45),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "$productcount",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                              onTap: () {
                                _increment(product.id);
                              },
                              child: Text("+", style: TextStyle(fontSize: 30))),
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                    padding: EdgeInsets.only(left: 40),
                    child: Text("\$${price * productcount}.00",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)))
              ],
            ),
          );
        },
      ),
    );
  }
}
