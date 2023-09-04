import 'package:e_commerce/provider/dark_theme_provider.dart';
import 'package:e_commerce/screens/cart/cart_screen.dart';
import 'package:e_commerce/screens/categories_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int selectedIndex = 3;

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

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: isDark ? Colors.white : Colors.black26,
          selectedItemColor:
              isDark ? Colors.lightBlue.withOpacity(0.8) : Colors.black,
          backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          currentIndex: selectedIndex,
          onTap: selectedScreen,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(selectedIndex == 0
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: 'Offers'),
            BottomNavigationBarItem(
                icon:
                    Icon(selectedIndex == 0 ? IconlyBold.buy : IconlyLight.buy),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                    selectedIndex == 0 ? IconlyBold.user3 : IconlyLight.user3),
                label: 'User'),
          ]),
    );
  }
}
