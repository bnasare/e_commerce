import 'package:e_commerce/screens/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(microseconds: 5), () async {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      await productProvider.fetchProducts();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomBarScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/loading.jpg',
              fit: BoxFit.cover, height: double.infinity),
          Container(color: Colors.black.withOpacity(0.7)),
          const Center(child: SpinKitFadingCircle(color: Colors.white))
        ],
      ),
    );
  }
}
