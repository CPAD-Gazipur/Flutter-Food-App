import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';

class SingleDeliveryItem extends StatelessWidget {
  final String title, address, number, addressType;
  final bool isSelected;
  const SingleDeliveryItem({
    Key? key,
    required this.title,
    required this.address,
    required this.number,
    required this.addressType,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 60,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    addressType,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: CircleAvatar(
            radius: 10,
            backgroundColor: textColor,
            child: Center(
              child: CircleAvatar(
                radius: 8,
                backgroundColor: isSelected ? primaryColor : Colors.white,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 5),
              Text(
                address,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                number,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 35),
      ],
    );
  }
}
