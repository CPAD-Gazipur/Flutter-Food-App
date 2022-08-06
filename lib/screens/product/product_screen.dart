import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';

import '../screens.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Product Overview',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          ProductBottomNavigationBar(
            title: 'Add To WishList',
            iconData: Icons.favorite_outline,
            color: Colors.white70,
            backgroundColor: textColor,
            iconColor: Colors.grey,
          ),
          ProductBottomNavigationBar(
            title: 'Add To Cart',
            iconData: Icons.shop_outlined,
            color: textColor,
            backgroundColor: primaryColor,
            iconColor: textColor,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Fresh Basil'),
                    subtitle: Text('\$50'),
                  ),
                  Container(
                    height: 250,
                    padding: const EdgeInsets.all(40),
                    child: Image.network(
                        'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png'),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
