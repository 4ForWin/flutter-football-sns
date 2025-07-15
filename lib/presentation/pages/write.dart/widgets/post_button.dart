import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/core/loading_bar.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/view_models/write_view_model.dart';

class PostButton extends StatelessWidget {
  final BuildContext homeContext;
  final GlobalKey<FormState> formKey;
  final TextEditingController costTextController;
  final TextEditingController personTextController;
  final TextEditingController teamTextController;
  final TextEditingController nameTextController;
  final TextEditingController contentTextController;
  final LoadingOverlay loadingOverlay;
  final String typeText;

  const PostButton({
    super.key,
    required this.homeContext,
    required this.formKey,
    required this.costTextController,
    required this.personTextController,
    required this.teamTextController,
    required this.nameTextController,
    required this.contentTextController,
    required this.loadingOverlay,
    required this.typeText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeVm = ref.read(writeViewModelProvider.notifier);

        return GestureDetector(
          onTap: () async {
            try {
              print('게시하기 버튼 터치');
              final result = formKey.currentState!.validate();

              if (result) {
                print('유효성 검사 완료');
                loadingOverlay.show(context);
                await writeVm.uploadImage();
                bool? isComplete;

                switch (typeText) {
                  case '용병':
                    isComplete = await writeVm.insertMercenaryFeed(
                      name: nameTextController.text.trim(),
                      cost: costTextController.text.trim(),
                      content: contentTextController.text.trim(),
                    );
                    break;

                  case '팀':
                    isComplete = await writeVm.insertTeamFeed(
                      teamName: teamTextController.text.trim(),
                      cost: costTextController.text.trim(),
                      person: personTextController.text.trim(),
                      content: contentTextController.text.trim(),
                    );
                    break;
                  default:
                    break;
                }

                if (isComplete == true) {
                  print('✅ 게시 완료');
                  loadingOverlay.hide();
                  Navigator.pop(context);

                  if (context.mounted) {
                    ScaffoldMessenger.of(homeContext)
                        .showSnackBar(SnackBar(content: Text('게시글을 등록하였습니다.')));
                  }
                } else {
                  print('✅ 게시 실패');
                  loadingOverlay.hide();
                  if (context.mounted) {
                    ScaffoldMessenger.of(homeContext).showSnackBar(
                        SnackBar(content: Text('게시글 등록에 실패했습니다. 다시 시도해주세요.')));
                  }
                }
              } else {
                print('유효성 검사 실패');
              }
            } catch (e) {
              loadingOverlay.hide();
              if (context.mounted) {
                ScaffoldMessenger.of(homeContext).showSnackBar(
                    SnackBar(content: Text('게시글 등록에 실패했습니다. 다시 시도해주세요.')));
              }
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
