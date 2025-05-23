import 'package:flutter/material.dart';

class FeedTypeDialog extends StatefulWidget {
  @override
  State<FeedTypeDialog> createState() => _FeedTypeDialogState();
}

class _FeedTypeDialogState extends State<FeedTypeDialog> {
  String? selected;

  final typTextList = [
    '용병 - 개인적으로 참여하는 경우',
    '팀 - 팀을 대표하여 모집하는 경우',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("게시글 유형을 선택하세요",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...typTextList.map(typeItem),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2BBB7D),
                foregroundColor: Colors.white,
              ),
              onPressed: selected == null
                  ? null
                  : () => Navigator.pop(context, selected),
              child: Text("계속하기"),
            ),
          ],
        ),
      ),
    );
  }

  Widget typeItem(String typeText) {
    final isSelected = selected == typeText;
    return GestureDetector(
      onTap: () {
        setState(() => selected = typeText);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE5F5FF) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(typeText, style: const TextStyle(fontSize: 15)),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xff2BBB7D),
              ),
          ],
        ),
      ),
    );
  }
}
