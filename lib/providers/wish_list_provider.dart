import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class WishListProvider extends ChangeNotifier {
  List<WishListModel> wishListedProductList = [];
  late ProductModel productModel;

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

  /*void updateProductToWishList({
    required String wishListID,
    required String wishListName,
    required String wishListImage,
    required num wishListPrice,
    required int wishListQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyWishListProducts')
        .doc(wishListID)
        .update({
          'wishListID': wishListID,
          'wishListName': wishListName,
          'wishListImage': wishListImage,
          'wishListPrice': wishListPrice,
          'wishListQuantity': wishListQuantity,
          'isWishListed': true,
        })
        .then((value) => debugPrint('Product Updated To Cart'))
        .catchError((e) => debugPrint('CartError: $e'));

    notifyListeners();
  }*/

  void fetchWishListedProducts() async {
    List<WishListModel> newList = [];

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

    wishListedProductList = newList;
    notifyListeners();
  }

  List<WishListModel> get getWishListedProductList {
    return wishListedProductList;
  }

  void fetchSingleWishListProduct({
    required String productID,
    required String productCategory,
  }) async {
    ProductModel newProductModel;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(productCategory)
        .doc(productID)
        .get();

    newProductModel = ProductModel(
      productID: snapshot.get('productID'),
      productCategory: snapshot.get('productCategory'),
      productName: snapshot.get('productName'),
      productImage: snapshot.get('productImage'),
      productDetails: snapshot.get('productDetails'),
      productPrice: snapshot.get('productPrice'),
      productUnit: snapshot.get('productUnit'),
    );

    productModel = newProductModel;
  }

  ProductModel get getSingleWishListProduct {
    return productModel;
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
