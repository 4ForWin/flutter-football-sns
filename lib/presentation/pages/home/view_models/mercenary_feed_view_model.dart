import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/domain/entity/mercenary_feed.dart';
import 'package:mercenaryhub/domain/entity/mercenary_feed_log.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

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

class MercenaryFeedViewModel extends Notifier<MercenaryFeedState> {
  @override
  build() {
    print('✅MercenaryFeedViewModel build');
    // streamFetchFeeds();
    // fetchFeeds();
    initialize();
    return MercenaryFeedState(
      isLoading: true,
      isLast: false,
      feedList: [],
    );
  }

  String? _lastId;
  bool _isLast = false;
  List<MercenaryFeedLog>? _feedLog;
  String? _location;

  void setLocationAndRefresh(String? location) {
    _location = location;
    _isLast = false;
    _lastId = null;

    state = state.copyWith(
      feedList: [],
      isLast: false,
      isLoading: true,
    );
    fetchMercenaryFeeds();
  }

  void initialize({bool? isRefresh}) async {
    if (isRefresh ?? false) {
      _isLast = false;
      _lastId = null;
      state = state.copyWith(
        isLoading: true,
        isLast: false,
      );
    }
    await fetchMercenaryFeedLogs(FirebaseAuth.instance.currentUser!.uid);
    fetchMercenaryFeeds();
  }

  void fetchMercenaryFeeds() async {
    print('✅FeedViewModel fetchFeeds');
    // if (_isLast) return;

    final fetchMercenaryFeedsUsecase =
        ref.read(fetchMercenaryFeedsUsecaseProvider);
    final feedIds = _feedLog?.map((e) => e.feedId).toList() ?? [];
    final nextFeeds = await fetchMercenaryFeedsUsecase.execute(
      lastId: _lastId,
      ignoreIds: feedIds,
      location: _location,
    );

    _isLast = nextFeeds.isEmpty;

    if (_isLast) {
      state = state.copyWith(
        isLast: true,
        isLoading: false,
      );
      return;
    }

    _lastId = nextFeeds.last.id;
    state = state.copyWith(
      isLoading: false,
      isLast: false,
      feedList: [...state.feedList, ...nextFeeds],
    );
  }

  void streamFetchMercenaryFeeds() {
    print('✅MercenaryFeedViewModel streamFetchMercenaryFeeds');
    final streamFetchMercenaryFeedsUsecase =
        ref.read(streamFetchMercenaryFeedsUsecaseProvider);
    final streamFeedList = streamFetchMercenaryFeedsUsecase.execute();

    final streamSubscription = streamFeedList.listen((feeds) {
      state = state.copyWith(feedList: [...feeds]);
    });

    // 뷰모델이 메모리에서 소거될 때 onDispose의 callback이 호출 됨
    ref.onDispose(() {
      streamSubscription.cancel();
    });
  }

  Future<void> fetchMercenaryFeedLogs(String uid) async {
    final fetchMercenaryFeedLogsUsecase =
        ref.read(fetchMercenaryFeedLogsUsecaseProvider);
    _feedLog = await fetchMercenaryFeedLogsUsecase.execute(uid);
  }

  Future<void> insertMercenaryFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    final insertMercenaryFeedLogUsecase =
        ref.read(insertMercenaryFeedLogUsecaseProvider);

    _feedLog = [
      ..._feedLog ?? [],
      MercenaryFeedLog(
        uid: uid,
        feedId: feedId,
        isApplicant: isApplicant,
      ),
    ];

    await insertMercenaryFeedLogUsecase.execute(uid, feedId, isApplicant);

    // 신청(초대)으로 스와이프 했으면 'users/userId/mercenaryInvitationHistory'으로 데이터 보내기
    if (isApplicant) {
      print('🔥 용병 초대 프로세스 시작 - feedId: $feedId');

      final inviteToMercenaryUsecase =
          ref.read(inviteToMercenaryUsecaseProvider);
      final success = await inviteToMercenaryUsecase.execute(feedId);

      if (success) {
        print(' 용병 초대 완료 - feedId: $feedId');
      } else {
        print(' 용병 초대 실패 - feedId: $feedId');
      }
    }
  }

  void removeFeedOfState() {
    state.feedList.removeAt(0);
    state = state.copyWith(feedList: [...state.feedList]);
  }
}

final mercenaryFeedViewModelProvider =
    NotifierProvider<MercenaryFeedViewModel, MercenaryFeedState>(
  () {
    return MercenaryFeedViewModel();
  },
);
