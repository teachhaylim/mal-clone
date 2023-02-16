import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mal_clone/core/locale/locale.dart';

class CustomSimpleDialog {
  static Future<void> showMessageDialog({required BuildContext context, String? title, String? message, String? positiveButtonTitle}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? "AlertDialog Title"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message ?? "This is a demo alert dialog. Would you like to approve of this message?"),
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

  static void showComingSoon({required BuildContext context}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text(AppLocale.comingSoonMessage),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }
}
