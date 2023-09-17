import 'package:e_commerce/consts/dialog_box.dart';
import 'package:e_commerce/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../providers/viewed_products_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
import 'viewed_recently_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;

  @override
  Widget build(BuildContext context) {
    final viewedProductsProvider = Provider.of<ViewedProductsProvider>(context);
    final viewedProductsItemsList = viewedProductsProvider
        .getViewedProductsItems.values
        .toList()
        .reversed
        .toList();
    Color color = Utils(context).color;
    return viewedProductsItemsList.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/sale/viewed.png',
            title: 'Oops!',
            subtitle: 'Nothing to See Here Yet',
            buttonText: 'Start Exploring')
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    AlertDialogs.warningDialog(
                        title: 'Empty your history?',
                        subtitle: 'Are you sure?',
                        fct: () {
                          viewedProductsProvider.clearHistory();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                )
              ],
              leading: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Icon(
                  IconlyLight.arrowLeft2,
                  color: color,
                  size: 24,
                ),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              centerTitle: true,
              title: TextWidget(
                text: 'History',
                color: color,
                textSize: 24.0,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.builder(
              itemCount: viewedProductsItemsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: ChangeNotifierProvider.value(
                      value: viewedProductsItemsList[index],
                      child: const ViewedRecentlyWidget()),
                );
              },
            ),
          );
  }
}
