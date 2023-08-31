import 'package:e_commerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.salePrice,
    required this.price,
    required this.textPrice,
    required this.isOnSale,
  }) : super(key: key);

  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    double userPrice = isOnSale ? salePrice : price;
    final Color color = Utils(context).color;

    double parsedTextPrice = double.tryParse(textPrice) ?? 1.0;

    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: '\$${(userPrice * parsedTextPrice).toStringAsFixed(2)}',
            color: Colors.green,
            textSize: 18,
            isTitle: false,
          ),
          const SizedBox(width: 5),
          if (isOnSale)
            Text(
              '\$${(price * parsedTextPrice).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 15,
                color: color,
                decoration: TextDecoration.lineThrough,
              ),
            ),
        ],
      ),
    );
  }
}
