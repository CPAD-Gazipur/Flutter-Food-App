import 'package:flutter/material.dart';
import 'package:flutter_food_app/screens/checkout/widgets/order_item_list_tile.dart';
import 'package:flutter_food_app/screens/screens.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../providers/providers.dart';

class PaymentSummaryScreen extends StatefulWidget {
  const PaymentSummaryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreenState();
}

enum PaymentType { bKash, nagad, cashOnDelivery }

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  var paymentType = PaymentType.bKash;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.fetchCartedProducts();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Payment Summary'),
      bottomNavigationBar: cartProvider.getCartedProductList.isNotEmpty
          ? Card(
              elevation: 4,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: ListTile(
                title: Text(
                  cartProvider.getCartedProductList.length == 1
                      ? 'Total Order: ${cartProvider.getCartedProductList.length} item'
                      : 'Total Order: ${cartProvider.getCartedProductList.length} items',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  'Total Price: \$ ${cartProvider.fetchTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
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
                      'Place Order',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
        ),
        child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    'Delivery To',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                    ),
                  ),
                  leading: Image.asset(
                    'assets/images/location_icon.png',
                    height: 30,
                  ),
                ),
                const Divider(height: 1),
                const SingleDeliveryDetailsItem(
                  title: 'Md. Al-Amin',
                  address:
                      'North Khailkur, Board Bazar, National University - 1704, Gazipur',
                  number: '+8801621893919',
                  addressType: 'Home',
                  isLeading: false,
                ),
                const ExpansionTile(
                  title: Text(
                    'Order Item',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  children: [
                    OrderItemListTile(),
                    OrderItemListTile(),
                  ],
                ),
                const Divider(),
                const ListTile(
                  leading: Text(
                    'Sub Total:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  trailing: Text(
                    '\$2.50',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Shipping Charge:',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Roboto',
                    ),
                  ),
                  trailing: const Text(
                    '\$0.15',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Discount:',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Roboto',
                    ),
                  ),
                  trailing: const Text(
                    '\$0.02',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'Payment Type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                    ),
                  ),
                ),
                RadioListTile(
                  tileColor:
                      paymentType == PaymentType.bKash ? Colors.white : null,
                  activeColor: primaryColor,
                  value: PaymentType.bKash,
                  groupValue: paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      paymentType = value!;
                    });
                  },
                  title: Text(
                    'bKash',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                    ),
                  ),
                  secondary: Image.asset(
                    'assets/images/b_kash_icon.png',
                    width: 60,
                  ),
                ),
                RadioListTile(
                  tileColor:
                      paymentType == PaymentType.nagad ? Colors.white : null,
                  activeColor: primaryColor,
                  value: PaymentType.nagad,
                  groupValue: paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      paymentType = value!;
                    });
                  },
                  title: Text(
                    'Nagad',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                    ),
                  ),
                  secondary: Image.asset(
                    'assets/images/nagad_icon.png',
                    width: 60,
                  ),
                ),
                RadioListTile(
                  tileColor: paymentType == PaymentType.cashOnDelivery
                      ? Colors.white
                      : null,
                  activeColor: primaryColor,
                  value: PaymentType.cashOnDelivery,
                  groupValue: paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      paymentType = value!;
                    });
                  },
                  title: Text(
                    'Cash on Delivery',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                    ),
                  ),
                  secondary: Image.asset(
                    'assets/images/cash_on_delivery_icon.jpg',
                    width: 60,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
