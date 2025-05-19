import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedViewModel extends Notifier<List<int>?> {
  @override
  List<int>? build() {
    return null;
  }

  void fetchFeeds(List<int> beforState) {
    print('헐!!! $beforState');
    print([...List.generate(10, (index) => 0 - index), ...beforState]);
    state = [...List.generate(10, (index) => 0 - index), ...beforState];
  }
}

final feedViewModelProvider = NotifierProvider<FeedViewModel, List<int>?>(
  () {
    return FeedViewModel();
  },
);
