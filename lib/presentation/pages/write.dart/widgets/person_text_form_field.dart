import 'package:flutter/material.dart';

class PersonTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const PersonTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      maxLength: 2,
      style: TextStyle(
        color: Color(0xff222222),
      ),
      decoration: InputDecoration(
        labelText: '인원',
        labelStyle: TextStyle(
          color: Color(0xff222222),
        ),
      ),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return '인원을 입력해 주세요';
        }

        return null;
      },
    );
  }
}
