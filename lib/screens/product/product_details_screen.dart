import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
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
