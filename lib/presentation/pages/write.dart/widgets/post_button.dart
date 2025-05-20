import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/core/loading_bar.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class PostButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleTextController;
  final TextEditingController contentTextController;
  final TextEditingController teamTextController;
  final LoadingOverlay loadingOverlay;

  const PostButton({
    super.key,
    required this.formKey,
    required this.titleTextController,
    required this.contentTextController,
    required this.teamTextController,
    required this.loadingOverlay,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeVm = ref.read(writeViewModelProvider.notifier);

        return GestureDetector(
          onTap: () async {
            print('게시하기');
            final result = formKey.currentState!.validate();
            if (result) {
              print('ye');
              loadingOverlay.show(context);
              await writeVm.uploadImage();
              bool isComplte = await writeVm.insertFeed(
                title: titleTextController.text,
                content: contentTextController.text,
                teamName: teamTextController.text,
              );
              if (isComplte) {
                print('✅ 게시 완료');
                loadingOverlay.hide();
              } else {
                print('✅ 게시 실패......');
              }
            } else {
              print('놉');
            }
          },
          child: Text(
            '게시하기',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
