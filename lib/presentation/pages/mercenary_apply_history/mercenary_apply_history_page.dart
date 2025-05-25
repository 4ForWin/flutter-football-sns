import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/presentation/pages/mercenary_apply_history/mercenary_apply_history_item.dart';
import 'package:mercenaryhub/presentation/pages/mercenary_apply_history/mercenary_apply_history_view_model.dart';

class MercenaryApplyHistoryPage extends ConsumerWidget {
  const MercenaryApplyHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myMercenaryInvitationHistoryViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
        title: const Text('용병 신청내역'),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
      ),
      body: state.when(
        data: (histories) {
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
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myMercenaryInvitationHistoryViewModelProvider);
            },
            color: const Color(0xFF2BBB7D),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: histories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return MercenaryApplyHistoryItem(
                  history: histories[index],
                  onCancel: () {
                    // ref
                    //     .read(myTeamApplicationHistoryViewModelProvider.notifier)
                    //     .cancelApply(histories[index].id);
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF2BBB7D),
          ),
        ),
        error: (error, stack) => Center(
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
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(myMercenaryInvitationHistoryViewModelProvider);
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
        ),
      ),
    );
  }
}
