import 'package:flutter/material.dart';

import '../config/config.dart';

class ProductCount extends StatefulWidget {
  const ProductCount({Key? key}) : super(key: key);

  @override
  State<ProductCount> createState() => _ProductCountState();
}

class _ProductCountState extends State<ProductCount> {
  int productCount = 1;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: isAdded
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (productCount > 1) {
                        productCount--;
                      } else {
                        isAdded = false;
                      }
                    });
                  },
                  child: Icon(
                    Icons.remove,
                    size: 14,
                    color: primaryColor,
                  ),
                ),
                Text(
                  '$productCount',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      productCount++;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    size: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isAdded = true;
                });
              },
              child: Center(
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
    );
  }
}
