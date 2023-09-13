import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/widgets/heart_button.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/utils.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/ProductDetailsScreen";

  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final productProvider = Provider.of<ProductProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final wishListProvider = Provider.of<WishListProvider>(context);
    final getCurrentProduct = productProvider.findProdById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    double totalPrice = usedPrice * int.parse(quantityTextController.text);
    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    bool? isInWishList =
        wishListProvider.getWishListItems.containsKey(getCurrentProduct.id);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
            size: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: getCurrentProduct.imageUrl,
              width: double.infinity,
              boxFit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextWidget(
                            text: getCurrentProduct.title,
                            color: color,
                            textSize: 25,
                            isTitle: true,
                          ),
                        ),
                        HeartButton(
                          productId: getCurrentProduct.id,
                          isInWishList: isInWishList,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '\$${usedPrice.toStringAsFixed(2)}/',
                          color: Colors.green,
                          textSize: 22,
                          isTitle: true,
                        ),
                        TextWidget(
                          text: getCurrentProduct.isSingle ? 'PC' : 'KG',
                          color: color,
                          textSize: 12,
                        ),
                        const SizedBox(width: 10),
                        Visibility(
                          visible: getCurrentProduct.isOnSale ? true : false,
                          child: Text(
                            getCurrentProduct.price.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 15,
                                color: color,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 86, 193, 90),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextWidget(
                              text: 'Free Delivery',
                              color: Colors.white,
                              textSize: 20,
                              isTitle: true),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Material(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                if (quantityTextController.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    quantityTextController.text = (int.parse(
                                                quantityTextController.text) -
                                            1)
                                        .toString();
                                  });
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Icon(CupertinoIcons.minus,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          key: const ValueKey('quantity'),
                          controller: quantityTextController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                quantityTextController.text = '1';
                              } else {
                                return;
                              }
                            });
                          },
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Material(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              setState(() {
                                quantityTextController.text =
                                    (int.parse(quantityTextController.text) + 1)
                                        .toString();
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(CupertinoIcons.add,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Total',
                                color: Colors.red.withOpacity(0.7),
                                textSize: 20,
                                isTitle: true,
                              ),
                              const SizedBox(height: 5),
                              FittedBox(
                                child: Row(
                                  children: [
                                    TextWidget(
                                      text:
                                          '\$${totalPrice.toStringAsFixed(2)}/',
                                      color: color,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                    TextWidget(
                                      text: '${quantityTextController.text}PC',
                                      color: color,
                                      textSize: 16,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: Material(
                            color: const Color.fromARGB(255, 86, 193, 90),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: isInCart
                                  ? null
                                  : () {
                                      cartProvider.addProductsToCart(
                                          productId: getCurrentProduct.id,
                                          quantity: int.parse(
                                              quantityTextController.text));
                                    },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                    text: isInCart ? 'In Cart' : 'Add to cart',
                                    color: Colors.white,
                                    textSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
