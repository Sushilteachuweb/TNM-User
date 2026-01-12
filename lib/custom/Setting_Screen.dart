import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naukri_mitra_jobs/Screens/Login.dart';
import 'package:provider/provider.dart';

import '../SessionManager/SessionManager.dart';
import '../utils/custom_app_bar.dart';
import '../generated/l10n/app_localizations.dart';
import '../provider/LocalizationProvider.dart';

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

  // 🔹 Language Selection Dialog
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, size: 60, color: Colors.blue),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context).selectLanguage,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                _buildLanguageOption(context, 'en', AppLocalizations.of(context).english),
                _buildLanguageOption(context, 'hi', AppLocalizations.of(context).hindi),
                _buildLanguageOption(context, 'pa', AppLocalizations.of(context).punjabi),
                _buildLanguageOption(context, 'gu', AppLocalizations.of(context).gujarati),
                _buildLanguageOption(context, 'mr', AppLocalizations.of(context).marathi),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context).cancel),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(BuildContext context, String languageCode, String languageName) {
    return ListTile(
      title: Text(languageName),
      onTap: () async {
        // Change language using LocalizationProvider
        final localizationProvider = Provider.of<LocalizationProvider>(context, listen: false);
        await localizationProvider.changeLanguage(languageCode);
        
        // Close dialog
        Navigator.pop(context);
        
        // Show confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Language changed to $languageName'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  // 🔹 Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, size: 60, color: Colors.blue),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context).logout,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context).areYouSureLogout,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // ❌ cancel dialog
                      },
                      child: Text(AppLocalizations.of(context).cancel),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
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
                      child: Text(AppLocalizations.of(context).logout),
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
