import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/state_icons.dart';

class MercenarySearchTab extends StatelessWidget {
  List<int> feeds;

  MercenarySearchTab({super.key, required this.feeds});

  @override
  Widget build(BuildContext context) {
    final pageViewController = PageController(initialPage: feeds.length ~/ 2);

    return Consumer(
      builder: (context, ref, child) {
        return PageView.builder(
          controller: pageViewController,
          itemCount: feeds.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(0xff2B2B2B),
                  child: Image.network(
                    'https://picsum.photos/200/300',
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
                          '용병 이름',
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
                          '5월 20일 풋살 인원 1명 급하게 모집합니다.' * 10,
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
                              '서울특별시 강남구',
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
