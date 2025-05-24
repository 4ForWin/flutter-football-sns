import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/core/loading_bar.dart';
import 'package:mercenaryhub/presentation/pages/home/view_models/team_feed_view_model.dart';
import 'package:mercenaryhub/presentation/pages/home/widgets/feed_type_dialog.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_page.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  String? locationText;

  LoadingOverlay loadingOverlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (consumerContext, ref, child) {
        final writeVm = ref.read(writeViewModelProvider.notifier);
        final feedVm = ref.read(feedViewModelProvider.notifier);
        return AppBar(
          backgroundColor: Color(0xff2B2B2B),
          title: GestureDetector(
            onTap: () async {
              print('위치 버튼');
              loadingOverlay.show(context);
              String? location = await writeVm.getLocation();
              feedVm.setLocationAndRefresh(location);
              print('👀');
              print(location);
              print('👀');
              setState(() {
                print('setState???');
                locationText = location;
              });
              loadingOverlay.hide();
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
                  locationText ?? '내 위치만 피드 보기',
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
              onPressed: () async {
                print('게시글 버튼');
                String? typeText = await _showFeedTypeDialog();

                if (typeText == null) return;
                typeText = typeText.split('-').first.trim();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // HomePage class의 build 메서드의 context
                  return WritePage(
                    homeContext: context,
                    typeText: typeText!,
                  );
                }));
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
      },
    );
  }

  Future<String?> _showFeedTypeDialog() async {
    return await showDialog<String>(
      context: context,
      builder: (context) => FeedTypeDialog(),
    );
  }
}
