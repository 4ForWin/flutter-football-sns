import 'package:flutter/material.dart';
import 'package:mercenaryhub/presentation/pages/intro/widgets/text_label.dart';

class IntroTypePage extends StatefulWidget {
  String level;
  IntroTypePage(this.level, {super.key});
  @override
  State<IntroTypePage> createState() => _IntroTypePageState();
}

class _IntroTypePageState extends State<IntroTypePage> {
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
            TextLabel(text: '원하는 모집 분야를 선택해 주세요.', type: 'question'),
            SizedBox(height: 16),
            Spacer(),
            getSubmitButton(),
          ],
        ),
      ),
    );
  }

  GestureDetector getLevelBox(String chosenType, String text) {
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
            TextLabel(text: text, type: 'body'),
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
        onPressed: () {},
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
