import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/project_firebase/product_fav.dart';
import 'package:firebase_testing/project_firebase/product_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class productHome extends StatefulWidget {
  const productHome({super.key});

  @override
  State<productHome> createState() => _productHomeState();
}

class _productHomeState extends State<productHome> {
//   final Product product;
//   _productHomeState({
//     required this.product
// });
  final List<Map<String, String>> item = [
    {
      "image": "assets/shoes.png",
      "title": "Shoes",
      "subtitle": "Alessia Nesca"
    },
    {
      "image": "assets/black.jpg",
      "title": "shoes",
      "subtitle": "Vector Blackest"
    },
    {
      "image": "assets/blackWhite.jpg",
      "title": "Shoes",
      "subtitle": "Woren Jeserted"
    },
    {
      "image": "assets/blackOrange.jpg",
      "title": "Shoes",
      "subtitle": "Alessia Nesca"
    },
    // {
    //   "image": "assets/shoes.png",
    //   "title": "Shoes",
    //   "subtitle": "Alessia Nesca"
    // },
  ];

  List<DocumentSnapshot> products = [];

  List<Map<String, dynamic>> Favproduct = [];

  Future<void> addtoFavourite(Map<String, dynamic> productData) async {
    SharedPreferences share = await SharedPreferences.getInstance();
    String? userId = share.getString('user_id');

    if (userId == null) {
      print("User ID not found");
      return;
    }

    productData['user_id'] = userId;

    try {
      await FirebaseFirestore.instance.collection('favorites').add(productData);
      print("Product added to Favorites ✅");
    } catch (e) {
      print("Error adding to favorites: $e ❌");
    }
  }

  Future<void> removetoFavorites(String favoriteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(favoriteId)
          .delete();
      print("Product removed from favorites ✅");
    } catch (e) {
      print("Error removing from favorites: $e ❌");
    }
  }

  void ClicktoFav(DocumentSnapshot productSnapshot) async {
    try {
      SharedPreferences share = await SharedPreferences.getInstance();
      String? userId = share.getString('user_id');

      if (userId == null) {
        print("User ID not found");
        return;
      }

      String productId = productSnapshot.id; // Unique product document ID

      // Check if the product is already in the user's favorites
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('user_id', isEqualTo: userId)
          .where('productId', isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Product is not in favorites, add it
        Map<String, dynamic> productData =
            productSnapshot.data() as Map<String, dynamic>;
        productData['user_id'] = userId;
        productData['productId'] = productId; // Store product ID in Firestore

        await addtoFavourite(productData);
      } else {
        // Product already in favorites, remove it
        await removetoFavorites(querySnapshot.docs.first.id);
      }
    } catch (e) {
      print("Error in ClicktoFav: $e");
    }
  }

  void initState() {
    super.initState();
    fetchproduct();
    listForRealtimeUpdate();
  }

  Future<void> fetchproduct() async {
    try {
      final database =
          await FirebaseFirestore.instance.collection('data').get();
      setState(() {
        products = database.docs;
      });
    } catch (e) {
      print("Error from fetch: $e");
    }
  }

  void listForRealtimeUpdate() {
    FirebaseFirestore.instance
        .collection('data')
        .snapshots()
        .listen((realTime) {
      setState(() {
        products = realTime.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Material(
          // borderOnForeground: debugPaintSizeEnabled = true,
          color: Colors.black87,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 10,
                    width: 29,
                  ),
                  // Icon(Icons.search),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // color: Colors.black26,
                    padding: EdgeInsets.only(top: 5),
                    width: 230,
                    height: 50,

                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white)),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 53,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.energy_savings_leaf_outlined,
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 53,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.money_off,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => productFav()),
                      );
                    },
                    child: Container(
                      width: 90,
                      height: 32,
                      padding: EdgeInsets.only(left: 16, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Text(
                        "Favorites",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 90,
                    height: 32,
                    padding: EdgeInsets.only(left: 14, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Text(
                      "Following",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 90,
                    height: 32,
                    padding: EdgeInsets.only(left: 20, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Text(
                      "On sale",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0),
                  ),
                  color: Colors.white,
                ),
                height: 800,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 20,
                        ),
                        Text(
                          "Order",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.00),
                                  topRight: Radius.circular(10.00)),
                            ),
                            child: Icon(Icons.arrow_right)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 160,
                        // Ensure the container wrapping the ListView has a height
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: item.length,
                          itemBuilder: (context, index) {
                            final pos = item[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9.0),
                              child: Container(
                                width: 300,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      pos["image"] ?? "",
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 95,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(right: 70),
                                          child: Text(
                                            pos["title"] ?? "",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          pos["subtitle"] ?? "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "For you",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.black87),
                        ),
                        SizedBox(width: 10),
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(Icons.arrow_right)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 360,
                          child: ListView.builder(
                            itemCount: (products.length / 2).ceil(),
                            // Number of rows needed
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, rowIndex) {
                              final product = products[rowIndex];
                              final isFav = Favproduct.contains(product);
                              // Extract two products for each row
                              final startIndex = rowIndex * 2;
                              final endIndex =
                                  (startIndex + 2).clamp(0, products.length);
                              final rowItems =
                                  products.sublist(startIndex, endIndex);

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: rowItems.map((product) {
                                  final productData =
                                      product.data() as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductInfo(
                                                      productData:
                                                          productData,
                                                    )));
                                      },
                                      child: SizedBox(
                                        width: 168,
                                        child: Column(
                                          children: [
                                            // InkWell(
                                            //   onTap: (){
                                            //     Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductInfo()));
                                            //   },
                                            // ),
                                            Align(
                                              child: Container(
                                                  height: 40,
                                                  width: 50,
                                                  // color: Colors.orange,

                                                  child: IconButton(
                                                      icon: Icon(
                                                        isFav
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: isFav
                                                            ? Colors.red
                                                            : Colors.grey,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        print('ha bhai ');
                                                        ClicktoFav(products[
                                                            rowIndex]);
                                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> productFav(favoriteProducts: Favproduct,)));
                                                      }
                                                      // => ClicktoFav(product[index]),
                                                      )),
                                              alignment: Alignment.topRight,
                                            ),

                                            Container(
                                              width: 200,
                                              height: 175,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      productData[
                                                              'imagePath'] ??
                                                          ''),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  productData[
                                                          'productNama'] ??
                                                      'Unknown Product',
                                                  style: const TextStyle(
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  productData[
                                                          'Descripition'] ??
                                                      'No description available',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '\$${productData['price'] ?? 0}',
                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
