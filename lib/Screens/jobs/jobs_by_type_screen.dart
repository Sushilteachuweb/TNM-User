import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/JobProvider.dart';
import '../../utils/app_colors.dart';
import 'job_full_details.dart';

class JobsByTypeScreen extends StatefulWidget {
  final String jobType;
  final String displayName;

  const JobsByTypeScreen({
    super.key,
    required this.jobType,
    required this.displayName,
  });

  @override
  State<JobsByTypeScreen> createState() => _JobsByTypeScreenState();
}

class _JobsByTypeScreenState extends State<JobsByTypeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch jobs for this type
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JobProvider>().fetchJobsByType(widget.jobType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "${widget.displayName} Jobs",
          style: TextStyle(
            color: AppColors.headingText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.headingText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<JobProvider>(
        builder: (context, jobProvider, child) {
          if (jobProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final typeJobs = jobProvider.jobs.where((job) => 
            job.jobType.toLowerCase().contains(widget.jobType.toLowerCase()) ||
            job.workLocation.toLowerCase().contains(widget.jobType.toLowerCase())
          ).toList();

          if (typeJobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_off,
                    size: 80,
                    color: AppColors.bodyText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No ${widget.displayName.toLowerCase()} jobs found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.headingText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Check back later for new opportunities",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.bodyText,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: typeJobs.length,
            itemBuilder: (context, index) {
              final job = typeJobs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobFullDetails(job: job),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _getJobTypeIcon(widget.jobType),
                              color: AppColors.primary,
                              size: 24,
                            ),
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
                                    fontSize: 14,
                                    color: AppColors.bodyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.bodyText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            job.workLocation,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.bodyText,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              job.jobType,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (job.minSalary > 0 || job.maxSalary > 0) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              job.minSalary > 0 && job.maxSalary > 0
                                  ? "₹${job.minSalary} - ₹${job.maxSalary}"
                                  : job.minSalary > 0
                                      ? "₹${job.minSalary}+"
                                      : "₹${job.maxSalary}",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _getJobTypeIcon(String jobType) {
    switch (jobType.toLowerCase()) {
      case 'full time':
      case 'fulltime':
        return Icons.work;
      case 'part time':
      case 'parttime':
        return Icons.access_time;
      case 'remote':
      case 'work from home':
        return Icons.home_work;
      case 'office':
      case 'work from office':
        return Icons.business;
      case 'internship':
      case 'internships':
        return Icons.school;
      case 'freelance':
        return Icons.laptop_mac;
      case 'contract':
        return Icons.assignment;
      default:
        return Icons.work;
    }
  }
}