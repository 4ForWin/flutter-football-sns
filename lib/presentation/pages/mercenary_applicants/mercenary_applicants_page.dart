import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/mercenary_applicants/mercenary_applicant_item.dart';
import 'package:mercenaryhub/presentation/pages/mercenary_applicants/mercenary_applicants_view_model.dart';

class MercenaryApplicantsPage extends ConsumerWidget {
  const MercenaryApplicantsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mercenaryApplicantsViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
        title: const Text('팀에 지원한 용병'),
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
                  .read(mercenaryApplicantsViewModelProvider.notifier)
                  .refreshMercenaryApplicants();
            },
            icon: const Icon(Icons.refresh),
            tooltip: '새로고침',
          ),
        ],
      ),
      body: state.when(
        data: (applicants) {
          if (applicants.isEmpty) {
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
                    '지원한 용병이 없습니다',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(mercenaryApplicantsViewModelProvider.notifier)
                          .refreshMercenaryApplicants();
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
                  .read(mercenaryApplicantsViewModelProvider.notifier)
                  .refreshMercenaryApplicants();
            },
            color: const Color(0xFF2BBB7D),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: applicants.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final applicant = applicants[index];
                return MercenaryApplicantsItem(
                  applicant: applicant,
                  onAccept: () {
                    _showResponseDialog(
                      context,
                      'accepted',
                      applicant.mercenaryName,
                      () {
                        ref
                            .read(mercenaryApplicantsViewModelProvider.notifier)
                            .acceptApplicant(applicant.id);
                      },
                    );
                  },
                  onReject: () {
                    _showResponseDialog(
                      context,
                      'rejected',
                      applicant.mercenaryName,
                      () {
                        ref
                            .read(mercenaryApplicantsViewModelProvider.notifier)
                            .rejectApplicant(applicant.id);
                      },
                    );
                  },
                );
              },
            ),
          );
        },
        loading: () {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF2BBB7D),
                ),
                SizedBox(height: 16),
                Text(
                  '지원자 목록을 불러오는 중...',
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
                        .read(mercenaryApplicantsViewModelProvider.notifier)
                        .refreshMercenaryApplicants();
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
    String mercenaryName,
    VoidCallback onConfirm,
  ) {
    String title;
    String message;
    Color actionColor;

    switch (response) {
      case 'accepted':
        title = '지원 수락';
        message = '$mercenaryName님의 지원을 수락하시겠습니까?';
        actionColor = const Color(0xFF2BBB7D);
        break;
      case 'rejected':
        title = '지원 거절';
        message = '$mercenaryName님의 지원을 거절하시겠습니까?';
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
