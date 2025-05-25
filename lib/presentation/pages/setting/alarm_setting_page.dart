import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/setting/viewmodel/alarm_setting_view_model.dart';

class AlarmSettingPage extends ConsumerWidget {
  const AlarmSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alarmSettingProvider);
    final notifier = ref.read(alarmSettingProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
        title: const Text('알림 설정'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            tileColor: const Color(0xFFFFFFFF),
            title: const Text(
              '전체 알림',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 16,
              ),
            ),
            value: state.isSignalOn,
            onChanged: notifier.toggleSignal,
            activeColor: const Color(0xFF2BBB7D),
          ),
          SwitchListTile(
            tileColor: const Color(0xFFFFFFFF),
            title: const Text(
              '푸시 알림',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 16,
              ),
            ),
            value: state.isSignalOn,
            onChanged: notifier.toggleSignal,
            activeColor: const Color(0xFF2BBB7D),
          ),
          SwitchListTile(
            tileColor: const Color(0xFFFFFFFF),
            title: const Text(
              '용병신청 알림',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 16,
              ),
            ),
            value: state.isBacktestOn,
            onChanged: notifier.toggleBacktest,
            activeColor: const Color(0xFF2BBB7D),
          ),
          SwitchListTile(
            tileColor: const Color(0xFFFFFFFF),
            title: const Text(
              '신청승인 알림',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 16,
              ),
            ),
            value: state.isRecommendationOn,
            onChanged: notifier.toggleRecommendation,
            activeColor: const Color(0xFF2BBB7D),
          ),
        ],
      ),
    );
  }
}
