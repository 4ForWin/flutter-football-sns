import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBottomNavigationBarViewModel extends AutoDisposeNotifier<int> {
  @override
  build() {
    return 0;
  }

  void onIndexChanged(int newIndex) {
    state = newIndex;
  }
}

final homeBottomNavigationBarViewModelProvider =
    NotifierProvider.autoDispose<HomeBottomNavigationBarViewModel, int>(
  () {
    return HomeBottomNavigationBarViewModel();
  },
);
