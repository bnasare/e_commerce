import 'package:flutter/material.dart';

import '../models/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static final List<OrderModel> ordersList = [];
  List<OrderModel> get getOrders {
    return ordersList;
  }
}
