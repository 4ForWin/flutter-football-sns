import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/feed_view_model.dart';
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
        print('컨슈머 ✅');
        // print(feedList.first.imageUrl);
        print('✅ 컨슈머 ✅');
        return PageView.builder(
          controller: pageViewController,
          itemCount: feedList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(0xff2B2B2B),
                  child: Image.network(
                    feedList[index].imageUrl,
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
                        Spacer(
                          flex: 20,
                        ),
                        Text(
                          feedList[index].teamName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(
                          flex: 4,
                        ),
                        Text(
                          feedList[index].content,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(
                          flex: 4,
                        ),
                        const StateIcons(),
                        Spacer(
                          flex: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              feedList[index].location,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 4,
                        ),
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
