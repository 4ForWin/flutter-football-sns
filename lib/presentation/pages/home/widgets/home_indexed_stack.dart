import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/home_bottom_navigation_bar_view_model.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/mercenary_search_tab.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/team_sarch_tab.dart';

class HomeIndexedStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex =
            ref.watch(homeBottomNavigationBarViewModelProvider);

        return SizedBox.expand(
            child: IndexedStack(
          index: currentIndex,
          children: [
            TeamSarchTab(
              feeds: List.generate(
                10,
                (index) => index,
              ),
            ),
            MercenarySearchTab(
              feeds: List.generate(
                10,
                (index) => index,
              ),
            ),
            Text('mypage'),
          ],
        ));
      },
    );
  }
}
