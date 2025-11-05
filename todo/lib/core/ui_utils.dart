import 'package:flutter/material.dart';

class UiUtils {
  //
  static void toast(BuildContext ctx, String text) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) =>
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(text))),
    );
  }

  static Future<void> errorDialog(
    BuildContext ctx,
    String message,
    String title,
  ) {
    return showDialog(
      context: ctx,
      barrierColor: Colors.black, //.withValues(alpha: 0.9),
      builder: (BuildContext ctx) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                Divider(height: 16, thickness: 1, color: Colors.grey),
                const SizedBox(height: 16),
                Text(message),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> alertDialog(
    BuildContext ctx,
    String message,
    String title,
  ) {
    return showDialog(
      context: ctx,
      builder: (BuildContext ctx) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                Divider(height: 16, thickness: 1, color: Colors.grey),
                const SizedBox(height: 16),
                Text(message),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void yesNoDialog(
    BuildContext ctx,
    String message,
    String title,
    VoidCallback? onConfirm,
  ) {
    Widget yesButton = TextButton(onPressed: onConfirm, child: Text("Yes"));
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () => Navigator.of(ctx).pop(),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [noButton, yesButton],
    );

    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
