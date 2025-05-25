import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/team_invitation_history/team_invitation_history_item.dart';
import 'package:mercenaryhub/presentation/pages/team_invitation_history/team_invitation_history_view_model.dart';

class TeamInvitationHistoryPage extends ConsumerWidget {
  const TeamInvitationHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamInvitationHistoryViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
        title: const Text('나를 초대한 팀'),
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
                  .read(teamInvitationHistoryViewModelProvider.notifier)
                  .refreshTeamInvitations();
            },
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
          ),
        ],
      ),
      body: state.when(
        data: (invitations) {
          print('📱 UI: ${invitations.length}개의 팀 초대 내역 표시');

          if (invitations.isEmpty) {
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
                    '받은 초대가 없습니다',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(teamInvitationHistoryViewModelProvider.notifier)
                          .refreshTeamInvitations();
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
                  .read(teamInvitationHistoryViewModelProvider.notifier)
                  .refreshTeamInvitations();
            },
            color: const Color(0xFF2BBB7D),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: invitations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final invitation = invitations[index];
                return TeamInvitationHistoryItem(
                  invitation: invitation,
                  onAccept: () {
                    print('📱 UI: 초대 수락 요청 - ${invitation.feedId}');
                    _showResponseDialog(
                      context,
                      'accepted',
                      invitation.teamName,
                      () {
                        ref
                            .read(
                                teamInvitationHistoryViewModelProvider.notifier)
                            .acceptInvitation(invitation.feedId);
                      },
                    );
                  },
                  onReject: () {
                    print('📱 UI: 초대 거절 요청 - ${invitation.feedId}');
                    _showResponseDialog(
                      context,
                      'rejected',
                      invitation.teamName,
                      () {
                        ref
                            .read(
                                teamInvitationHistoryViewModelProvider.notifier)
                            .rejectInvitation(invitation.feedId);
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
                  '팀 초대 내역을 불러오는 중...',
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
                        .read(teamInvitationHistoryViewModelProvider.notifier)
                        .refreshTeamInvitations();
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

  /// 응답 확인 다이얼로그
  void _showResponseDialog(
    BuildContext context,
    String response,
    String teamName,
    VoidCallback onConfirm,
  ) {
    String title;
    String message;
    Color actionColor;

    switch (response) {
      case 'accepted':
        title = '초대 수락';
        message = '$teamName의 초대를 수락하시겠습니까?';
        actionColor = const Color(0xFF2BBB7D);
        break;
      case 'rejected':
        title = '초대 거절';
        message = '$teamName의 초대를 거절하시겠습니까?';
        actionColor = Colors.red;
        break;
      default:
        title = '응답 처리';
        message = '응답을 처리하시겠습니까?';
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
