import 'package:e_commerce/inner_screens/feeds_screen.dart';
import 'package:e_commerce/services/global_methods.dart';
import 'package:e_commerce/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  final String imagePath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final themeState = Utils(context).getTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1),
            Image.asset(
              imagePath,
              width: double.infinity,
              height: size.height * 0.4,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.red, fontSize: 35, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextWidget(
              text: subtitle,
              color: Colors.cyan,
              textSize: 20,
            ),
            SizedBox(height: size.height * 0.1),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: color,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
              ),
              onPressed: () {
                GlobalMethods.navigateTo(
                    context: context, routeName: FeedsScreen.routeName);
              },
              child: TextWidget(
                text: buttonText,
                color: themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                textSize: 20,
                isTitle: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
