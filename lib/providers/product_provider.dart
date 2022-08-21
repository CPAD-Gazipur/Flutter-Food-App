import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductProvider extends ChangeNotifier {
  List<dynamic> homeBannerList = [];
  List<ProductModel> allProductList = [];
  List<ProductModel> herbsProductList = [];
  List<ProductModel> freshFruitsProductList = [];
  List<ProductModel> rootVegetableProductList = [];

  late ProductModel productModel;

  fetchHomeBanners() async {
    List<dynamic> newList = [];

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('banners')
        .doc('bannerList')
        .get();

    newList = snapshot.get('homeBanners');

    homeBannerList = newList;
  }

  fetchHerbsProduct() async {
    List<ProductModel> newList = [];

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('HerbsProductList').get();

    for (var product in snapshot.docs) {
      productModels(product);
      newList.add(productModel);
    }

    herbsProductList = newList;

    notifyListeners();
  }

  fetchFreshFruitsProduct() async {
    List<ProductModel> newList = [];

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('FreshFruitList').get();

    for (var product in snapshot.docs) {
      productModels(product);
      newList.add(productModel);
    }

    freshFruitsProductList = newList;

    notifyListeners();
  }

  fetchRootVegetableProduct() async {
    List<ProductModel> newList = [];

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('RootVegetableList').get();

    for (var product in snapshot.docs) {
      productModels(product);
      newList.add(productModel);
    }

    rootVegetableProductList = newList;

    notifyListeners();
  }

  productModels(var product) {
    productModel = ProductModel(
      productID: product.get('productID'),
      productName: product.get('productName'),
      productImage: product.get('productImage'),
      productDetails: product.get('productDetails'),
      productPrice: product.get('productPrice'),
      productUnit: product.get('productUnit'),
    );
    allProductList.add(productModel);
  }

  List<dynamic> get getHomeBannerList {
    return homeBannerList;
  }

  List<ProductModel> get getAllProductList {
    return allProductList;
  }

  List<ProductModel> get getHerbsProductList {
    return herbsProductList;
  }

  List<ProductModel> get getFreshFruitsList {
    return freshFruitsProductList;
  }

  List<ProductModel> get getRootVegetableList {
    return rootVegetableProductList;
  }
}
