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
        padding: EdgeInsets.only(
          top: 8.0,
          bottom: widget.isCarted ? 0 : 8.0,
          left: 8.0,
          right: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  width: 130,
                  imageUrl: widget.product.productImage,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 100,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider),
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
                        child: Image.asset(
                          'assets/images/placeholder_image.png',
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    margin: const EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                Expanded(
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
                          Row(
                            children: [
                              if (widget.isCarted)
                                Text(
                                  widget.productUnit ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              if (widget.isCarted) const Text(' - '),
                              Text(
                                '\$${widget.product.productPrice.toString()}',
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (widget.isCarted)
                                const Text(
                                  ' x ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              if (widget.isCarted)
                                Text(
                                  '${widget.quantity}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      if (!widget.isCarted)
                        Column(
                          children: [
                            const SizedBox(height: 5.0),
                            SizedBox(
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
                            ),
                          ],
                        ),
                      if (widget.isCarted)
                        Column(
                          children: [
                            const SizedBox(height: 8.0),
                            SizedBox(
                              height: 25,
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
                    ],
                  ),
                ),
                widget.isCarted
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$${(widget.product.productPrice * num.parse(widget.quantity.toString())).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          height: 90,
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Column(
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
                              if (!widget.isSearchScreen)
                                const SizedBox(height: 5),
                              SizedBox(
                                height: 25,
                                child: ProductCount(
                                  product: widget.product,
                                  iconSize: 18,
                                  textSize: 16,
                                  productUnit: unitData,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
            if (widget.isCarted)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: widget.onDeletePressed,
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/ic_delete.png',
                          height: 15,
                          color: const Color(0xFF737373),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Remove',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: const Color(0xFF737373),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/icons/ic_save.png',
                          height: 14,
                          color: const Color(0xFF737373),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Save for later',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: const Color(0xFF737373),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
