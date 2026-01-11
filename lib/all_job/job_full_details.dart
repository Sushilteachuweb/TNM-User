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



// working hai 09-09-2025
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../model/JobModel.dart';
import '../provider/AppliedJobsProvider.dart';

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
''';

    Share.share(
      shareText,
      subject: '${job.title} at ${job.companyName}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;

    // ✅ Debug print
    print("📌 Education: ${job.education}");
    print("📌 Skills: ${job.skills}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      _shareJob();
                    },
                    icon: const Icon(Icons.share, size: 16, color: Colors.white),
                    label: const Text("Share", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Company
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.apartment, size: 40, color: Colors.blue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(job.title,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(job.companyName,
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Text(job.jobType, style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(job.workLocation,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text("₹${job.minSalary} - ₹${job.maxSalary} / month"),
                    const SizedBox(height: 6),
                    Text("${job.experience} Experience"),
                    const SizedBox(height: 6),
                    Text("Posted ${job.postedDate}",
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 10),

                    // Requirement Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.person_pin, size: 20, color: Colors.blue),
                              SizedBox(width: 6),
                              Text("Requirement",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // ✅ Skills from server
                          _buildInfoBox(
                            title: "Skills Required :",
                            content: widget.job.skills.isNotEmpty
                                ? widget.job.skills.join(", ")
                                : "Not specified",
                          ),
                          const SizedBox(height: 8),

                          // ✅ Education from server
                          _buildInfoBox(
                            title: "Education :",
                            content: widget.job.education.isNotEmpty
                                ? widget.job.education
                                : "Not specified",
                          ),
                          const SizedBox(height: 8),

                          // ✅ Description from server
                          _buildInfoBox(
                            title: "Job Description :",
                            content: widget.job.description.isNotEmpty
                                ? widget.job.description
                                : "Not specified",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Column(
                children: [
                  // Apply Now Button (Full Width)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final provider = Provider.of<AppliedJobsProvider>(context, listen: false);
                        String result = await provider.applyJob(widget.job.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result == "success" ? "Job Applied Successfully ✓" : result),
                            backgroundColor: result == "success" ? Colors.green : Colors.red,
                          ),
                        );

                        if (result == "success") {
                          provider.setTabIndex(2);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_circle, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Apply Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Call and WhatsApp Row - Coming Soon
                  Row(
                    children: [
                      // Call HR Button - Coming Soon
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Call HR feature coming soon! 📞"),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade400, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.call, color: Colors.grey.shade600, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                "Call HR",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Soon",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // WhatsApp Button - Coming Soon
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("WhatsApp HR feature coming soon! 💬"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade400, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.message_rounded, color: Colors.grey.shade600, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                "WhatsApp",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Soon",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w600,
                                  ),
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
      ),
    );
  }

  Widget _buildInfoBox({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black)),
          const SizedBox(height: 6),
          Text(content,
              style: const TextStyle(
                  fontSize: 13, color: Colors.black87, height: 1.4)),
        ],
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
