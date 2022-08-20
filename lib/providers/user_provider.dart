import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/models/models.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _currentUserData;

  void addUserData({
    required User currentUser,
    required String userName,
    required String userEmail,
    required String userImage,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .set({
      'userName': userName,
      'userEmail': userEmail,
      'userImage': userImage,
      'userID': currentUser.uid,
    });
  }

  void fetchCurrentUserData() async {
    UserModel userModel;
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (result.exists) {
      userModel = UserModel(
        userName: result.get('userName'),
        userImage: result.get('userImage'),
        userID: result.get('userID'),
        userEmail: result.get('userEmail'),
      );

      _currentUserData = userModel;
      notifyListeners();
    }
  }

  UserModel get getCurrentUserData {
    return _currentUserData;
  }
}
