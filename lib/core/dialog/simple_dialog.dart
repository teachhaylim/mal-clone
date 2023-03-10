import 'package:flutter/material.dart';
import 'package:mal_clone/core/locale/locale.dart';
import 'package:mal_clone/core/theme/design_system.dart';

class CustomSimpleDialog {
  static void showMessageDialog({required BuildContext context, String title = AppLocale.info, required String message, String positiveButtonTitle = AppLocale.ok}) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(positiveButtonTitle),
              onPressed: () => Navigator.of(context).pop(),
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
            borderRadius: BorderRadius.circular(DesignSystem.radius12),
          ),
        ),
      );
  }
}
