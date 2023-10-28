import 'package:e_commerce/consts/dialog_box.dart';
import 'package:e_commerce/consts/firebase_consts.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      onTap: () async {
        try {
          final User? user = authInstance.currentUser;
          if (user == null) {
            AlertDialogs.errorDialog(
              subtitle: 'No user found. Please login first.',
              context: context,
            );
            return;
          }
          if (isInWishList == false) {
            await wishListProvider.addToWishList(
                productId: productId, context: context);
          } else {
            await wishListProvider.removeOneItem(productId);
          }
          await wishListProvider.fetchWishList();
        } catch (error) {}
      },
      child: Icon(
        isInWishList ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishList ? Colors.red : color,
      ),
    );
  }
}
