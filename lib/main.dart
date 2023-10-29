import 'package:device_preview/device_preview.dart';
import 'package:e_commerce/fetch_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'firebase_options.dart';
import 'inner_screens/category_screen.dart';
import 'inner_screens/feeds_screen.dart';
import 'inner_screens/on_sale_screen.dart';
import 'inner_screens/product_details.dart';
import 'providers/cart_provider.dart';
import 'providers/dark_theme_provider.dart';
import 'providers/orders_provider.dart';
import 'providers/product_provider.dart';
import 'providers/viewed_products_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/auth/forget_password.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/viewed_recently/viewed_recently_screen.dart';
import 'screens/wishlist/wishlist_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51O6bl5APWReggQoZ8BtZ1N2MQSH1Ddo2L0iT6kVsVoqVFWdvLzrAWHrX583Hzuw8OaiNswrDumrs0qOyYSYgfZ1l00jNpfTO3i';
  Stripe.instance.applySettings();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    );
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

  Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          const MaterialApp(
            debugShowCheckedModeBanner: false,
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
            }),
            ChangeNotifierProvider(create: (_) {
              return OrdersProvider();
            })
          ],
          child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                home: const FetchScreen(),
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

// class PaymentDemo extends StatelessWidget {
//   const PaymentDemo({Key? key}) : super(key: key);
//   Future<void> initPayment(
//       {required String email,
//       required double amount,
//       required BuildContext context}) async {
//     try {
//       // 1. Create a payment intent on the server
//       final response = await http.post(
//           Uri.parse(
//               'https://us-central1-e-commerce1a.cloudfunctions.net/stripePaymentIntentRequest'),
//           body: {
//             'email': email,
//             'amount': amount.toString(),
//           });

//       final jsonResponse = jsonDecode(response.body);
//       log(jsonResponse.toString());
//       // 2. Initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: jsonResponse['paymentIntent'],
//         merchantDisplayName: 'Footwear Hub',
//         customerId: jsonResponse['customer'],
//         customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
//         // testEnv: true,
//         // merchantCountryCode: 'SG',
//       ));
//       await Stripe.instance.presentPaymentSheet();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Payment is successful'),
//         ),
//       );
//     } catch (errorr) {
//       if (errorr is StripeException) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('An error occured ${errorr.error.localizedMessage}'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('An error occured $errorr'),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//         child: const Text('Pay 20\$'),
//         onPressed: () async {
//           await initPayment(
//               amount: 50.0, context: context, email: 'email@test.com');
//         },
//       )),
//     );
//   }
// }
