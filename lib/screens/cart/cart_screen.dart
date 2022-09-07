import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/screens/screens.dart';
import 'package:flutter_food_app/widgets/single_item.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';

class CartScreen extends StatelessWidget {
  final bool isAppDrawer;
  const CartScreen({
    Key? key,
    this.isAppDrawer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.fetchCartedProducts();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Review Cart'),
      bottomNavigationBar: cartProvider.getCartedProductList.isNotEmpty
          ? Card(
              elevation: 4,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: ListTile(
                title: Text(
                  cartProvider.getCartedProductList.length == 1
                      ? 'Total Order: ${cartProvider.getCartedProductList.length} item'
                      : 'Total Order: ${cartProvider.getCartedProductList.length} items',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  'Total Price: \$ ${cartProvider.fetchTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                trailing: SizedBox(
                  width: 160,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DeliveryDetailsScreen(),
                        ),
                      );
                    },
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: cartProvider.getCartedProductList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.getCartedProductList.length,
              itemBuilder: (context, index) {
                CartModel data = cartProvider.getCartedProductList[index];
                ProductModel product = ProductModel(
                  productID: data.cartID,
                  productCategory: '',
                  productName: data.cartName,
                  productImage: data.cartImage,
                  productDetails: '',
                  productPrice: data.cartPrice,
                  productUnit: [],
                );
                return Column(
                  children: [
                    const SizedBox(height: 5),
                    SingleItem(
                      product: product,
                      quantity: data.cartQuantity,
                      isCarted: true,
                      productUnit: data.cartUnit,
                      onDeletePressed: () {
                        AlertDialog alert = AlertDialog(
                          title: const Text(
                            'Remove Product',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.red,
                            ),
                          ),
                          content: Text(
                              'Are you sure to remove "${data.cartName}" from cart?'),
                          actions: [
                            TextButton(
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.grey,
                                ),
                              ),
                              onPressed: () {
                                cartProvider.deleteCartedProduct(
                                    cartID: data.cartID);
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text(
                                'No',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: textColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'No product added into cart',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (isAppDrawer) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Go Shop',
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
