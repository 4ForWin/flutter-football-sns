import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/mercenary_feed_view_model.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/post_text.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/state_icons.dart';
import 'package:swipable_stack/swipable_stack.dart';

class MercenarySearchTab extends ConsumerStatefulWidget {
  const MercenarySearchTab({super.key});

  @override
  ConsumerState<MercenarySearchTab> createState() => _MercenarySearchTabState();
}

class _MercenarySearchTabState extends ConsumerState<MercenarySearchTab> {
  @override
  Widget build(BuildContext context) {
    final swipableStackController = SwipableStackController();
    final feedState = ref.watch(mercenaryFeedViewModelProvider);
    final feedVm = ref.read(mercenaryFeedViewModelProvider.notifier);

    print('✌️ 용병 찾기 피드 화면 빌드');
    print(
        '✌️ 피드 상태: 로딩=${feedState.isLoading}, 마지막=${feedState.isLast}, 피드수=${feedState.feedList.length}');

    if (feedState.isLoading) {
      return Container(
        color: const Color(0xff2B2B2B),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          color: const Color(0xff2B2B2B),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (feedState.isLast)
                  const Text(
                    '피드가 더 이상 없습니다',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    print('🔄 새로고침 버튼 클릭');
                    feedVm.initialize(isRefresh: true);
                  },
                  child: const Text(
                    '새로고침',
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            print('😳 더블탭 - 다음 피드로');
            swipableStackController.next(
              swipeDirection: SwipeDirection.up,
            );
          },
          child: SwipableStack(
            controller: swipableStackController,
            itemCount: feedState.feedList.length,
            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            // 스와이프가 완료되면, 즉 현재 이미지가 사라지면 발생하는 이벤트
            onSwipeCompleted: (index, direction) async {
              final currentFeed = feedState.feedList[index];
              final currentUser = FirebaseAuth.instance.currentUser;

              print('🎯 카드 $index가 $direction으로 스와이프됨');
              print('🎯 용병명: ${currentFeed.name}');
              print('🎯 피드ID: ${currentFeed.id}');
              print('🎯 현재 사용자: ${currentUser?.uid}');

              if (direction == SwipeDirection.right ||
                  direction == SwipeDirection.left) {
                final isApplicant = direction == SwipeDirection.right;

                print(
                    '🎯 초대 여부: $isApplicant (오른쪽=${direction == SwipeDirection.right})');

                try {
                  // 1. 용병 피드 로그 저장
                  await feedVm.insertMercenaryFeedLog(
                    uid: currentUser!.uid,
                    feedId: currentFeed.id,
                    isApplicant: isApplicant,
                  );

                  if (isApplicant) {
                    print('✅ 용병 초대 프로세스 완료');

                    // 성공 알림 표시 (선택사항)
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${currentFeed.name}님을 초대했습니다!'),
                          backgroundColor: const Color(0xFF2BBB7D),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    print('⏭️ 피드 건너뛰기 완료');
                  }
                } catch (e) {
                  print('❌ 스와이프 처리 중 에러: $e');

                  // 에러 알림 표시
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('처리 중 오류가 발생했습니다.'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              }

              // UI에서 피드 제거
              feedVm.removeFeedOfState();

              // 마지막 피드 이전에 다음 피드들 가져오기
              if (index == feedState.feedList.length - 2) {
                print('❤️ 무한 피드 로딩 트리거');
                feedVm.fetchMercenaryFeeds();
              }
            },
            builder: (context, properties) {
              if (properties.index >= feedState.feedList.length) {
                print(
                    '⚠️ 인덱스 범위 초과: ${properties.index} >= ${feedState.feedList.length}');
                return const SizedBox.shrink();
              }

              final feed = feedState.feedList[properties.index];

              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xff2B2B2B),
                    child: Image.network(
                      feed.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('❌ 이미지 로드 실패: ${feed.imageUrl}');
                        return Container(
                          color: Colors.grey[800],
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                              size: 64,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[800],
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 20),
                          PostText(
                            feed.name,
                            fontSize: 24,
                          ),
                          const Spacer(flex: 4),
                          PostText(
                            '${feed.level.split('-').first.trim()}',
                          ),
                          PostText(
                            '${NumberFormat('#,###').format(int.parse(feed.cost))}원',
                          ),
                          PostText(DateFormat('yyyy-MM-dd').format(feed.date)),
                          PostText(
                            '${DateFormat('HH:mm').format(feed.time.start!)} ~ ${DateFormat('HH:mm').format(feed.time.end!)}',
                          ),
                          PostText(feed.content),
                          const Spacer(flex: 4),
                          const StateIcons(),
                          const Spacer(flex: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              PostText(feed.location),
                            ],
                          ),
                          const Spacer(flex: 4),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            overlayBuilder: (context, properties) {
              final opacity = properties.swipeProgress.clamp(0.0, 1.0);

              if (properties.direction == SwipeDirection.right) {
                // 오른쪽 스와이프 중에는 초대 아이콘 표시
                return Opacity(
                  opacity: opacity,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thumb_up, color: Colors.green, size: 48),
                          SizedBox(height: 8),
                          Text(
                            '초대하기',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (properties.direction == SwipeDirection.left) {
                // 왼쪽 스와이프 중에는 건너뛰기 아이콘 표시
                return Opacity(
                  opacity: opacity,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thumb_down, color: Colors.red, size: 48),
                          SizedBox(height: 8),
                          Text(
                            '건너뛰기',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        )
      ],
    );
  }
}
