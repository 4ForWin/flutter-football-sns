import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const Center(
                child: Text(
              '용병모아',
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  color: Color(0x00222222)),
            )),
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  print("버튼 클릭");
                }
              },
              child: SvgPicture.asset("assets/image/kakao_login.svg"),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '가입을 진행할 경우,이용약관과 개인정보 수집 및 이용에\n 대해 동의한 것으로 간주됩니다.',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w300,
                fontSize: 18,
                color:Color(0x00757B80),
              ),
            )
          ],
        ),
      ),
    );
  }
}
