import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // 경로 확인

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: const Center(
              child: Text(
                '용병모아',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w800,
                  fontSize: 36,
                  color: Color(0xFF222222), // ✅ 불투명한 진회색
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print("버튼 클릭");
                    }
                  },
                  child: SvgPicture.asset("assets/images/kakao_login.svg"),
                ),
                const SizedBox(height: 25),
                const Text(
                  '가입을 진행할 경우, 이용약관과 개인정보 수집 및 이용에\n 대해 동의한 것으로 간주됩니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Color(0xFF757B80), // ✅ 불투명한 회색
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
