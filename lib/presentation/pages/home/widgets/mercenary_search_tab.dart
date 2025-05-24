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
  ConsumerState<MercenarySearchTab> createState() => _MercenarySarchTabState();
}

class _MercenarySarchTabState extends ConsumerState<MercenarySearchTab> {
  final swipableStackController = SwipableStackController();
  @override
  Widget build(BuildContext context) {
    final feedList = ref.watch(mercenaryFeedViewModelProvider);
    final feedVm = ref.read(mercenaryFeedViewModelProvider.notifier);
    print('✌️');
    print('용병 찾기 피드');
    print('✌️');
    return Container(
      color: Color(0xff2B2B2B),
      child: SwipableStack(
          controller: swipableStackController,
          itemCount: feedList.length,
          detectableSwipeDirections: const {
            SwipeDirection.right,
            SwipeDirection.left,
          },
          // 스와이프가 완료되면, 즉 현재 이미지가 사라지면 발생하는 이벤트
          onSwipeCompleted: (index, direction) {
            print('카드 $index가 $direction으로 스와이프됨');
            print(feedList[index].name);

            // TODO: uid로 하기
            feedVm.insertMercenaryFeedLog(
              uid: FirebaseAuth.instance.currentUser!.uid,
              feedId: feedList[index].id,
              isApplicant: direction == SwipeDirection.right ? true : false,
            );
            // feedVm.addUserToList(feedList[index], direction);

            // 마지막 피드 이전에 fetch하기
            if (index == feedList.length - 2) {
              print('❤️❤️❤️무한 피드');
              feedVm.fetchMercenaryFeeds();
            }
          },
          // true일 때만 스와이프가 가능
          // onWillMoveNext: (index, direction) {
          //   // 마지막 피드일 때 스와이프 막기
          //   return index != feedList.length - 1;
          // },
          builder: (context, properties) {
            // 스와이프 하면 builder가 계속 실행됨
            // print('buider');
            final feed = feedList[properties.index];
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(0xff2B2B2B),
                  child: Image.network(
                    feed.imageUrl,
                    fit: BoxFit.cover,
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
                        Spacer(flex: 20),
                        PostText(
                          feed.name,
                          fontSize: 24,
                        ),
                        Spacer(flex: 4),
                        PostText(
                          '${NumberFormat('#,###').format(int.parse(feed.cost))}원',
                        ),
                        PostText(DateFormat('yyyy-MM-dd').format(feed.date)),
                        PostText(
                          '${DateFormat('HH:mm').format(feed.time.start!)} ~ ${DateFormat('HH:mm').format(feed.time.end!)}',
                        ),
                        PostText(feed.content),
                        Spacer(flex: 4),
                        const StateIcons(),
                        Spacer(flex: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            PostText(feed.location),
                          ],
                        ),
                        Spacer(flex: 4),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
          overlayBuilder: (context, properties) {
            // 스와이프 하면 overlayBuilder가 계속 실행됨
            // print('overlayBuilder');
            final opacity = properties.swipeProgress.clamp(0.0, 1.0);
            if (properties.direction == SwipeDirection.right) {
              // 오른쪽 스와이프 중에는 좋아요 아이콘 표시
              return Opacity(
                opacity: opacity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.thumb_up, color: Colors.green, size: 48),
                ),
              );
            } else if (properties.direction == SwipeDirection.left) {
              // 왼쪽 스와이프 중에는 싫어요 아이콘 표시
              return Opacity(
                opacity: opacity,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.thumb_down, color: Colors.red, size: 48),
                ),
              );
            }
            // 위/아래 스와이프거나, 방향이 없을 때는 아무것도 표시하지 않음
            return SizedBox.shrink();
          }),
    );
  }
}


// @override
  // Widget build(BuildContext context) {
  //   // final pageViewController = PageController(initialPage: feeds.length ~/ 2);
  //   final pageViewController = PageController(initialPage: 0);

  //   return Consumer(
  //     builder: (context, ref, child) {
  //       final feedList = ref.watch(feedViewModelProvider);

  //       return PageView.builder(
  //         controller: pageViewController,
  //         itemCount: feedList.length,
  //         itemBuilder: (context, index) {
  //           final feed = feedList[index];

  //           return Stack(
  //             children: [
  //               Container(
  //                 width: double.infinity,
  //                 height: double.infinity,
  //                 color: Color(0xff2B2B2B),
  //                 child: Image.network(
  //                   feed.imageUrl,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               Container(
  //                 width: double.infinity,
  //                 height: double.infinity,
  //                 color: Colors.black.withValues(alpha: 0.5),
  //               ),
  //               SizedBox.expand(
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 50),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Spacer(flex: 20),
  //                       PostText(
  //                         feed.teamName,
  //                         fontSize: 24,
  //                       ),
  //                       Spacer(flex: 4),
  //                       PostText(
  //                         '${feed.person}명(${feed.level.split('-').first.trim()})',
  //                       ),
  //                       PostText(
  //                         '${NumberFormat('#,###').format(int.parse(feed.cost))}원',
  //                       ),
  //                       PostText(DateFormat('yyyy-MM-dd').format(feed.date)),
  //                       PostText(
  //                         '${DateFormat('HH:mm').format(feed.time.start!)} ~ ${DateFormat('HH:mm').format(feed.time.end!)}',
  //                       ),
  //                       PostText(feed.content),
  //                       Spacer(flex: 4),
  //                       const StateIcons(),
  //                       Spacer(flex: 4),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(
  //                             Icons.location_on_outlined,
  //                             color: Colors.white,
  //                           ),
  //                           PostText(feed.location),
  //                         ],
  //                       ),
  //                       Spacer(flex: 4),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }