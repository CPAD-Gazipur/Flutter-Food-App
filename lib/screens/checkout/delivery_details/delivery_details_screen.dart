import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:flutter_food_app/screens/screens.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  DeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  int selectedAddress = 0;

  List<DeliveryAddressModel> deliveryList = [];

  /* List<Widget> addressList = const [
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
  ];*/

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);
    checkoutProvider.fetchDeliveryAddress();
    deliveryList = checkoutProvider.getDeliveryAddress;

    debugPrint('DeliveryAddress: $deliveryList');

    return Scaffold(
      appBar: const CustomAppBar(title: 'Delivery Details'),
      floatingActionButton: deliveryList.isNotEmpty
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
            deliveryList.isNotEmpty ? 'Process To Pay' : 'Add new Address',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: textColor,
            ),
          ),
          onPressed: () {
            if (deliveryList.isNotEmpty) {
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
      body: Column(
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
          deliveryList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: deliveryList.length,
                  itemBuilder: (context, index) {
                    return SingleDeliveryDetailsItem(
                      value: index,
                      groupValue: selectedAddress,
                      onChanged: (int? value) {
                        setState(() {
                          selectedAddress = value!;
                        });
                      },
                      checkoutProvider: checkoutProvider,
                      deliveryAddress: deliveryList[index],
                    );
                  },
                )
              : const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text(
                      'No Delivery Address Found',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
