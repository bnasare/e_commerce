import 'package:e_commerce/inner_screens/product_details.dart';
import 'package:e_commerce/models/wishlist_models.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:e_commerce/widgets/heart_button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListModel = Provider.of<WishListModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct =
        productProvider.findProdById(wishListModel.productId);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    bool? isInWishList =
        wishListProvider.getWishListItems.containsKey(getCurrentProduct.id);
    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsScreen.routeName,
              arguments: wishListModel.productId);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8),
                width: size.width * 0.2,
                height: size.width * 0.25,
                child: FancyShimmerImage(
                  imageUrl: getCurrentProduct.imageUrl,
                  boxFit: BoxFit.fill,
                ),
              ),
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            cartProvider.addProductsToCart(
                                productId: getCurrentProduct.id, quantity: 1);
                          },
                          icon: Icon(
                            isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                            color: isInCart ? Colors.green : color,
                          ),
                        ),
                        HeartButton(
                            productId: getCurrentProduct.id,
                            isInWishList: isInWishList),
                      ],
                    ),
                    TextWidget(
                      text: getCurrentProduct.title,
                      color: color,
                      textSize: 20.0,
                      maxLines: 1,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: '₵${usedPrice.toStringAsFixed(2)}',
                      color: color,
                      textSize: 18.0,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
