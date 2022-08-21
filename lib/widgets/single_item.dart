import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/colors.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../models/models.dart';

class SingleItem extends StatefulWidget {
  final bool isCarted;
  final bool isSearchScreen;
  final ProductModel product;
  final int? quantity;
  final String? productUnit;
  final Function()? onDeletePressed;

  const SingleItem({
    Key? key,
    this.isCarted = false,
    this.isSearchScreen = false,
    required this.product,
    this.productUnit,
    this.quantity,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late String unitData = widget.product.productUnit[0];

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
                imageUrl: widget.product.productImage,
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
                          widget.product.productName,
                          style: TextStyle(
                            color: textColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${widget.product.productPrice.toString()}',
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    widget.isCarted == false
                        ? SizedBox(
                            width: 80,
                            height: 30,
                            child: ProductUnitBottomSheet(
                              title: unitData,
                              fontSize: 12,
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
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          widget.product.productUnit.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(
                                            '${widget.product.productUnit[index]}',
                                          ),
                                          onTap: () {
                                            setState(() {
                                              unitData = widget
                                                  .product.productUnit[index];
                                            });

                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Text(
                            widget.productUnit!,
                            style: const TextStyle(
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
                child: widget.isCarted == false
                    ? Column(
                        crossAxisAlignment: widget.isSearchScreen
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.end,
                        mainAxisAlignment: widget.isSearchScreen
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.center,
                        children: [
                          if (!widget.isSearchScreen)
                            IconButton(
                              onPressed: widget.onDeletePressed,
                              icon: const Icon(Icons.delete),
                            ),
                          if (!widget.isSearchScreen) const SizedBox(height: 5),
                          SizedBox(
                            width: 70,
                            child: ProductCount(
                              product: widget.product,
                              iconSize: 18,
                              textSize: 16,
                              productUnit: unitData,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: widget.onDeletePressed,
                            icon: const Icon(Icons.delete),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 30,
                            width: 65,
                            child: ProductCount(
                              product: widget.product,
                              iconSize: 18,
                              textSize: 16,
                              isCart: widget.isCarted,
                              productUnit: widget.productUnit!,
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
