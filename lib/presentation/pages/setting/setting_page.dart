import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget/profile_section.dart';
import 'widget/setting_tile.dart';
import 'viewmodel/setting_view_model.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(settingViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          const ProfileSection(),
          const Divider(height: 1),
          SettingTile(
            title: '신청 내역',
            onTap: () => viewModel.navigateToApplyHistory(context),
          ),
          SettingTile(
            title: '알림 설정',
            onTap: () => viewModel.navigateToAlarmSetting(context),
          ),
          SettingTile(
            title: '이용약관 및 개인정보 처리방침',
            onTap: () => viewModel.navigateToPolicy(context),
          ),
          SettingTile(
            title: '버전정보',
            onTap: () => viewModel.showAppVersion(context),
          ),
          SettingTile(
            title: '로그아웃',
            onTap: () => viewModel.onLogoutPressed(context),
          ),
        ],
      ),
    );
  }
}
