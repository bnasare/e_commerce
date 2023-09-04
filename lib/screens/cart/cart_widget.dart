import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/heart_button.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../inner_screens/product_details.dart';
import '../../services/global_methods.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final quantityTextController = TextEditingController();
  @override
  void initState() {
    quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(
            context: context, routeName: ProductDetailsScreen.routeName);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.29,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: FancyShimmerImage(
                        imageUrl:
                            'https://static.wixstatic.com/media/8ae49c_38b9112702ca4a34ba1ac6270a402d9b~mv2.jpg/v1/fill/w_640,h_560,fp_0.50_0.50,q_80,usm_0.66_1.00_0.01,enc_auto/8ae49c_38b9112702ca4a34ba1ac6270a402d9b~mv2.jpg',
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextWidget(
                            text: 'Title',
                            color: color,
                            textSize: 20,
                            isTitle: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Material(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        if (quantityTextController.text ==
                                            '1') {
                                          return;
                                        } else {
                                          setState(() {
                                            quantityTextController
                                                .text = (int.parse(
                                                        quantityTextController
                                                            .text) -
                                                    1)
                                                .toString();
                                          });
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Icon(CupertinoIcons.minus,
                                            color: Colors.white, size: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(),
                                  ),
                                  textAlign: TextAlign.center,
                                  cursorColor: Colors.green,
                                  enabled: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        if (value.isEmpty) {
                                          quantityTextController.text = '1';
                                        } else {
                                          return;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Material(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      setState(() {
                                        quantityTextController.text =
                                            (int.parse(quantityTextController
                                                        .text) +
                                                    1)
                                                .toString();
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Icon(CupertinoIcons.add,
                                          color: Colors.white, size: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const HeartButton(),
                          TextWidget(
                            text: '\$0.39',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
