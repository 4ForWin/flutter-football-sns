import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroLevelState {
  String? futsalLevel;
  IntroLevelState(this.futsalLevel);
}

class IntroLevelViewModel extends Notifier<IntroLevelState> {
  @override
  IntroLevelState build() {
    return IntroLevelState(null);
  }

  setLevel(String level) {
    state = IntroLevelState(level);
  }
}

final introLevelViewModelProvider =
    NotifierProvider<IntroLevelViewModel, IntroLevelState>(() {
  return IntroLevelViewModel();
});
