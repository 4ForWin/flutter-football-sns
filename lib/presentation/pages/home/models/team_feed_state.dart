import 'package:mercenaryhub/domain/entity/team_feed.dart';

class TeamFeedState {
  bool isLoading;
  bool isLast;
  List<TeamFeed> feedList;

  TeamFeedState({
    required this.isLoading,
    required this.isLast,
    required this.feedList,
  });

  TeamFeedState copyWith({
    bool? isLoading,
    bool? isLast,
    List<TeamFeed>? feedList,
  }) {
    return TeamFeedState(
      isLoading: isLoading ?? this.isLoading,
      isLast: isLast ?? this.isLast,
      feedList: feedList ?? this.feedList,
    );
  }
}
