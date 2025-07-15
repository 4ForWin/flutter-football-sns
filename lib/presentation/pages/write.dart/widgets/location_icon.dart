import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/core/loading_bar.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/view_models/write_view_model.dart';

class LocationIcon extends StatelessWidget {
  final TextEditingController controller;
  final LoadingOverlay loadingOverlay;

  const LocationIcon({
    super.key,
    required this.controller,
    required this.loadingOverlay,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeVm = ref.read(writeViewModelProvider.notifier);
        return GestureDetector(
          onTap: () async {
            print('위치 아이콘');
            loadingOverlay.show(context);
            controller.text = await writeVm.getLocation();
            await Future.delayed(Duration(milliseconds: 10));
            writeVm.changeIsLocationFieldEnable(false);
            loadingOverlay.hide();
          },
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.gps_fixed),
          ),
        );
      },
    );
  }
}
