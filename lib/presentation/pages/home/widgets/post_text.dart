import 'package:flutter/material.dart';

class PostText extends StatelessWidget {
  final String text;
  final double? fontSize;

  const PostText(
    this.text, {
    super.key,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ).copyWith(fontSize: fontSize),
    );
  }
}
