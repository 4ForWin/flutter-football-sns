import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/view_models/write_view_model.dart';

class TimeIcon extends StatelessWidget {
  final TextEditingController controller;
  final String type;

  const TimeIcon({
    super.key,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeVm = ref.read(writeViewModelProvider.notifier);
        final changeEnable = type == 'start'
            ? writeVm.changeIsStartTimeFieldEnable
            : writeVm.changeIsEndTimeFieldEnable;
        return GestureDetector(
          onTap: () async {
            print('시간 아이콘');
            final time = await writeVm.changeTime(context, type);
            print(time);
            if (time == null) return;
            controller.text = time;
            await Future.delayed(Duration(milliseconds: 10));
            changeEnable(false);
          },
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.access_time_sharp),
          ),
        );
      },
    );
  }
}
