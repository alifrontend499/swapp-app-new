import 'package:flutter/material.dart';

// build snack bar
SnackBar buildSnackBar(String text, String type) => SnackBar(
  content: Text(text),
  backgroundColor: type == 'error' ? Colors.redAccent : Colors.green,
  dismissDirection: DismissDirection.startToEnd,
);