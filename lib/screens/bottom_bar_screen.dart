import 'package:badges/badges.dart' as badge;
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/dark_theme_provider.dart';
import 'package:e_commerce/screens/cart/cart_screen.dart';
import 'package:e_commerce/screens/categories_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../widgets/text_widget.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int selectedIndex = 0;

  final List screens = [
    const HomeScreen(),
    CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];

  void selectedScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isDark = themeState.getDarkTheme;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: isDark ? Colors.white : Colors.black26,
        selectedItemColor:
            isDark ? Colors.lightBlue.withOpacity(0.8) : Colors.black,
        backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: selectedScreen,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon:
                  Icon(selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(selectedIndex == 0
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: 'Offers'),
          BottomNavigationBarItem(
            icon: badge.Badge(
              badgeAnimation: const badge.BadgeAnimation.slide(),
              badgeStyle: badge.BadgeStyle(
                shape: badge.BadgeShape.circle,
                badgeColor: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              position: badge.BadgePosition.topEnd(top: -7, end: -7),
              badgeContent: FittedBox(
                  child: TextWidget(
                      text: cartProvider.getCartItems.length.toString(),
                      color: Colors.white,
                      textSize: 15)),
              child:
                  Icon(selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  selectedIndex == 0 ? IconlyBold.user3 : IconlyLight.user3),
              label: 'User'),
        ],
      ),
    );
  }
}
