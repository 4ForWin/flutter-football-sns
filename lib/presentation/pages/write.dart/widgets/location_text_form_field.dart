import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class LocationTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const LocationTextFormField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final writeState = ref.watch(writeViewModelProvider);
      return Expanded(
        child: TextFormField(
          enabled: writeState.isLocationFieldEnable,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onChanged: (value) {
            if (writeState.isLocationFieldEnable) {
              controller.text = '';
            }
          },
          style: TextStyle(
            color: Color(0xff222222),
          ),
          decoration: InputDecoration(
            labelText: '지역',
            labelStyle: TextStyle(
              color: Color(0xff222222),
            ),
            hintText: '우측 아이콘을 이용해 지역를 설정해 주세요',
            hintStyle: TextStyle(
              color: Color(0xff222222),
            ),
          ),
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return '우측 아이콘을 이용해 지역를 설정해 주세요';
            }

            return null;
          },
        ),
      );
    });
  }
}
