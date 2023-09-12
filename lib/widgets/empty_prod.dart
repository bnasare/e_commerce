import 'package:e_commerce/services/utils.dart';
import 'package:flutter/cupertino.dart';

class EmptyProductScreen extends StatelessWidget {
  const EmptyProductScreen({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.08),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset('assets/images/sale/box.png'),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30, color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
