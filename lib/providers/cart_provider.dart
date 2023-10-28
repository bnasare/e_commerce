import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase_consts.dart';
import '../models/cart_models.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> cartItems = {};

  Map<String, CartModel> get getCartItems {
    return cartItems;
  }

  // void addProductsToCart({required String productId, required int quantity}) {
  //   cartItems.putIfAbsent(
  //     productId,
  //     () => CartModel(
  //         id: DateTime.now().toString(),
  //         productId: productId,
  //         quantity: quantity),
  //   );
  //   notifyListeners();
  // }

  /// Add to Firebase cart
  Future<void> addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userCartItems': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      AlertDialogs.errorDialog(subtitle: error.toString(), context: context);
    }
  }

  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;
    String uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc == null) {
      return;
    }
    final noOfCartItems = userDoc.get('userCartItems').length;
    for (int i = 0; i < noOfCartItems; i++) {
      cartItems.putIfAbsent(
          userDoc.get('userCartItems')[i]['productId'],
          () => CartModel(
                id: userDoc.get('userCartItems')[i]['cartId'],
                productId: userDoc.get('userCartItems')[i]['productId'],
                quantity: userDoc.get('userCartItems')[i]['quantity'],
              ));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    cartItems.update(
      productId,
      (value) => CartModel(
          id: value.id, productId: productId, quantity: value.quantity - 1),
    );
    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    cartItems.update(
      productId,
      (value) => CartModel(
          id: value.id, productId: productId, quantity: value.quantity + 1),
    );
    notifyListeners();
  }

  Future<void> clearCart() async {
    final User? user = authInstance.currentUser;
    String uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'userCartItems': [],
    });
    cartItems.clear();
    notifyListeners();
  }

  Future<void> removeOneItem(
    String productId,
  ) async {
    final User? user = authInstance.currentUser;
    String uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'userCartItems': FieldValue.arrayRemove([
        {
          'productId': productId,
          'cartId': cartItems[productId]!.id,
          'quantity': cartItems[productId]!.quantity
        }
      ])
    });
    cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  //   Future<void> removeOneItem(
  //     {required String cartId,
  //     required String productId,
  //     required int quantity}) async {
  //   await userCollection.doc(user!.uid).update({
  //     'userCart': FieldValue.arrayRemove([
  //       {'cartId': cartId, 'productId': productId, 'quantity': quantity}
  //     ])
  //   });
  //   _cartItems.remove(productId);
  //   notifyListeners();
  // }
}
