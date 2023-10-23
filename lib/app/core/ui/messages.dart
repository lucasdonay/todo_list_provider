import 'package:flutter/material.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(message),
      ),
      backgroundColor: color,
    ));
  }

  void showError(String message) => showMessage(message, Colors.red);
  void showInfo(String message) => showMessage(message, Color(0xff5C77CE));
}
