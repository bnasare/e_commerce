import 'package:e_commerce/models/viewed_products_models.dart';
import 'package:flutter/material.dart';

class ViewedProductsProvider with ChangeNotifier {
  Map<String, ViewedProductsModel> viewedProductsItems = {};

  Map<String, ViewedProductsModel> get getViewedProductsItems {
    return viewedProductsItems;
  }

  void addProductToHistory({required String productId}) {
    viewedProductsItems.putIfAbsent(
      productId,
      () => ViewedProductsModel(
        id: DateTime.now().toString(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

  void clearHistory() {
    viewedProductsItems.clear();
    notifyListeners();
  }
}
