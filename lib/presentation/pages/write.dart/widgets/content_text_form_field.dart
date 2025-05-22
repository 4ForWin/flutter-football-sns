import 'package:flutter/material.dart';

class ContentTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const ContentTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 30,
      controller: controller,
      style: TextStyle(
        color: Color(0xff222222),
      ),
      decoration: InputDecoration(
          labelText: '장소 및 특이사항',
          labelStyle: TextStyle(
            color: Color(0xff222222),
          )),
    );
  }
}
