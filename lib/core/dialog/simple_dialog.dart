import 'package:flutter/material.dart';

class CustomSimpleDialog {
  static Future<void> showMessageDialog(
      {required BuildContext context,
      String? title,
      String? message,
      String? positiveButtonTitle}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? "AlertDialog Title"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message ??
                    "This is a demo alert dialog. Would you like to approve of this message?"),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(positiveButtonTitle ?? "Approve"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
