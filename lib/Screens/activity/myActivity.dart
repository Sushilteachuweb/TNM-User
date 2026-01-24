// Modern Activity Page - Redesigned to match Home and Job screens

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/AppliedJobsProvider.dart';
import '../../providers/LocationProvider.dart';
import '../../providers/ProfileProvider.dart';
import '../../utils/app_colors.dart';
import '../../generated/l10n/app_localizations.dart';

class MyActivity extends StatefulWidget {
  const MyActivity({super.key});

  @override
  State<MyActivity> createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    final appliedJobs = Provider.of<AppliedJobsProvider>(context).appliedJobs;
    
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
                child: _buildAppliedJobsSection(appliedJobs),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Modern Header matching home and job screens exactly
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
          // Left side - Location (matching home and job screens)
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
          

          
          // Right side - Notification (matching home and job screens)
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
            AppLocalizations.of(context).myActivity,
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
            AppLocalizations.of(context).trackJobApplications,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Applied Jobs Section
  Widget _buildAppliedJobsSection(List appliedJobs) {
    if (appliedJobs.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: appliedJobs.length,
      itemBuilder: (context, index) {
        final job = appliedJobs[index];
        return _buildModernJobCard(job, index);
      },
    );
  }

  // Modern Job Card
  Widget _buildModernJobCard(dynamic job, int index) {
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
          // Card Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getStatusColor(index).withOpacity(0.1),
                  _getStatusColor(index).withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_getStatusColor(index), _getStatusColor(index).withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.work, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.companyName,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.success.withOpacity(0.3)),
                  ),
                  child: Text(
                    AppLocalizations.of(context).applied,
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Card Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job.workLocation,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.currency_rupee,
                        size: 16,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "₹${job.minSalary} - ${job.maxSalary}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.message_outlined, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              AppLocalizations.of(context).chatHR,
                              style: const TextStyle(
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call_outlined, color: AppColors.primary, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              AppLocalizations.of(context).callHR,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  // Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.work_outline,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context).noApplicationsYet,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.headingText,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context).startApplyingJobs,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                AppLocalizations.of(context).browseJobs,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(int index) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.success,
      AppColors.warning,
      AppColors.info,
    ];
    return colors[index % colors.length];
  }
}










// Post and get dono hai
// my_activity.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/AppliedJobsProvider.dart';
//
// class MyActivity extends StatefulWidget {
//   final String cookie;
//   final String userId; // ✅ Required for GET API
//
//   const MyActivity({super.key, required this.cookie, required this.userId});
//
//   @override
//   State<MyActivity> createState() => _MyActivityState();
// }
//
// class _MyActivityState extends State<MyActivity> {
//   @override
//   void initState() {
//     super.initState();
//     if (widget.cookie.isNotEmpty && widget.userId.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Provider.of<AppliedJobsProvider>(context, listen: false)
//             .fetchAppliedJobs(widget.cookie, widget.userId);
//       });
//     }
//   }
//
//   Future<void> _refreshJobs() async {
//     if (widget.cookie.isNotEmpty && widget.userId.isNotEmpty) {
//       await Provider.of<AppliedJobsProvider>(context, listen: false)
//           .fetchAppliedJobs(widget.cookie, widget.userId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppliedJobsProvider>(
//       builder: (context, provider, _) {
//         final jobs = provider.appliedJobs;
//         final isLoading = provider.isLoading;
//
//         return Scaffold(
//           backgroundColor: const Color(0xfff2f4f8),
//           appBar: AppBar(
//             backgroundColor: const Color(0xfff2f4f8),
//             elevation: 0,
//             title: const Text(
//               "My Activity",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18),
//             ),
//           ),
//           body: isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : RefreshIndicator(
//             onRefresh: _refreshJobs,
//             child: jobs.isEmpty
//                 ? const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                   "You have not applied to any jobs yet.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.black54, fontSize: 16),
//                 ),
//               ),
//             )
//                 : ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: jobs.length,
//               itemBuilder: (context, index) {
//                 final job = jobs[index];
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.withOpacity(0.2),
//                           blurRadius: 6,
//                           offset: const Offset(0, 3))
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(job.title,
//                           style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600)),
//                       const SizedBox(height: 4),
//                       Text(job.companyName,
//                           style: const TextStyle(
//                               fontSize: 13, color: Colors.black54)),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           const Icon(Icons.location_on,
//                               size: 16, color: Colors.blueAccent),
//                           const SizedBox(width: 4),
//                           Text(job.workLocation),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.currency_rupee,
//                               size: 16, color: Colors.blueAccent),
//                           const SizedBox(width: 4),
//                           Text("${job.minSalary} - ${job.maxSalary}"),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: () async {
//                                 bool success =
//                                 await provider.applyJob(
//                                   job.id,
//                                   widget.cookie,
//                                   userId: widget.userId,
//                                 );
//
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(
//                                   SnackBar(
//                                     content: Text(success
//                                         ? "Job Applied Successfully"
//                                         : "Failed to apply job"),
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.message),
//                               label: const Text("Chat HR"),
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: () async {
//                                 bool success =
//                                 await provider.applyJob(
//                                   job.id,
//                                   widget.cookie,
//                                   userId: widget.userId,
//                                 );
//
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(
//                                   SnackBar(
//                                     content: Text(success
//                                         ? "Job Applied Successfully"
//                                         : "Failed to apply job"),
//                                   ),
//                                 );
//                               },
//                               icon: const Icon(Icons.call),
//                               label: const Text("Call HR"),
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/custom/ViewJobsUser.dart';
//
// class MyActivity extends StatefulWidget {
//   const MyActivity({super.key});
//
//   @override
//   State<MyActivity> createState() => _MyActivityState();
// }
//
// class _MyActivityState extends State<MyActivity> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff2f4f8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xfff2f4f8),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.blue),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           "My Activity",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//         actions: [
//
//           Container(
//             margin: const EdgeInsets.only(right: 10),
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             decoration: BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Row(
//               children: [
//                 Icon(Icons.share, size: 16, color: Colors.white),
//                 SizedBox(width: 5),
//                 Text(
//                   "Share App",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: Image.asset("images/notification1.png",height: 30,),
//           ),
//           // onPressed: () {},
//
//           // IconButton(
//           //   icon: const Icon(Icons.notifications, color: Colors.blue),
//
//           // ),
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 60),
//
//             // Title
//             const Text(
//               "Welcome To My Activity",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.center,
//             ),
//
//             const SizedBox(height: 10),
//
//             // Subtitle
//             const Text(
//               "You Can View Applied and saved Jobs, Jobs invite and closed jobs in one place.",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//               textAlign: TextAlign.center,
//             ),
//
//             const SizedBox(height: 20),
//             Center(
//               child: Image.asset(
//                 "images/mergepic1.png",
//                 height: MediaQuery.of(context).size.height * 0.25,
//                 fit: BoxFit.contain,
//               ),
//             ),
//
//             const SizedBox(height: 5),
//
//             // Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 onPressed: () {
//                  Navigator.push(
//                      context, MaterialPageRoute(builder: (context)=>ViewJobsUser()));
//                 },
//                 child: const Text(
//                   "View Jobs",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
