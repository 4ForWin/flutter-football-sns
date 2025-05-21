import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class TimeTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String type;

  const TimeTextFormField({
    super.key,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final writeState = ref.watch(writeViewModelProvider);
      final enabled = type == 'start'
          ? writeState.isStartTimeFieldEnable
          : writeState.isEndTimeFieldEnable;
      return Expanded(
        child: TextFormField(
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onChanged: (value) {
            if (enabled) {
              controller.text = '';
            }
          },
          style: TextStyle(
            color: Color(0xff222222),
          ),
          decoration: InputDecoration(
            labelText: type == 'start' ? '시작 시간' : '끝 시간',
            labelStyle: TextStyle(
              color: Color(0xff222222),
            ),
          ),
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return '우측 아이콘을 이용해 시간을 설정해 주세요';
            }

            return null;
          },
        ),
      );
    });
  }
}
