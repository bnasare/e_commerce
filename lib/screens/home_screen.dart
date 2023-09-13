// ignore_for_file: unused_local_variable

import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/inner_screens/feeds_screen.dart';
import 'package:e_commerce/inner_screens/on_sale_screen.dart';
import 'package:e_commerce/services/global_methods.dart';
import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/feeds_items_widget.dart';
import 'package:e_commerce/widgets/on_sale_widget.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../models/products_models.dart';
import '../providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> allProducts = productProvider.getProducts;
    List<ProductModel> productsOnSale = productProvider.getOnSaleProducts;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.30,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      Consts.offerImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: Consts.offerImages.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.red)),
                ),
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: OnSaleScreen.routeName);
                },
                child: TextWidget(
                  text: 'View All',
                  color: Colors.blue,
                  textSize: 20,
                  isTitle: false,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Row(
                      children: [
                        TextWidget(
                          text: 'PROMO',
                          color: Colors.red,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          IconlyLight.discount,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productsOnSale.length < 10
                            ? productsOnSale.length
                            : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return ChangeNotifierProvider.value(
                              value: productsOnSale[index],
                              child: const OnSaleWidget());
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TextWidget(
                      text: 'Our products',
                      color: color,
                      textSize: 22,
                      isTitle: true,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context: context, routeName: FeedsScreen.routeName);
                      },
                      child: TextWidget(
                        text: 'Browse all',
                        color: Colors.blue,
                        textSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                childAspectRatio: 0.7,
                children: List.generate(
                  allProducts.length < 4 ? allProducts.length : 4,
                  (index) {
                    return ChangeNotifierProvider.value(
                        value: allProducts[index], child: const FeedsWidget());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
