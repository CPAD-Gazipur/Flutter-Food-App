import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:flutter_food_app/screens/screens.dart';
import 'package:flutter_food_app/widgets/widgets.dart';

import '../../models/models.dart';

class ProfileScreen extends StatelessWidget {
  final UserProvider userProvider;
  const ProfileScreen({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userData = userProvider.getCurrentUserData;

    String userName, userImage, userEmail;

    try {
      userName = userData.userName;
      userEmail = userData.userEmail;
      userImage = userData.userImage;
    } catch (e) {
      userName = 'Guest';
      userImage = '';
      userEmail = 'example@gmail.com';
      debugPrint('Error: $e');
    }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const CustomAppBar(title: 'My Profile'),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: primaryColor,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 250,
                            height: 80,
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      userEmail,
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primaryColor,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: backgroundColor,
                                    child: Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomListTile(
                        text: 'My Orders',
                        icon: Icons.shop_outlined,
                        onTap: () {},
                      ),
                      CustomListTile(
                        text: 'My Delivery Address',
                        icon: Icons.location_on_outlined,
                        onTap: () {},
                      ),
                      CustomListTile(
                        text: 'Refer A Friend',
                        icon: Icons.person_outlined,
                        onTap: () {},
                      ),
                      CustomListTile(
                        text: 'Terms & Conditions',
                        icon: Icons.file_copy_outlined,
                        onTap: () {},
                      ),
                      CustomListTile(
                        text: 'Privacy Policy',
                        icon: Icons.policy_outlined,
                        onTap: () {},
                      ),
                      CustomListTile(
                        text: 'About',
                        icon: Icons.add_chart_outlined,
                        onTap: () {},
                      ),
                      CustomListTile(
                        text: 'Logout',
                        icon: Icons.exit_to_app_outlined,
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: const Text(
                              'Warning!!!',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.red,
                              ),
                            ),
                            content: const Text(
                                'Are you sure to logout from the app?'),
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
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen(),
                                    ),
                                    (route) => false,
                                  );
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
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 30,
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: backgroundColor,
                backgroundImage: NetworkImage(userImage),
              ),
            ),
          )
        ],
      ),
    );
  }
}
