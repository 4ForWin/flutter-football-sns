import 'package:mercenaryhub/domain/entity/time_state.dart';

class MercenaryApplicantDto {
  final String applicationId;
  final String mercenaryUid;
  final String mercenaryName;
  final String profileImage;
  final String teamFeedId;
  final String teamName;
  final String cost;
  final String level;
  final String location;
  final String gameDate; // String 형태로 저장 (ISO 8601)
  final TimeState gameTime;
  final String appliedAt; // String 형태로 저장 (ISO 8601)
  final String status;
  final String? content;

  MercenaryApplicantDto({
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

  /// JSON에서 DTO 생성
  factory MercenaryApplicantDto.fromJson(Map<String, dynamic> json) {
    return MercenaryApplicantDto(
      applicationId: json['applicationId'] ?? '',
      mercenaryUid: json['mercenaryUid'] ?? '',
      mercenaryName: json['mercenaryName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      teamFeedId: json['teamFeedId'] ?? '',
      teamName: json['teamName'] ?? '',
      cost: json['cost'] ?? '',
      level: json['level'] ?? '',
      location: json['location'] ?? '',
      gameDate: json['gameDate'] ?? '',
      gameTime: TimeState.fromJson(json['gameTime'] ?? {}),
      appliedAt: json['appliedAt'] ?? '',
      status: json['status'] ?? 'pending',
      content: json['content'],
    );
  }

  /// DTO를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'applicationId': applicationId,
      'mercenaryUid': mercenaryUid,
      'mercenaryName': mercenaryName,
      'profileImage': profileImage,
      'teamFeedId': teamFeedId,
      'teamName': teamName,
      'cost': cost,
      'level': level,
      'location': location,
      'gameDate': gameDate,
      'gameTime': gameTime.toJson(),
      'appliedAt': appliedAt,
      'status': status,
      if (content != null) 'content': content,
    };
  }

  /// DTO 복사본 생성
  MercenaryApplicantDto copyWith({
    String? applicationId,
    String? mercenaryUid,
    String? mercenaryName,
    String? profileImage,
    String? teamFeedId,
    String? teamName,
    String? cost,
    String? level,
    String? location,
    String? gameDate,
    TimeState? gameTime,
    String? appliedAt,
    String? status,
    String? content,
  }) {
    return MercenaryApplicantDto(
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

  /// 디버깅용 문자열 표현
  @override
  String toString() {
    return 'MercenaryApplicantDto{'
        'applicationId: $applicationId, '
        'mercenaryName: $mercenaryName, '
        'teamName: $teamName, '
        'status: $status, '
        'appliedAt: $appliedAt'
        '}';
  }

  /// 두 DTO가 같은지 비교
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MercenaryApplicantDto &&
        other.applicationId == applicationId &&
        other.mercenaryUid == mercenaryUid &&
        other.status == status;
  }

  /// 해시코드 생성
  @override
  int get hashCode {
    return applicationId.hashCode ^ mercenaryUid.hashCode ^ status.hashCode;
  }
}
