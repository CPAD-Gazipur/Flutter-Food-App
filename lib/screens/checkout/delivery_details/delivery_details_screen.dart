import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/screens/screens.dart';
import 'package:flutter_food_app/widgets/widgets.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  DeliveryDetailsScreen({Key? key}) : super(key: key);

  List<Widget> addressList = const [
    SingleDeliveryDetailsItem(
      title: 'Md. Al-Amin',
      address:
          'North Khailkur, Board Bazar, National University - 1704, Gazipur',
      number: '+8801621893919',
      addressType: 'Home',
      isSelected: true,
    ),
    SingleDeliveryDetailsItem(
      title: 'Md. Al-Amin',
      address: 'Rokomari Head Office, Arambag, Motijil - 1000, Dhaka',
      number: '+8801621893919',
      addressType: 'Office',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Delivery Details'),
      floatingActionButton: addressList.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddDeliveryAddressScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: textColor,
              ),
            )
          : const SizedBox(),
      bottomNavigationBar: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          color: primaryColor,
          child: Text(
            addressList.isNotEmpty ? 'Process To Pay' : 'Add new Address',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: textColor,
            ),
          ),
          onPressed: () {
            if (addressList.isNotEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PaymentSummaryScreen(),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddDeliveryAddressScreen(),
                ),
              );
            }
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              'Delivery To',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: textColor,
              ),
            ),
            leading: Image.asset(
              'assets/images/location_icon.png',
              height: 30,
            ),
          ),
          const Divider(height: 1),
          Column(
            children: addressList,
          )
        ],
      ),
    );
  }
}
