// import 'package:flutter/material.dart';
// import '../api/video_api.dart';
// import '../models/video_model.dart';
// import '../widgets/video_player_widget.dart';
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen({super.key});
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   late Future<List<VideoModel>> videosFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     videosFuture = VideoApi.fetchVideos();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Video Feed"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: FutureBuilder<List<VideoModel>>(
//         future: videosFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }
//
//           final videos = snapshot.data ?? [];
//
//           return ListView.builder(
//             itemCount: videos.length,
//             itemBuilder: (context, index) {
//               final v = videos[index];
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 250,
//                     width: double.infinity,
//                     child: VideoPlayerWidget(videoUrl: v.url),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Text(v.about,
//                         style: const TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.thumb_up_alt_outlined),
//                         onPressed: () {
//                           VideoApi.likeVideo(v.id);
//                           setState(() {
//                             v.likes + 1;
//                           });
//                         },
//                       ),
//                       Text("${v.likes} Likes"),
//                       const SizedBox(width: 20),
//                       IconButton(
//                         icon: const Icon(Icons.comment_outlined),
//                         onPressed: () {
//                           _showCommentBox(v.id);
//                         },
//                       ),
//                       Text("${v.comments} Comments"),
//                     ],
//                   ),
//                   const Divider(),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   void _showCommentBox(String videoId) {
//     final controller = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Add Comment"),
//         content: TextField(controller: controller),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(ctx);
//             },
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               VideoApi.commentVideo(videoId, controller.text);
//               Navigator.pop(ctx);
//               setState(() {});
//             },
//             child: const Text("Post"),
//           ),
//         ],
//       ),
//     );
//   }
// }
