import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';
import 'package:flutter_food_app/providers/cart_provider.dart';
import 'package:flutter_food_app/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductProvider? productProvider;
  late CartProvider cartProvider;

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchHomeBanners();
    productProvider.fetchHerbsProduct();
    productProvider.fetchFreshFruitsProduct();
    productProvider.fetchRootVegetableProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    cartProvider = Provider.of<CartProvider>(context);
    cartProvider.fetchCartedProducts();

    final imageList = productProvider!.getHomeBannerList;

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
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    searchProducts: productProvider!.getAllProductList,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: textColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              icon: cartProvider.getCartedProductList.isNotEmpty
                  ? Badge(
                      toAnimate: false,
                      shape: BadgeShape.circle,
                      animationType: BadgeAnimationType.slide,
                      badgeColor: Colors.red,
                      elevation: 2,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent: Text(
                        '${cartProvider.cartedProductList.length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: Icon(
                        Icons.shop,
                        color: textColor,
                      ),
                    )
                  : Icon(
                      Icons.shop,
                      color: textColor,
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
                    (image) => CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
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
                                            borderRadius:
                                                const BorderRadius.only(
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
                                                    color:
                                                        Colors.green.shade900,
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
                                                    color:
                                                        Colors.green.shade900,
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
                      placeholder: (context, url) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white54,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: SizedBox(
                            width: double.infinity,
                            height: 170,
                            child: Image.asset(
                              'assets/images/placeholder_image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ), /**/
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    searchProducts: productProvider!.getHerbsProductList,
                  ),
                ),
              );
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
              ),
              child: Row(
                children: productProvider!.getHerbsProductList
                    .map((product) => ProductItem(
                          product: product,
                          onProductClicked: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsScreen(product: product),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
          HeaderTitleText(
            title: 'Fresh Fruits',
            buttonText: 'View All',
            onButtonClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    searchProducts: productProvider!.getFreshFruitsList,
                  ),
                ),
              );
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
              ),
              child: Row(
                children: productProvider!.getFreshFruitsList
                    .map((product) => ProductItem(
                          product: product,
                          onProductClicked: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsScreen(product: product),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
          HeaderTitleText(
            title: 'Root Vegetable',
            buttonText: 'View All',
            onButtonClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    searchProducts: productProvider!.getRootVegetableList,
                  ),
                ),
              );
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
              ),
              child: Row(
                children: productProvider!.getRootVegetableList
                    .map((product) => ProductItem(
                          product: product,
                          onProductClicked: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsScreen(product: product),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
