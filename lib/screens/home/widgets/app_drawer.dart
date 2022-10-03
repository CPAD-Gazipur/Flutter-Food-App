import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/providers/providers.dart';

import '../../screens.dart';

class AppDrawer extends StatelessWidget {
  final UserProvider userProvider;
  const AppDrawer({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userData = userProvider.getCurrentUserData;

    String userName, userImage;

    try {
      userName = userData.userName;

      userImage = userData.userImage;
    } catch (e) {
      userName = 'Guest';
      userImage = '';
      debugPrint('Error: $e');
    }
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 43,
                  backgroundColor: backgroundColor,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: primaryColor,
                    backgroundImage: NetworkImage(userImage),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        FirebaseAuth.instance.currentUser == null
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 7),
                      FirebaseAuth.instance.currentUser == null
                          ? InkWell(
                              onTap: () {
                                debugPrint('Login Clicked');
                              },
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white54,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              userData.userEmail,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black45,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.home_outlined,
              size: 32,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(
                    isAppDrawer: true,
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.shop_outlined,
              size: 32,
            ),
            title: const Text(
              'Review Cart',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userProvider: userProvider,
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.person_outlined,
              size: 32,
            ),
            title: const Text(
              'My Profile',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.notifications_outlined,
              size: 32,
            ),
            title: const Text(
              'Notification',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.star_outline,
              size: 32,
            ),
            title: const Text(
              'Rating & Review',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WishListScreen(),
                ),
              );
            },
            leading: const Icon(
              Icons.favorite_outline,
              size: 32,
            ),
            title: const Text(
              'WishList',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.report_outlined,
              size: 32,
            ),
            title: const Text(
              'Raise a Complain',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.format_quote_outlined,
              size: 32,
            ),
            title: const Text(
              'FAQs',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  'Contact Support',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        SizedBox(
                          width: 40,
                          child: Text(
                            'Call:',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 40,
                          child: Text(
                            'Mail:',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '+8801621893919',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'support@foodie.com',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text('Version: 1.0.0'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
