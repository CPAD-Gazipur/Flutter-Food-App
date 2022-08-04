import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.grey.shade200,
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 5,
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.amber.shade200,
              child: Center(
                child: InkWell(
                  onTap: () {
                    debugPrint('Search Icon Clicked');
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
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
              backgroundColor: Colors.amber.shade200,
              child: Center(
                child: InkWell(
                  onTap: () {
                    debugPrint('Cart Icon Clicked');
                  },
                  child: const Icon(
                    Icons.shop,
                    color: Colors.black,
                    size: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            CarouselSlider(
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
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.black87,
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
                                child: Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Herbs Seasonings',
                    style: TextStyle(
                      //color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint('View All Clicked');
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Container(
                    height: 230,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.network(
                              'https://assets.stickpng.com/images/58bf1e2ae443f41d77c734ab.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Fresh Basil',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$0.10/50 gram',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
