import 'package:flutter/material.dart';

class TitleTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const TitleTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(hintText: '제목을 입력해 주세요'),
      validator: (value) {
        if (value?.trim().isEmpty ?? true) {
          return '제목을 입력해 주세요';
        }

        return null;
      },
    );
  }
}
