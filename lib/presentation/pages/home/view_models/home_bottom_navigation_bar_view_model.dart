import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBottomNavigationBarViewModel extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void onIndexChanged(int newIndex) {
    state = newIndex;
  }
}

final homeBottomNavigationBarViewModelProvider =
    NotifierProvider<HomeBottomNavigationBarViewModel, int>(
  () {
    return HomeBottomNavigationBarViewModel();
  },
);
