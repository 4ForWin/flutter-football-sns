import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mercenaryhub/presentation/pages/terms/widget/terms_button_widget.dart';

class TermsOfServiceAgreement extends StatefulWidget {
  const TermsOfServiceAgreement({super.key});

  @override
  State<TermsOfServiceAgreement> createState() => _TermsOfServiceAgreementState();
}

class _TermsOfServiceAgreementState extends State<TermsOfServiceAgreement> {
  List<bool> _isChecked = List.generate(5, (_) => false);

  // 필수 약관 체크 여부
  bool get _buttonActive => _isChecked[1] && _isChecked[2] && _isChecked[3];

  // 약관 URL 리스트
  final List<String> _urls = [
    '', // '모두 동의'는 URL 없음
    'https://www.notion.so/1fb94968b97380a9ac4fd33cdc6105c1?pvs=4',
    'https://www.notion.so/1fb94968b973803d9664f58c5fa3d704?pvs=4',
    'https://www.notion.so/1fb94968b9738030a653ce33e9993baf?pvs=4',
    '', // 선택 약관은 URL 없음
  ];

  void _updateCheckState(int index) {
    setState(() {
      if (index == 0) {
        bool isAllChecked = !_isChecked.every((e) => e);
        _isChecked = List.generate(5, (_) => isAllChecked);
      } else {
        _isChecked[index] = !_isChecked[index];
        _isChecked[0] = _isChecked.getRange(1, 5).every((e) => e);
      }
    });
  }

  void _onSubmit() {
    print("약관에 모두 동의했습니다!");
    // 다음 화면으로 이동 가능
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '고객님의\n동의가 필요해요',
              style: TextStyle(
                color: Color(0xff464A4D),
                fontSize: 36.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 50),
            ..._renderCheckList(),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: TermsButton(
                    enabled: _buttonActive,
                    onPressed: _buttonActive ? _onSubmit : () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _renderCheckList() {
    List<String> labels = [
      '약관 모두 동의하기',
      '회원 이용약관(필수)',
      '개인정보 수집/이용(필수)',
      '위치기반 서비스 이용약관(필수)',
      '이벤트 및 할인 혜택 안내 동의(선택)',
    ];

    List<Widget> list = [
      renderContainer(
        _isChecked[0],
        labels[0],
        () => _updateCheckState(0),
        isHeader: true,
      ),
      const SizedBox(height: 8),
    ];

    list.addAll(List.generate(
      4,
      (index) => renderContainer(
        _isChecked[index + 1],
        labels[index + 1],
        () => _updateCheckState(index + 1),
        index: index + 1,
      ),
    ));

    return list;
  }

  Widget renderContainer(
    bool checked,
    String text,
    VoidCallback onTap, {
    bool isHeader = false,
    int? index,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isHeader ? const Color(0xFFEEEEEE) : Colors.transparent,
            width: isHeader ? 1.5 : 0.0,
          ),
          borderRadius: isHeader ? BorderRadius.circular(12.0) : BorderRadius.zero,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: checked ? const Color(0xff2BBB7D) : Colors.grey,
                  width: 2.0,
                ),
                color: checked ? const Color(0xff2BBB7D) : Colors.white,
              ),
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.check,
                color: checked ? Colors.white : Colors.grey,
                size: 18,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
            if (!isHeader && index != null)
              GestureDetector(
                onTap: () {
                  final url = _urls[index];
                  if (url.isNotEmpty) {
                    _launchURL(url);
                  }
                },
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
