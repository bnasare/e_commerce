import 'package:e_commerce/models/wishlist_models.dart';
import 'package:flutter/material.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishListModel> wishLishtItems = {};

  Map<String, WishListModel> get getWishListItems {
    return wishLishtItems;
  }

  void addRemoveProductToWishList({required String productId}) {
    if (wishLishtItems.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      wishLishtItems.putIfAbsent(
        productId,
        () => WishListModel(
          id: DateTime.now().toString(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    wishLishtItems.remove(productId);
    notifyListeners();
  }

  void clearWishList() {
    wishLishtItems.clear();
    notifyListeners();
  }
}
