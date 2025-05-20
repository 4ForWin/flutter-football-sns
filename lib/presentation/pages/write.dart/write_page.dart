import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final formKey = GlobalKey<FormState>();
  final locationTextController = TextEditingController(text: '');
  final titleTextController = TextEditingController(text: '');
  final teamTextController = TextEditingController(text: '');
  final contentTextController = TextEditingController(text: '');
  final imagePathTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    locationTextController.dispose();
    titleTextController.dispose();
    teamTextController.dispose();
    contentTextController.dispose();
    imagePathTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final writeState = ref.watch(writeViewModelProvider);
    final writeVm = ref.read(writeViewModelProvider.notifier);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
              shape: Border(
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    print('게시하기');
                    final result = formKey.currentState!.validate();
                    if (result) {
                      print('ye');
                      await writeVm.uploadImage();
                      bool isComplte = await writeVm.insertFeed(
                        title: titleTextController.text,
                        content: teamTextController.text,
                        teamName: contentTextController.text,
                      );
                      if (isComplte) {
                        print('✅ 게시 완료');
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
                )
              ],
              actionsPadding: EdgeInsets.only(right: 20)),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: writeState.isLocationFieldEnable,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          if (writeState.isLocationFieldEnable) {
                            locationTextController.text = '';
                          }
                        },
                        controller: locationTextController,
                        decoration: InputDecoration(
                          hintText: '위치를 설정해 주세요',
                        ),
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return '우측 아이콘을 이용해 위치를 설정해 주세요';
                          }

                          return null;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print('위치 아이콘');
                        locationTextController.text = writeVm.setLocation();
                        await Future.delayed(Duration(milliseconds: 10));
                        writeVm.changeIsLocationFieldEnable(false);
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.gps_fixed),
                      ),
                    )
                  ],
                ),
                TextFormField(
                  controller: teamTextController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: '팀을 입력해 주세요'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return '팀을 입력해 주세요';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: titleTextController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: '제목을 입력해 주세요'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return '제목을 입력해 주세요';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 300,
                  child: TextFormField(
                    controller: contentTextController,
                    expands: true,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: '시간, 장소 등 자세한 내용을 입력해 주세요',
                    ),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return '시간, 장소 등 자세한 내용을 입력해 주세요';
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
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
                )
              ],
            ),
          ),
          bottomSheet: Padding(
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
                      controller: imagePathTextController,
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

                      final imagePicker = ImagePicker();
                      XFile? xfile = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );

                      if (xfile != null) {
                        // 유효성 검사 통과하기 위해
                        imagePathTextController.text = xfile.path;

                        // 업로드할 이미지 상태에 저장
                        writeVm.changeImageFile(xfile);

                        // 이미지 업로드 에러 텍스트 숨김
                        writeVm.changeIsErrorVisible(false);
                      }
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
          ),
        ),
      ),
    );
  }
}
