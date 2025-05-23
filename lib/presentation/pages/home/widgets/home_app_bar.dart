import 'package:flutter/material.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_page.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff2B2B2B),
      title: GestureDetector(
        onTap: () {
          print('위치 버튼');
        },
        child: Row(
          children: [
            Icon(
              Icons.gps_fixed,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '서울특별시 금천구',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            print('게시글 버튼');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WritePage(
                          // HomePage class의 build 메서드의 context
                          homeContext: context,
                        )));
          },
          icon: Icon(
            Icons.create_outlined,
            size: 28,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            print('알림 버튼');
          },
          icon: Icon(
            Icons.notifications_none,
            size: 28,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
