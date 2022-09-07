import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../screens.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late String unitData = widget.product.productUnit[0];

  bool isWishListed = false;
  bool isCarted = false;

  void getWishListedProduct() {
    FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyWishListProducts')
        .doc(widget.product.productID)
        .get()
        .then((value) {
      if (mounted && value.exists) {
        setState(() {
          isWishListed = value.get('isWishListed');
        });
      } else {
        isWishListed = false;
      }
    });
  }

  void getCartAddedProduct() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyCartedProducts')
        .doc(widget.product.productID)
        .get()
        .then((value) {
      if (mounted && value.exists) {
        setState(() {
          isCarted = value.get('isAdded');
        });
      } else {
        isCarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    wishListProvider.fetchWishListedProducts();
    getWishListedProduct();
    getCartAddedProduct();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Product Overview'),
      bottomNavigationBar: Row(
        children: [
          ProductBottomNavigationBar(
            title: isWishListed ? 'Added' : 'Add To WishList',
            iconData: isWishListed ? Icons.favorite : Icons.favorite_outline,
            color: Colors.white70,
            backgroundColor: textColor,
            iconColor: isWishListed ? Colors.red : Colors.grey,
            onTap: () {
              setState(() {
                isWishListed = !isWishListed;

                if (isWishListed) {
                  wishListProvider.addProductToWishList(
                    productID: widget.product.productID,
                    productCategory: widget.product.productCategory,
                  );
                } else {
                  wishListProvider.deleteWishListedProduct(
                    productID: widget.product.productID,
                  );
                }
              });
            },
          ),
          ProductBottomNavigationBar(
            title: isCarted ? 'Go To Cart' : 'Add To Cart',
            iconData: Icons.shop_outlined,
            color: textColor,
            backgroundColor: primaryColor,
            iconColor: textColor,
            onTap: () {
              if (isCarted) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ));
              } else {
                cartProvider.addProductToCart(
                  cartID: widget.product.productID,
                  cartName: widget.product.productName,
                  cartImage: widget.product.productImage,
                  cartPrice: widget.product.productPrice,
                  cartQuantity: 1,
                  cartUnit: unitData,
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(widget.product.productName),
                subtitle: Text('\$${widget.product.productPrice}'),
              ),
              CachedNetworkImage(
                imageUrl: widget.product.productImage,
                imageBuilder: (context, imageProvider) => Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: 40,
                  ),
                  child: Hero(
                    tag: widget.product.productImage,
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  height: 250,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Image.asset('assets/images/placeholder_image.png'),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Available Option',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 15,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ProductUnitBottomSheet(
                        title: unitData,
                        fontSize: 16,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                ),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.product.productUnit.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(
                                      '${widget.product.productUnit[index]}',
                                    ),
                                    onTap: () {
                                      setState(() {
                                        unitData =
                                            widget.product.productUnit[index];
                                      });

                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                        ),
                        child: ProductCount(
                          product: widget.product,
                          productUnit: unitData,
                          iconSize: 20,
                          textSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About This Product',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.productDetails,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
