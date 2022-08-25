import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/screens/screens.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  const DeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery Details',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: textColor,
          ),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: textColor,
        ),
      ),
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
            'Process To Pay',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: textColor,
            ),
          ),
          onPressed: () {},
        ),
      ),
      body: ListView(
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
            children: [
              SingleDeliveryItem(
                title: 'Md. Al-Amin',
                address:
                    'North Khailkur, Board Bazar, National University - 1704, Gazipur',
                number: '+8801621893919',
                addressType: 'Home',
                isSelected: true,
              ),
              SingleDeliveryItem(
                title: 'Md. Al-Amin',
                address: 'Rokomari Head Office, Arambag, Motijil - 1000, Dhaka',
                number: '+8801621893919',
                addressType: 'Office',
              ),
            ],
          )
        ],
      ),
    );
  }
}
