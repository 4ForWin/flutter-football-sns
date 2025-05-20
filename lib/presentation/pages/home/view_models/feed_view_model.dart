import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class FeedViewModel extends Notifier<List<Feed>> {
  @override
  build() {
    print('이거?');
    fetchFeeds();
    return [];
  }

  void fetchFeeds() async {
    print('이거?2222222');
    final fetchFeedsUsecase = ref.read(fetchFeedsUsecaseProvider);
    print('이거?✅');
    state = await fetchFeedsUsecase.execute();
  }
}

final feedViewModelProvider = NotifierProvider<FeedViewModel, List<Feed>>(
  () {
    return FeedViewModel();
  },
);
