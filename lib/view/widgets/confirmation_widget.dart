import 'package:flutter/material.dart';

class ConfirmExitDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class ConfirmationWidget extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  const ConfirmationWidget({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text(cancelText),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: Text(confirmText, style: const TextStyle(color: Colors.red)),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
