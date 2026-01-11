// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/video_model.dart';
//
// class VideoApi {
//   static const baseUrl = "https://yourapi.com"; // change with your API
//
//
//   static Future<List<VideoModel>> fetchVideos() async {
//     final response = await http.get(Uri.parse("$baseUrl/videos"));
//     if (response.statusCode == 200) {
//       final List data = json.decode(response.body);
//       return data.map((e) => VideoModel.fromJson(e)).toList();
//     } else {
//       throw Exception("Failed to load videos");
//     }
//   }
//
//   /// Like a video
//   static Future<void> likeVideo(String id) async {
//     await http.post(Uri.parse("$baseUrl/videos/$id/like"));
//   }
//
//   /// Comment on video
//   static Future<void> commentVideo(String id, String comment) async {
//     await http.post(
//       Uri.parse("$baseUrl/videos/$id/comment"),
//       body: {"comment": comment},
//     );
//   }
//
//   /// Upload video
//   static Future<void> uploadVideo(String filePath, String about) async {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse("$baseUrl/videos/upload"),
//     );
//     request.files.add(await http.MultipartFile.fromPath("video", filePath));
//     request.fields['about'] = about;
//     await request.send();
//   }
// }
