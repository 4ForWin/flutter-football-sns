import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class DateIcon extends StatelessWidget {
  final TextEditingController controller;

  const DateIcon({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeVm = ref.read(writeViewModelProvider.notifier);
        return GestureDetector(
          onTap: () async {
            print('날짜 아이콘');
            final date = await writeVm.changeDate(context);
            print(date);
            if (date == null) return;
            controller.text = date;
            await Future.delayed(Duration(milliseconds: 10));
            writeVm.changeIsDateFieldEnable(false);
          },
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.calendar_month),
          ),
        );
      },
    );
  }
}
