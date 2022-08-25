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
    required String cartUnit,
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
          'cartUnit': cartUnit,
          'isAdded': true,
        })
        .then((value) => debugPrint('Product Added To Cart'))
        .catchError((e) => debugPrint('CartError: $e'));

    notifyListeners();
  }

  void updateProductToCart({
    required String cartID,
    required String cartName,
    required String cartImage,
    required num cartPrice,
    required int cartQuantity,
    required String cartUnit,
  }) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyCartedProducts')
        .doc(cartID)
        .update({
          'cartID': cartID,
          'cartName': cartName,
          'cartImage': cartImage,
          'cartPrice': cartPrice,
          'cartQuantity': cartQuantity,
          'cartUnit': cartUnit,
          'isAdded': true,
        })
        .then((value) => debugPrint('Product Updated To Cart'))
        .catchError((e) => debugPrint('CartError: $e'));

    notifyListeners();
  }

  void fetchCartedProducts() async {
    List<CartModel> newList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('MyCartedProducts')
        .get();

    for (var cartProduct in querySnapshot.docs) {
      CartModel cartModel = CartModel(
        cartID: cartProduct.get('cartID'),
        cartName: cartProduct.get('cartName'),
        cartImage: cartProduct.get('cartImage'),
        cartPrice: cartProduct.get('cartPrice'),
        cartQuantity: cartProduct.get('cartQuantity'),
        cartUnit: cartProduct.get('cartUnit'),
      );

      newList.add(cartModel);
    }

    cartedProductList = newList;
    notifyListeners();
  }

  List<CartModel> get getCartedProductList {
    return cartedProductList;
  }

  double fetchTotalPrice() {
    double totalPrice = 0;
    for (var product in cartedProductList) {
      totalPrice += product.cartPrice * product.cartQuantity;
    }
    return totalPrice;
  }

  void deleteCartedProduct({required String cartID}) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyCartedProducts')
        .doc(cartID)
        .delete()
        .then((value) => debugPrint('Product remove from cart'))
        .onError((error, stackTrace) => debugPrint('Error: $error'));

    notifyListeners();
  }
}
