import 'package:firebase_testing/project_firebase/product_home_list.dart';

class Product {
  String Descripition;
  String imagePath;
  String price;
  String productNama;
  String producttype;

  Product(
      {required this.Descripition,
      required this.imagePath,
      required this.price,
      required this.productNama,
      required this.producttype});

  factory Product.toJson(Map<String, dynamic> json) {
    return Product(
        Descripition: json['Descripition'],
        imagePath: json['imagePath'],
        price: json['price'],
        productNama: json['productNama'],
        producttype: json['producttype']);
  }
}
