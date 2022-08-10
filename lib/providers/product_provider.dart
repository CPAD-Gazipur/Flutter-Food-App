import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> herbsProductList = [];

  getHerbsProduct() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('HerbsProductList').get();

    for (var product in snapshot.docs) {
      debugPrint('${product.data()}');
      debugPrint(product.get('productName'));
    }
  }
}
