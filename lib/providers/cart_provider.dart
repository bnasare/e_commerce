import 'package:flutter/cupertino.dart';

import '../models/cart_models.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> cartItems = {};

  Map<String, CartModel> get getCartItems {
    return cartItems;
  }

  void addProductsToCart({required String productId, required int quantity}) {
    cartItems.putIfAbsent(
      productId,
      () => CartModel(
          id: DateTime.now().toString(),
          productId: productId,
          quantity: quantity),
    );
  }
}
