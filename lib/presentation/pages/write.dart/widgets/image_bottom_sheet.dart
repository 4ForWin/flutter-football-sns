import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercenaryhub/core/loading_bar.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class ImageBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final LoadingOverlay loadingOverlay;

  const ImageBottomSheet({
    super.key,
    required this.controller,
    required this.loadingOverlay,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeState = ref.watch(writeViewModelProvider);
        final writeVm = ref.read(writeViewModelProvider.notifier);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -30,
                  child: Visibility(
                    visible: writeState.isErrorVisible,
                    child: Text(
                      '이미지를 업로드 해주세요',
                      style: TextStyle(
                        color: Color(0xffC82223),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  // TextFormFiled는 Visibility위젯 사용하면 x
                  // 사용하면 텍스트관련 인식 안함
                  width: 0,
                  height: 0,
                  child: TextFormField(
                    enabled: false,
                    controller: controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        // 이미지 업로드 에러 텍스트 보여줌
                        writeVm.changeIsErrorVisible(true);

                        return '이미지를 업로드 해주세요!!';
                      }

                      return null;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    print('이미지 선택');

                    loadingOverlay.show(context);

                    final imagePicker = ImagePicker();
                    XFile? xfile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (xfile != null) {
                      // 유효성 검사 통과하기 위해
                      controller.text = xfile.path;

                      // 업로드할 이미지 상태에 저장
                      writeVm.changeImageFile(xfile);

                      // 이미지 업로드 에러 텍스트 숨김
                      writeVm.changeIsErrorVisible(false);
                    }
                    loadingOverlay.hide();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.transparent,
                    child: Icon(Icons.image),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
