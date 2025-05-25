import 'package:flutter/material.dart';

class ContentTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String typeText;

  const ContentTextFormField({
    super.key,
    required this.controller,
    required this.typeText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 30,
      controller: controller,
      style: TextStyle(
        color: Color(0xff222222),
      ),
      decoration: InputDecoration(
          labelText: typeText == '용병' ? '특이사항' : '장소 및 특이사항',
          labelStyle: TextStyle(
            color: Color(0xff222222),
          )),
    );
  }
}
