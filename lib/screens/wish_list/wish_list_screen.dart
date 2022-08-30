import 'package:flutter/material.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late WishListProvider wishListProvider;

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of<WishListProvider>(context);
    wishListProvider.fetchWishListedProducts();

    return Scaffold(
      appBar: const CustomAppBar(title: 'WishList'),
      body: wishListProvider.getWishListedProductList.isNotEmpty
          ? ListView.builder(
              itemCount: wishListProvider.getWishListedProductList.length,
              itemBuilder: (context, index) {
                ProductModel product =
                    wishListProvider.getWishListedProductList[index];
                return Column(
                  children: [
                    const SizedBox(height: 5),
                    SingleItem(
                      product: product,
                      isCarted: false,
                      productUnit: '',
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
                              'Are you sure to remove "${product.productName}" from wishlist?'),
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
                                wishListProvider.deleteWishListedProduct(
                                  productID: wishListProvider
                                      .getWishListedProductList[index]
                                      .productID,
                                );
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
                    'No product added into wishlist',
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
