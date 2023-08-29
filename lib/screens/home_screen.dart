import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/services/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offers/camboo_wear.jpg',
    'assets/images/offers/heels_shop.jpg',
    'assets/images/offers/kicks_wear.jpg',
    'assets/images/offers/leather_wear.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height * 0.30,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                _offerImages[index],
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
            itemCount: _offerImages.length,
            pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    color: Colors.white, activeColor: Colors.red)),
            // control: const SwiperControl(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
