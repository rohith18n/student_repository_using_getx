import 'package:flutter/material.dart';

class CustomDecoration extends InputDecoration {
  final String text;
  final IconData iconData;
  CustomDecoration(this.text, this.iconData)
      : super(
            border: const OutlineInputBorder(),
            label: Text(text),
            prefixIcon: Icon(iconData));
}
