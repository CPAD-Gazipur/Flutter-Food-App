import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:location/location.dart';

class CheckoutProvider extends ChangeNotifier {
  List<DeliveryAddressModel> deliveryAddressList = [];

  LocationData? setLocation;

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
    if (setLocation?.longitude == null) {
      EasyLoading.showError('Please set location first');
      notifyListeners();
    } else {
      EasyLoading.show(status: 'Adding new Address...');

      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('DeliveryAddress')
          .doc();

      await documentReference.set({
        'uID': documentReference.id,
        'name': name,
        'phoneNumber': phoneNumber,
        'altPhoneNumber': altPhoneNumber,
        'streetAddress': streetAddress,
        'zipCode': zipCode,
        'city': city,
        'addressType': addressType,
        'latitude': setLocation!.latitude ?? '',
        'longitude': setLocation!.longitude ?? '',
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

  fetchDeliveryAddress() async {
    List<DeliveryAddressModel> newDeliveryAddressList = [];
    DeliveryAddressModel deliveryAddressModel;

    var addressDocuments = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('DeliveryAddress')
        .get();

    if (addressDocuments.docs.isNotEmpty) {
      for (var address in addressDocuments.docs) {
        deliveryAddressModel = DeliveryAddressModel(
          uID: address.get('uID'),
          name: address.get('name'),
          phoneNumber: address.get('phoneNumber'),
          altPhoneNumber: address.get('altPhoneNumber'),
          streetAddress: address.get('streetAddress'),
          zipCode: address.get('zipCode'),
          city: address.get('city'),
          addressType: address.get('addressType'),
          latitude: address.get('latitude').toString(),
          longitude: address.get('longitude').toString(),
        );

        newDeliveryAddressList.add(deliveryAddressModel);
      }
    } else {
      debugPrint('No Delivery Address Found');
    }

    deliveryAddressList = newDeliveryAddressList;
    notifyListeners();
  }

  deleteDeliveryAddress(String deliveryAddressID) async {
    EasyLoading.show(status: 'Deleting Address...');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('DeliveryAddress')
        .doc(deliveryAddressID)
        .delete()
        .then((value) {
      EasyLoading.showSuccess('Delete Successfully');
      EasyLoading.dismiss();
      notifyListeners();
    }).catchError((e) {
      EasyLoading.showError('$e');
      EasyLoading.dismiss();
    });
  }

  List<DeliveryAddressModel> get getDeliveryAddress {
    return deliveryAddressList;
  }
}
