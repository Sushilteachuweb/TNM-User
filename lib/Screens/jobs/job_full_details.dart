// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/JobModel.dart';
// import '../provider/AppliedJobsProvider.dart';
//
// class JobFullDetails extends StatefulWidget {
//   final JobModel job;
//   const JobFullDetails({super.key, required this.job});
//
//   @override
//   State<JobFullDetails> createState() => _JobFullDetailsState();
// }
//
// class _JobFullDetailsState extends State<JobFullDetails> {
//   @override
//   Widget build(BuildContext context) {
//     final job = widget.job;
//
//     // ✅ Debug print
//     print("📌 Education: ${job.education}");
//     print("📌 Skills: ${job.skills}");
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.blue),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     onPressed: () {},
//                     icon: const Icon(Icons.share, size: 16, color: Colors.white),
//                     label: const Text("Share", style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title & Company
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(Icons.apartment, size: 40, color: Colors.blue),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(job.title,
//                                   style: const TextStyle(
//                                       fontSize: 18, fontWeight: FontWeight.bold)),
//                               Text(job.companyName,
//                                   style: const TextStyle(color: Colors.grey)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     Text(job.jobType, style: const TextStyle(fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 6),
//                     Text(job.workLocation,
//                         style: const TextStyle(fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 6),
//                     Text("₹${job.minSalary} - ₹${job.maxSalary} / month"),
//                     const SizedBox(height: 6),
//                     Text("${job.experience} Experience"),
//                     const SizedBox(height: 6),
//                     Text("Posted ${job.postedDate}",
//                         style: const TextStyle(color: Colors.grey)),
//                     const SizedBox(height: 10),
//
//                     // Requirement Section
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.blue, width: 1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(Icons.person_pin, size: 20, color: Colors.blue),
//                               SizedBox(width: 6),
//                               Text("Requirement",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 14)),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//
//                           // ✅ Skills from server
//                           _buildInfoBox(
//                             title: "Skills Required :",
//                             content: widget.job.skills.isNotEmpty
//                                 ? widget.job.skills.join(", ")
//                                 : "Not specified",
//                           ),
//                           const SizedBox(height: 8),
//
//                           // ✅ Education from server
//                           _buildInfoBox(
//                             title: "Education :",
//                             content: widget.job.education.isNotEmpty
//                                 ? widget.job.education
//                                 : "Not specified",
//                           ),
//                           const SizedBox(height: 8),
//
//                           // ✅ Description from server
//                           _buildInfoBox(
//                             title: "Job Description :",
//                             content: widget.job.description.isNotEmpty
//                                 ? widget.job.description
//                                 : "Not specified",
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 80),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Bottom Buttons
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               color: Colors.white,
//               child:Row(
//                 children: [
//                   // ✅ Call Now Button
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         final prefs = await SharedPreferences.getInstance();
//                         String? cookie = prefs.getString("cookie");
//                         String? userId = prefs.getString("userId"); // userId fetch karo
//
//                         if (cookie == null || userId == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("User not logged in")),
//                           );
//                           return;
//                         }
//
//                         final provider = Provider.of<AppliedJobsProvider>(context, listen: false);
//                         bool success = await provider.applyJob(
//                           widget.job.id,
//                           cookie,
//                           userId: userId,
//                         );
//
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               success ? "Job Applied Successfully" : "Failed to apply job",
//                             ),
//                           ),
//                         );
//
//                         if (success) {
//                           provider.setTabIndex(2); // MyActivity tab select
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.call, color: Colors.white, size: 20),
//                           SizedBox(width: 8),
//                           Text(
//                             "Call Now",
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(width: 12),
//
//                   // ✅ WhatsApp Button
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         final prefs = await SharedPreferences.getInstance();
//                         String? cookie = prefs.getString("cookie");
//                         String? userId = prefs.getString("userId");
//
//                         if (cookie == null || userId == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("User not logged in")),
//                           );
//                           return;
//                         }
//
//                         final provider = Provider.of<AppliedJobsProvider>(context, listen: false);
//                         bool success = await provider.applyJob(
//                           widget.job.id,
//                           cookie,
//                           userId: userId,
//                         );
//
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               success ? "Job Applied Successfully" : "Failed to apply job",
//                             ),
//                           ),
//                         );
//                         if (success) {
//                           provider.setTabIndex(2);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.greenAccent.shade700,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.message_rounded, color: Colors.white, size: 20),
//                           SizedBox(width: 8),
//                           Text(
//                             "WhatsApp",
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//
//
//
//
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoBox({required String title, required String content}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 13,
//                   color: Colors.black)),
//           const SizedBox(height: 6),
//           Text(content,
//               style: const TextStyle(
//                   fontSize: 13, color: Colors.black87, height: 1.4)),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/job_model.dart';
import '../../providers/AppliedJobsProvider.dart';
import '../../utils/app_colors.dart';
import '../../utils/job_utils.dart';

class JobFullDetails extends StatefulWidget {
  final JobModel job;
  const JobFullDetails({super.key, required this.job});

  @override
  State<JobFullDetails> createState() => _JobFullDetailsState();
}

class _JobFullDetailsState extends State<JobFullDetails> {
  
  void _shareJob() {
    final job = widget.job;
    final String shareText = '''
🔔 Job Opportunity Alert!

📌 Position: ${job.title}
🏢 Company: ${job.companyName}
📍 Location: ${job.workLocation}
💼 Job Type: ${job.jobType}
💰 Salary: ₹${job.minSalary} - ₹${job.maxSalary} / month
📅 Experience: ${job.experience}
🎓 Education: ${job.education.isNotEmpty ? job.education : "Not specified"}
🛠️ Skills: ${job.skills.isNotEmpty ? job.skills.join(", ") : "Not specified"}

📝 Description:
${job.description.isNotEmpty ? job.description : "Not specified"}

Apply now and grab this opportunity! 🚀

Download Naukri Mitra Jobs App for more opportunities!
''';

    Share.share(
      shareText,
      subject: '${job.title} at ${job.companyName}',
    );
  }

  String _formatDate(String dateStr) {
    return JobUtils.formatDate(dateStr);
  }

  String _formatSalary(JobModel job) {
    return JobUtils.formatSalary(job.minSalary, job.maxSalary, job.salaryType);
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Modern App Bar
            _buildAppBar(context),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Hero Section
                    _buildHeroSection(job),
                    
                    // Quick Info Cards
                    _buildQuickInfoCards(job),
                    
                    // Job Details Sections
                    _buildJobDetailsSection(job),
                    
                    // Additional Information
                    _buildAdditionalInfoSection(job),
                    
                    // Perks Section (if available)
                    if (job.perks.isNotEmpty)
                      _buildPerksSection(job.perks),
                    
                    // Bottom Spacing for buttons
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Fixed Bottom Action Buttons
      bottomNavigationBar: _buildBottomActionButtons(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            "Job Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.headingText,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.primary),
            onPressed: _shareJob,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(JobModel job) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.work_outline,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.companyName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Job Type Badge with urgency indicator
          Row(
            children: [
              if (job.jobType.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: JobUtils.getJobTypeColor(job.jobType).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: JobUtils.getJobTypeColor(job.jobType),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    job.jobType.toUpperCase(),
                    style: TextStyle(
                      color: JobUtils.getJobTypeColor(job.jobType),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              
              if (JobUtils.isUrgent(job.jobType, job.description, job.title))
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.flash_on, color: Colors.red, size: 12),
                      SizedBox(width: 4),
                      Text(
                        "URGENT",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoCards(JobModel job) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildInfoCard(
              icon: Icons.location_on_outlined,
              title: "Location",
              value: job.workLocation.isNotEmpty ? job.workLocation : "Not specified",
              color: AppColors.info,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildInfoCard(
              icon: Icons.currency_rupee,
              title: "Salary",
              value: _formatSalary(job),
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildInfoCard(
              icon: Icons.schedule_outlined,
              title: "Posted",
              value: _formatDate(job.postedDate),
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.bodyText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.headingText,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetailsSection(JobModel job) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary, size: 24),
                const SizedBox(width: 12),
                const Text(
                  "Job Requirements",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headingText,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Experience
                if (JobUtils.hasContent(job.experience))
                  _buildDetailRow(
                    icon: Icons.work_history_outlined,
                    title: "Experience Required",
                    value: job.experience,
                    color: JobUtils.getExperienceColor(job.experience),
                  ),
                
                // Education
                if (JobUtils.hasContent(job.education))
                  _buildDetailRow(
                    icon: Icons.school_outlined,
                    title: "Education",
                    value: job.education,
                    color: AppColors.secondary,
                  ),
                
                // Skills
                if (job.skills.isNotEmpty)
                  _buildSkillsSection(job.skills),
                
                // Vacancies
                if (job.vacancies > 0)
                  _buildDetailRow(
                    icon: Icons.people_outline,
                    title: "Openings",
                    value: "${job.vacancies} positions",
                    color: AppColors.success,
                  ),
                
                // Salary Type
                if (JobUtils.hasContent(job.salaryType))
                  _buildDetailRow(
                    icon: Icons.payment_outlined,
                    title: "Salary Type",
                    value: job.salaryType,
                    color: AppColors.warning,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(List<String> skills) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology_outlined, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              const Text(
                "Skills Required",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.headingText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headingText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.bodyText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoSection(JobModel job) {
    final additionalFields = [
      if (JobUtils.hasContent(job.description))
        {"title": "Job Description", "value": job.description, "icon": Icons.description_outlined},
      if (JobUtils.hasContent(job.jobCategory))
        {"title": "Job Category", "value": job.jobCategory, "icon": Icons.category_outlined},
      if (JobUtils.hasContent(job.jobLocation) && job.jobLocation != job.workLocation)
        {"title": "Job Location", "value": job.jobLocation, "icon": Icons.location_city_outlined},
      if (JobUtils.hasContent(job.officeAddress))
        {"title": "Office Address", "value": job.officeAddress, "icon": Icons.business_outlined},
      if (JobUtils.hasContent(job.floorDetails))
        {"title": "Floor Details", "value": job.floorDetails, "icon": Icons.layers_outlined},
      if (JobUtils.hasContent(job.communicationPreference))
        {"title": "Communication", "value": job.communicationPreference, "icon": Icons.chat_outlined},
      if (JobUtils.hasContent(job.englishLevel))
        {"title": "English Level", "value": job.englishLevel, "icon": Icons.language_outlined},
      if (JobUtils.hasContent(job.preferredLocation))
        {"title": "Preferred Location", "value": job.preferredLocation, "icon": Icons.place_outlined},
      if (JobUtils.hasContent(job.gender))
        {"title": "Gender Preference", "value": job.gender, "icon": Icons.person_outline},
      if (JobUtils.hasContent(job.planType))
        {"title": "Plan Type", "value": job.planType, "icon": Icons.card_membership_outlined},
    ];

    if (additionalFields.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.secondary, size: 24),
                const SizedBox(width: 12),
                const Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headingText,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: additionalFields.map((field) => 
                _buildDetailRow(
                  icon: field["icon"] as IconData,
                  title: field["title"] as String,
                  value: field["value"] as String,
                  color: AppColors.secondary,
                )
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerksSection(List<String> perks) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.star_outline, color: AppColors.success, size: 24),
                const SizedBox(width: 12),
                const Text(
                  "Additional Perks & Benefits",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headingText,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: perks.map((perk) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.success.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, 
                      color: AppColors.success, 
                      size: 16
                    ),
                    const SizedBox(width: 6),
                    Text(
                      perk,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Apply Now Button (Primary)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<AppliedJobsProvider>(context, listen: false);
                  String result = await provider.applyJob(widget.job.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result == "success" ? "Job Applied Successfully ✓" : result),
                      backgroundColor: result == "success" ? AppColors.success : AppColors.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );

                  if (result == "success") {
                    provider.setTabIndex(2);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.send_rounded, size: 20),
                    SizedBox(width: 12),
                    Text(
                      "Apply Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Secondary Actions Row
            Row(
              children: [
                // Call HR Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Call HR feature coming soon! 📞"),
                          backgroundColor: AppColors.warning,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call_outlined, color: AppColors.primary, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          "Call HR",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // WhatsApp Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("WhatsApp HR feature coming soon! 💬"),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.success, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_outlined, color: AppColors.success, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          "WhatsApp",
                          style: TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
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
    );
  }
}












// import 'package:flutter/material.dart';
//
// class JobFullDetails extends StatefulWidget {
//   final String title;
//   final String company;
//   final String location;
//   final String salary;
//   final bool urgent;
//   final int vacancies;
//   const JobFullDetails({super.key,
//      required this.title, required this.company,
//     required this.location, required this.salary,
//     required this.urgent, required this.vacancies,
//   });
//
//   @override
//   State<JobFullDetails> createState() => _JobFullDetailsState();
// }
//
// class _JobFullDetailsState extends State<JobFullDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Navigation Row
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.blue),
//                     onPressed: () {
//                       Navigator.pop(context); // 👈 Go back to previous page
//                     },
//                   ),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     onPressed: () {
//                       // Share logic here
//                     },
//                     icon: const Icon(Icons.share, size: 16, color: Colors.white),
//                     label: const Text("Share", style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               )
//
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Job Icon and Title
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(Icons.apartment, size: 40, color: Colors.blue),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               Text(
//                                 "Technical Assistant",
//                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 "Techuweb Private Limited",
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Job Details
//                     const Text("Field Job"),
//                     const SizedBox(height: 6),
//                     const Text(
//                       "H-169, Sector 63, Noida",
//                       style: TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(height: 6),
//                     const Text("10,000 - 15,000 / months"),
//                     const SizedBox(height: 6),
//                     const Text("12 - 48 months Experience in IT / Hardware / Net"),
//                     const SizedBox(height: 6),
//                     const Text("Post 1 day ago", style: TextStyle(color: Colors.grey)),
//                     const SizedBox(height: 10),
//
//                     // Tags
//                     Row(
//                       children: [
//                         _buildTag("New Job", Colors.orange),
//                         const SizedBox(width: 8),
//                         _buildTag("10 Vacancies", Colors.blue),
//                         const SizedBox(width: 8),
//                         _buildTag("Full Time", Colors.deepPurple),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Requirement Section
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.blue, width: 1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(Icons.person_pin, size: 20, color: Colors.blue),
//                               SizedBox(width: 6),
//                               Text(
//                                 "Requirement",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//
//                           // Skills
//                           _buildInfoBox(
//                             title: "Skills Required :",
//                             content: "HTML, CSS, MySQL, React Js, .NET, SQL",
//                           ),
//                           const SizedBox(height: 8),
//
//                           // Degree
//                           _buildInfoBox(
//                             title: "Degree & Specialisation",
//                             content:
//                             "MCA : Computers\nBCA : Computers\nB.Tech : Computers",
//                           ),
//                           const SizedBox(height: 8),
//
//                           // More Skills
//                           _buildInfoBox(
//                             title: "Skills Required :",
//                             content: "HTML, CSS, MySQL, React Js, .NET, SQL",
//                           ),
//                           const SizedBox(height: 8),
//
//                           // Description
//                           _buildInfoBox(
//                             title: "Descriptions:",
//                             content: "HTML, CSS, MySQL, React Js, .NET, SQL",
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 80), // space for bottom buttons
//                   ],
//                 ),
//               ),
//             ),
//
//             // Bottom Buttons
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               color: Colors.white,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 10),
//                       ),
//                       child: const Text("Call Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green.shade700,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: const Text("Whatsapp",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTag(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
//       ),
//     );
//   }
//
//   Widget _buildInfoBox({required String title, required String content}) {
//     return Container(
//
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black)),
//           const SizedBox(height: 6),
//           Text(content,
//               style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4)),
//         ],
//       ),
//     );
//   }
// }
