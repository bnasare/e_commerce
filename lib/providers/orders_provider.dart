import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> ordersList = [];
  List<OrderModel> get getOrders {
    return ordersList;
  }

  Future<void> addToOrders() async {
    final orderId = const Uuid().v4();
    User? user = authInstance.currentUser;
    await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
      'orderId': orderId,
      'userId': user!.uid,
    });
  }

  Future<void> fetchOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      ordersList = [];
      // _orders.clear();
      for (var element in ordersSnapshot.docs) {
        ordersList.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: element.get('productId'),
            userName: element.get('userName'),
            price: element.get('price').toString(),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantity').toString(),
            orderDate: element.get('orderDate'),
          ),
        );
      }
    });
    notifyListeners();
  }
}
