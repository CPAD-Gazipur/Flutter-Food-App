import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_food_app/models/models.dart';
import 'package:flutter_food_app/screens/screens.dart';
import 'package:flutter_food_app/widgets/widgets.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../providers/providers.dart';

class PaymentSummaryScreen extends StatefulWidget {
  final DeliveryAddressModel deliveryAddress;
  const PaymentSummaryScreen({
    Key? key,
    required this.deliveryAddress,
  }) : super(key: key);

  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreenState();
}

enum PaymentType { sslcommerz, bKash, nagad, cashOnDelivery }

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  var paymentType = PaymentType.bKash;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.fetchCartedProducts();

    double discountPercent = 5;
    double discountAmount = 0;
    double shippingCharge = 0.15;
    double priceAfterDiscount;
    double totalPrice = cartProvider.fetchTotalPrice();
    priceAfterDiscount = totalPrice + shippingCharge;
    if (totalPrice > 100) {
      discountAmount = (totalPrice * discountPercent) / 100;
      priceAfterDiscount = totalPrice - discountAmount + shippingCharge;
    } else {
      discountPercent = 0;
    }

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
                  'Payable: \$ ${priceAfterDiscount.toStringAsFixed(2)}',
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
                    onPressed: () async {
                      if (paymentType == PaymentType.sslcommerz) {
                        debugPrint('Pay with bKash');

                        Sslcommerz sslcommerz = Sslcommerz(
                          initializer: SSLCommerzInitialization(
                            ipn_url: "www.ipnurl.com",
                            multi_card_name: "visa,master,bkash",
                            currency: SSLCurrencyType.BDT,
                            product_category: "Food",
                            sdkType: SSLCSdkType.TESTBOX,
                            store_id: "flutt631f1be7b7c05",
                            store_passwd: "flutt631f1be7b7c05@ssl",
                            total_amount: double.parse(
                                priceAfterDiscount.toStringAsFixed(2)),
                            tran_id: "custom_transaction_id",
                          ),
                        );

                        sslcommerz.addShipmentInfoInitializer(
                          sslcShipmentInfoInitializer:
                              SSLCShipmentInfoInitializer(
                            shipmentMethod: "yes",
                            numOfItems: 5,
                            shipmentDetails: ShipmentDetails(
                              shipAddress1: "Ship address 1",
                              shipCity: "Faridpur",
                              shipCountry: "Bangladesh",
                              shipName: "Ship name 1",
                              shipPostCode: "7860",
                            ),
                          ),
                        );

                        sslcommerz.addProductInitializer(
                          sslcProductInitializer: SSLCProductInitializer(
                            productName: "Water Filter",
                            productCategory: "Widgets",
                            general: General(
                                general: "General Purpose",
                                productProfile: "Product Profile"),
                          ),
                        );

                        await sslcommerz.payNow().then((value) {
                          if (value.status?.toLowerCase() == 'failed' ||
                              value.status == null ||
                              value.status == '') {
                            EasyLoading.showError('Transaction Failed');
                          } else {
                            EasyLoading.showSuccess(
                                'Transaction is ${value.status} & Paid Amount is ${value.amount} BDT');
                          }
                        }).catchError((e) {
                          EasyLoading.showError('Transaction not complete.');
                        });
                      }
                    },
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
                SelectedDeliveryDetails(
                  deliveryAddress: widget.deliveryAddress,
                ),
                ExpansionTile(
                  title: Text(
                    'Order Item (${cartProvider.getCartedProductList.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  children: cartProvider.getCartedProductList
                      .map(
                        (product) => OrderItemListTile(productDetails: product),
                      )
                      .toList(),
                ),
                const Divider(),
                ListTile(
                  leading: const Text(
                    'Sub Total:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  trailing: Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
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
                  trailing: Text(
                    '\$${shippingCharge.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Discount (${discountPercent.toStringAsFixed(1)}%):',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Roboto',
                    ),
                  ),
                  trailing: Text(
                    '\$${discountAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Text(
                    'Total:',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '\$${priceAfterDiscount.toStringAsFixed(2)}',
                    style: const TextStyle(
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
                  tileColor: paymentType == PaymentType.sslcommerz
                      ? Colors.white
                      : null,
                  activeColor: primaryColor,
                  value: PaymentType.sslcommerz,
                  groupValue: paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      paymentType = value!;
                    });
                  },
                  title: Text(
                    'SSLCommerz',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: textColor,
                    ),
                  ),
                  secondary: Image.asset(
                    'assets/images/ssl_commerz_icon.png',
                    width: 60,
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
