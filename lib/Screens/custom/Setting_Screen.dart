import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/Login.dart';
import 'package:provider/provider.dart';

import '../../SessionManager/SessionManager.dart';
import '../../utils/custom_app_bar.dart';
import '../../generated/l10n/app_localizations.dart';
import '../../providers/LocalizationProvider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool msgFromHR = true;
  bool callFromHR = false;
  bool jobHaiNotify = true;

  bool help1 = true;
  bool help2 = false;
  bool help3 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f8),
      appBar: CustomAppBar(
        title: AppLocalizations.of(context).settings,
        backgroundColor: const Color(0xfff2f4f8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Language Section
            _buildSection(
              title: AppLocalizations.of(context).changeLanguage,
              icon: Icons.language,
              items: [
                ListTile(
                  title: Text(
                    AppLocalizations.of(context).selectLanguage,
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Account Section
            _buildSection(
              title: AppLocalizations.of(context).account,
              icon: Icons.person,
              items: [
                // ListTile(
                //   title: const Text(
                //     "Delete My Profile",
                //     style: TextStyle(fontSize: 14),
                //   ),
                //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                //   onTap: () {
                //     // Delete profile ka logic yaha dalna hai
                //   },
                // ),
                // const Divider(height: 2),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context).logout,
                    style: const TextStyle(fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing:
                  const Icon(Icons.logout, size: 18, color: Colors.blue),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Modern Language Selection Bottom Sheet
  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.withOpacity(0.1),
                          Colors.blue.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        // Drag handle
                        Container(
                          height: 4,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        
                        // Header content
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Color(0xFF1976D2)],
                                ),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.language_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).selectLanguage,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Choose your preferred language',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Language Options
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildLanguageCard(context, 'en', AppLocalizations.of(context).english, '🇺🇸', 'English'),
                          const SizedBox(height: 12),
                          _buildLanguageCard(context, 'hi', AppLocalizations.of(context).hindi, '🇮🇳', 'हिंदी'),
                          const SizedBox(height: 12),
                          _buildLanguageCard(context, 'pa', AppLocalizations.of(context).punjabi, '🇮🇳', 'ਪੰਜਾਬੀ'),
                          const SizedBox(height: 12),
                          _buildLanguageCard(context, 'gu', AppLocalizations.of(context).gujarati, '🇮🇳', 'ગુજરાતી'),
                          const SizedBox(height: 12),
                          _buildLanguageCard(context, 'mr', AppLocalizations.of(context).marathi, '🇮🇳', 'मराठी'),
                        ],
                      ),
                    ),
                  ),

                  // Info Footer
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xfff2f4f8),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.1),
                            Colors.blue.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Language changes will take effect immediately',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageCard(BuildContext context, String languageCode, String displayName, String flag, String nativeName) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final isSelected = localizationProvider.locale.languageCode == languageCode;
    
    return Material(
      elevation: isSelected ? 8 : 2,
      shadowColor: isSelected 
          ? Colors.blue.withOpacity(0.3)
          : Colors.black.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () async {
          // Change language using LocalizationProvider
          await localizationProvider.changeLanguage(languageCode);
          
          // Close bottom sheet
          Navigator.pop(context);
          
          // Show confirmation with animation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text('Language changed to $displayName'),
                ],
              ),
              backgroundColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Colors.blue, Color(0xFF1976D2)],
                  )
                : const LinearGradient(
                    colors: [Colors.white, Colors.white],
                  ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Flag Container
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : const Color(0xfff2f4f8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Language Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nativeName,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Selection Indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.blue,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Modern Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  const Color(0xfff2f4f8),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.1),
                        Colors.red.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Title
                Text(
                  AppLocalizations.of(context).logout,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Message
                Text(
                  AppLocalizations.of(context).areYouSureLogout,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f4f8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(12),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).cancel,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.red, Color(0xFFD32F2F)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              await SessionManager.logout();
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.remove("cookie");
                              await prefs.clear();

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) =>
                                const Login(phone: '',)),
                                    (route) => false,
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).logout,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Reusable Section Widget
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String text, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ),
        Transform.scale(
          scale: 0.8, // 👈 yaha size chhota ya bada karna hai (0.7, 0.8 etc.)
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:naukri_mitra_jobs/Screens/Login.dart';
//
// import '../SessionManager/SessionManager.dart';
//
// class SettingScreen extends StatefulWidget {
//   const SettingScreen({super.key});
//
//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends State<SettingScreen> {
//   bool msgFromHR = true;
//   bool callFromHR = false;
//   bool jobHaiNotify = true;
//
//   bool help1 = true;
//   bool help2 = false;
//   bool help3 = true;
//
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
//           "Setting",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Notifications Section
//             _buildSection(
//               title: "Notifications",
//               icon: Icons.notifications,
//               items: [
//                 _buildSwitchTile(
//                   "Get Direct Message from HR",
//                   msgFromHR,
//                       (val) => setState(() => msgFromHR = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Direct Call from HR",
//                   callFromHR,
//                       (val) => setState(() => callFromHR = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Notified by Job Hai",
//                   jobHaiNotify,
//                       (val) => setState(() => jobHaiNotify = val),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             // Help Section
//             _buildSection(
//               title: "Help",
//               icon: Icons.help,
//               items: [
//                 _buildSwitchTile(
//                   "Get Direct message from HR",
//                   help1,
//                       (val) => setState(() => help1 = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Direct message from HR",
//                   help2,
//                       (val) => setState(() => help2 = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Direct message from HR",
//                   help3,
//                       (val) => setState(() => help3 = val),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             // Account Section
//             _buildSection(
//               title: "Account",
//               icon: Icons.person,
//               items: [
//                 ListTile(
//                   title: const Text(
//                     "Delete My Profile",
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     // Delete profile ka logic yaha dalna hai
//                   },
//                 ),
//                 const Divider(height: 2),
//                 ListTile(
//                   title: const Text(
//                     "Logout",
//                     style: TextStyle(fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   trailing:
//                   const Icon(Icons.logout, size: 18, color: Colors.blue),
//                   onTap: () {
//                     _showLogoutDialog(context);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Logout Confirmation Dialog
//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.logout, size: 60, color: Colors.blue),
//                 const SizedBox(height: 12),
//                 const Text(
//                   "Logout",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   "Are you sure you want to logout from your account?",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 14, color: Colors.black54),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[300],
//                         foregroundColor: Colors.black87,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context); // ❌ cancel dialog
//                       },
//                       child: const Text("Cancel"),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () async {
//                         await SessionManager.logout();
//                         final prefs = await SharedPreferences.getInstance();
//                         await prefs.remove("cookie");
//                         await prefs.clear();
//
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(builder: (_) => const Login()),
//                               (route) => false,
//                         );
//                       },
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // Reusable Section Widget
//   Widget _buildSection({
//     required String title,
//     required IconData icon,
//     required List<Widget> items,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: Colors.blue, size: 22),
//               const SizedBox(width: 8),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           ...items,
//         ],
//       ),
//     );
//   }
//
//   // Reusable SwitchTile Widget
//   Widget _buildSwitchTile(
//       String text, bool value, Function(bool) onChanged) {
//     return SwitchListTile(
//       dense: true,
//       contentPadding: EdgeInsets.zero,
//       title: Text(
//         text,
//         style: const TextStyle(fontSize: 14),
//       ),
//       value: value,
//       activeColor: Colors.blue,
//       onChanged: onChanged,
//     );
//   }
// }
//










// import 'package:flutter/material.dart';
//
// class SettingScreen extends StatefulWidget {
//   const SettingScreen({super.key});
//
//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }
//
// class _SettingScreenState extends State<SettingScreen> {
//
//   bool msgFromHR = true;
//   bool callFromHR = false;
//   bool jobHaiNotify = true;
//
//   bool help1 = true;
//   bool help2 = false;
//   bool help3 = true;
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
//           "Setting",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 18,
//           ),
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildSection(
//               title: "Notifications",
//               icon: Icons.notifications,
//               items: [
//                 _buildSwitchTile(
//                   "Get Direct Message from HR",
//                   msgFromHR,
//                       (val) => setState(() => msgFromHR = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Direct Call from HR",
//                   callFromHR,
//                       (val) => setState(() => callFromHR = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Notified by Job Hai",
//                   jobHaiNotify,
//                       (val) => setState(() => jobHaiNotify = val),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//
//             _buildSection(
//               title: "Help",
//               icon: Icons.help,
//               items: [
//                 _buildSwitchTile(
//                   "Get Direct message from HR",
//                   help1,
//                       (val) => setState(() => help1 = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Direct message from HR",
//                   help2,
//                       (val) => setState(() => help2 = val),
//                 ),
//                 _buildSwitchTile(
//                   "Get Direct message from HR",
//                   help3,
//                       (val) => setState(() => help3 = val),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//
//             _buildSection(
//               title: "Account",
//               icon: Icons.person,
//               items: [
//                 ListTile(
//                   title: const Text(
//                     "Delete My Profile",
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//
//                   },
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection({
//     required String title,
//     required IconData icon,
//     required List<Widget> items,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: Colors.blue, size: 22),
//               const SizedBox(width: 8),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           ...items,
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildSwitchTile(
//       String text, bool value, Function(bool) onChanged) {
//     return SwitchListTile(
//       dense: true,
//       contentPadding: EdgeInsets.zero,
//       title: Text(
//         text,
//         style: const TextStyle(fontSize: 14),
//       ),
//       value: value,
//       activeColor: Colors.blue,
//       onChanged: onChanged,
//     );
//   }
// }
