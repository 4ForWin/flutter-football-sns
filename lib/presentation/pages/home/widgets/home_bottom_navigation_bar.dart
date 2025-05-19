import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/home_bottom_navigation_bar_view_model.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex =
            ref.watch(homeBottomNavigationBarViewModelProvider);
        final homeBottomVm =
            ref.read(homeBottomNavigationBarViewModelProvider.notifier);

        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: homeBottomVm.onIndexChanged,
          backgroundColor: Color(0xff2B2B2B),
          iconSize: 28,
          selectedItemColor: Color(0xff9ED7C1),
          unselectedItemColor: Color(0xff888888),
          selectedLabelStyle: TextStyle(fontSize: 16),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '팀 찾기',
              tooltip: '팀 찾기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt),
              label: '용병 찾기',
              tooltip: '용병 찾기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이 페이지',
              tooltip: '마이 페이지',
            ),
          ],
        );
      },
    );
  }
}
