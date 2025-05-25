import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mercenaryhub/domain/entity/my_mercenary_invitation_history.dart';

class MercenaryApplyHistoryItem extends StatelessWidget {
  final MyMercenaryInvitationHistory history;
  final Function(String status) onStatusUpdate;

  const MercenaryApplyHistoryItem({
    super.key,
    required this.history,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[300],
                backgroundImage: history.imageUrl.isNotEmpty
                    ? NetworkImage(history.imageUrl)
                    : null,
                child: history.imageUrl.isEmpty
                    ? const Icon(Icons.person, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '초대일: ${DateFormat('yyyy.MM.dd').format(history.appliedAt)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusChip(history.status),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.location_on, history.location),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.calendar_today,
                  DateFormat('yyyy년 MM월 dd일').format(history.date),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.access_time,
                    '${DateFormat('HH:mm').format(history.time.start!)} ~ ${DateFormat('HH:mm').format(history.time.end!)}'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.military_tech, history.level),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.attach_money,
                  '${NumberFormat('#,###').format(int.parse(history.cost))}원',
                ),
              ],
            ),
          ),

          // 초대 취소 버튼 (pending 상태일 때만 표시)
          if (history.status == 'pending') ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  onStatusUpdate('cancelled');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('초대 취소'),
              ),
            ),
          ],

          // 상태 변경 알림
          if (history.status != 'pending') ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getStatusColor(history.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(history.status),
                    size: 16,
                    color: _getStatusColor(history.status),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getStatusMessage(history.status),
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(history.status),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case 'pending':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        text = '대기중';
        break;
      case 'accepted':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        text = '수락됨';
        break;
      case 'rejected':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        text = '거절됨';
        break;
      case 'cancelled':
        backgroundColor = Colors.grey[300]!;
        textColor = Colors.grey[700]!;
        text = '취소됨';
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
        text = '알 수 없음';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'accepted':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      case 'cancelled':
        return Icons.remove_circle;
      default:
        return Icons.schedule;
    }
  }

  String _getStatusMessage(String status) {
    switch (status) {
      case 'accepted':
        return '용병이 초대를 수락했습니다';
      case 'rejected':
        return '용병이 초대를 거절했습니다';
      case 'cancelled':
        return '초대가 취소되었습니다';
      default:
        return '응답 대기 중입니다';
    }
  }
}
