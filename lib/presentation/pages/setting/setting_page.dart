import 'package:flutter/material.dart';
import 'widget/profile_section.dart';
import 'widget/setting_tile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          const ProfileSection(),
          const Divider(height: 1),
          SettingTile(
            title: '신청 내역',
            onTap: () {
              // TODO: navigateToApplyHistory()
            },
          ),
          SettingTile(
            title: '알림 설정',
            onTap: () {
              // TODO: navigateToAlarmSetting()
            },
          ),
          SettingTile(
            title: '이용약관 및 개인정보 처리방침',
            onTap: () {
              // TODO: navigateToPolicy()
            },
          ),
          SettingTile(
            title: '버전정보',
            onTap: () {
              // TODO: showAppVersion()
            },
          ),
          SettingTile(
            title: '로그아웃',
            onTap: () {
              // TODO: onLogoutPressed()
            },
          ),
        ],
      ),
    );
  }
}
