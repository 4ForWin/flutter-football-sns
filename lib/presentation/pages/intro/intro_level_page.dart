import 'package:flutter/material.dart';
import 'package:mercenaryhub/presentation/pages/intro/widgets/text_label.dart';

class IntroLevelPage extends StatefulWidget {
  @override
  State<IntroLevelPage> createState() => _IntroLevelPageState();
}

class _IntroLevelPageState extends State<IntroLevelPage> {
  String? level;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(text: '당신의 풋살 실력은 어느 정도인가요?', type: 'question'),
            SizedBox(height: 16),
            getLevelBox('rookie', '루키 - 아직 내 실력을 모르겠어요.'),
            getLevelBox('beginner', '비기너 - 풋살과 친해지는 중이에요'),
            getLevelBox('amateur', '아마추어 - 기본기는 어느 정도 있는 상태예요.'),
            getLevelBox('semipro', '세미프로 - 실전 경험이 있고 대회에 많이 나가 봤어요.'),
            getLevelBox('pro', '프로 - 프로선수 경험이 있어요'),
          ],
        ),
      ),
    );
  }

  GestureDetector getLevelBox(String chosenLevel, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          level = chosenLevel;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: level == chosenLevel ? Color(0xFF004FFF) : Color(0xFFE8EEF2),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextLabel(text: text, type: 'body'),
            Icon(
              Icons.check_circle,
              color: level == chosenLevel ? Color(0xFF2BBB7D) : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
