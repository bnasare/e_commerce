import 'package:e_commerce/models/cart_models.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/heart_button.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../inner_screens/product_details.dart';
import '../../providers/product_provider.dart';
import '../../providers/wishlist_provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key, required this.quantity});
  final int quantity;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final quantityTextController = TextEditingController();
  @override
  void initState() {
    quantityTextController.text = widget.quantity.toString();
    super.initState();
  }

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
    final cartModel = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct = productProvider.findProdById(cartModel.productId);
    final wishListProvider = Provider.of<WishListProvider>(context);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    bool? isInWishList =
        wishListProvider.getWishListItems.containsKey(getCurrentProduct.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: cartModel.productId);
      },
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.29,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.imageUrl,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: TextWidget(
                              text: getCurrentProduct.title,
                              color: color,
                              maxLines: 1,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: size.width * 0.3,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Material(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          if (quantityTextController.text ==
                                              '1') {
                                            return;
                                          } else {
                                            cartProvider.reduceQuantityByOne(
                                                cartModel.productId);
                                            setState(() {
                                              quantityTextController
                                                  .text = (int.parse(
                                                          quantityTextController
                                                              .text) -
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
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'))
                                    ],
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          if (value.isEmpty) {
                                            quantityTextController.text = '1';
                                          } else {
                                            return;
                                          }
                                        },
                                      );
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
                                        cartProvider.increaseQuantityByOne(
                                            cartModel.productId);
                                        setState(() {
                                          quantityTextController.text =
                                              (int.parse(quantityTextController
                                                          .text) +
                                                      1)
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
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cartProvider.removeOneItem(cartModel.productId);
                            },
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          HeartButton(
                            productId: getCurrentProduct.id,
                            isInWishList: isInWishList,
                          ),
                          TextWidget(
                            text:
                                '₵${(usedPrice * int.parse(quantityTextController.text)).toStringAsFixed(2)}',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
