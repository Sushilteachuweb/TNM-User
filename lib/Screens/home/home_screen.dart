import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'video_player_screen.dart';
import '../video/VideoScreen.dart';
import '../jobs/job_full_details.dart';
import '../jobs/jobs_by_category_screen.dart';
import '../jobs/jobs_by_type_screen.dart';
import 'main_screen.dart';
import '../../providers/JobProvider.dart';
import '../../providers/ProfileProvider.dart';
import '../../providers/LocationProvider.dart';
import '../../utils/location_permission_dialog.dart';
import '../../utils/app_colors.dart';
import '../../generated/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final String image;
  final String fullName;
  final String gender;
  final String education;
  final String workExperience;
  final String salary;
  final File? imageFile;
  final List<String> skills;
  
  const HomeScreen({
    super.key,
    required this.title,
    required this.image,
    required this.fullName,
    required this.gender,
    required this.education,
    required this.workExperience,
    required this.salary,
    required this.imageFile,
    required this.skills,
  });
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _initializeApp();
    _animationController.forward();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndFetchLocation();
    }
  }

  Future<void> _initializeApp() async {
    Future.microtask(() async {
      await LocationPermissionDialog.checkAndShowDialog(context);
      await _checkAndFetchLocation();
      context.read<JobProvider>().fetchJobs();
      context.read<ProfileProvider>().fetchProfile();
      // Fetch job categories for the home screen
      context.read<ProfileProvider>().fetchJobCategories();
    });
  }

  Future<void> _checkAndFetchLocation() async {
    if (mounted) {
      await context.read<LocationProvider>().fetchLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildModernHeader(),
                  _buildModernSearchBox(),
                  const SizedBox(height: 20),
                  _buildFeaturedJobsSection(),
                  const SizedBox(height: 20),
                  _buildNearbyJobsSection(),
                  const SizedBox(height: 20),
                  _buildCareerDevelopmentSection(),
                  const SizedBox(height: 20),
                  _buildJobCategoriesSection(),
                  const SizedBox(height: 20),
                  _buildAllJobsGrid(),
                  const SizedBox(height: 20),
                  _buildRatingSection(),
                  const SizedBox(height: 20),
                  _buildChatSupportSection(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Clean App Bar with perfectly centered logo
  Widget _buildModernHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.background, // Match main app background
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
                
                return GestureDetector(
                  onTap: () => locationProvider.refreshLocation(),
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
                          displayLocation,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                        if (locationProvider.isLoading)
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: SizedBox(
                              width: 8,
                              height: 8,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
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

  // Compact Modern Search Box
  Widget _buildModernSearchBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search for jobs, companies, skills...",
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.search,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[400], size: 18),
                  onPressed: () {
                    _searchController.clear();
                    context.read<JobProvider>().searchJobs('');
                  },
                )
              : Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white, size: 16),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(fontSize: 14),
        onChanged: (value) {
          setState(() {});
          context.read<JobProvider>().searchJobs(value);
        },
      ),
    );
  }
  // Featured Jobs Section
  Widget _buildFeaturedJobsSection() {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context).featuredJobs, AppLocalizations.of(context).viewAll, AppColors.primary, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MainScreen(
                initialIndex: 1,
                title: "",
                image: "",
                fullName: "fullName",
                gender: "",
                education: "",
                workExperience: "",
                salary: "",
                imageFile: null,
                skills: const [],
              ),
            ),
          );
        }),
        const SizedBox(height: 12),
        Consumer<JobProvider>(
          builder: (context, jobProvider, child) {
            if (jobProvider.isLoading) {
              return _buildJobLoadingSkeleton();
            }
            if (jobProvider.jobs.isEmpty) {
              return _buildEmptyJobsState();
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: jobProvider.jobs.length > 3 ? 3 : jobProvider.jobs.length,
              itemBuilder: (context, index) {
                final job = jobProvider.jobs[index];
                return _buildModernJobCard(
                  title: job.title,
                  company: job.companyName,
                  location: job.workLocation,
                  salary: (job.minSalary > 0 && job.maxSalary > 0)
                      ? "₹${job.minSalary} - ${job.maxSalary}"
                      : job.salaryType,
                  isUrgent: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobFullDetails(job: job),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }


  // Redesigned Nearby Jobs Section
  Widget _buildNearbyJobsSection() {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context).nearbyJobs, AppLocalizations.of(context).comingSoon, Colors.orange, null),
        const SizedBox(height: 15),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildModernNearbyCard("Connaught Place", "1.2 km", "25+ Jobs", Icons.location_city),
              _buildModernNearbyCard("Cyber City", "2.8 km", "40+ Jobs", Icons.business),
              _buildModernNearbyCard("Sector 18", "3.5 km", "15+ Jobs", Icons.apartment),
              _buildModernNearbyCard("DLF Phase 1", "4.1 km", "30+ Jobs", Icons.domain),
              _buildModernNearbyCard("MG Road", "5.0 km", "20+ Jobs", Icons.store),
            ],
          ),
        ),
      ],
    );
  }

  // Redesigned Career Development Section
  Widget _buildCareerDevelopmentSection() {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context).careerDevelopment, "", AppColors.info, null), // Empty string instead of "Coming Soon"
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildModernVideoCard("Career Development Video", "rRSXgWooxq8", Icons.play_circle_filled, AppColors.primary),
              // Only one video card - removed the other dummy cards
            ],
          ),
        ),
      ],
    );
  }

  // Job Categories Section
  Widget _buildJobCategoriesSection() {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            _buildSectionHeader(AppLocalizations.of(context).jobCategories, "", AppColors.success, null),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: provider.isCategoriesLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.jobCategories.isEmpty
                      ? const Center(child: Text("No categories available"))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: provider.jobCategories.take(6).map((category) {
                              final colors = [
                                AppColors.primary,
                                AppColors.secondary,
                                AppColors.accent,
                                AppColors.warning,
                                AppColors.success,
                                AppColors.error,
                              ];
                              final colorIndex = provider.jobCategories.indexOf(category) % colors.length;
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: _buildModernCategoryCard(
                                  category.jobCategory,
                                  "images/man.jpg",
                                  colors[colorIndex],
                                  category.id,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
            ),
          ],
        );
      },
    );
  }

  // All Jobs Grid
  Widget _buildAllJobsGrid() {
    return Consumer<JobProvider>(
      builder: (context, jobProvider, child) {
        // Calculate job counts by type from real data
        final jobs = jobProvider.jobs;
        
        final fullTimeJobs = jobs.where((job) => 
          job.jobType.toLowerCase().contains('full') ||
          job.jobType.toLowerCase().contains('permanent')
        ).length;
        
        final partTimeJobs = jobs.where((job) => 
          job.jobType.toLowerCase().contains('part')
        ).length;
        
        final remoteJobs = jobs.where((job) => 
          job.workLocation.toLowerCase().contains('remote') ||
          job.workLocation.toLowerCase().contains('home')
        ).length;
        
        final officeJobs = jobs.where((job) => 
          job.workLocation.toLowerCase().contains('office') ||
          job.workLocation.toLowerCase().contains('onsite') ||
          (!job.workLocation.toLowerCase().contains('remote') && 
           !job.workLocation.toLowerCase().contains('home'))
        ).length;

        return Column(
          children: [
            _buildSectionHeader(AppLocalizations.of(context).allJobs, "", AppColors.info, null),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildModernJobTypeCard(
                        AppLocalizations.of(context).fullTime, 
                        "$fullTimeJobs+ Jobs", 
                        Icons.work, 
                        AppColors.primary,
                        "full time"
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _buildModernJobTypeCard(
                        AppLocalizations.of(context).partTime, 
                        "$partTimeJobs+ Jobs", 
                        Icons.access_time, 
                        AppColors.secondary,
                        "part time"
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildModernJobTypeCard(
                        "Remote", 
                        "$remoteJobs+ Jobs", 
                        Icons.home_work, 
                        AppColors.accent,
                        "remote"
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _buildModernJobTypeCard(
                        "Office", 
                        "$officeJobs+ Jobs", 
                        Icons.business, 
                        AppColors.warning,
                        "office"
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Rating Section
  Widget _buildRatingSection() {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context).rateYourExperience, "", Colors.purple, null),
        const SizedBox(height: 15),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return FutureBuilder<bool>(
                future: profileProvider.hasUserRated(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  
                  bool hasRated = snapshot.data ?? false;
                  
                  if (hasRated) {
                    // Show thank you message if already rated
                    return Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.success, Color(0xFF66BB6A)],
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Thank You!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We appreciate your valuable feedback",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // Show rating widget if not rated yet
                  return _ModernRatingWidget();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Chat Support Section
  Widget _buildChatSupportSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Lottie.asset(
                    'animations/chat1.json',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context).chatWithUs,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context).supportAvailable,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Text(
              AppLocalizations.of(context).comingSoon,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Helper Widgets

  Widget _buildSectionHeader(String title, String actionText, Color color, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.headingText,
            ),
          ),
          if (actionText.isNotEmpty)
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  actionText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModernJobCard({
    required String title,
    required String company,
    required String location,
    required String salary,
    required bool isUrgent,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingText,
                        ),
                      ),
                    ),
                    if (isUrgent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Urgent",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  company,
                  style: TextStyle(
                    color: AppColors.bodyText,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(child: Text(location, style: const TextStyle(fontSize: 12))),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.currency_rupee,
                        size: 14,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(salary, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildJobTag(AppLocalizations.of(context).newJob, AppColors.warning),
                    const SizedBox(width: 6),
                    _buildJobTag("10 ${AppLocalizations.of(context).vacancies}", AppColors.info),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  // Redesigned Nearby Jobs Card
  Widget _buildModernNearbyCard(String location, String distance, String jobs, IconData icon) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    jobs,
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.headingText,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.near_me, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  distance,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Redesigned Video Card
  Widget _buildModernVideoCard(String title, String youtubeVideoId, IconData icon, Color color) {
    // YouTube thumbnail URL
    final String thumbnailUrl = 'https://img.youtube.com/vi/$youtubeVideoId/hqdefault.jpg';
    
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to Video screen by pushing it
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoScreen(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    // YouTube Thumbnail
                    Positioned.fill(
                      child: Image.network(
                        thumbnailUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: color,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback gradient background if thumbnail fails
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Icon(icon, color: color, size: 40),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Dark overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Play Button
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
                      ),
                    ),
                    
                    // HD Badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "HD",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.headingText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCategoryCard(String title, String imagePath, Color color, String categoryId) {
    return GestureDetector(
      onTap: () {
        // Navigate to jobs filtered by this category
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobsByCategoryScreen(
              categoryId: categoryId,
              categoryName: title,
            ),
          ),
        );
      },
      child: Container(
        width: 120, // Fixed width for uniform cards
        height: 120, // Fixed height for uniform cards
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernJobTypeCard(String title, String subtitle, IconData icon, Color color, String jobType) {
    return GestureDetector(
      onTap: () {
        // Navigate to jobs filtered by this type
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobsByTypeScreen(
              jobType: jobType,
              displayName: title,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobLoadingSkeleton() {
    return Column(
      children: List.generate(3, (index) => 
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyJobsState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.work_outline,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "No jobs found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Try adjusting your search criteria",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}

// Modern Rating Widget
class _ModernRatingWidget extends StatefulWidget {
  @override
  State<_ModernRatingWidget> createState() => _ModernRatingWidgetState();
}

class _ModernRatingWidgetState extends State<_ModernRatingWidget> with TickerProviderStateMixin {
  int _rating = 0;
  bool _submitted = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: _submitted
          ? Column(
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.success, Color(0xFF66BB6A)],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Thank You!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "We appreciate your valuable feedback",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  AppLocalizations.of(context).howWasYourJobSearchExperience,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.headingText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = index + 1;
                        });
                        _animationController.forward().then((_) {
                          _animationController.reverse();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: index < _rating ? Colors.amber : Colors.grey[300],
                          size: 35,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                if (_rating > 0)
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Submit rating using ProfileProvider
                        final provider = Provider.of<ProfileProvider>(context, listen: false);
                        final result = await provider.submitRating(_rating);
                        
                        if (result["success"] == true) {
                          setState(() {
                            _submitted = true;
                          });
                          _animationController.forward();
                          
                          // Show success message
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text("Thank you for your rating!"),
                                  ],
                                ),
                                backgroundColor: AppColors.success,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }
                        } else {
                          // Check if it's a duplicate rating attempt
                          if (result["alreadyRated"] == true) {
                            // Show friendly message for duplicate rating
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.white),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "You've already shared your valuable feedback with us. Thank you!",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.orange,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  duration: const Duration(seconds: 4),
                                ),
                              );
                            }
                            // Also update the UI to show "already rated" state
                            setState(() {
                              _submitted = true;
                            });
                            _animationController.forward();
                          } else {
                            // Show generic error message
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.error, color: Colors.white),
                                      const SizedBox(width: 8),
                                      Expanded(child: Text(result["message"] ?? "Failed to submit rating")),
                                    ],
                                  ),
                                  backgroundColor: AppColors.error,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Submit Rating",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}