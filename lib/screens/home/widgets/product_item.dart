import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  final Function() onProductClicked;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onProductClicked,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late String unitData = widget.product.productUnit[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: 160,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: widget.onProductClicked,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 140,
              imageUrl: widget.product.productImage,
              imageBuilder: (context, imageProvider) => Center(
                child: Container(
                  height: 140,
                  width: 150,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade50,
                  ),
                  child: Hero(
                    tag: widget.product.productImage,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
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
                  child: Image.asset('assets/images/placeholder_image.png'),
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Container(
                  height: 140,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade50,
                  ),
                  child: Icon(
                    Icons.image,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
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
                    Text(
                      '\$${widget.product.productPrice.toString()}/${widget.product.productUnit[0]}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ProductUnitBottomSheet(
                                title: unitData,
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
                                              unitData = widget
                                                  .product.productUnit[index];
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
                            const SizedBox(width: 8.0),
                            ProductCount(
                              product: widget.product,
                              productUnit: unitData,
                            ),
                          ],
                        ),
                      ),
                    )
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
