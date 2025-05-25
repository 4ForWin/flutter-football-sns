import 'package:flutter/material.dart';

class NameTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const NameTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 10,
      style: TextStyle(
        color: Color(0xff222222),
      ),
      decoration: InputDecoration(
          labelText: '이름',
          labelStyle: TextStyle(
            color: Color(0xff222222),
          )),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return '이름을 입력해 주세요';
        }

        return null;
      },
    );
  }
}
