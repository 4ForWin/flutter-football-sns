import 'package:flutter/material.dart';

class CostTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const CostTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      maxLength: 6,
      style: TextStyle(
        color: Color(0xff222222),
      ),
      decoration: InputDecoration(
        labelText: '참가비',
        labelStyle: TextStyle(
          color: Color(0xff222222),
        ),
      ),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return '참가비를 입력해 주세요';
        }

        return null;
      },
    );
  }
}
