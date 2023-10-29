import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../consts/dialog_box.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
import '../../providers/product_provider.dart';
import '../../services/utils.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';
import 'cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(key);
      total += (getCurrProduct.isOnSale
              ? getCurrProduct.salePrice
              : getCurrProduct.price) *
          value.quantity;
    });

    return cartItemsList.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/sale/emptycart.png',
            title: 'Oops!',
            buttonText: 'Continue Shopping',
            subtitle: "Your Cart's Feeling a Bit Lonely",
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor:
                  Theme.of(context).colorScheme.background.withOpacity(0.3),
              title: TextWidget(
                text: 'Cart (${cartItemsList.length})',
                color: color,
                textSize: 22,
                isTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    AlertDialogs.warningDialog(
                        title: 'Empty your cart?',
                        subtitle: 'Are you sure?',
                        fct: () {
                          cartProvider.clearCart();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Material(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () async {
                              User? user = authInstance.currentUser;
                              try {
                                await initPayment(
                                    email: user!.email ?? '',
                                    amount: total * 100,
                                    context: context);
                              } catch (error) {
                                print('error $error');
                                return;
                              }
                              await ordersProvider.placeOrder(context);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextWidget(
                                  text: 'Order Now',
                                  color: color,
                                  textSize: 20),
                            ),
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          child: TextWidget(
                            text: 'Total: ₵${total.toStringAsFixed(2)}',
                            color: color,
                            textSize: 18,
                            isTitle: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemsList.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: cartItemsList[index],
                          child: CartWidget(
                              quantity: cartItemsList[index].quantity));
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> initPayment(
      {required String email,
      required double amount,
      required BuildContext context}) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-e-commerce1a.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());
      if (jsonResponse['success'] == false) {
        AlertDialogs.errorDialog(
            subtitle: jsonResponse['error'], context: context);
        throw jsonResponse['error'];
      }
      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'Footwear Hub',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        // testEnv: true,
        // merchantCountryCode: 'SG',
      ));
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment is successful'),
        ),
      );
    } catch (error) {
      if (error is StripeException) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('An error occured ${error.error.localizedMessage}'),
        //   ),
        // );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('An error occured $error'),
        //   ),
        // );
      }
      throw '$error';
    }
  }
}
