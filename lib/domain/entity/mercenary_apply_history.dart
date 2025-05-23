class MercenaryApplyHistory {
  final String id;
  final String userId; // 용병 유저 ID
  final String teamId;
  final String teamName;
  final String teamProfileImage;
  final String feedId;
  final DateTime appliedAt;
  final String status; // pending, accepted, rejected
  final String location;
  final DateTime gameDate;
  final String gameTime;
  final String cost;
  final String level;

  MercenaryApplyHistory({
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
}
