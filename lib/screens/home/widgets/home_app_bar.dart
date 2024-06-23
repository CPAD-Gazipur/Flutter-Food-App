import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_food_app/providers/providers.dart';

import '../../../config/config.dart';
import '../../screens.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProductProvider productProvider;
  final CartProvider cartProvider;
  const HomeAppBar({
    Key? key,
    required this.productProvider,
    required this.cartProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: textColor),
      title: Text(
        'Home',
        style: TextStyle(color: textColor),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  searchProducts: productProvider.getAllProductList,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.search,
            color: textColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: cartProvider.getCartedProductList.isNotEmpty
                ? badge.Badge(
                    toAnimate: true,
                    shape: badge.BadgeShape.circle,
                    animationType: badge.BadgeAnimationType.slide,
                    badgeColor: Colors.red,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    badgeContent: Text(
                      cartProvider.cartedProductList.length > 9
                          ? '9+'
                          : '${cartProvider.cartedProductList.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    child: Icon(
                      Icons.shop,
                      color: textColor,
                    ),
                  )
                : Icon(
                    Icons.shop,
                    color: textColor,
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
