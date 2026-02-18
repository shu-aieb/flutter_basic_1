import 'package:flutter/material.dart';

import '../constants/my_sizes.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final int maxLines;

  const MyTextfield({
    super.key,
    required this.controller,
    this.hintText = "",
    required this.labelText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.5),
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyRadiusSize.large),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
