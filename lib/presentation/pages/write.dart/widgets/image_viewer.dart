import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/view_models/write_view_model.dart';

class ImageViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final writeState = ref.watch(writeViewModelProvider);

        return Align(
          alignment: Alignment.centerRight,
          child: writeState.imageFile == null
              ? Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: Icon(Icons.image),
                )
              : SizedBox(
                  height: 100,
                  child: Image.file(
                    File(writeState.imageFile!.path),
                    fit: BoxFit.cover,
                  ),
                ),
        );
      },
    );
  }
}
