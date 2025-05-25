import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class LevelDropdownFormField extends StatelessWidget {
  final String typeText;

  const LevelDropdownFormField({
    super.key,
    required this.typeText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final writeState = ref.watch(writeViewModelProvider);
      final writeVm = ref.read(writeViewModelProvider.notifier);
      return DropdownButtonFormField(
        value: writeState.level,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
          color: Color(0xff222222),
        ),
        decoration: InputDecoration(
          labelText: typeText == '용병' ? '내 실력' : '원하는 실력',
          labelStyle: TextStyle(
            color: Color(0xff222222),
          ),
        ),
        onChanged: writeVm.changeLevel,
        items: [
          '루키 - 아직 내 실력을 모르겠어요',
          '비기너 - 입문부터 풋살과 친해지는 중이에요',
          '세미프로 - 실전 경험이 많아요',
          '프로 - 대회 경험이 다수 있는 생활 체육인'
        ].map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value?.trim().isEmpty ?? true) {
            return typeText == '용병' ? '내 실력을 선택해 주세요' : '원하는 실력을 선택해 주세요';
          }

          return null;
        },
      );
    });
  }
}
