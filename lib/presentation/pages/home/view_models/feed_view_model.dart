import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/usecase/stream_fetch_feeds_usecase.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class FeedViewModel extends Notifier<List<Feed>> {
  @override
  build() {
    print('✅FeedViewModel build');
    streamFetchFeeds();
    return [];
  }

  void fetchFeeds() async {
    print('✅FeedViewModel fetchFeeds');
    final fetchFeedsUsecase = ref.read(fetchFeedsUsecaseProvider);
    state = await fetchFeedsUsecase.execute();
  }

  void streamFetchFeeds() {
    print('✅FeedViewModel streamFetchFeeds');
    final streamFetchFeedsUsecase = ref.read(streamFetchFeedsUsecaseProvider);
    final streamFeedList = streamFetchFeedsUsecase.execute();

    final streamSubscription = streamFeedList.listen((feeds) {
      state = feeds;
    });

    // 뷰모델이 메모리에서 소거될 때 onDispose의 callback이 호출 됨
    ref.onDispose(() {
      // ✅✅ 호출되면 streamSubscription을 cancel 꼭 해줘야함.
      // ✅✅ 그래야 구독이 종료된다.
      streamSubscription.cancel();
    });
  }
}

final feedViewModelProvider = NotifierProvider<FeedViewModel, List<Feed>>(
  () {
    return FeedViewModel();
  },
);
