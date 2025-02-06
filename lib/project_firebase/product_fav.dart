
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/project_firebase/user_id.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class productFav extends StatefulWidget {

  // final List<Map<String, dynamic>> favoriteProducts;

  const productFav({Key? key}) : super(key: key);
  @override
  State<productFav> createState() => _productFavState();
}

class _productFavState extends State<productFav> {

  String userId = '';

  // Future<void> addtoFavourite(Map<String, dynamic> productData) async {
  //   try{
  //     await FirebaseFirestore.instance.collection('favorites').add(productData);
  //     print("Product added to Favorites");
  //   }catch(e){
  //     print("Error adding favorites: $e");
  //   }
  // }



  Future<void> removetoFavorites(String productId) async{
    try{
      await FirebaseFirestore.instance.collection('favorites').doc(productId).delete();
      print("Product removed from favorites! ");
    }catch(e){
      print("Error removing favorites: $e");
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchmethod();
  }
  Future<QuerySnapshot> fetchfavorites() async{
    final db = FirebaseFirestore.instance;

    SharedPreferences share = await SharedPreferences.getInstance();
    String? userId = share.getString('user_id');
    print("id is : $userId");
   return  db.collection("favorites").where("user_id", isEqualTo: userId).get();

    // return FirebaseFirestore.instance.collection('favorites').snapshots();


  }


  Future<void> fetchmethod() async{
    SharedPreferences share = await SharedPreferences.getInstance();
    userId = share.getString('user_id')!;
    print('user id is $userId');
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("favorites").where("user_id", isEqualTo: userId).snapshots(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return Center(child: Text('No favorites added yet.'));
    }

    final favoriteProducts = snapshot.data!.docs;

      return  ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index].data() as Map<String, dynamic>;
          final productId = favoriteProducts[index].id;

          return ListTile(
            leading: Image.asset(product['imagePath'] ?? '', width: 50, height: 50),
            title: Text(product['productNama'] ?? 'Unknown Product'),
            subtitle: Text(product['Descripition'] ?? 'No description available'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removetoFavorites(productId),
            ),
          );
        },
      );
    },
      ),
    );
  }
}
