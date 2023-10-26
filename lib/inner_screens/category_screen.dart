import 'package:e_commerce/widgets/empty_prod.dart';
import 'package:e_commerce/widgets/feeds_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../models/products_models.dart';
import '../providers/product_provider.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreen";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? searchTextController = TextEditingController();
  final FocusNode searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    searchTextController!.dispose();
    searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productProvider = Provider.of<ProductProvider>(context);
    final catText = ModalRoute.of(context)!.settings.arguments as String;

    List<ProductModel> productsbyCategory =
        productProvider.findByCategory(catText);

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
        centerTitle: true,
        title: TextWidget(
          text: catText,
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: productsbyCategory.isEmpty
          ? const EmptyProductScreen(
              text: 'No products in this category yet',
            )
          : SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: TextField(
                      focusNode: searchTextFocusNode,
                      controller: searchTextController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        hintText: "What's in your mind",
                        prefixIcon: const Icon(Icons.search),
                        suffix: IconButton(
                          onPressed: () {
                            searchTextController!.clear();
                            searchTextFocusNode.unfocus();
                          },
                          icon: Icon(
                            Icons.close,
                            color: searchTextFocusNode.hasFocus
                                ? Colors.red
                                : color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  // crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  children: List.generate(productsbyCategory.length, (index) {
                    return ChangeNotifierProvider.value(
                        value: productsbyCategory[index],
                        child: const FeedsWidget());
                  }),
                ),
              ]),
            ),
    );
  }
}
