import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmSettingState {
  final bool isSignalOn;
  final bool isBacktestOn;
  final bool isRecommendationOn;

  const AlarmSettingState({
    this.isSignalOn = false,
    this.isBacktestOn = false,
    this.isRecommendationOn = false,
  });

  AlarmSettingState copyWith({
    bool? isSignalOn,
    bool? isBacktestOn,
    bool? isRecommendationOn,
  }) {
    return AlarmSettingState(
      isSignalOn: isSignalOn ?? this.isSignalOn,
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
