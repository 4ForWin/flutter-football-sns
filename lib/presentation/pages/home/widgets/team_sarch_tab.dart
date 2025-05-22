import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/feed_view_model.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/post_text.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/state_icons.dart';

class TeamSarchTab extends StatelessWidget {
  List<int> feeds;

  TeamSarchTab({super.key, required this.feeds});

  @override
  Widget build(BuildContext context) {
    // final pageViewController = PageController(initialPage: feeds.length ~/ 2);
    final pageViewController = PageController(initialPage: 0);

    return Consumer(
      builder: (context, ref, child) {
        final feedList = ref.watch(feedViewModelProvider);

        return PageView.builder(
          controller: pageViewController,
          itemCount: feedList.length,
          itemBuilder: (context, index) {
            final feed = feedList[index];

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
                          feed.teamName,
                          fontSize: 24,
                        ),
                        Spacer(flex: 4),
                        PostText(
                          '${feed.person}명(${feed.level.split('-').first.trim()})',
                        ),
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
        );
      },
    );
  }
}
