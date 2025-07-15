import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/intro/intro_type_page.dart';
import 'package:mercenaryhub/presentation/pages/intro/view_models/intro_level_view_model.dart';
import 'package:mercenaryhub/presentation/pages/intro/widgets/progress_bar.dart';
import 'package:mercenaryhub/presentation/pages/intro/widgets/text_label.dart';

class IntroLevelPage extends ConsumerWidget {
  const IntroLevelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressBar(0.5),
            TextLabel(text: '당신의 풋살 실력은 어느 정도인가요?', type: 'question'),
            SizedBox(height: 16),
            getLevelBox(ref, 'rookie', '루키 - 아직 내 실력을 모르겠어요.'),
            getLevelBox(ref, 'beginner', '비기너 - 풋살과 친해지는 중이에요'),
            getLevelBox(ref, 'amateur', '아마추어 - 기본기는 어느 정도 있는 상태예요.'),
            getLevelBox(ref, 'semipro', '세미프로 - 실전 경험이 있고 대회에 많이 나가 봤어요.'),
            getLevelBox(ref, 'pro', '프로 - 프로선수 경험이 있어요'),
            Spacer(),
            getSubmitButton(ref, context),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  SizedBox getSubmitButton(WidgetRef ref, BuildContext context) {
    IntroLevelState state = ref.watch(introLevelViewModelProvider);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (state.futsalLevel == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('알림'),
                  content: Text('풋살 실력을 선택해 주세요!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      child: Text('확인'),
                    ),
                  ],
                );
              },
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return IntroTypePage(state.futsalLevel!);
                },
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2BBB7D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 원하는 borderRadius 값
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          '계속하기',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  GestureDetector getLevelBox(WidgetRef ref, String chosenLevel, String text) {
    IntroLevelState state = ref.watch(introLevelViewModelProvider);
    return GestureDetector(
      onTap: () {
        ref.read(introLevelViewModelProvider.notifier).setLevel(chosenLevel);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: state.futsalLevel == chosenLevel
                ? Color(0xFF004FFF)
                : Color(0xFFE8EEF2),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLabel(text: text, type: 'body'),
              Icon(
                Icons.check_circle,
                color: state.futsalLevel == chosenLevel
                    ? Color(0xFF2BBB7D)
                    : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
