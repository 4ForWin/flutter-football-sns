import 'package:flutter/material.dart';

class ContentTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const ContentTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: TextFormField(
        controller: controller,
        expands: true,
        maxLines: null,
        textInputAction: TextInputAction.newline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: '시간, 장소 등 자세한 내용을 입력해 주세요',
        ),
        validator: (value) {
          if (value?.trim().isEmpty ?? true) {
            return '시간, 장소 등 자세한 내용을 입력해 주세요';
          }

          return null;
        },
      ),
    );
  }
}
