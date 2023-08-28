import 'package:flutter/material.dart';

class AlertDialogs {
  static void showAddressDialog(
      BuildContext context, TextEditingController addressTextController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Address'),
          content: TextField(
            onChanged: (value) {
              print('Value: $addressTextController');
            },
            controller: addressTextController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Update user address'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert Dialog 2'),
          content: const Text('This is the content for Alert Dialog 2.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
