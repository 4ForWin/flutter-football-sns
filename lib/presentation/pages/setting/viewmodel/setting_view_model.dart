import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingViewModelProvider = Provider((ref) => SettingViewModel());

class SettingViewModel {
  void navigateToAlarmSetting(BuildContext context) {
    Navigator.pushNamed(context, '/alarm_setting');
  }

  void navigateToApplyHistory(BuildContext context) {
    Navigator.pushNamed(context, '/apply_history');
  }

  void navigateToPolicy(BuildContext context) {
    Navigator.pushNamed(context, '/policy');
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
