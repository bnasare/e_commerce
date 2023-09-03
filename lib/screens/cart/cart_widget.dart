import 'package:e_commerce/services/utils.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.27,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: FancyShimmerImage(
                      imageUrl:
                          'https://static.wixstatic.com/media/8ae49c_38b9112702ca4a34ba1ac6270a402d9b~mv2.jpg/v1/fill/w_640,h_560,fp_0.50_0.50,q_80,usm_0.66_1.00_0.01,enc_auto/8ae49c_38b9112702ca4a34ba1ac6270a402d9b~mv2.jpg',
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Title',
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Material(
                                color: color,
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {},
                                  child: const Icon(Icons.plus_one_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Material(
                                color: color,
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {},
                                  child: const Icon(Icons.plus_one_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
