import 'package:e_commerce/consts/dialog_box.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/screens/cart/cart_widget.dart';
import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../widgets/empty_screen.dart';

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
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    final productProvider = Provider.of<ProductProvider>(context);

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
                            onTap: () {},
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
}
