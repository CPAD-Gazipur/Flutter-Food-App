import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductModel> searchProducts;

  const SearchScreen({
    Key? key,
    required this.searchProducts,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  searchItems(String query) {
    List<ProductModel> searchItem = widget.searchProducts
        .where((product) => product.productName.toLowerCase().contains(query))
        .toList();

    return searchItem;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchItem = searchItems(query);

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_alt_outlined,
              ),
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
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase();
                });
              },
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
          Column(
            children: searchItem
                .map((product) => SingleItem(
                      isCarted: false,
                      product: product,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
