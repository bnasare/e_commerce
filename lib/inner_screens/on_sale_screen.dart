// ignore_for_file: unused_local_variable

import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/empty_prod.dart';
import 'package:e_commerce/widgets/on_sale_widget.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../models/products_models.dart';
import '../providers/product_provider.dart';

class OnSaleScreen extends StatefulWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  State<OnSaleScreen> createState() => _OnSaleScreenState();
}

class _OnSaleScreenState extends State<OnSaleScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> productsOnSale = productProvider.getOnSaleProducts;

    final Color color = Utils(context).color;
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: productsOnSale.isEmpty
          ? const EmptyProductScreen(
              text: 'No products on sale yet! \nStay tuned.')
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: 1.1,
              children: List.generate(
                productsOnSale.length,
                (index) {
                  return ChangeNotifierProvider.value(
                      value: productsOnSale[index],
                      child: const OnSaleWidget());
                },
              ),
            ),
    );
  }
}
