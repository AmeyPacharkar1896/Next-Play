import 'package:flutter/material.dart';
import 'package:next_play/application.dart';

void showSnackBar(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(message)),
  );
}
