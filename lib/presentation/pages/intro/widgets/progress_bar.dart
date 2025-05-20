import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  double progressState;

  ProgressBar(this.progressState);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      height: 5, // 진행바 높이 설정
      color: Colors.grey[300], // 회색 배경
      child: LinearProgressIndicator(
        value: progressState, // 진행 상태 (0.0 ~ 1.0)
        backgroundColor: Colors.transparent, // 배경 투명
        valueColor:
            AlwaysStoppedAnimation<Color>(Color(0xFF2BBB7D)), // 진행 중 색상 (초록색)
      ),
    );
  }
}
