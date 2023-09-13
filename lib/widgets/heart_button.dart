import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartButton extends StatelessWidget {
  const HeartButton(
      {Key? key, this.isInWishList = false, required this.productId})
      : super(key: key);
  final bool isInWishList;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        wishListProvider.addRemoveProductToWishList(productId: productId);
      },
      child: Icon(
        isInWishList ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishList ? Colors.red : color,
      ),
    );
  }
}
