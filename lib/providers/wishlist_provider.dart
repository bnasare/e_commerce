import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/wishlist_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../consts/dialog_box.dart';
import '../consts/firebase_consts.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishListModel> wishLishtItems = {};

  Map<String, WishListModel> get getWishListItems {
    return wishLishtItems;
  }

  // void addRemoveProductToWishList({required String productId}) {
  //   if (wishLishtItems.containsKey(productId)) {
  //     removeOneItem(productId);
  //   } else {
  //     wishLishtItems.putIfAbsent(
  //       productId,
  //       () => WishListModel(
  //         id: DateTime.now().toString(),
  //         productId: productId,
  //       ),
  //     );
  //   }
  //   notifyListeners();
  // }

  Future<void> fetchWishList() async {
    final User? user = authInstance.currentUser;
    String uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    // ignore: unnecessary_null_comparison
    if (userDoc == null) {
      return;
    }
    final noOfWishlistItems = userDoc.get('userWishList').length;
    for (int i = 0; i < noOfWishlistItems; i++) {
      wishLishtItems.putIfAbsent(
          userDoc.get('userWishList')[i]['productId'],
          () => WishListModel(
                id: userDoc.get('userWishList')[i]['wishlistId'],
                productId: userDoc.get('userWishList')[i]['productId'],
              ));
    }
    notifyListeners();
  }

  /// Add to Firebase wishlist
  Future<void> addToWishList(
      {required String productId, required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userWishList': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Item has been added to your wishlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      AlertDialogs.errorDialog(subtitle: error.toString(), context: context);
    }
  }

  Future<void> removeOneItem(
    String productId,
  ) async {
    final User? user = authInstance.currentUser;
    String uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'userWishList': FieldValue.arrayRemove([
        {
          'productId': productId,
          'wishlistId': wishLishtItems[productId]!.id,
        }
      ])
    });
    wishLishtItems.remove(productId);
    await fetchWishList();
    notifyListeners();
  }

  Future<void> clearWishList() async {
    final User? user = authInstance.currentUser;
    if (user != null) {
      String uid = user.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userWishList': [],
      });
      wishLishtItems.clear();
      notifyListeners();
    }
  }
}
