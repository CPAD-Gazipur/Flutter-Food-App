import 'package:flutter/material.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';

class ProductCount extends StatefulWidget {
  final ProductModel product;
  const ProductCount({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductCount> createState() => _ProductCountState();
}

class _ProductCountState extends State<ProductCount> {
  int productCount = 1;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      height: 30,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: isAdded
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (productCount > 1) {
                        productCount--;
                      } else {
                        isAdded = false;
                      }
                    });
                  },
                  child: Icon(
                    Icons.remove,
                    size: 14,
                    color: primaryColor,
                  ),
                ),
                Text(
                  '$productCount',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      productCount++;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    size: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            )
          : InkWell(
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
                );
              },
              child: Center(
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
    );
  }
}
