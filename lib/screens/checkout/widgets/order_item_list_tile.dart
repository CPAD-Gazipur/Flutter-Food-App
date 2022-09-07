import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/config.dart';

class OrderItemListTile extends StatelessWidget {
  final CartModel productDetails;
  const OrderItemListTile({
    Key? key,
    required this.productDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        width: 60,
        imageUrl: productDetails.cartImage,
        imageBuilder: (context, imageProvider) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        placeholder: (context, url) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Image.asset(
              'assets/images/placeholder_image.png',
              width: 60,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              productDetails.cartName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            productDetails.cartUnit,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
          ),
          Text(
            '\$ ${productDetails.cartPrice}',
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      subtitle: Text(
        'Total Item: ${productDetails.cartQuantity}',
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
