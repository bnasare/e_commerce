import 'package:e_commerce/dialog_box.dart/dialog_box.dart';
import 'package:e_commerce/provider/dark_theme_provider.dart';
import 'package:e_commerce/screens/wishlist/wishlist_screen.dart';
import 'package:e_commerce/services/global_methods.dart';
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
              const Text(
                'My Name',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
              ),
              const Text(
                'benedictasare2@gmail.com',
                style: TextStyle(fontWeight: FontWeight.w400),
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
                subtitle: const Text('GW-0820-3072'),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  AlertDialogs.showAddressDialog(
                      context, addressTextController);
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
                onTap: () {},
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
                onTap: () {},
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
                onTap: () {},
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
                        setState(() {
                          themeState.setDarkTheme = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  IconlyLight.logout,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(IconlyLight.arrowRight2),
                onTap: () {
                  AlertDialogs.showSignOutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
