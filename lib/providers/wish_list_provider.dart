import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class WishListProvider extends ChangeNotifier {
  List<WishListModel> wishListedProductList = [];

  void addProductToWishList({
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
        .set({
          'wishListID': wishListID,
          'wishListName': wishListName,
          'wishListImage': wishListImage,
          'wishListPrice': wishListPrice,
          'wishListQuantity': wishListQuantity,
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
        wishListID: wishListProduct.get('wishListID'),
        wishListName: wishListProduct.get('wishListName'),
        wishListImage: wishListProduct.get('wishListImage'),
        wishListPrice: wishListProduct.get('wishListPrice'),
        wishListQuantity: wishListProduct.get('wishListQuantity'),
      );

      newList.add(wishListModel);
    }

    wishListedProductList = newList;
    notifyListeners();
  }

  List<WishListModel> get getWishListedProductList {
    return wishListedProductList;
  }

  void deleteWishListedProduct({required String wishListID}) async {
    await FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyWishListProducts')
        .doc(wishListID)
        .delete()
        .then((value) => debugPrint('Product remove from wishList'))
        .onError((error, stackTrace) => debugPrint('WishListError: $error'));

    notifyListeners();
  }
}
