import 'package:flutter/material.dart';
import 'package:flutter_food_app/screens/screens.dart';

import '../../config/config.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Search',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: textColor,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu_rounded,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Items'),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xFFD7D7D7),
                filled: true,
                hintText: 'Search for item in the store',
                suffixIcon: const Icon(Icons.search_outlined),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const SearchItem(),
          const SearchItem(),
          const SearchItem(),
          const SearchItem(),
        ],
      ),
    );
  }
}
