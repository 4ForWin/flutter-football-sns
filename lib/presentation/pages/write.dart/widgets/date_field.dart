import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/view_models/write_view_model.dart';

class DateField extends StatelessWidget {
  const DateField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeState = ref.watch(writeViewModelProvider);
        final writeVm = ref.read(writeViewModelProvider.notifier);

        return ElevatedButton(
          onPressed: () async {
            await writeVm.changeDate(context);
          },
          child: Text(
            '날짜 : ${DateFormat('yyyy-MM-dd').format((writeState.date))}',
          ),
        );
      },
    );
  }
}
