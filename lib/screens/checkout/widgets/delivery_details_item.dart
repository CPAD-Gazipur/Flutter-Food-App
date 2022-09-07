import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/providers/providers.dart';

class DeliveryDetailsItem extends StatelessWidget {
  final DeliveryAddressModel deliveryAddress;
  final CheckoutProvider checkoutProvider;
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final bool isSelected;
  final bool isLeading;
  const DeliveryDetailsItem({
    Key? key,
    required this.deliveryAddress,
    required this.checkoutProvider,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isSelected = false,
    this.isLeading = true,
  }) : super(key: key);

  void deleteDeliveryAddress(
    BuildContext context,
  ) {
    AlertDialog alert = AlertDialog(
      title: const Text(
        'Warning!!!',
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.red,
        ),
      ),
      content: Text(
          'Are you sure to delete ${deliveryAddress.addressType} address?'),
      actions: [
        TextButton(
          child: const Text(
            'Yes',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.grey,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            checkoutProvider.deleteDeliveryAddress(deliveryAddress.uID);
          },
        ),
        TextButton(
          child: Text(
            'No',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: textColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    deliveryAddress.phoneNumber,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          deleteDeliveryAddress(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
