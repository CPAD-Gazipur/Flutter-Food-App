import 'package:flutter/material.dart';

class ProductBottomNavigationBar extends StatelessWidget {
  final Color color, iconColor, backgroundColor;
  final IconData iconData;
  final String title;
  final Function() onTap;

  const ProductBottomNavigationBar({
    Key? key,
    required this.title,
    required this.iconData,
    required this.color,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
