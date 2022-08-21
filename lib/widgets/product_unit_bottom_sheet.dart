import 'package:flutter/material.dart';

class ProductUnitBottomSheet extends StatelessWidget {
  final String title;
  final double fontSize;
  final Function() onTap;
  const ProductUnitBottomSheet({
    Key? key,
    required this.title,
    required this.onTap,
    this.fontSize = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 50,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
