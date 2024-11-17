import 'package:flutter/material.dart';

void showClientNotFoundDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(_getDialogTitle(message)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

String _getDialogTitle(String message) {
  switch (message.toLowerCase()) {
    case 'invalid credentials':
      return 'Incorrect Password';
    case 'user not found':
      return 'User Not Found';
    default:
      return 'Error';
  }
}
