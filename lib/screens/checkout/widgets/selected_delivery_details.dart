import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../models/models.dart';

class SelectedDeliveryDetails extends StatelessWidget {
  final DeliveryAddressModel deliveryAddress;

  const SelectedDeliveryDetails({
    Key? key,
    required this.deliveryAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deliveryAddress.name,
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
                    deliveryAddress.addressType.toUpperCase(),
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 5),
              Text(
                '${deliveryAddress.streetAddress} - ${deliveryAddress.zipCode}, ${deliveryAddress.city}',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                deliveryAddress.phoneNumber,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
