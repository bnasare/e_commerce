import 'package:e_commerce/consts/dialog_box.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:e_commerce/screens/wishlist/wishlist_widget.dart';
import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../widgets/empty_screen.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = "/WishListScreen";

  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListItemsList =
        wishListProvider.getWishListItems.values.toList().reversed.toList();
    return wishListItemsList.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/sale/viewed.png',
            title: 'Oops!',
            subtitle: "Your Wishlist is Currently Empty.",
            buttonText: "Let's Add Some")
        : Scaffold(
            appBar: AppBar(
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
              centerTitle: true,
              elevation: 0,
              backgroundColor:
                  Theme.of(context).colorScheme.background.withOpacity(0.3),
              title: TextWidget(
                text: 'WishList (${wishListItemsList.length})',
                color: color,
                textSize: 22,
                isTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    AlertDialogs.warningDialog(
                        title: 'Empty your wishlist?',
                        subtitle: 'Are you sure?',
                        fct: () async {
                          await wishListProvider.clearWishList();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: MasonryGridView.count(
              itemCount: wishListItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishListItemsList[index],
                    child: const WishlistWidget());
              },
            ),
          );
  }
}
