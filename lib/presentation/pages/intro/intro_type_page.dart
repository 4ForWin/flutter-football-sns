import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/home_bottom_navigation_bar_view_model.dart';
import 'package:mercenaryhub/presentation/pages/intro/widgets/progress_bar.dart';
import 'package:mercenaryhub/presentation/pages/intro/widgets/text_label.dart';

class IntroTypePage extends ConsumerStatefulWidget {
  String level;
  IntroTypePage(this.level, {super.key});
  @override
  ConsumerState<IntroTypePage> createState() => _IntroTypePageState();
}

class _IntroTypePageState extends ConsumerState<IntroTypePage> {
  String? type;
  @override
  Widget build(BuildContext context) {
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
            ProgressBar(1.0),
            TextLabel(text: '원하는 모집 분야를 선택해 주세요.', type: 'question'),
            SizedBox(height: 16),
            getTypeBox('recruitingPlayer'),
            getTypeBox('findingTeam'),
            Spacer(),
            getSubmitButton(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  GestureDetector getTypeBox(String chosenType) {
    String title = '용병을 모집하고 싶어요.';
    String content = '풋살을 하고 싶은 용병을 모집';
    if (chosenType == 'findingTeam') {
      title = '운동할 수 있는 팀을 찾고 싶어요';
      content = '참가하고 싶은 팀을 자유롭게 선택';
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          type = chosenType;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: type == chosenType ? Color(0xFF004FFF) : Color(0xFFE8EEF2),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  chosenType == 'recruitingPlayer'
                      ? 'assets/images/recruiting_player.svg'
                      : 'assets/images/finding_team.svg',
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(text: title, type: 'title'),
                    TextLabel(text: content, type: 'body'),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.check_circle,
              color: type == chosenType ? Color(0xFF2BBB7D) : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox getSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final homeBottomVm =
              ref.read(homeBottomNavigationBarViewModelProvider.notifier);

          if (type == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('알림'),
                  content: Text('모집 유형을 선택해 주세요!'),
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
          } else if (type == 'recruitingPlayer') {
            homeBottomVm.onIndexChanged(1);

            // 용병찾기 페이지로 이동
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else {
            homeBottomVm.onIndexChanged(0);

            // 팀 찾기 페이지로 이동
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
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
}
