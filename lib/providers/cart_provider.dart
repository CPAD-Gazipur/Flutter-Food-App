import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartedProductList = [];

  void addProductToCart({
    required String cartID,
    required String cartName,
    required String cartImage,
    required num cartPrice,
    required int cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyCartedProducts')
        .doc(cartID)
        .set({
          'cartID': cartID,
          'cartName': cartName,
          'cartImage': cartImage,
          'cartPrice': cartPrice,
          'cartQuantity': cartQuantity,
        })
        .then((value) => debugPrint('Product Added To Cart'))
        .catchError((e) => debugPrint('CartError: $e'));
  }

  void fetchCartedProducts() async {
    List<CartModel> newList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyCartedProducts')
        .get();

    for (var cartProduct in querySnapshot.docs) {
      CartModel cartModel = CartModel(
        cartID: cartProduct.get('cartID'),
        cartName: cartProduct.get('cartName'),
        cartImage: cartProduct.get('cartImage'),
        cartPrice: cartProduct.get('cartPrice'),
        cartQuantity: cartProduct.get('cartQuantity'),
      );

      newList.add(cartModel);
    }

    cartedProductList = newList;
    notifyListeners();
  }

  List<CartModel> get getCartedProductList {
    return cartedProductList;
  }
}
