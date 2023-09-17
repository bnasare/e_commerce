import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AlertDialogs {
  static void warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                IconlyLight.dangerTriangle,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 3),
              Text(title),
            ],
          ),
          content: Text(subtitle),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                fct();
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  static void errorDialog({
    required String subtitle,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                IconlyLight.dangerTriangle,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 3),
              Text('An Error Occured'),
            ],
          ),
          content: Text(subtitle),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
