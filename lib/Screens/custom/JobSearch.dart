import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../jobs/job_full_details.dart';

import '../../models/job_model.dart';
import '../../providers/JobProvider.dart';
import '../../utils/app_colors.dart';
import '../../generated/l10n/app_localizations.dart';

class JobSearch extends StatefulWidget {
  final List<JobModel> jobs;
  const JobSearch({super.key, required this.jobs});

  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  List<JobModel> filteredJobs = [];
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
    
    Future.microtask(() {
      final provider = Provider.of<JobProvider>(context, listen: false);
      provider.fetchJobs().then((_) {
        setState(() {
          filteredJobs = provider.jobs;
        });
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _filterJobs(String query, List<JobModel> allJobs) {
    if (query.isEmpty) {
      setState(() {
        filteredJobs = allJobs;
      });
    } else {
      setState(() {
        filteredJobs = allJobs
            .where((job) =>
                job.title.toLowerCase().contains(query.toLowerCase()) ||
                job.companyName.toLowerCase().contains(query.toLowerCase()) ||
                job.workLocation.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModernHeader(),
              const SizedBox(height: 16),
              _buildJobStats(),
              const SizedBox(height: 20),
              _buildModernSearchBar(jobProvider.jobs),
              const SizedBox(height: 16),
              Expanded(
                child: _buildJobsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Modern Header matching home screen style
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
                    AppLocalizations.of(context).location,
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
          

          
          // Right side - Filter
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

  // Modern Search Bar matching home screen style
  Widget _buildModernSearchBar(List<JobModel> allJobs) {
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
        controller: searchController,
        onChanged: (value) {
          _filterJobs(value, allJobs);
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).searchJobsCompaniesLocations,
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
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[400], size: 18),
                  onPressed: () {
                    searchController.clear();
                    _filterJobs('', allJobs);
                    setState(() {});
                  },
                )
              : Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.mic, color: Colors.white, size: 16),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  // Job Statistics Section
  Widget _buildJobStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${filteredJobs.length} ${AppLocalizations.of(context).jobsFound}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context).findYourPerfectMatch,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.work_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // Modern Jobs List
  Widget _buildJobsList() {
    if (filteredJobs.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredJobs.length,
      itemBuilder: (context, index) {
        final job = filteredJobs[index];
        return _buildModernJobCard(job, index);
      },
    );
  }

  // Modern Job Card matching home screen style
  Widget _buildModernJobCard(JobModel job, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobFullDetails(job: job),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
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
                        job.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingText,
                        ),
                      ),
                    ),
                    if (job.jobType.toLowerCase().contains("urgent"))
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Urgent",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  job.companyName,
                  style: TextStyle(
                    color: AppColors.bodyText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
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
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                      "₹${job.minSalary} - ₹${job.maxSalary}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildModernTag("New Job", AppColors.warning),
                    const SizedBox(width: 8),
                    _buildModernTag("${job.vacancies} Vacancies", AppColors.info),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        AppLocalizations.of(context).applyNow,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Modern Tag Widget
  Widget _buildModernTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.search_off,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "No Jobs Found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.headingText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your search criteria\nor check back later for new opportunities",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.bodyText,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                searchController.clear();
                _filterJobs('', Provider.of<JobProvider>(context, listen: false).jobs);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Clear Search",
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
}





// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/all_job/job_full_details.dart';
// import 'package:naukri_mitra_jobs/filter/filter_row.dart';
//
//
// import '../ model/JobModel.dart';
// import '../provider/JobProvider.dart';
//
// class JobSearch extends StatefulWidget {
//   final List<JobModel> jobs;
//   const JobSearch({super.key, required this.jobs});
//
//   @override
//   State<JobSearch> createState() => _JobSearchState();
// }
//
// class _JobSearchState extends State<JobSearch> {
//   TextEditingController searchController = TextEditingController();
//   List<JobModel> filteredJobs = [];
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       final provider = Provider.of<JobProvider>(context, listen: false);
//       provider.fetchJobs().then((_) {
//         setState(() {
//           filteredJobs = provider.jobs;
//         });
//       });
//     });
//   }
//
//   void _filterJobs(String query, List<JobModel> allJobs) {
//     if (query.isEmpty) {
//       setState(() {
//         filteredJobs = allJobs;
//       });
//     } else {
//       setState(() {
//         filteredJobs = allJobs
//             .where((job) =>
//         job.title.toLowerCase().contains(query.toLowerCase()) ||
//             job.companyName.toLowerCase().contains(query.toLowerCase()) ||
//             job.workLocation.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final jobProvider = Provider.of<JobProvider>(context);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFE7EAF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 12),
//               _buildSearchBar(jobProvider.jobs),
//               const SizedBox(height: 12),
//               const FilterRow(),
//               const SizedBox(height: 8),
//
//               // ---------------- API Job List ----------------
//               Expanded(
//                 child: filteredJobs.isEmpty
//                     ? const Center(child: Text("No jobs available"))
//                     : ListView.builder(
//                   itemCount: filteredJobs.length,
//                   itemBuilder: (context, index) {
//                     final job = filteredJobs[index];
//                     return _buildJobCard(
//                       context,
//                       title: job.title,
//                       company: job.companyName,
//                       location: job.workLocation,
//                       salary: "₹${job.minSalary} - ₹${job.maxSalary}",
//                       urgent: job.jobType.toLowerCase().contains("urgent"),
//                       vacancies: 5,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ---------------- HEADER ----------------
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         const Icon(Icons.location_on, color: Colors.blue),
//         const SizedBox(width: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Noida",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             Text(
//               "Sector 62",
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ],
//         ),
//         const Spacer(),
//         Image.asset(
//           "images/logo3.png",
//           height: 30,
//         ),
//         const Spacer(),
//         Padding(
//           padding: const EdgeInsets.only(
//             right: 8.0,
//           ),
//           child: Image.asset(
//             'images/arrow2.png',
//             height: 25,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ---------------- SEARCH BAR ----------------
//   Widget _buildSearchBar(List<JobModel> allJobs) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         gradient: const LinearGradient(
//           colors: [Color(0xFF8E9EFD), Color(0xFF4A64FE)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: TextField(
//         controller: searchController,
//         onChanged: (value) => _filterJobs(value, allJobs), // 🔹 filter call
//         decoration: const InputDecoration(
//           hintText: "Search Job",
//           hintStyle: TextStyle(color: Colors.white),
//           prefixIcon: Icon(Icons.search, color: Colors.white),
//           border: InputBorder.none,
//         ),
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }
//
//   // ---------------- JOB CARD ----------------
//   Widget _buildJobCard(
//       BuildContext context, {
//         required String title,
//         required String company,
//         required String location,
//         required String salary,
//         required bool urgent,
//         required int vacancies,
//       }) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => JobFullDetails(
//               title: title,
//               company: company,
//               location: location,
//               salary: salary,
//               urgent: urgent,
//               vacancies: vacancies,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 4,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 if (urgent)
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Text(
//                       "Urgent Hiring",
//                       style: TextStyle(color: Colors.blue, fontSize: 10),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(company, style: const TextStyle(fontSize: 12)),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 14, color: Colors.blue),
//                 const SizedBox(width: 4),
//                 Text(location, style: const TextStyle(fontSize: 12)),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text(
//               salary,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 _buildTag("New Job", Colors.orange),
//                 const SizedBox(width: 6),
//                 _buildTag("$vacancies Vacancies", Colors.orange),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTag(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 10, color: color),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/all_job/job_full_details.dart';
//
// import 'package:naukri_mitra_jobs/filter/filter_row.dart';
//
// import '../ model/JobModel.dart';
// import '../provider/JobProvider.dart';
// class JobSearch extends StatefulWidget {
//   final List<JobModel> jobs;
//   const JobSearch({super.key, required this.jobs});
//
//   @override
//   State<JobSearch> createState() => _JobSearchState();
// }
//
// class _JobSearchState extends State<JobSearch> {
//   @override
//   void initState() {
//     super.initState();
//
//     Future.microtask(() {
//       Provider.of<JobProvider>(context, listen: false).fetchJobs();
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final jobProvider = Provider.of<JobProvider>(context);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFE7EAF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 12),
//               _buildSearchBar(),
//               const SizedBox(height: 12),
//               const FilterRow(),
//               const SizedBox(height: 8),
//
//               // ---------------- API Job List ----------------
//               Expanded(
//                 child: jobProvider.jobs.isEmpty
//                     ? const Center(child: Text("No jobs available"))
//                     : ListView.builder(
//                   itemCount: jobProvider.jobs.length,
//                   itemBuilder: (context, index) {
//                     final job = jobProvider.jobs[index];
//                     return _buildJobCard(
//                       context,
//                       title: job.title,
//                       company: job.companyName,
//                       location: job.workLocation,
//                       salary: "₹${job.minSalary} - ₹${job.maxSalary}",
//                       urgent: job.jobType.toLowerCase().contains("urgent"),
//                       vacancies: 5,
//                     );
//                   },
//                 ),
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ---------------- HEADER ----------------
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         const Icon(Icons.location_on, color: Colors.blue),
//         const SizedBox(width: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Noida",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             Text(
//               "Sector 62",
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ],
//         ),
//         const Spacer(),
//         Image.asset(
//           "images/logo3.png",
//           height: 30,
//         ),
//         const Spacer(),
//         Padding(
//           padding: const EdgeInsets.only(
//             right: 8.0,
//           ),
//           child: Image.asset(
//             'images/arrow2.png',
//             height: 25,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ---------------- SEARCH BAR ----------------
//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         gradient: const LinearGradient(
//           colors: [Color(0xFF8E9EFD), Color(0xFF4A64FE)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: "Search Job",
//           hintStyle: TextStyle(color: Colors.white),
//           prefixIcon: Icon(Icons.search, color: Colors.white),
//           border: InputBorder.none,
//         ),
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
//
//   // ---------------- JOB CARD ----------------
//   Widget _buildJobCard(
//       BuildContext context, {
//         required String title,
//         required String company,
//         required String location,
//         required String salary,
//         required bool urgent,
//         required int vacancies,
//       }) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => JobFullDetails(
//               title: title,
//               company: company,
//               location: location,
//               salary: salary,
//               urgent: urgent,
//               vacancies: vacancies,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 4,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 if (urgent)
//                   Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Text(
//                       "Urgent Hiring",
//                       style: TextStyle(color: Colors.blue, fontSize: 10),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(company, style: const TextStyle(fontSize: 12)),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 14, color: Colors.blue),
//                 const SizedBox(width: 4),
//                 Text(location, style: const TextStyle(fontSize: 12)),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text(
//               salary,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 _buildTag("New Job", Colors.orange),
//                 const SizedBox(width: 6),
//                 _buildTag("$vacancies Vacancies", Colors.orange),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTag(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 10, color: color),
//       ),
//     );
//   }
// }
//
















// bina APi se data aaye
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/all_job/job_full_details.dart';
// import 'package:naukri_mitra_jobs/custom/custom_buttom_nav.dart';
// import 'package:naukri_mitra_jobs/filter/filter_row.dart';
//
// import '../ model/JobModel.dart';
//
// class JobSearch extends StatefulWidget {
//   final List<JobModel> jobs;
//   const JobSearch({super.key,  required this.jobs});
//
//   @override
//   State<JobSearch> createState() => _JobSearchState();
// }
// class _JobSearchState extends State<JobSearch> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE7EAF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0,right: 8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 12),
//               _buildSearchBar(),
//               const SizedBox(height: 12),
//
//               const FilterRow(),
//               const SizedBox(height: 8),
//
//
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       _buildJobCard(
//                         context,
//                         title: "PHP Laravel Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 10,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),_buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Office Boy",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ---------------- HEADER ----------------
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         const Icon(Icons.location_on, color: Colors.blue),
//         const SizedBox(width: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Noida",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             Text(
//               "Sector 62",
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ],
//         ),
//         const Spacer(),
//         Image.asset(
//           "images/logo3.png",
//           height: 30,
//         ),
//         const Spacer(),
//         Padding(
//           padding: const EdgeInsets.only(right: 8.0,),
//           child: Image.asset(
//             'images/arrow2.png',
//             height: 25,
//           ),
//
//         ),
//
//       ],
//     );
//   }
//   // ---------------- SEARCH BAR ----------------
//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         gradient: const LinearGradient(
//           colors: [Color(0xFF8E9EFD), Color(0xFF4A64FE)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: "Search Job",
//           hintStyle: TextStyle(color: Colors.white),
//           prefixIcon: Icon(Icons.search, color: Colors.white),
//           border: InputBorder.none,
//         ),
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
//
//   // ---------------- FILTER ROW ----------------
//
//
//
//   // ---------------- JOB CARD ----------------
//   Widget _buildJobCard(
//       BuildContext context, {
//         required String title,
//         required String company,
//         required String location,
//         required String salary,
//         required bool urgent,
//         required int vacancies,
//       }) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => JobFullDetails(
//               title: title,
//               company: company,
//               location: location,
//               salary: salary,
//               urgent: urgent,
//               vacancies: vacancies,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 4,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//
//                 if (urgent)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Text(
//                       "Urgent Hiring",
//                       style: TextStyle(color: Colors.blue, fontSize: 10),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(company, style: const TextStyle(fontSize: 12)),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 14, color: Colors.blue),
//                 const SizedBox(width: 4),
//                 Text(location, style: const TextStyle(fontSize: 12)),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text(
//               salary,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 _buildTag("New Job", Colors.orange),
//                 const SizedBox(width: 6),
//                 _buildTag("$vacancies Vacancies", Colors.orange),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTag(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 10, color: color),
//       ),
//     );
//   }
// }
//







// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/all_job/job_full_details.dart';
// import 'package:naukri_mitra_jobs/custom/custom_buttom_nav.dart';
// import 'package:naukri_mitra_jobs/filter/filter_row.dart';
//
// class JobSearch extends StatefulWidget {
//   const JobSearch({super.key});
//
//   @override
//   State<JobSearch> createState() => _JobSearchState();
// }
// class _JobSearchState extends State<JobSearch> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE7EAF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0,right: 8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 12),
//               _buildSearchBar(),
//               const SizedBox(height: 12),
//
//               const FilterRow(),
//               const SizedBox(height: 8),
//
//               // Scrollable Job Cards
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       _buildJobCard(
//                         context,
//                         title: "PHP Laravel Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 10,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),_buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Backend Developer",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 8,
//                       ),
//                       _buildJobCard(
//                         context,
//                         title: "Office Boy",
//                         company: "Techuweb pvt ltd",
//                         location: "Noida, Sector 63",
//                         salary: "₹ 10000 - 150000",
//                         urgent: true,
//                         vacancies: 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ---------------- HEADER ----------------
//   Widget _buildHeader() {
//     return Row(
//       children: [
//         const Icon(Icons.location_on, color: Colors.blue),
//         const SizedBox(width: 4),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Noida",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             Text(
//               "Sector 62",
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ],
//         ),
//         const Spacer(),
//         Image.asset(
//           "images/logo3.png",
//           height: 30,
//         ),
//         const Spacer(),
//         Padding(
//           padding: const EdgeInsets.only(right: 8.0,),
//           child: Image.asset(
//             'images/arrow2.png',
//             height: 25,
//           ),
//
//         ),
//
//       ],
//     );
//   }
//   // ---------------- SEARCH BAR ----------------
//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         gradient: const LinearGradient(
//           colors: [Color(0xFF8E9EFD), Color(0xFF4A64FE)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: "Search Job",
//           hintStyle: TextStyle(color: Colors.white),
//           prefixIcon: Icon(Icons.search, color: Colors.white),
//           border: InputBorder.none,
//         ),
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
//
//   // ---------------- FILTER ROW ----------------
//
//
//
//   // ---------------- JOB CARD ----------------
//   Widget _buildJobCard(
//       BuildContext context, {
//         required String title,
//         required String company,
//         required String location,
//         required String salary,
//         required bool urgent,
//         required int vacancies,
//       }) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => JobFullDetails(
//               title: title,
//               company: company,
//               location: location,
//               salary: salary,
//               urgent: urgent,
//               vacancies: vacancies,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: double.infinity,
//
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade200,
//               blurRadius: 4,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//
//                 if (urgent)
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Text(
//                       "Urgent Hiring",
//                       style: TextStyle(color: Colors.blue, fontSize: 10),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(company, style: const TextStyle(fontSize: 12)),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 14, color: Colors.blue),
//                 const SizedBox(width: 4),
//                 Text(location, style: const TextStyle(fontSize: 12)),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text(
//               salary,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 _buildTag("New Job", Colors.orange),
//                 const SizedBox(width: 6),
//                 _buildTag("$vacancies Vacancies", Colors.orange),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTag(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 10, color: color),
//       ),
//     );
//   }
// }
//
