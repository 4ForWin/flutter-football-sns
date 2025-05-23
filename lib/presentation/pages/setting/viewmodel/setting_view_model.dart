import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final settingViewModelProvider = Provider((ref) => SettingViewModel());

class SettingViewModel {
  void navigateToAlarmSetting(BuildContext context) {
    Navigator.pushNamed(context, '/alarm_setting');
  }

  void navigateToApplyHistory(BuildContext context) {
    Navigator.pushNamed(context, '/apply_history');
  }

  Future<void> showPolicyLinks(BuildContext context) async {
    final policies = [
      {
        'title': '회원 이용약관',
        'url': 'https://www.notion.so/1fb94968b97380a9ac4fd33cdc6105c1?pvs=4'
      },
      {
        'title': '개인정보 수집/이용',
        'url': 'https://www.notion.so/1fb94968b973803d9664f58c5fa3d704?pvs=4'
      },
      {
        'title': '위치기반 서비스 이용약관',
        'url': 'https://www.notion.so/1fb94968b9738030a653ce33e9993baf?pvs=4'
      },
    ];

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('이용약관 및 개인정보 처리방침'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: policies.map((policy) {
            return ListTile(
              title: Text(
                policy['title']!,
                style: const TextStyle(
                  color: Color(0xFF2BBB7D),
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () async {
                final uri = Uri.parse(policy['url']!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('링크를 열 수 없습니다.'),
                      ),
                    );
                  }
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void showAppVersion(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('버전정보'),
        content: Text('현재 버전: ver.'),
      ),
    );
  }

  Future<void> logout() async {
    // TODO 실제 로그아웃 처리 로직 작성
    await Future.delayed(const Duration(milliseconds: 500)); //대기
  }

  void onLogoutPressed(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('확인'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await logout();
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (route) => false); //로그아웃시 이동
    }
  }
}
