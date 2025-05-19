import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final formKey = GlobalKey<FormState>();
  final gpsTextController = TextEditingController(text: '');
  final titleTextController = TextEditingController(text: '');
  final contentTextController = TextEditingController(text: '');
  final imagePathTextController = TextEditingController();
  bool isVisible = false;
  String? imageUrl;

  @override
  void dispose() {
    super.dispose();
    gpsTextController.dispose();
    titleTextController.dispose();
    contentTextController.dispose();
    imagePathTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    print('게시 완료');
                    final result = formKey.currentState!.validate();
                    if (result) {
                      print('ye');
                    } else {
                      print('놉');
                      ;
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
                        enabled: false,
                        controller: gpsTextController,
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
                      onTap: () {
                        print('위치 아이콘');
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
                  controller: titleTextController,
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
                  child: imageUrl == null
                      ? Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey,
                          child: Icon(Icons.image),
                        )
                      : SizedBox(
                          height: 100,
                          child: Image.network(
                            imageUrl!,
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
                      visible: isVisible,
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
                    width: 0,
                    height: 0,
                    child: TextFormField(
                      enabled: false,
                      controller: imagePathTextController,
                      decoration: InputDecoration(
                        hintText: '123',
                      ),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          setState(() {
                            isVisible = true;
                            imagePathTextController.text = '1';
                          });

                          return '';
                        }

                        return null;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('이미지 선택');
                      setState(() {
                        isVisible = false;
                      });
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
