class FeedDto {
  String id;
  String title;
  String content;
  String imageUrl;
  String createAt;
  String teamName;
  String location;

  FeedDto({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createAt,
    required this.teamName,
    required this.location,
  });

  FeedDto copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    String? createAt,
    String? teamName,
    String? location,
  }) =>
      FeedDto(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        imageUrl: imageUrl ?? this.imageUrl,
        createAt: createAt ?? this.createAt,
        teamName: teamName ?? this.teamName,
        location: location ?? this.location,
      );

  factory FeedDto.fromJson(Map<String, dynamic> json) => FeedDto(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        imageUrl: json["imageUrl"],
        createAt: json["createAt"],
        teamName: json["teamName"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "imageUrl": imageUrl,
        "createAt": createAt,
        "teamName": teamName,
        "location": location,
      };
}
