import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/home_bottom_navigation_bar_view_model.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/mercenary_search_tab.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/team_sarch_tab.dart';
import 'package:mercenaryhub/presentation/pages/setting/setting_page.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_page.dart';

class HomeIndexedStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (consumerContext, ref, child) {
      final currentIndex = ref.watch(homeBottomNavigationBarViewModelProvider);

      return Container(
        color: Color(0xff2B2B2B),
        child: IndexedStack(
          index: currentIndex,
          children: [
            Scaffold(
              appBar: HomeAppBar(),
              body: TeamSarchTab(
                feeds: List.generate(
                  10,
                  (index) => index,
                ),
              ),
            ),
            Scaffold(
              appBar: HomeAppBar(),
              body: MercenarySearchTab(
                feeds: List.generate(
                  10,
                  (index) => index,
                ),
              ),
            ),
            SettingPage(),
          ],
        ),
      );
    });
  }
}
