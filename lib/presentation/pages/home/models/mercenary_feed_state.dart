import 'package:mercenaryhub/domain/entity/mercenary_feed.dart';

class MercenaryFeedState {
  bool isLoading;
  bool isLast;
  List<MercenaryFeed> feedList;

  MercenaryFeedState({
    required this.isLoading,
    required this.isLast,
    required this.feedList,
  });

  MercenaryFeedState copyWith({
    bool? isLoading,
    bool? isLast,
    List<MercenaryFeed>? feedList,
  }) {
    return MercenaryFeedState(
      isLoading: isLoading ?? this.isLoading,
      isLast: isLast ?? this.isLast,
      feedList: feedList ?? this.feedList,
    );
  }
}
