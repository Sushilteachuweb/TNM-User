import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';
import '../../providers/LocationProvider.dart';
import '../../providers/ProfileProvider.dart';
import '../../utils/app_colors.dart';
import '../../generated/l10n/app_localizations.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late PodPlayerController _podController;

  // Real YouTube video configuration
  final String videoId = "rRSXgWooxq8";
  final String videoTitle = "Career Development Video";

  @override
  void initState() {
    super.initState();
    
    // Initialize animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // Initialize Pod Player for YouTube
    _podController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube('https://www.youtube.com/watch?v=$videoId'),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: false,
        isLooping: false,
        videoQualityPriority: [720, 360],
      ),
    )..initialise();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _podController.dispose();
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
                child: _buildVideoPlayer(),
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
            child: Consumer2<LocationProvider, ProfileProvider>(
              builder: (context, locationProvider, profileProvider, child) {
                // Use profile location if available, otherwise use GPS location
                String displayLocation = profileProvider.user?.userLocation ?? 
                                       locationProvider.city;
                
                return Container(
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
                        displayLocation,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              },
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
            AppLocalizations.of(context).careerDevelopmentVideos,
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
            AppLocalizations.of(context).learnGrowAdvance,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Video Player Widget with Pod Player
  Widget _buildVideoPlayer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // YouTube Video Player
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: PodVideoPlayer(
                controller: _podController,
                frameAspectRatio: 16 / 9,
                videoAspectRatio: 16 / 9,
                alwaysShowProgressBar: false,
                podProgressBarConfig: PodProgressBarConfig(
                  playingBarColor: AppColors.primary,
                  circleHandlerColor: AppColors.primary,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ),
            
            // Video Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                videoTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.headingText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
