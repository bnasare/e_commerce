import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/dialog_box.dart';
import 'package:e_commerce/consts/firebase_consts.dart';
import 'package:e_commerce/providers/dark_theme_provider.dart';
import 'package:e_commerce/screens/auth/forget_password.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/orders/orders_screen.dart';
import 'package:e_commerce/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:e_commerce/screens/wishlist/wishlist_screen.dart';
import 'package:e_commerce/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController addressTextController = TextEditingController();
  final User? user = authInstance.currentUser;
  @override
  void dispose() {
    addressTextController.dispose();
    super.dispose();
  }

  String? email;
  String? name;
  String? address;

  bool isLoading = false;
  @override
  void initState() {
    getUserdata();
    super.initState();
  }

  Future<void> getUserdata() async {
    setState(() {
      isLoading = true;
    });
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      String uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // ignore: unnecessary_null_comparison
      if (userDoc == null) {
        return;
      } else {
        email = userDoc.get('email');
        address = userDoc.get('shipping_address');
        name = userDoc.get('name');
        addressTextController.text = userDoc.get('shipping_address');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      AlertDialogs.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Hi ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: name == null ? 'user' : name!,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                email == null ? 'Email' : email!,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  IconlyLight.profile,
                ),
                title: const Text(
                  'Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(address ?? "Shipping Address"),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Change Address'),
                        content: TextField(
                          onChanged: (value) {
                            print('Value: $addressTextController');
                          },
                          controller: addressTextController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                              hintText: 'Update user address'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              try {
                                final User? user = authInstance.currentUser;
                                FirebaseFirestore.instance
                                    .doc(user!.uid)
                                    .update({
                                  'shipping_address': addressTextController.text
                                });
                              } catch (error) {
                                AlertDialogs.errorDialog(
                                    subtitle: 'Update unsuccessful',
                                    context: context);
                              }

                              setState(() {
                                address = addressTextController.text;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  IconlyLight.bag2,
                ),
                title: const Text(
                  'Orders',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: OrdersScreen.routeName);
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  IconlyLight.show,
                ),
                title: const Text(
                  'Viewed',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  GlobalMethods.navigateTo(
                      context: context,
                      routeName: ViewedRecentlyScreen.routeName);
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  IconlyLight.heart,
                ),
                title: const Text(
                  'Wishlist',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: WishListScreen.routeName);
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  IconlyLight.password,
                ),
                title: const Text(
                  'Forgot password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPasswordScreen()));
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ListTile(
                  leading: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  title: const Text(
                    'Theme',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  trailing: SizedBox(
                    width: 24.0,
                    child: SwitchListTile(
                      title: const Text('Theme'),
                      value: themeState.getDarkTheme,
                      onChanged: (bool value) {
                        setState(
                          () {
                            themeState.setDarkTheme = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(
                  user == null ? IconlyLight.login : IconlyLight.logout,
                ),
                title: Text(
                  user == null ? 'Login' : 'Logout',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  if (user == null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                    return;
                  }
                  AlertDialogs.warningDialog(
                    title: 'Sign out',
                    subtitle: 'Do you wish to sign out?',
                    fct: () async {
                      await authInstance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
