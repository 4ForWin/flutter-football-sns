import 'package:mercenaryhub/domain/entity/time_state.dart';

class MercenaryApplicant {
  final String applicationId; // 지원 ID (고유 식별자)
  final String mercenaryUid; // 용병 사용자 ID
  final String mercenaryName; // 용병 이름
  final String profileImage; // 프로필 이미지 URL
  final String teamFeedId; // 팀 피드 ID
  final String teamName; // 팀명
  final String cost; // 참가비
  final String level; // 실력 수준
  final String location; // 지역
  final DateTime gameDate; // 경기 날짜
  final TimeState gameTime; // 경기 시간
  final DateTime appliedAt; // 지원한 날짜
  final String status; // pending, accepted, rejected, cancelled
  final String? content; // 팀 게시글 내용 (선택적)

  MercenaryApplicant({
    required this.applicationId,
    required this.mercenaryUid,
    required this.mercenaryName,
    required this.profileImage,
    required this.teamFeedId,
    required this.teamName,
    required this.cost,
    required this.level,
    required this.location,
    required this.gameDate,
    required this.gameTime,
    required this.appliedAt,
    required this.status,
    this.content,
  });

  /// 상태가 대기중인지 확인
  bool get isPending => status == 'pending';

  /// 상태가 수락됨인지 확인
  bool get isAccepted => status == 'accepted';

  /// 상태가 거절됨인지 확인
  bool get isRejected => status == 'rejected';

  /// 상태가 취소됨인지 확인
  bool get isCancelled => status == 'cancelled';

  /// 응답 가능한 상태인지 확인 (수락/거절 버튼 표시 여부)
  bool get canRespond => isPending;

  /// 상태 텍스트 반환
  String get statusText {
    switch (status) {
      case 'pending':
        return '대기중';
      case 'accepted':
        return '수락됨';
      case 'rejected':
        return '거절됨';
      case 'cancelled':
        return '취소됨';
      default:
        return '알 수 없음';
    }
  }

  /// 상태 복사본 생성 (상태 업데이트용)
  MercenaryApplicant copyWith({
    String? applicationId,
    String? mercenaryUid,
    String? mercenaryName,
    String? profileImage,
    String? teamFeedId,
    String? teamName,
    String? cost,
    String? level,
    String? location,
    DateTime? gameDate,
    TimeState? gameTime,
    DateTime? appliedAt,
    String? status,
    String? content,
  }) {
    return MercenaryApplicant(
      applicationId: applicationId ?? this.applicationId,
      mercenaryUid: mercenaryUid ?? this.mercenaryUid,
      mercenaryName: mercenaryName ?? this.mercenaryName,
      profileImage: profileImage ?? this.profileImage,
      teamFeedId: teamFeedId ?? this.teamFeedId,
      teamName: teamName ?? this.teamName,
      cost: cost ?? this.cost,
      level: level ?? this.level,
      location: location ?? this.location,
      gameDate: gameDate ?? this.gameDate,
      gameTime: gameTime ?? this.gameTime,
      appliedAt: appliedAt ?? this.appliedAt,
      status: status ?? this.status,
      content: content ?? this.content,
    );
  }
}
