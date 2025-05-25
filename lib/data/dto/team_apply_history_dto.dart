class TeamApplyHistoryDto {
  final String id;
  final String teamName;
  final String mercenaryUserId;
  final String mercenaryName;
  final String mercenaryProfileImage;
  final String feedId;
  final String appliedAt;
  final String status;
  final String location;
  final String gameDate;
  final String gameTime;
  final String level;

  TeamApplyHistoryDto({
    required this.id,
    required this.teamName,
    required this.mercenaryUserId,
    required this.mercenaryName,
    required this.mercenaryProfileImage,
    required this.feedId,
    required this.appliedAt,
    required this.status,
    required this.location,
    required this.gameDate,
    required this.gameTime,
    required this.level,
  });

  factory TeamApplyHistoryDto.fromJson(Map<String, dynamic> json) {
    return TeamApplyHistoryDto(
      id: json['id'],
      teamName: json['teamName'],
      mercenaryUserId: json['mercenaryUserId'],
      mercenaryName: json['mercenaryName'],
      mercenaryProfileImage: json['mercenaryProfileImage'] ?? '',
      feedId: json['feedId'],
      appliedAt: json['appliedAt'],
      status: json['status'],
      location: json['location'],
      gameDate: json['gameDate'],
      gameTime: json['gameTime'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamName': teamName,
      'mercenaryUserId': mercenaryUserId,
      'mercenaryName': mercenaryName,
      'mercenaryProfileImage': mercenaryProfileImage,
      'feedId': feedId,
      'appliedAt': appliedAt,
      'status': status,
      'location': location,
      'gameDate': gameDate,
      'gameTime': gameTime,
      'level': level,
    };
  }
}
