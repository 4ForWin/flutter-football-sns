import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class TimeField extends StatelessWidget {
  final String type;

  const TimeField({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeState = ref.watch(writeViewModelProvider);
        final writeVm = ref.read(writeViewModelProvider.notifier);
        final text1 = type == 'start' ? '시작 시간' : '끝 시간';
        String? text2;
        final time =
            type == 'start' ? writeState.time.start : writeState.time.end;
        print('시간쓰--');
        print(time);

        if (time is DateTime) {
          text2 = DateFormat('HH:MM').format(time);
        } else {
          text2 = '설정이 필요합니다';
        }

        return ElevatedButton(
          onPressed: () async {
            await writeVm.changeTime(context, type);
          },
          child: Text('$text1 : $text2'),
        );
      },
    );
  }
}
