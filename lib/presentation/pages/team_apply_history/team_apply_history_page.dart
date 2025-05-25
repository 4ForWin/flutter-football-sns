import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/team_apply_history/team_apply_history_item.dart';
import 'package:mercenaryhub/presentation/pages/team_apply_history/team_apply_history_view_model.dart';

class TeamApplyHistoryPage extends ConsumerWidget {
  const TeamApplyHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamApplyHistoryViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
        title: const Text('내가 신청한 팀'),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        actions: [
          // 새로고침 버튼 추가
          IconButton(
            onPressed: () {
              ref
                  .read(teamApplyHistoryViewModelProvider.notifier)
                  .refreshApplicationHistories();
            },
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
          ),
        ],
      ),
      body: state.when(
        data: (histories) {
          print('📱 UI: ${histories.length}개의 신청 내역 표시');

          if (histories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '신청내역이 없습니다',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(teamApplyHistoryViewModelProvider.notifier)
                          .refreshApplicationHistories();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BBB7D),
                    ),
                    child: const Text(
                      '새로고침',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(teamApplyHistoryViewModelProvider.notifier)
                  .refreshApplicationHistories();
            },
            color: const Color(0xFF2BBB7D),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: histories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final history = histories[index];
                return TeamApplyHistoryItem(
                  history: history,
                  onStatusUpdate: (status) {
                    print('📱 UI: 상태 업데이트 요청 - ${history.feedId} -> $status');

                    // 확인 다이얼로그 표시
                    _showStatusUpdateDialog(
                      context,
                      status,
                      history.teamName,
                      () {
                        ref
                            .read(teamApplyHistoryViewModelProvider.notifier)
                            .updateStatus(history.feedId, status);
                      },
                    );
                  },
                );
              },
            ),
          );
        },
        loading: () {
          print('📱 UI: 로딩 중...');
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF2BBB7D),
                ),
                SizedBox(height: 16),
                Text(
                  '신청 내역을 불러오는 중...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF222222),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stack) {
          print('📱 UI: 에러 발생 - $error');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  '오류가 발생했습니다',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(teamApplyHistoryViewModelProvider.notifier)
                        .refreshApplicationHistories();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2BBB7D),
                  ),
                  child: const Text(
                    '다시 시도',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 상태 업데이트 확인 다이얼로그
  void _showStatusUpdateDialog(
    BuildContext context,
    String status,
    String teamName,
    VoidCallback onConfirm,
  ) {
    String title;
    String message;
    Color actionColor;

    switch (status) {
      case 'cancelled':
        title = '신청 취소';
        message = '$teamName에 대한 신청을 취소하시겠습니까?';
        actionColor = Colors.red;
        break;
      case 'accepted':
        title = '신청 수락';
        message = '$teamName에서 신청을 수락했습니다.';
        actionColor = const Color(0xFF2BBB7D);
        break;
      case 'rejected':
        title = '신청 거절';
        message = '$teamName에서 신청을 거절했습니다.';
        actionColor = Colors.red;
        break;
      default:
        title = '상태 변경';
        message = '상태를 변경하시겠습니까?';
        actionColor = const Color(0xFF2BBB7D);
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF222222),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Color(0xFF222222),
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '취소',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              '확인',
              style: TextStyle(color: actionColor),
            ),
          ),
        ],
      ),
    );
  }
}
