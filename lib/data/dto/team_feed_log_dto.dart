class TeamFeedLogDto {
  final String feedId;
  final bool isApplicant;
  final String uid;

  TeamFeedLogDto({
    required this.feedId,
    required this.isApplicant,
    required this.uid,
  });

  factory TeamFeedLogDto.fromJson(Map<String, dynamic> json) => TeamFeedLogDto(
        feedId: json["feedId"],
        isApplicant: json["isApplicant"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "feedId": feedId,
        "isApplicant": isApplicant,
        "uid": uid,
      };
}
