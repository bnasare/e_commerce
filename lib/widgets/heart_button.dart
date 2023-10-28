import 'package:e_commerce/consts/dialog_box.dart';
import 'package:e_commerce/consts/firebase_consts.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartButton extends StatefulWidget {
  const HeartButton(
      {Key? key, this.isInWishList = false, required this.productId})
      : super(key: key);
  final bool isInWishList;
  final String productId;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async {
        try {
          setState(() {
            isLoading = true;
          });
          final User? user = authInstance.currentUser;
          if (user == null) {
            AlertDialogs.errorDialog(
              subtitle: 'No user found. Please login first.',
              context: context,
            );
            return;
          }
          if (widget.isInWishList == false) {
            await wishListProvider.addToWishList(
                productId: widget.productId, context: context);
          } else {
            await wishListProvider.removeOneItem(widget.productId);
          }
          await wishListProvider.fetchWishList();
          setState(() {
            isLoading = false;
          });
        } catch (error) {
          AlertDialogs.errorDialog(
              subtitle: error.toString(), context: context);
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.all(3.0),
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            )
          : Icon(
              widget.isInWishList ? IconlyBold.heart : IconlyLight.heart,
              size: 22,
              color: widget.isInWishList ? Colors.red : color,
            ),
    );
  }
}
