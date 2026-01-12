import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:naukri_mitra_jobs/Screens/job_cate1.dart';
import '../generated/l10n/app_localizations.dart';

class JobCategories extends StatefulWidget {
  final String fullName;
  final String gender;
  final String education;
  final String workExperience;
  final File imageFile;
  const JobCategories({
    super.key,
    required this.fullName,
    required this.gender,
    required this.education,
    required this.workExperience,
    required this.imageFile, 
    required List skills,
  });

  @override
  State<JobCategories> createState() => _JobCategoriesState();
}

class _JobCategoriesState extends State<JobCategories> with TickerProviderStateMixin {
  final List<Map<String, String>> jobList = [
    {'title': 'Graphic Designer', 'image': 'images/man.jpg'},
    {'title': 'Sales / Business Development', 'image': 'images/man.jpg'},
    {'title': 'Data Entry Operator', 'image': 'images/man.jpg'},
    {'title': 'Delivery Executive', 'image': 'images/man.jpg'},
    {'title': 'Customer Support', 'image': 'images/man.jpg'},
    {'title': 'Sales / Business Development', 'image': 'images/man.jpg'},
    {'title': 'Data Entry Operator', 'image': 'images/man.jpg'},
    {'title': 'Delivery Executive', 'image': 'images/man.jpg'},
    {'title': 'Customer Support', 'image': 'images/man.jpg'},
    {'title': 'Field Executive', 'image': 'images/man.jpg'},
  ];
  
  String searchQuery = '';
  bool isLoading = true;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _animationController.forward();

    // Simulate API load
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = jobList
        .where((job) => job['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Professional Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      // Header with Back Button
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios_rounded),
                              color: Colors.grey[700],
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Expanded(
                            child: Text(
                            AppLocalizations.of(context)!.jobCategories,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          ),
                          const SizedBox(width: 48), // Balance the back button
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Main Title
                      Text(
                        AppLocalizations.of(context)!.chooseYourCareerPath,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        AppLocalizations.of(context)!.selectJobCategoryMatching,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Professional Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!, width: 1.5),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.searchJobCategoriesPlaceholder,
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.search_rounded,
                                color: Colors.blue[700],
                                size: 20,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Job Categories List
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: isLoading
                      ? _buildShimmerList()
                      : filteredList.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              itemCount: filteredList.length,
                              padding: const EdgeInsets.only(top: 8),
                              itemBuilder: (context, index) {
                                final job = filteredList[index];
                                return _buildJobCategoryCard(job, index);
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Professional Job Category Card
  Widget _buildJobCategoryCard(Map<String, String> job, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobCate1(
                    title: job['title']!,
                    image: job['image']!,
                    fullName: widget.fullName,
                    gender: widget.gender,
                    education: widget.education,
                    workExperience: widget.workExperience,
                    imageFile: widget.imageFile,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Professional Avatar Container
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        job['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Job Title and Arrow
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            job['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Professional Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noCategoriesFound,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.trySearchingDifferentKeywords,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Professional Shimmer Loading
  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 8,
      padding: const EdgeInsets.only(top: 8),
      itemBuilder: (_, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 12,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// import 'package:naukri_mitra_jobs/Screens/job_cate1.dart';
// import 'package:naukri_mitra_jobs/utils/app_colors.dart';
//
// class JobCategories extends StatefulWidget {
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final File imageFile;
//   const JobCategories({
//     super.key,
//     required this.fullName,
//     required this.gender,
//     required this.education,
//     required this.workExperience,
//     required this.imageFile,
//   });
//
//   @override
//   State<JobCategories> createState() => _JobCategoriesState();
// }
//
// class _JobCategoriesState extends State<JobCategories> {
//   final List<Map<String, String>> jobList = [
//     {'title': 'Graphic Designer', 'image': 'images/man.jpg'},
//     {'title': 'Sales / Business Development', 'image': 'images/man.jpg'},
//     {'title': 'Data Entry Operator', 'image': 'images/man.jpg'},
//     {'title': 'Delivery Executive', 'image': 'images/man.jpg'},
//     {'title': 'Customer Support', 'image': 'images/man.jpg'},
//     {'title': 'Sales / Business Development', 'image': 'images/man.jpg'},
//     {'title': 'Data Entry Operator', 'image': 'images/man.jpg'},
//     {'title': 'Delivery Executive', 'image': 'images/man.jpg'},
//     {'title': 'Customer Support', 'image': 'images/man.jpg'},
//     {'title': 'Field Executive', 'image': 'images/man.jpg'},
//   ];
//
//   String searchQuery = '';
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Simulate API load
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final filteredList = jobList
//         .where((job) => job['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
//         .toList();
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FE),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back Arrow
//               IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(Icons.arrow_back, color: Colors.blue),
//               ),
//               const SizedBox(height: 10),
//
//               // Search Field
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   onChanged: (value) {
//                     setState(() {
//                       searchQuery = value;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Search Job Categories",
//                     prefixIcon: const Icon(Icons.search, color: Colors.blue,),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//               const Text(
//                 "Select Job Category",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 10),
//
//               // Job List or Shimmer
//               Expanded(
//                 child: isLoading
//                     ? _buildShimmerList()
//                     : filteredList.isEmpty
//                     ? const Center(child: Text('No categories found'))
//                     : ListView.builder(
//                   itemCount: filteredList.length,
//                   itemBuilder: (context, index) {
//                     final job = filteredList[index];
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => JobCate1(
//                               title: job['title']!,
//                               image: job['image']!,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.15),
//                               blurRadius: 6,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.asset(
//                                 job['image']!,
//                                 width: 60,
//                                 height: 60,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Text(
//                                 job['title']!,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               // Navigation Buttons
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     ElevatedButton(
//               //       onPressed: () => Navigator.pop(context),
//               //       style: ElevatedButton.styleFrom(
//               //         backgroundColor: Colors.blue,
//               //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//               //         shape: RoundedRectangleBorder(
//               //           borderRadius: BorderRadius.circular(8),
//               //         ),
//               //       ),
//               //       child: const Text(
//               //         'Back',
//               //         style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
//               //       ),
//               //     ),
//               //     ElevatedButton(
//               //       onPressed: () {
//               //         // Optional: you can skip or disable this if not used anymore
//               //       },
//               //       style: ElevatedButton.styleFrom(
//               //         backgroundColor: Colors.blue,
//               //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//               //         shape: RoundedRectangleBorder(
//               //           borderRadius: BorderRadius.circular(8),
//               //         ),
//               //       ),
//               //       child: const Text(
//               //         'Next',
//               //         style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Shimmer UI
//   Widget _buildShimmerList() {
//     return ListView.builder(
//       itemCount: 6,
//       itemBuilder: (_, __) => Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Shimmer.fromColors(
//               baseColor: AppColors.searchIcon,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Shimmer.fromColors(
//                 baseColor: Colors.grey[300]!,
//                 highlightColor: Colors.grey[100]!,
//                 child: Container(
//                   height: 20,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//











