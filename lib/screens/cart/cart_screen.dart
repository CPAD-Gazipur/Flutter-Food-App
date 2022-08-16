import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.fetchCartedProducts();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Review Cart',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: const Text(
          'Total Order',
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
        subtitle: Text(
          '\$ 145.00',
          style: TextStyle(
            color: Colors.green[900],
            fontFamily: 'Roboto',
          ),
        ),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            onPressed: () {},
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
      body: cartProvider.getCartedProductList.isNotEmpty
          ? ListView.builder(
              itemCount: cartProvider.getCartedProductList.length,
              itemBuilder: (context, index) {
                CartModel data = cartProvider.getCartedProductList[index];
                ProductModel product = ProductModel(
                  productID: data.cartID,
                  productName: data.cartName,
                  productImage: data.cartImage,
                  productDetails: '',
                  productPrice: data.cartPrice,
                );
                return Column(
                  children: [
                    const SizedBox(height: 5),
                    SingleItem(
                      product: product,
                      quantity: data.cartQuantity,
                      isCarted: true,
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
                    'No product Added into Cart',
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
                      Navigator.pop(context);
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
