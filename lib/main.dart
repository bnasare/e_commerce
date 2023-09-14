import 'package:e_commerce/inner_screens/category_screen.dart';
import 'package:e_commerce/inner_screens/feeds_screen.dart';
import 'package:e_commerce/inner_screens/on_sale_screen.dart';
import 'package:e_commerce/inner_screens/product_details.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/providers/viewed_products_provider.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:e_commerce/screens/auth/forget_password.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/auth/signup_screen.dart';
import 'package:e_commerce/screens/orders/orders_screen.dart';
import 'package:e_commerce/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:e_commerce/screens/wishlist/wishlist_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'provider/dark_theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('An error occured'),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return themeChangeProvider;
            }),
            ChangeNotifierProvider(create: (_) {
              return ProductProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return CartProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return WishListProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return ViewedProductsProvider();
            })
          ],
          child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                home: const LoginScreen(),
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                routes: {
                  OnSaleScreen.routeName: (context) => const OnSaleScreen(),
                  FeedsScreen.routeName: (context) => const FeedsScreen(),
                  ProductDetailsScreen.routeName: (context) =>
                      const ProductDetailsScreen(),
                  WishListScreen.routeName: (context) => const WishListScreen(),
                  OrdersScreen.routeName: (context) => const OrdersScreen(),
                  ViewedRecentlyScreen.routeName: (context) =>
                      const ViewedRecentlyScreen(),
                  SignUpScreen.routeName: (context) => const SignUpScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  ForgetPasswordScreen.routeName: (context) =>
                      const ForgetPasswordScreen(),
                  CategoryScreen.routeName: (context) => const CategoryScreen()
                },
              );
            },
          ),
        );
      },
    );
  }
}
