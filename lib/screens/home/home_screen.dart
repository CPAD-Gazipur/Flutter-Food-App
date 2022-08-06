import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';

import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageList = [
      'https://wallpaperaccess.com/full/1306571.jpg',
      'https://www.eatthis.com/wp-content/uploads/sites/4/2021/11/basket-of-vegetables.jpg?quality=82&strip=1',
      'https://images.unsplash.com/photo-1518843875459-f738682238a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dmVnZXRhYmxlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      'https://w0.peakpx.com/wallpaper/575/305/HD-wallpaper-vegitable-medly-cabbage-onion-vegitables-food-sweet-pepers-veggies.jpg',
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Home',
          style: TextStyle(color: textColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 5,
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: iconBackground,
              child: Center(
                child: InkWell(
                  onTap: () {
                    debugPrint('Search Icon Clicked');
                  },
                  child: Icon(
                    Icons.search,
                    color: textColor,
                    size: 17,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
              right: 16.0,
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: iconBackground,
              child: Center(
                child: InkWell(
                  onTap: () {
                    debugPrint('Cart Icon Clicked');
                  },
                  child: Icon(
                    Icons.shop,
                    color: textColor,
                    size: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: CarouselSlider(
              items: imageList
                  .map(
                    (image) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    textColor,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.bottomCenter,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                  )
                                ]),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 160,
                                      ),
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.amber.shade400,
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(0),
                                            topLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                          ),
                                          child: Text(
                                            'Foodie',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.green.shade900,
                                                  blurRadius: 5,
                                                  offset: const Offset(3, 3),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '30% off',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[100],
                                              fontFamily: 'Roboto',
                                              fontSize: 40,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.green.shade900,
                                                  blurRadius: 5,
                                                  offset: const Offset(3, 3),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'On all vegetable products',
                                            style: TextStyle(
                                              color: Colors.green[100],
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 170,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                autoPlay: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          HeaderTitleText(
            title: 'Herbs Seasonings',
            buttonText: 'View All',
            onButtonClicked: () {
              debugPrint('View All Clicked');
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              child: Row(
                children: [
                  Product(
                    productName: 'Fresh Basil',
                    productImage:
                        'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Fresh Mint',
                    productImage:
                        'https://www.nicepng.com/png/full/927-9276396_mint-png-clipart-background-fresh-mint.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Cilantro',
                    productImage:
                        'https://www.pngkey.com/png/full/137-1373372_parsley-coriander-cilantro.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Dill',
                    productImage:
                        'https://www.pngmart.com/files/22/Dill-PNG.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Oregano',
                    productImage:
                        'https://assets.stickpng.com/images/58bf1e57e443f41d77c734b1.png',
                    onProductClicked: () {},
                  ),
                ],
              ),
            ),
          ),
          HeaderTitleText(
            title: 'Fresh Fruits',
            buttonText: 'View All',
            onButtonClicked: () {
              debugPrint('View All Clicked');
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              child: Row(
                children: [
                  Product(
                    productName: 'Water Melons',
                    productImage:
                        'https://www.transparentpng.com/thumb/watermelon/TsIHwz-watermelon-clipart-file.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Berries',
                    productImage:
                        'https://www.pngkey.com/png/full/45-456152_berries-transparent-and-food-image-transparent-fruit.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Winter Squash',
                    productImage:
                        'https://assets.stickpng.com/images/585ea823cb11b227491c3542.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Apples',
                    productImage:
                        'http://assets.stickpng.com/images/580b57fbd9996e24bc43c118.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Beans and Lentils',
                    productImage:
                        'http://www.alliancezone.ca/dir/wp-content/uploads/2013/07/beans-global-sourcing.png',
                    onProductClicked: () {},
                  ),
                ],
              ),
            ),
          ),
          HeaderTitleText(
            title: 'Root Vegetable',
            buttonText: 'View All',
            onButtonClicked: () {
              debugPrint('View All Clicked');
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              child: Row(
                children: [
                  Product(
                    productName: 'Carrots',
                    productImage:
                        'https://www.pngmart.com/files/8/Carrot-Transparent-Background.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Beets',
                    productImage:
                        'https://www.pngmart.com/files/15/Organic-Beetroot-Transparent-PNG.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Parsnips',
                    productImage:
                        'https://www.natureandmore.com/sites/www.natureandmore.com/files/styles/zijbalk/public/product/thumb/pastinaak_kopieeren.png?itok=uom2IimW',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Turnips',
                    productImage:
                        'https://purepng.com/public/uploads/large/purepng.com-turnipvegetables-root-vegetable-rutabaga-swede-turnip-neep-941524702928b62ft.png',
                    onProductClicked: () {},
                  ),
                  Product(
                    productName: 'Jicama',
                    productImage:
                        'https://purepng.com/public/uploads/large/purepng.com-jicamavegetablesjicama-mexican-potato-mexican-yam-bean-941524705374x5018.png',
                    onProductClicked: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
