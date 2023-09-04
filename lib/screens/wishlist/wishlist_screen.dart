import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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
    Size size = Utils(context).getScreenSize;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              Theme.of(context).colorScheme.background.withOpacity(0.3),
          title: TextWidget(
            text: 'WishList (2)',
            color: color,
            textSize: 22,
            isTitle: true,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            ),
          ],
        ),
        body: Container());
  }
}
