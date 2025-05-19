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
      appBar: AppBar(title: const Text('알림 설정')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('시그널 알림'),
            value: state.isSignalOn,
            onChanged: notifier.toggleSignal,
          ),
          SwitchListTile(
            title: const Text('백테스팅 알림'),
            value: state.isBacktestOn,
            onChanged: notifier.toggleBacktest,
          ),
          SwitchListTile(
            title: const Text('토글 추천 알림림'),
            value: state.isRecommendationOn,
            onChanged: notifier.toggleRecommendation,
          ),
        ],
      ),
    );
  }
}
