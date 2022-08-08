import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';

import '../screens.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  SignInCharacter? _character = SignInCharacter.fill;

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
            child: Container(
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
                    child: Hero(
                      tag:
                          'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
                      child: Image.network(
                          'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png'),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              activeColor: Colors.green[700],
                              value: SignInCharacter.fill,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value as SignInCharacter?;
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          '\$0.10 / 50gram',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: textColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 17,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'ADD',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              activeColor: Colors.green[700],
                              value: SignInCharacter.cover,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value as SignInCharacter?;
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          '\$0.20 / 100gram',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: textColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 17,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'ADD',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
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
                    'In marketing, a product is an object, or system, or service made available for consumer use as of the consumer demand; it is anything that can be offered to a market to satisfy the desire or need of a customer.',
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
          ),
        ],
      ),
    );
  }
}
