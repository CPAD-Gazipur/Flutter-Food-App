import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.amber,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome Guest',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 7),
                      InkWell(
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
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
                            'alamin.karno@outlook.com',
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
      ),
    );
  }
}
