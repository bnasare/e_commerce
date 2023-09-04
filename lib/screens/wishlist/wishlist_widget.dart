import 'package:e_commerce/inner_screens/product_details.dart';
import 'package:e_commerce/widgets/heart_button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
              context: context, routeName: ProductDetailsScreen.routeName);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8),
                width: size.width * 0.2,
                height: size.width * 0.25,
                child: FancyShimmerImage(
                  imageUrl:
                      'https://static.wixstatic.com/media/8ae49c_38b9112702ca4a34ba1ac6270a402d9b~mv2.jpg/v1/fill/w_640,h_560,fp_0.50_0.50,q_80,usm_0.66_1.00_0.01,enc_auto/8ae49c_38b9112702ca4a34ba1ac6270a402d9b~mv2.jpg',
                  boxFit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyLight.bag2,
                            color: color,
                          ),
                        ),
                        const HeartButton(),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextWidget(
                      text: 'Title',
                      color: color,
                      textSize: 20.0,
                      maxLines: 2,
                      isTitle: true,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: '\$2.59',
                    color: color,
                    textSize: 18.0,
                    maxLines: 1,
                    isTitle: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
