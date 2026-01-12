import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> videos = [
    {
      "title": "Flutter Career Tips",
      "description": "🔥 Urgent Requirement: Senior Flutter Developer needed for a FinTech project. Remote/Hybrid options available. 5+ years exp. Apply now! #FlutterJobs #Hiring",
      "duration": "5:30",
      "views": "12K",
      "category": "Career",
      "color": AppColors.primary,
      "icon": Icons.work_outline,
    },
    {
      "title": "UI/UX Design Trends",
      "description": "🚀 We are expanding our design team! Looking for creative UI/UX Designers with Figma expertise. Join us to build world-class products. 🎨 #DesignJobs #UIUX",
      "duration": "8:45",
      "views": "8.5K",
      "category": "Design",
      "color": AppColors.secondary,
      "icon": Icons.design_services,
    },
    {
      "title": "Interview Preparation",
      "description": "💡 Interview Tip: deeply understand State Management (Provider, Riverpod, Bloc) before your next Flutter interview. Here is a quick breakdown... #InterviewPrep #Flutter",
      "duration": "12:15",
      "views": "20K",
      "category": "Interview",
      "color": AppColors.success,
      "icon": Icons.psychology,
    },
    {
      "title": "Office Culture",
      "description": "🏢 Office Tour: A glimpse into our new HQ in Bangalore! Open workspaces, gaming zones, and free coffee! Come change the world with us. #LifeAtCompany #OfficeTour",
      "duration": "6:20",
      "views": "15K",
      "category": "Culture",
      "color": AppColors.warning,
      "icon": Icons.business,
    },
    {
      "title": "Career Growth",
      "description": "📈 Career Growth: How to transition from a Junior Developer to a Team Lead. Key skills you need to master beyond coding. #CareerAdvice #Growth",
      "duration": "10:30",
      "views": "25K",
      "category": "Growth",
      "color": AppColors.info,
      "icon": Icons.trending_up,
    },
    {
      "title": "Hiring Events",
      "description": "📢 Walk-in Drive this Saturday for Freshers! Java, Python, and React roles. Location: Tech Park, Sector 5. Don't miss out! #FreshersHiring #WalkIn",
      "duration": "4:15",
      "views": "9K",
      "category": "Events",
      "color": AppColors.error,
      "icon": Icons.event,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildModernHeader(),
              _buildWelcomeSection(),
              const SizedBox(height: 16),
              Expanded(
                child: _buildVideosList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Modern Header matching home and job screens
  Widget _buildModernHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left side - Location
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: AppColors.primary, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    "Location",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Center - Logo
          Align(

          ),
          
          // Right side - Notification
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Icon(Icons.notifications_outlined, color: AppColors.primary, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  // Welcome Section matching home screen style
  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Career Development Videos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Learn, grow, and advance your career",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Modern Videos List
  Widget _buildVideosList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return _buildModernVideoCard(video, index);
      },
    );
  }

  // Modern Video Card
  Widget _buildModernVideoCard(Map<String, dynamic> video, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Video Thumbnail
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  video['color'].withOpacity(0.1),
                  video['color'].withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [video['color'], video['color'].withOpacity(0.8)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: video['color'].withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(video['icon'], color: video['color'], size: 24),
                      ),
                    ],
                  ),
                ),
                // Duration Badge
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      video['duration'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Category Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: video['color'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      video['category'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Video Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        video['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingText,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.success.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.visibility, size: 12, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text(
                            "${video['views']} views",
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  video['description'],
                  style: TextStyle(
                    color: AppColors.bodyText,
                    fontSize: 13,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              "Watch Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.bookmark_outline, color: AppColors.primary, size: 18),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.share_outlined, color: AppColors.primary, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen({super.key});
//
//   @override
//   State<VideoScreen> createState() => _VideoFeedScreenState();
// }
//
// class _VideoFeedScreenState extends State<VideoScreen> {
//   final List<Map<String, String>> stories = [
//     {"name": "Hello", "image": "images/man.jpg"},
//     {"name": "RockStar", "image": "images/man.jpg"},
//     {"name": "User3", "image": "images/man.jpg"},
//     {"name": "User4", "image": "images/man.jpg"},
//     {"name": "User5", "image": "images/man.jpg"},
//     {"name": "User6", "image": "images/man.jpg"},
//     {"name": "User7", "image": "images/man.jpg"},
//   ];
//
//   final List<Map<String, String>> videos = [
//     {"video": "videos/ads.mp4",  "about": "I am A Flutter developer"},
//     {"video": "videos/ads2.mp4", "about": "Fintech Wallet UI Demo।"},
//     {"video": "videos/ads3.mp4",  "about": "I am A Flutter developer"},
//     {"video": "videos/ads.mp4", "about": "Fintech Wallet UI Demo।"},
//     {"video": "videos/ads2.mp4",  "about": "I am A Flutter developer"},
//     {"video": "videos/ads3.mp4", "about": "Fintech Wallet UI Demo।"},
//     {"video": "videos/ads.mp4",  "about": "I am A Flutter developer"},
//     {"video": "videos/ads2.mp4", "about": "Fintech Wallet UI Demo।"},
//
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Video Feed"),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black,
//       ),
//
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           SizedBox(
//             height: 106,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               itemCount: stories.length,
//               itemBuilder: (context, index) {
//                 final s = stories[index];
//                 return SizedBox(
//                   width: 78,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundImage: AssetImage(s["image"]!),
//                       ),
//                       const SizedBox(height: 6),
//                       SizedBox(
//                         height: 16,
//                         child: Text(
//                           s["name"]!,
//                           textAlign: TextAlign.center,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           const Divider(height: 1),
//           ...videos.map((v) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 250,
//                   width: double.infinity,
//                   child: VideoPlayerWidget(videoPath: v["video"]!),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
//                   child: Text(
//                     v["about"]!,
//                     style: const TextStyle(fontSize: 14, color: Colors.black87),
//                   ),
//                 ),
//                 const Divider(height: 16),
//               ],
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
//
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoPath;
//   const VideoPlayerWidget({super.key, required this.videoPath});
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   ChewieController? _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(widget.videoPath)
//       ..initialize().then((_) {
//         if (mounted) setState(() {});
//       });
//     _chewieController = ChewieController(
//       videoPlayerController: _controller,
//       autoPlay: false,
//       looping: false,
//       showControls: true,
//     );
//   }
//
//   @override
//   void dispose() {
//     _chewieController?.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     return AspectRatio(
//       aspectRatio: _controller.value.aspectRatio,
//       child: Chewie(controller: _chewieController!),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen({super.key});
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   final List<Map<String, String>> videos = [
//     {
//       "path": "videos/ads.mp4",
//       "title": "Flutter Video Player Demo",
//       "channel": "Tech Channel",
//       "views": "12K views · 2 days ago"
//     },
//     {
//       "path": "videos/ads2.mp4",
//       "title": "Chewie Player Example",
//       "channel": "Code with Asif",
//       "views": "8.5K views · 1 week ago"
//     },
//     {
//       "path": "videos/ads3.mp4",
//       "title": "YouTube Style UI in Flutter",
//       "channel": "Flutter Dev",
//       "views": "20K views · 1 month ago"
//     },
//   ];
//
//   final List<VideoPlayerController> _videoControllers = [];
//   final List<ChewieController> _chewieControllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideos();
//   }
//
//   Future<void> _initializeVideos() async {
//     for (var video in videos) {
//       final controller = VideoPlayerController.asset(video["path"]!);
//       await controller.initialize();
//       final chewieController = ChewieController(
//         videoPlayerController: controller,
//         autoPlay: false,
//         looping: false,
//         showControls: true,
//       );
//       _videoControllers.add(controller);
//       _chewieControllers.add(chewieController);
//     }
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     for (var c in _videoControllers) {
//       c.dispose();
//     }
//     for (var c in _chewieControllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("The Naukri Mitra"),
//         backgroundColor: const Color(0xFFE7EAF6),
//       ),
//       body: _videoControllers.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: videos.length,
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Video Player
//               AspectRatio(
//                 aspectRatio:
//                 _videoControllers[index].value.aspectRatio,
//                 child: Chewie(
//                   controller: _chewieControllers[index],
//                 ),
//               ),
//               // Title + Channel + Views
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   videos[index]["title"]!,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                   "${videos[index]["channel"]} • ${videos[index]["views"]}",
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ),
//               // Actions Row (Like, Share, Save)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: const [
//                     Icon(Icons.thumb_up_alt_outlined),
//                     Icon(Icons.thumb_down_alt_outlined),
//                     Icon(Icons.share),
//                     Icon(Icons.download),
//                     Icon(Icons.playlist_add),
//                   ],
//                 ),
//               ),
//               const Divider(),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
