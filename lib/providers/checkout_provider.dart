import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CheckoutProvider extends ChangeNotifier {
  addDeliveryAddress({
    required BuildContext context,
    required String name,
    required String phoneNumber,
    required String altPhoneNumber,
    required String streetAddress,
    required String zipCode,
    required String city,
    required String addressType,
  }) async {
    EasyLoading.show(status: 'Adding new Address...');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('DeliveryAddress')
        .add({
      'name': name,
      'phoneNumber': phoneNumber,
      'altPhoneNumber': altPhoneNumber,
      'streetAddress': streetAddress,
      'zipCode': zipCode,
      'city': city,
      'addressType': addressType,
    }).then((value) {
      EasyLoading.showSuccess('Added Successfully');
      EasyLoading.dismiss();
      notifyListeners();
      Navigator.pop(context);
    }).catchError((e) {
      EasyLoading.showError('$e');
      EasyLoading.dismiss();
    });
  }
}
