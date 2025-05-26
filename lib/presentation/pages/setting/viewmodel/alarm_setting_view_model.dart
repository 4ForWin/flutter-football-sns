import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmSettingState {
  final bool isSignalOn;
  final bool isPushOn;
  final bool isBacktestOn;
  final bool isRecommendationOn;

  const AlarmSettingState({
    this.isSignalOn = false,
    this.isPushOn = false,
    this.isBacktestOn = false,
    this.isRecommendationOn = false,
  });

  AlarmSettingState copyWith({
    bool? isSignalOn,
    bool? isPushOn,
    bool? isBacktestOn,
    bool? isRecommendationOn,
  }) {
    return AlarmSettingState(
      isSignalOn: isSignalOn ?? this.isSignalOn,
      isPushOn: isPushOn ?? this.isPushOn,
      isBacktestOn: isBacktestOn ?? this.isBacktestOn,
      isRecommendationOn: isRecommendationOn ?? this.isRecommendationOn,
    );
  }
}

class AlarmSettingViewModel extends StateNotifier<AlarmSettingState> {
  AlarmSettingViewModel() : super(const AlarmSettingState());

  void toggleSignal(bool value) {
    state = state.copyWith(isSignalOn: value);
  }

  void togglePush(bool value) {
    state = state.copyWith(isPushOn: value);
  }

  void toggleBacktest(bool value) {
    state = state.copyWith(isBacktestOn: value);
  }

  void toggleRecommendation(bool value) {
    state = state.copyWith(isRecommendationOn: value);
  }
}

final alarmSettingProvider =
    StateNotifierProvider<AlarmSettingViewModel, AlarmSettingState>(
  (ref) => AlarmSettingViewModel(),
);
