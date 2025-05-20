import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  String text;
  String type;

  TextLabel({required this.text, required this.type});

  TextStyle questionStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  TextStyle titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle bodyStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  late TextStyle style = questionStyle;

  @override
  Widget build(BuildContext context) {
    if (type == 'question') {
      style = questionStyle;
    } else if (type == 'title') {
      style = titleStyle;
    } else {
      style = bodyStyle;
    }
    return Text(text, style: style);
  }
}
