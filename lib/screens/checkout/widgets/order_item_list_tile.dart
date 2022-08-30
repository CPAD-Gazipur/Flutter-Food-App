import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/config.dart';

class OrderItemListTile extends StatelessWidget {
  const OrderItemListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        width: 60,
        imageUrl:
            'https://www.nicepng.com/png/full/927-9276396_mint-png-clipart-background-fresh-mint.png',
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
          Text(
            'Fresh Mint',
            style: TextStyle(
              color: textColor,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            '50 Gram',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
          ),
          const Text(
            '\$ 2.5',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      subtitle: const Text(
        'Total Item: 2',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
