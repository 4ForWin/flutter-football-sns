import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mercenaryhub/providers/kakao_login_providers.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(kakaoLoginViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: const Text(
                  '용병모아',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Column(
                children: [
                  InkWell(
                    onTap:  () => ref.read(kakaoLoginViewModelProvider).login(context),


                    //child: SvgPicture.asset("assets/images/kakao_login.svg"),
                    child: SvgPicture.asset("assets/images/kakao_login.svg"),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '가입을 진행할 경우, 이용약관과 개인정보 수집 및 이용에\n 대해 동의한 것으로 간주됩니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757B80),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
