import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../providers/providers.dart';

class ProductCount extends StatefulWidget {
  final ProductModel product;
  final double iconSize;
  final double textSize;
  final bool isCart;
  final String productUnit;
  const ProductCount({
    Key? key,
    required this.product,
    required this.productUnit,
    this.iconSize = 14,
    this.textSize = 12,
    this.isCart = false,
  }) : super(key: key);

  @override
  State<ProductCount> createState() => _ProductCountState();
}

class _ProductCountState extends State<ProductCount> {
  int productCount = 1;
  bool isAdded = false;

  void getAddedProductAndProductQuantity() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyCartedProducts')
        .doc(widget.product.productID)
        .get()
        .then((value) {
      if (mounted && value.exists) {
        setState(() {
          isAdded = value.get('isAdded');
          productCount = value.get('cartQuantity');
        });
      } else {
        isAdded = false;
        productCount = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    getAddedProductAndProductQuantity();
    return isAdded
        ? Container(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (productCount > 1) {
                        productCount--;
                        cartProvider.updateProductToCart(
                          cartID: widget.product.productID,
                          cartName: widget.product.productName,
                          cartImage: widget.product.productImage,
                          cartPrice: widget.product.productPrice,
                          cartQuantity: productCount,
                          cartUnit: widget.productUnit,
                        );
                      } else {
                        if (widget.isCart) {
                          Fluttertoast.showToast(
                            msg: "You reach minimum limit",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.amberAccent,
                            textColor: Colors.black87,
                            fontSize: 16.0,
                          );
                        } else {
                          isAdded = false;
                          cartProvider.deleteCartedProduct(
                            cartID: widget.product.productID,
                          );
                          Fluttertoast.showToast(
                            msg:
                                '${widget.product.productName} remove from cart',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.amberAccent,
                            textColor: Colors.black87,
                            fontSize: 16.0,
                          );
                        }
                      }
                    });
                  },
                  child: Container(
                    width: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.remove,
                        size: 11,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '$productCount',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF333333),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (productCount < 10) {
                        productCount++;
                        cartProvider.updateProductToCart(
                          cartID: widget.product.productID,
                          cartName: widget.product.productName,
                          cartImage: widget.product.productImage,
                          cartPrice: widget.product.productPrice,
                          cartQuantity: productCount,
                          cartUnit: widget.productUnit,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "You reach maximum limit",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.amberAccent,
                          textColor: Colors.black87,
                          fontSize: 16.0,
                        );
                      }
                    });
                  },
                  child: Container(
                    width: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 11,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 30,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isAdded = true;
                });

                cartProvider.addProductToCart(
                  cartID: widget.product.productID,
                  cartName: widget.product.productName,
                  cartImage: widget.product.productImage,
                  cartPrice: widget.product.productPrice,
                  cartQuantity: productCount,
                  cartUnit: widget.productUnit,
                );

                Fluttertoast.showToast(
                  msg: '${widget.product.productName} added to cart',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.amberAccent,
                  textColor: Colors.black87,
                  fontSize: 16.0,
                );
              },
              child: Center(
                child: Text(
                  'ADD',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
          );
  }
}
