import 'package:flutter/material.dart';
import 'package:flutter_food_app/widgets/widgets.dart';

import '../../../config/config.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  const AddDeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddressScreen> createState() =>
      _AddDeliveryAddressScreenState();
}

enum AddressType { home, office, other }

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  var addressType = AddressType.home;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alternatePhoneController = TextEditingController();
  TextEditingController stressAddressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Address Details',
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
      bottomNavigationBar: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: primaryColor,
          child: Text(
            'Add Address',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: textColor,
            ),
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            CustomTextField(
              controller: nameController,
              hintText: 'Ex. Md. Al-Amin',
              labelText: 'Full Name',
              keyboardType: TextInputType.name,
            ),
            CustomTextField(
              controller: phoneController,
              hintText: 'Ex. +8801612....',
              labelText: 'Mobile Number',
              keyboardType: TextInputType.phone,
            ),
            CustomTextField(
              controller: alternatePhoneController,
              hintText: 'Ex. +8801612....',
              labelText: 'Alternate Mobile Number',
              keyboardType: TextInputType.phone,
            ),
            CustomTextField(
              controller: stressAddressController,
              hintText: 'Ex. House No 15, Road No...',
              labelText: 'Street Address',
              keyboardType: TextInputType.streetAddress,
            ),
            CustomTextField(
              controller: zipCodeController,
              hintText: 'Ex. 1000',
              labelText: 'Zip Code (PIN Code)',
              keyboardType: TextInputType.streetAddress,
            ),
            CustomTextField(
              controller: cityController,
              hintText: 'Ex. Dhaka',
              labelText: 'City',
              keyboardType: TextInputType.streetAddress,
            ),
            /*InkWell(
              onTap: () {},
              child: SizedBox(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Set Locations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: textColor),*/
            ListTile(
              title: Text(
                'Address Type',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
            ),
            RadioListTile(
              tileColor: addressType == AddressType.home ? Colors.white : null,
              activeColor: primaryColor,
              value: AddressType.home,
              groupValue: addressType,
              onChanged: (AddressType? value) {
                setState(() {
                  addressType = value!;
                });
              },
              title: Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
              secondary: Icon(
                Icons.add_home,
                color: textColor,
              ),
            ),
            RadioListTile(
              tileColor:
                  addressType == AddressType.office ? Colors.white : null,
              activeColor: primaryColor,
              value: AddressType.office,
              groupValue: addressType,
              onChanged: (AddressType? value) {
                setState(() {
                  addressType = value!;
                });
              },
              title: Text(
                'Office',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
              secondary: Icon(
                Icons.work,
                color: textColor,
              ),
            ),
            RadioListTile(
              tileColor: addressType == AddressType.other ? Colors.white : null,
              activeColor: primaryColor,
              value: AddressType.other,
              groupValue: addressType,
              onChanged: (AddressType? value) {
                setState(() {
                  addressType = value!;
                });
              },
              title: Text(
                'Other',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                ),
              ),
              secondary: Icon(
                Icons.add_home_work_rounded,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}