class VideoModel {
  final String id;
  final String url;
  final String about;
  final String userName;
  final int likes;
  final int comments;

  VideoModel({
    required this.id,
    required this.url,
    required this.about,
    required this.userName,
    required this.likes,
    required this.comments,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'].toString(),
      url: json['video_url'],
      about: json['about'],
      userName: json['user_name'],
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
    );
  }
}
