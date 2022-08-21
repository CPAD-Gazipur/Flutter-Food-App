import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class WishListProvider extends ChangeNotifier {
  List<ProductModel> wishListedProductList = [];

  void addProductToWishList({
    required String productID,
    required String productCategory,
  }) async {
    await FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyWishListProducts')
        .doc(productID)
        .set({
          'productID': productID,
          'productCategory': productCategory,
          'isWishListed': true,
        })
        .then((value) => debugPrint('Product Added To WishList'))
        .catchError((e) => debugPrint('WishListError: $e'));

    notifyListeners();
  }

  void fetchWishListedProducts() async {
    List<WishListModel> newList = [];
    List<ProductModel> newProductList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyWishListProducts')
        .get();

    for (var wishListProduct in querySnapshot.docs) {
      WishListModel wishListModel = WishListModel(
        productID: wishListProduct.get('productID'),
        productCategory: wishListProduct.get('productCategory'),
      );

      newList.add(wishListModel);
    }

    for (var wishListProduct in newList) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(wishListProduct.productCategory)
          .doc(wishListProduct.productID)
          .get();

      ProductModel productModel = ProductModel(
        productID: snapshot.get('productID'),
        productCategory: snapshot.get('productCategory'),
        productName: snapshot.get('productName'),
        productImage: snapshot.get('productImage'),
        productDetails: snapshot.get('productDetails'),
        productPrice: snapshot.get('productPrice'),
        productUnit: snapshot.get('productUnit'),
      );

      newProductList.add(productModel);
    }

    wishListedProductList = newProductList;
    notifyListeners();
  }

  List<ProductModel> get getWishListedProductList {
    return wishListedProductList;
  }

  void deleteWishListedProduct({required String productID}) async {
    await FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyWishListProducts')
        .doc(productID)
        .delete()
        .then((value) => debugPrint('Product remove from wishList'))
        .onError((error, stackTrace) => debugPrint('WishListError: $error'));

    notifyListeners();
  }
}
