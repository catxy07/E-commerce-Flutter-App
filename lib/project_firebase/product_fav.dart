import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class productFav extends StatefulWidget {

  // final List<Map<String, dynamic>> favoriteProducts;

  const productFav({Key? key}) : super(key: key);
  @override
  State<productFav> createState() => _productFavState();
}

class _productFavState extends State<productFav> {



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


  Stream<QuerySnapshot> fetchfavorites(){
    return FirebaseFirestore.instance.collection('favorites').snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
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
