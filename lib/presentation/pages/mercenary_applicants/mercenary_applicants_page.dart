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
          print('📱 UI: ${applicants.length}개의 지원자 표시');

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
            child: Column(
              children: [
                // 상태별 필터 탭 (선택사항)
                _buildFilterTabs(context, ref, applicants),

                // 지원자 목록
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: applicants.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final applicant = applicants[index];
                      return MercenaryApplicantItem(
                        applicant: applicant,
                        onAccept: () {
                          print('📱 UI: 지원 수락 요청 - ${applicant.applicationId}');
                          _showResponseDialog(
                            context,
                            'accepted',
                            applicant.mercenaryName,
                            () {
                              ref
                                  .read(mercenaryApplicantsViewModelProvider
                                      .notifier)
                                  .acceptApplication(applicant.applicationId);
                            },
                          );
                        },
                        onReject: () {
                          print('📱 UI: 지원 거절 요청 - ${applicant.applicationId}');
                          _showResponseDialog(
                            context,
                            'rejected',
                            applicant.mercenaryName,
                            () {
                              ref
                                  .read(mercenaryApplicantsViewModelProvider
                                      .notifier)
                                  .rejectApplication(applicant.applicationId);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
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

  /// 상태별 필터 탭
  Widget _buildFilterTabs(
      BuildContext context, WidgetRef ref, dynamic applicants) {
    final viewModel = ref.read(mercenaryApplicantsViewModelProvider.notifier);

    // 상태별 카운트 계산
    final pendingCount = viewModel.getPendingApplicants().length;
    final acceptedCount = viewModel.getAcceptedApplicants().length;
    final rejectedCount = viewModel.getRejectedApplicants().length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterChip('전체', applicants.length, true),
          _buildFilterChip('대기중', pendingCount, false),
          _buildFilterChip('수락됨', acceptedCount, false),
          _buildFilterChip('거절됨', rejectedCount, false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int count, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2BBB7D) : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$label ($count)',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : const Color(0xFF222222),
        ),
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
