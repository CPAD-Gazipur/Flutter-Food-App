import 'package:flutter/material.dart';
import 'package:flutter_food_app/config/config.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Review Cart',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: const Text(
          'Total Order',
          style: TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
        subtitle: Text(
          '\$ 145.00',
          style: TextStyle(
            color: Colors.green[900],
            fontFamily: 'Roboto',
          ),
        ),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            onPressed: () {},
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 10),
          /* SingleItem(isCarted: true),
          SingleItem(isCarted: true),
          SingleItem(isCarted: true),
          SingleItem(isCarted: true),*/
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
