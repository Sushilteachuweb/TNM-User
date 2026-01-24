









//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../UpdateProfileScreen/UpdateProfileScreen.dart';
// import '../provider/ProfileProvider.dart';
// import 'Setting_Screen.dart';
// import 'resume_service.dart';
// import 'bottom_sheet_helper.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? resumeFilePath;
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch profile after first frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//     final profile = provider.user;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.share, color: Colors.white, size: 18),
//               label: const Text(
//                 "Share App",
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.black),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const SettingScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Profile Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xfff0f3ff),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 35,
//                     backgroundColor: Colors.grey,
//                     backgroundImage: profile?.image != null
//                         ? NetworkImage(profile!.image!)
//                         : null,
//                     child: profile?.image == null
//                         ? const Icon(Icons.person, size: 45, color: Colors.white)
//                         : null,
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           profile?.fullName ?? "User Name",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             const Icon(Icons.location_on, size: 14, color: Colors.blue),
//                             const SizedBox(width: 4),
//                             Text(
//                               profile?.userLocation ?? "Not Provided",
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const Icon(Icons.phone, size: 14, color: Colors.blue),
//                             const SizedBox(width: 4),
//                             Text(
//                               profile?.phone ?? "Not Provided",
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const Icon(Icons.work, size: 14, color: Colors.blue),
//                             const SizedBox(width: 4),
//                             Text(
//                               profile?.jobCategory ?? "Not Provided",
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                         ),
//                         builder: (context) => Padding(
//                           padding: EdgeInsets.only(
//                             bottom: MediaQuery.of(context).viewInsets.bottom,
//                           ),
//                           child: UpdateProfileSheet(
//                             fullName: profile?.fullName ?? "",
//                             email: profile?.email ?? "",
//                             gender: profile?.gender ?? "",
//                             education: profile?.education ?? "",
//                           ),
//                         ),
//                       ).then((_) {
//                         Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             // Work Experience
//             _buildCard(
//               title: "Work Experience",
//               trailing: "Add New",
//               content: [
//                 _ListItem(
//                   icon: Icons.work,
//                   value: profile?.isExperienced == true
//                       ? "${profile?.totalExperience} Years"
//                       : "Fresher",
//                 ),
//               ],
//             ),
//
//             // Personal Information
//             _buildCard(
//               title: "Personal Information",
//               editable: true,
//               content: [
//                 _InfoRow(
//                   label: "Email",
//                   value: profile?.email ?? "Not Provided",
//                 ),
//                 _InfoRow(
//                   label: "Gender",
//                   value: profile?.gender ?? "Not Provided",
//                 ),
//                 _InfoRow(
//                   label: "Education Level",
//                   value: profile?.education ?? "Not Provided",
//                 ),
//               ],
//             ),
//
//             // Language
//             _buildCard(
//               title: "Language",
//               content: (profile?.language ?? [])
//                   .map((lang) => _ListItem(value: lang))
//                   .toList(),
//             ),
//
//             // Skills
//             _buildCard(
//               title: "Skills",
//               editable: true,
//               onEdit: () async {
//                 final updatedSkills = await BottomSheetHelper.showSkillsSelector(
//                   context: context,
//                   currentSkills: profile?.skills ?? [],
//                 );
//                 if (updatedSkills != null) {
//                   setState(() {
//                     profile?.skills = updatedSkills;
//                   });
//                 }
//               },
//               content: (profile?.skills ?? []).map((s) => _ListItem(value: s)).toList(),
//             ),
//
//             // Resume
//             _buildCard(
//               title: "Resume",
//               editable: true,
//               onEdit: () async {
//                 final filePath = await ResumeService.pickResume(context);
//                 if (filePath != null) {
//                   setState(() {
//                     resumeFilePath = filePath;
//                   });
//                 }
//               },
//               content: [
//                 _ListItem(
//                   value: profile?.resume != null
//                       ? profile!.resume!.split('/').last
//                       : "Add Resume",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     List<Widget> content = const [],
//     bool editable = false,
//     String? trailing,
//     VoidCallback? onEdit,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               if (trailing != null)
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     trailing,
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               if (editable)
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                   onPressed: onEdit,
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ...content,
//         ],
//       ),
//     );
//   }
// }
//
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//
//   const _InfoRow({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ListItem extends StatelessWidget {
//   final IconData? icon;
//   final String? text;
//   final String? value;
//
//   const _ListItem({this.icon, this.text, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Icon(icon, size: 16, color: Colors.blue)
//           else
//             const SizedBox(width: 16),
//           if (icon != null) const SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               text != null ? (value != null ? "$text: $value" : text!) : value ?? "",
//               style: const TextStyle(fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//







//29-09-2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/l10n/app_localizations.dart';
import '../profile/UpdateProfileScreen.dart';
import '../../providers/ProfileProvider.dart';
import '../../utils/app_colors.dart';
import '../../utils/image_helper.dart';
import 'Setting_Screen.dart';
import 'resume_service.dart';
import 'bottom_sheet_helper.dart';
import '../help/help_screen.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key,});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  String? resumeFilePath;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    // ✅ FIX: Call fetchProfile after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("🔄 ProfileScreen: Fetching profile on init");
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    });
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ✅ Refresh profile when returning to this screen, but avoid infinite loops
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    
    // Only fetch if user is null AND we don't have a session error AND not already loading
    if (provider.user == null && !provider.hasSessionError && !provider.isLoading) {
      print("🔄 ProfileScreen: Refreshing profile (user is null, no session error)");
      // ✅ FIX: Defer fetchProfile call to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !provider.hasSessionError) {
          provider.fetchProfile();
        }
      });
    } else if (provider.hasSessionError) {
      print("⚠️ ProfileScreen: Session error detected, not fetching profile");
    } else if (provider.isLoading) {
      print("⏳ ProfileScreen: Profile fetch already in progress");
    }
  }

  // Helper to build profile image with error handling
  Widget _buildProfileImage(String? imageUrl) {
    print("🖼️ _buildProfileImage called with: $imageUrl");
    
    if (imageUrl == null || imageUrl.isEmpty) {
      print("⚠️ No image URL provided, showing default icon");
      return const Icon(Icons.person, size: 45, color: Colors.white);
    }

    // ✅ Use ImageHelper to get full URL
    final fullImageUrl = ImageHelper.getFullImageUrl(imageUrl);
    print("🖼️ Full image URL: $fullImageUrl");

    return Image.network(
      fullImageUrl,
      fit: BoxFit.cover,
      width: 70,
      height: 70,
      errorBuilder: (context, error, stackTrace) {
        print("❌ Error loading image from: $fullImageUrl");
        print("❌ Error: $error");
        return const Icon(Icons.person, size: 45, color: Colors.white);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          print("✅ Image loaded successfully");
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final profile = provider.user;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 60,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildModernHeader(context, profile),
                      _buildProfileWelcomeSection(profile),
                      const SizedBox(height: 20),
                      _buildWorkExperienceSection(profile),
                      const SizedBox(height: 20),
                      _buildPersonalInfoSection(profile),
                      const SizedBox(height: 20),
                      _buildAdditionalInfoSection(profile),
                      const SizedBox(height: 20),
                      _buildLanguagesSection(),
                      const SizedBox(height: 20),
                      _buildSkillsSection(),
                      const SizedBox(height: 20),
                      _buildResumeSection(profile),
                      const SizedBox(height: 20),
                      _buildHelpSection(),
                      const SizedBox(height: 20),
                      _buildRatingSection(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // Modern Header matching home screen style
  Widget _buildModernHeader(BuildContext context, dynamic profile) {
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
          // Left side - Back or Menu
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Icon(Icons.person_outline, color: AppColors.primary, size: 18),
            ),
          ),
          
          // Center - Title
          Align(
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.myProfile,
              style: TextStyle(
                color: AppColors.headingText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Right side - Settings
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Icon(Icons.settings_outlined, color: AppColors.primary, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Profile Welcome Section matching home screen style
  Widget _buildProfileWelcomeSection(dynamic profile) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(20),
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
          // Profile Image with edit button
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 3),
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.background,
                  child: ClipOval(
                    child: _buildProfileImage(profile?.image),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: UpdateProfileSheet(
                          fullName: profile?.fullName ?? "",
                          email: profile?.email ?? "",
                          gender: profile?.gender ?? "",
                          education: profile?.education ?? "",
                        ),
                      ),
                    ).then((_) {
                      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.edit, size: 16, color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            profile?.fullName ?? AppLocalizations.of(context)!.guestUser,
            style: TextStyle(
              color: AppColors.headingText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile?.jobCategory ?? AppLocalizations.of(context)!.jobSeeker,
            style: TextStyle(
              color: AppColors.bodyText,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileStat(Icons.phone, profile?.phone ?? "N/A"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Work Experience Section
  Widget _buildWorkExperienceSection(dynamic profile) {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context)!.workExperience, "", AppColors.primary, null),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildModernCard(
            icon: Icons.business_center,
            title: AppLocalizations.of(context)!.experience,
            subtitle: profile?.isExperienced == true
                ? "${profile?.totalExperience} ${AppLocalizations.of(context)!.years}"
                : AppLocalizations.of(context)!.fresher,
            color: AppColors.primary,
            isUrgent: profile?.isExperienced == true,
          ),
        ),
      ],
    );
  }

  // Personal Information Section
  Widget _buildPersonalInfoSection(dynamic profile) {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context)!.personalInformation, "", AppColors.secondary, null),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
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
            children: [
              _buildInfoRow(Icons.email_outlined, AppLocalizations.of(context)!.email, profile?.email ?? AppLocalizations.of(context)!.notProvided),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.person_outline, AppLocalizations.of(context)!.gender, profile?.gender ?? AppLocalizations.of(context)!.notProvided),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.school_outlined, AppLocalizations.of(context)!.educationLevel, profile?.education ?? AppLocalizations.of(context)!.notProvided),
            ],
          ),
        ),
      ],
    );
  }

  // Additional Information Section (Salary, Location, etc.)
  Widget _buildAdditionalInfoSection(dynamic profile) {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context)!.additionalInformation, "", AppColors.warning, null),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
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
            children: [
              if (profile?.currentSalary != null)
                _buildInfoRow(Icons.currency_rupee_outlined, AppLocalizations.of(context)!.currentSalary, "₹${profile!.currentSalary}"),
              if (profile?.currentSalary != null && profile?.userLocation != null)
                const SizedBox(height: 12),
              if (profile?.userLocation != null)
                _buildInfoRow(Icons.location_on_outlined, AppLocalizations.of(context)!.location, profile!.userLocation!),
              if (profile?.currentSalary == null && profile?.userLocation == null)
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.noDataFound,
                    style: TextStyle(
                      color: AppColors.bodyText,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // Languages Section
  Widget _buildLanguagesSection() {
    final provider = Provider.of<ProfileProvider>(context);
    final profile = provider.user;
    
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context)!.languages, "", AppColors.info, null),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
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
          child: profile?.language != null && profile!.language!.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: profile.language!.map((lang) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.language, color: AppColors.info, size: 16),
                        const SizedBox(width: 12),
                        Text(
                          lang,
                          style: TextStyle(
                            color: AppColors.headingText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                )
              : Center(
                  child: Text(
                    AppLocalizations.of(context)!.noDataFound,
                    style: TextStyle(
                      color: AppColors.bodyText,
                      fontSize: 14,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  // Skills Section
  Widget _buildSkillsSection() {
    final provider = Provider.of<ProfileProvider>(context);
    final profile = provider.user;
    
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context)!.skills, "", AppColors.success, null),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
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
          child: profile?.skills != null && profile!.skills!.isNotEmpty && profile.skills!.any((skill) => skill.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: profile.skills!.where((skill) => skill.isNotEmpty).map((skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: AppColors.success, size: 16),
                        const SizedBox(width: 12),
                        Text(
                          skill,
                          style: TextStyle(
                            color: AppColors.headingText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                )
              : Center(
                  child: Text(
                    AppLocalizations.of(context)!.noDataFound,
                    style: TextStyle(
                      color: AppColors.bodyText,
                      fontSize: 14,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  // Resume Section
  Widget _buildResumeSection(dynamic profile) {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context)!.resume, AppLocalizations.of(context)!.update, AppColors.warning, () async {
          final filePath = await ResumeService.pickResume(context);
          if (filePath != null) {
            setState(() {
              resumeFilePath = filePath;
            });
          }
        }),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: _ResumeItem(
            resumeUrl: profile?.resume,
            localPath: resumeFilePath,
          ),
        ),
      ],
    );
  }

  // Help Section
  Widget _buildHelpSection() {
    return Column(
      children: [
        _buildSectionHeader("Help & Support", "", AppColors.info, null),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildModernCard(
            icon: Icons.help_outline,
            title: "Help & Support",
            subtitle: "Get assistance and support",
            color: AppColors.info,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  // Rating Section matching home screen
  Widget _buildRatingSection() {
    return Column(
      children: [
        _buildSectionHeader(AppLocalizations.of(context)!.rateYourExperience, "", Colors.purple, null),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: _ModernRatingWidget(),
        ),
      ],
    );
  }

  // Helper Methods

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

  Widget _buildModernCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    bool isUrgent = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.headingText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.bodyText,
                    ),
                  ),
                ],
              ),
            ),
          if (isUrgent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                AppLocalizations.of(context)!.active,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.bodyText,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.headingText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResumeItem extends StatelessWidget {
  final String? resumeUrl;
  final String? localPath;

  const _ResumeItem({this.resumeUrl, this.localPath});

  String _getResumeFileName(BuildContext context) {
    if (resumeUrl != null && resumeUrl!.isNotEmpty) {
      return resumeUrl!.split('/').last;
    }
    if (localPath != null && localPath!.isNotEmpty) {
      return localPath!.split('/').last;
    }
    return AppLocalizations.of(context)!.noResumeUploaded;
  }

  Future<void> _openResume(BuildContext context) async {
    if (resumeUrl == null || resumeUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noResumeAvailable),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final fullUrl = ImageHelper.getFullImageUrl(resumeUrl!);
      print("📄 Opening resume from: $fullUrl");
      
      final uri = Uri.parse(fullUrl);
      
      // Try to launch the URL
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // Opens in browser or PDF viewer
        );
        print("✅ Resume opened successfully");
      } else {
        print("❌ Cannot launch URL: $fullUrl");
        // Show dialog with URL as fallback
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.resumeUrl),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.copyUrlToBrowser),
                  const SizedBox(height: 8),
                  SelectableText(
                    fullUrl,
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.close),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      print("❌ Error opening resume: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${AppLocalizations.of(context)!.errorOpeningResume}: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasResume = resumeUrl != null && resumeUrl!.isNotEmpty;
    
    return InkWell(
      onTap: hasResume ? () => _openResume(context) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: hasResume ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasResume ? Colors.blue.shade200 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              hasResume ? Icons.description : Icons.upload_file,
              size: 20,
              color: hasResume ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getResumeFileName(context),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: hasResume ? Colors.black87 : Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (hasResume)
                    Text(
                      AppLocalizations.of(context)!.tapToView,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
            ),
            if (hasResume)
              const Icon(
                Icons.open_in_new,
                size: 18,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}

// Modern Rating Widget matching home screen style
class _ModernRatingWidget extends StatefulWidget {
  @override
  State<_ModernRatingWidget> createState() => _ModernRatingWidgetState();
}

class _ModernRatingWidgetState extends State<_ModernRatingWidget> with TickerProviderStateMixin {
  int _rating = 0;
  bool _submitted = false;
  bool _isSubmitting = false;
  bool _alreadyRated = false;
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
    
    // Check if user has already rated
    _checkRatingStatus();
  }

  void _checkRatingStatus() async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    final hasRated = await provider.hasUserRated();
    
    if (mounted && hasRated) {
      setState(() {
        _alreadyRated = true;
      });
    }
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
                Text(
                  AppLocalizations.of(context)!.thankYou,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.appreciateFeedback,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : _alreadyRated
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Already Rated",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You have already submitted your rating. Thank you for your feedback!",
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
                  AppLocalizations.of(context)!.howWasProfileExperience,
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
                      onPressed: _isSubmitting ? null : () async {
                        setState(() {
                          _isSubmitting = true;
                        });
                        
                        // Call the rating API
                        final provider = Provider.of<ProfileProvider>(context, listen: false);
                        final result = await provider.submitRating(_rating);
                        
                        setState(() {
                          _isSubmitting = false;
                        });
                        
                        if (result["success"] == true) {
                          setState(() {
                            _submitted = true;
                          });
                          _animationController.forward();
                          
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Rating submitted successfully! Thank you for your feedback.'),
                              backgroundColor: AppColors.success,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else if (result["alreadyRated"] == true) {
                          // User has already submitted a rating
                          setState(() {
                            _alreadyRated = true;
                          });
                          
                          // Show info message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result["message"] ?? 'You have already submitted a rating.'),
                              backgroundColor: Colors.orange,
                              duration: Duration(seconds: 4),
                            ),
                          );
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result["message"] ?? 'Failed to submit rating. Please try again.'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
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
                      child: _isSubmitting
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.submitRating,
                              style: const TextStyle(
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































// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// import 'Setting_Screen.dart';
// import 'resume_service.dart';
// import 'bottom_sheet_helper.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? resumeFilePath;
//   List<String> skills = ["PHP", "Dart", "Flutter"];
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//     final user = provider.user;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.share, color: Colors.white, size: 18),
//               label: const Text(
//                 "Share App",
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.black),
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => SettingScreen()));
//             },
//           ),
//         ],
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Profile Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xfff0f3ff),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 35,
//                     backgroundColor: Colors.grey,
//                     backgroundImage: user?.image != null
//                         ? NetworkImage(user!.image!)
//                         : null,
//                     child: user?.image == null
//                         ? const Icon(Icons.person,
//                         size: 40, color: Colors.white)
//                         : null,
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           user?.fullName ?? "User Name",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             const Icon(Icons.phone,
//                                 size: 14, color: Colors.blue),
//                             const SizedBox(width: 4),
//                             Text(user?.phone ?? "phone",
//                                 style: const TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             const Icon(Icons.work,
//                                 size: 14, color: Colors.blue),
//                             const SizedBox(width: 4),
//                             Text(user?.jobCategory ??
//                                 "Flutter Developer",
//                                 style: const TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.edit,
//                         color: Colors.blue, size: 18),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             _buildCard(
//               title: "Work Experience",
//               trailing: "Add New",
//               content: [
//                 _ListItem(
//                     icon: Icons.work,
//                     value: user?.isExperienced == true
//                         ? "${user?.totalExperience} Years"
//                         : "Fresher"),
//               ],
//             ),
//
//             _buildCard(
//               title: "Personal Information",
//               editable: true,
//               content: [
//                 _InfoRow(
//                     label: "Email",
//                     value: user?.email ?? "codingwalle@gmail.com"),
//                 _InfoRow(
//                     label: "Gender",
//                     value: user?.gender ?? "Gender"),
//                 _InfoRow(
//                     label: "Education Level",
//                     value: user?.education ?? "Education"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     List<Widget> content = const [],
//     bool editable = false,
//     String? trailing,
//     VoidCallback? onEdit,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               if (trailing != null)
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     trailing,
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               if (editable)
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                   onPressed: onEdit,
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ...content,
//         ],
//       ),
//     );
//   }
// }
//
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//
//   const _InfoRow({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ListItem extends StatelessWidget {
//   final IconData? icon;
//   final String? text;
//   final String? value;
//
//   const _ListItem({this.icon, this.text, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Icon(icon, size: 16, color: Colors.blue)
//           else
//             const SizedBox(width: 16),
//           if (icon != null) const SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               text != null
//                   ? (value != null ? "$text: $value" : text!)
//                   : value ?? "",
//               style: const TextStyle(fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//



//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'Setting_Screen.dart';
// import 'resume_service.dart';
// import 'bottom_sheet_helper.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? resumeFilePath;
//   List<String> skills = ["PHP", "Dart", "Flutter"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.share, color: Colors.white, size: 18),
//               label: const Text(
//                 "Share App",
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.black),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Profile Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xfff0f3ff),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const CircleAvatar(
//                     radius: 35,
//                     backgroundColor: Colors.grey,
//                     child: Icon(Icons.person, size: 40, color: Colors.white),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Asif Ali Khan",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.location_on,
//                                 size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("Sector 63, Noida",
//                                 style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.phone, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("9199786786",
//                                 style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.work, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("Flutter Developer",
//                                 style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             _buildCard(
//               title: "Work Experience",
//               trailing: "Add New",
//               content: const [
//                 _ListItem(icon: Icons.work, value: "Full Stack Developer"),
//               ],
//             ),
//
//             // ✅ Updated Personal Information
//             _buildCard(
//               title: "Personal Information",
//               editable: true,
//               content: const [
//                 _InfoRow(label: "Email", value: "codingwalle@gmail.com"),
//                 _InfoRow(label: "Gender", value: "Male"),
//                 _InfoRow(label: "Education Level", value: "Graduate"),
//               ],
//             ),
//             _buildCard(
//               title: "Language",
//               content: const [
//                 _ListItem(text: "English Level", value: "Good English"),
//               ],
//             ),
//             _buildCard(
//               title: "Skills",
//               editable: true,
//               onEdit: () async {
//                 final updatedSkills =
//                 await BottomSheetHelper.showSkillsSelector(
//                   context: context,
//                   currentSkills: skills,
//                 );
//                 if (updatedSkills != null) {
//                   setState(() {
//                     skills = updatedSkills;
//                   });
//                 }
//               },
//               content: skills.map((s) => _ListItem(value: s)).toList(),
//             ),
//             _buildCard(
//               title: "Resume",
//               editable: true,
//               onEdit: () async {
//                 final filePath = await ResumeService.pickResume(context);
//                 if (filePath != null) {
//                   setState(() {
//                     resumeFilePath = filePath;
//                   });
//                 }
//               },
//               content: [
//                 _ListItem(
//                   value: resumeFilePath != null
//                       ? resumeFilePath!.split('/').last
//                       : "Add Resume",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     List<Widget> content = const [],
//     bool editable = false,
//     String? trailing,
//     VoidCallback? onEdit,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               if (trailing != null)
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     trailing,
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               if (editable)
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                   onPressed: onEdit,
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ...content,
//         ],
//       ),
//     );
//   }
// }
//
// // 🔹 New widget for left label + right bold value
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//
//   const _InfoRow({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ListItem extends StatelessWidget {
//   final IconData? icon;
//   final String? text;
//   final String? value;
//
//   const _ListItem({this.icon, this.text, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Icon(icon, size: 16, color: Colors.blue)
//           else
//             const SizedBox(width: 16),
//           if (icon != null) const SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               text != null ? (value != null ? "$text: $value" : text!) : value ?? "",
//               style: const TextStyle(fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






// Without use Api

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
// import 'Setting_Screen.dart';
// import 'resume_service.dart';
// import 'bottom_sheet_helper.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? resumeFilePath;
//   List<String> skills = ["PHP", "Dart", "Flutter"];
//
//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final profile = profileProvider.profile;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.share, color: Colors.white, size: 18),
//               label: const Text(
//                 "Share App",
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.black),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Profile Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xfff0f3ff),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 35,
//                     backgroundColor: Colors.grey,
//                     backgroundImage: profile?.imageUrl != null
//                         ? NetworkImage(profile!.imageUrl!)
//                         : null,
//                     child: profile?.imageUrl == null
//                         ? const Icon(Icons.person, size: 40, color: Colors.white)
//                         : null,
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           profile?.name ?? "N/A",
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.phone, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text(profile?.mobile ?? "N/A", style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.work, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text(profile?.jobCategory ?? "N/A", style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             _buildCard(
//               title: "Work Experience",
//               trailing: "Add New",
//               content: const [
//                 _ListItem(icon: Icons.work, value: "Full Stack Developer"),
//               ],
//             ),
//
//             // ✅ Updated Personal Information
//             _buildCard(
//               title: "Personal Information",
//               editable: true,
//               content: [
//                 _InfoRow(label: "Email", value: profile?.email ?? "N/A"),
//                 _InfoRow(label: "Gender", value: profile?.gender ?? "N/A"),
//                 _InfoRow(label: "Education", value: profile?.education ?? "N/A"),
//               ],
//             ),
//
//             _buildCard(
//               title: "Language",
//               content: const [
//                 _ListItem(text: "English Level", value: "Good English"),
//               ],
//             ),
//             _buildCard(
//               title: "Skills",
//               editable: true,
//               content: (profile?.skills.isNotEmpty == true
//                   ? profile!.skills.split(",").map((s) => _ListItem(value: s)).toList()
//                   : [_ListItem(value: "No skills added")]),
//             ),
//
//             _buildCard(
//               title: "Resume",
//               editable: true,
//               onEdit: () async {
//                 final filePath = await ResumeService.pickResume(context);
//                 if (filePath != null) {
//                   setState(() {
//                     resumeFilePath = filePath;
//                   });
//                 }
//               },
//               content: [
//                 _ListItem(
//                   value: resumeFilePath != null
//                       ? resumeFilePath!.split('/').last
//                       : "Add Resume",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     List<Widget> content = const [],
//     bool editable = false,
//     String? trailing,
//     VoidCallback? onEdit,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               if (trailing != null)
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     trailing,
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               if (editable)
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                   onPressed: onEdit,
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ...content,
//         ],
//       ),
//     );
//   }
// }
//
// // 🔹 New widget for left label + right bold value
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//
//   const _InfoRow({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ListItem extends StatelessWidget {
//   final IconData? icon;
//   final String? text;
//   final String? value;
//
//   const _ListItem({this.icon, this.text, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Icon(icon, size: 16, color: Colors.blue)
//           else
//             const SizedBox(width: 16),
//           if (icon != null) const SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               text != null ? (value != null ? "$text: $value" : text!) : value ?? "",
//               style: const TextStyle(fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//




// correct code
//

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'Setting_Screen.dart';
// import 'resume_service.dart';
// import 'bottom_sheet_helper.dart';
//
// class ProfileScreen extends StatefulWidget {
//   // final String fullName;
//   // final String gender;
//   // final String education;
//   // final String workExperience;
//   // final File imageFile;
//   const ProfileScreen({super.key,
//     // required this.fullName,
//     // required this.gender,
//     // required this.education,
//     // required this.workExperience,
//     // required this.imageFile, required List skills, required String salary,
//   });
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? resumeFilePath;
//   List<String> skills = ["PHP", "Dart", "Flutter"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.share, color: Colors.white, size: 18),
//               label: const Text(
//                 "Share App",
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.black),
//             onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Profile Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xfff0f3ff),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const CircleAvatar(
//                     radius: 35,
//                     backgroundColor: Colors.grey,
//                     child: Icon(Icons.person, size: 40, color: Colors.white),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Asif Ali Khan",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.location_on,
//                                 size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("Sector 63, Noida",
//                                 style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.phone, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("9199786786",
//                                 style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.work, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("Flutter Developer",
//                                 style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             _buildCard(
//               title: "Work Experience",
//               trailing: "Add New",
//               content: const [
//                 _ListItem(icon: Icons.work, value: "Full Stack Developer"),
//               ],
//             ),
//
//             // ✅ Updated Personal Information
//             _buildCard(
//               title: "Personal Information",
//               editable: true,
//               content: const [
//                 _InfoRow(label: "Email", value: "codingwalle@gmail.com"),
//                 _InfoRow(label: "Gender", value: "Male"),
//                 _InfoRow(label: "Education Level", value: "Graduate"),
//               ],
//             ),
//             _buildCard(
//               title: "Language",
//               content: const [
//                 _ListItem(text: "English Level", value: "Good English"),
//               ],
//             ),
//             _buildCard(
//               title: "Skills",
//               editable: true,
//               onEdit: () async {
//                 final updatedSkills =
//                 await BottomSheetHelper.showSkillsSelector(
//                   context: context,
//                   currentSkills: skills,
//                 );
//                 if (updatedSkills != null) {
//                   setState(() {
//                     skills = updatedSkills;
//                   });
//                 }
//               },
//               content: skills.map((s) => _ListItem(value: s)).toList(),
//             ),
//             _buildCard(
//               title: "Resume",
//               editable: true,
//               onEdit: () async {
//                 final filePath = await ResumeService.pickResume(context);
//                 if (filePath != null) {
//                   setState(() {
//                     resumeFilePath = filePath;
//                   });
//                 }
//               },
//               content: [
//                 _ListItem(
//                   value: resumeFilePath != null
//                       ? resumeFilePath!.split('/').last
//                       : "Add Resume",
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     List<Widget> content = const [],
//     bool editable = false,
//     String? trailing,
//     VoidCallback? onEdit,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               if (trailing != null)
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     trailing,
//                     style: const TextStyle(
//                       color: Colors.blue,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               if (editable)
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                   onPressed: onEdit,
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ...content,
//         ],
//       ),
//     );
//   }
// }
//
// // 🔹 New widget for left label + right bold value
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//
//   const _InfoRow({required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ListItem extends StatelessWidget {
//   final IconData? icon;
//   final String? text;
//   final String? value;
//
//   const _ListItem({this.icon, this.text, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Icon(icon, size: 16, color: Colors.blue)
//           else
//             const SizedBox(width: 16),
//           if (icon != null) const SizedBox(width: 4),
//           Expanded(
//             child: Text(
//               text != null ? (value != null ? "$text: $value" : text!) : value ?? "",
//               style: const TextStyle(fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//






//
//
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/custom/Setting_Screen.dart';
// // import 'package:naukri_mitra_jobs/custom/custom_buttom_nav.dart';
// import 'package:naukri_mitra_jobs/custom/resume_service.dart';
// import 'bottom_sheet_helper.dart';
//
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   String? resumeFileName;
//   // int _selectedIndex = 0;
//   //
//   // void _onBottomNavTap(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text("My Profile",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.share, color: Colors.white, size: 18),
//               label: const Text("Share App", style: TextStyle(color: Colors.white, fontSize: 12)),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.black),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
//
//
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Profile Card
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xfff0f3ff),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const CircleAvatar(
//                     radius: 35,
//                     backgroundColor: Colors.grey,
//                     child: Icon(Icons.person, size: 40, color: Colors.white),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Asif Ali Khan",
//                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                         Row(
//                           children: const [
//                             Icon(Icons.location_on, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("Sector 63, Noida", style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: const [
//                             Icon(Icons.phone, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("9199786786", style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                         Row(
//                           children: const [
//                             Icon(Icons.work, size: 14, color: Colors.blue),
//                             SizedBox(width: 4),
//                             Text("Flutter Developer", style: TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                     onPressed: () {
//                       BottomSheetHelper.show(
//                         context: context,
//                         title: "Edit Profile",
//                         content: "Here you can edit profile details.",
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             _buildCard(
//               title: "Work Experience",
//               trailing: "Add New",
//               content: const [_ListItem(icon: Icons.work, text: "Full Stack Developer")],
//             ),
//             _buildCard(
//               title: "Personal Information",
//               editable: true,
//               content: const [
//                 _ListItem(text: "Email", value: "codingwalle@gmail.com"),
//                 _ListItem(text: "Gender", value: "Male"),
//                 _ListItem(text: "Education Level", value: "Graduate"),
//               ],
//             ),
//             _buildCard(
//               title: "Language",
//               content: const [_ListItem(text: "English Level", value: "Good English")],
//             ),
//             _buildCard(
//               title: "Skills",
//               editable: true,
//               content: const [
//                 _ListItem(value: "PHP"),
//                 _ListItem(value: "Dart"),
//                 _ListItem(value: "Flutter"),
//               ],
//             ),
//             _buildCard(
//               title: "Resume",
//               editable: true,
//               onEdit: () async {
//                 final fileName = await ResumeService.pickResume(context);
//                 if (fileName != null) {
//                   setState(() {
//                     resumeFileName = fileName;
//                   });
//                 }
//               },
//               content: [
//                 _ListItem(value: resumeFileName ?? "Add Resume    Resume File name"),
//               ],
//             ),
//           ],
//         ),
//       ),
//
//       // bottomNavigationBar: CustomBottomNav(
//       //   currentIndex: _selectedIndex,
//       //   onTap: _onBottomNavTap,
//       // ),
//
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     List<Widget> content = const [],
//     bool editable = false,
//     String? trailing,
//     VoidCallback? onEdit,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
//               if (trailing != null)
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(trailing, style: const TextStyle(color: Colors.blue, fontSize: 12)),
//                 ),
//               if (editable)
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
//                   onPressed: onEdit ??
//                           () {
//                         BottomSheetHelper.show(
//                           context: context,
//                           title: "Edit $title",
//                           content: "Here you can edit $title details.",
//                         );
//                       },
//                 ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ...content
//         ],
//       ),
//     );
//   }
// }
//
// class _ListItem extends StatelessWidget {
//   final IconData? icon;
//   final String? text;
//   final String? value;
//
//   const _ListItem({this.icon, this.text, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Icon(icon, size: 16, color: Colors.blue)
//           else
//             const SizedBox(width: 16),
//           if (icon != null) const SizedBox(width: 4),
//           if (text != null)
//             Expanded(
//               child: Text(
//                 value != null ? "$text\n$value" : text!,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: value != null ? FontWeight.normal : FontWeight.bold,
//                 ),
//               ),
//             )
//           else if (value != null)
//             Expanded(
//               child: Text(value!, style: const TextStyle(fontSize: 12)),
//             ),
//         ],
//       ),
//     );
//   }
// }
