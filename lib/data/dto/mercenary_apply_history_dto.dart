class MercenaryApplyHistoryDto {
  final String id;
  final String userId;
  final String teamId;
  final String teamName;
  final String teamProfileImage;
  final String feedId;
  final String appliedAt;
  final String status;
  final String location;
  final String gameDate;
  final String gameTime;
  final String cost;
  final String level;

  MercenaryApplyHistoryDto({
    required this.id,
    required this.userId,
    required this.teamId,
    required this.teamName,
    required this.teamProfileImage,
    required this.feedId,
    required this.appliedAt,
    required this.status,
    required this.location,
    required this.gameDate,
    required this.gameTime,
    required this.cost,
    required this.level,
  });

  factory MercenaryApplyHistoryDto.fromJson(Map<String, dynamic> json) {
    return MercenaryApplyHistoryDto(
      id: json['id'],
      userId: json['userId'],
      teamId: json['teamId'],
      teamName: json['teamName'],
      teamProfileImage: json['teamProfileImage'] ?? '',
      feedId: json['feedId'],
      appliedAt: json['appliedAt'],
      status: json['status'],
      location: json['location'],
      gameDate: json['gameDate'],
      gameTime: json['gameTime'],
      cost: json['cost'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'teamId': teamId,
      'teamName': teamName,
      'teamProfileImage': teamProfileImage,
      'feedId': feedId,
      'appliedAt': appliedAt,
      'status': status,
      'location': location,
      'gameDate': gameDate,
      'gameTime': gameTime,
      'cost': cost,
      'level': level,
    };
  }
}
