import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/colors.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../models/models.dart';

class SingleItem extends StatelessWidget {
  final bool isCarted;
  final bool isSearchScreen;
  final ProductModel product;
  final int? quantity;
  final Function()? onDeletePressed;

  const SingleItem({
    Key? key,
    this.isCarted = false,
    this.isSearchScreen = false,
    required this.product,
    this.quantity,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: product.productImage,
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
                  margin: const EdgeInsets.only(
                    right: 16,
                    left: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  height: 100,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        left: 8,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Image.asset('assets/images/placeholder_image.png'),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${product.productPrice.toString()}/50 gram',
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    isCarted == false
                        ? InkWell(
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
                                  child: ListView(
                                    shrinkWrap: true,
                                    //mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: const Text('50 Gram'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('500 Gram'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('1 Kg'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey),
                              ),
                              margin: const EdgeInsets.only(right: 15),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      '50 gram',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const Text(
                            '50 gram',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 90,
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: isCarted == false
                    ? Column(
                        crossAxisAlignment: isSearchScreen
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.end,
                        mainAxisAlignment: isSearchScreen
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.center,
                        children: [
                          if (!isSearchScreen)
                            IconButton(
                              onPressed: onDeletePressed,
                              icon: const Icon(Icons.delete),
                            ),
                          if (!isSearchScreen) const SizedBox(height: 5),
                          SizedBox(
                            width: 70,
                            child: ProductCount(
                              product: product,
                              iconSize: 18,
                              textSize: 16,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: onDeletePressed,
                            icon: const Icon(Icons.delete),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 30,
                            width: 65,
                            child: ProductCount(
                              product: product,
                              iconSize: 18,
                              textSize: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
