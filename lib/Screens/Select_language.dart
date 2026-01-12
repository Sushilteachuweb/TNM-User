import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:naukri_mitra_jobs/Screens/Select_job.dart';
import 'package:naukri_mitra_jobs/provider/LocalizationProvider.dart';
import '../generated/l10n/app_localizations.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> with SingleTickerProviderStateMixin {
  final List<String> languages = [
    'हिंदी',
    'English',
    'ਪੰਜਾਬੀ',
    'ગુજરાતી',
    'मराठी',
  ];
  String selectedLanguage = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Set English as default selected language
    selectedLanguage = 'English';
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(236, 236, 245, 1),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      AppLocalizations.of(context).selectYourLanguage,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    // const SizedBox(height: 8),
                    // const Text(
                    //   'Choose your preferred language',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //     color: Color(0xFF666666),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context).moreLanguagesComingSoon,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Language buttons
                    ...languages.asMap().entries.map((entry) {
                      int index = entry.key;
                      String lang = entry.value;
                      bool isSelected = selectedLanguage == lang;
                      
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Material(
                            elevation: isSelected ? 4 : 0,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedLanguage = lang;
                                });
                                // Save language selection
                                context.read<LocalizationProvider>().changeLanguageByName(lang);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFFFF9800),
                                            Color(0xFFFF6F00),
                                          ],
                                        )
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xFF2196F3),
                                            Color(0xFF1976D2),
                                          ],
                                        ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.orange.withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          )
                                        ]
                                      : [],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.check_circle
                                          : Icons.language,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      lang,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 10),

                    // Confirm Button
                    AnimatedOpacity(
                      opacity: selectedLanguage.isNotEmpty ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedSlide(
                        offset: selectedLanguage.isNotEmpty
                            ? Offset.zero
                            : const Offset(0, 0.5),
                        duration: const Duration(milliseconds: 300),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: selectedLanguage.isNotEmpty
                                ? () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectJob(phone: ''),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context).continueButton,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Screens/Select_job.dart';
//
// class SelectLanguage extends StatefulWidget {
//   const SelectLanguage({super.key});
//
//   @override
//   State<SelectLanguage> createState() => _SelectLanguageState();
// }
//
// class _SelectLanguageState extends State<SelectLanguage> {
//   final List<String> languages = [
//     'हिंदी',
//     'English',
//     'ਪੰਜਾਬੀ',
//     'ગુજરાતી',
//     'मराठी',
//   ];
//   String selectedLanguage = '';
//    @override
//   Widget build(BuildContext context) {
//     double buttonWidth = MediaQuery.of(context).size.width * 0.85;
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color.fromRGBO(236, 236, 245, 1)
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors:  [
//           //
//           //     // Color.fromRGBO(237, 237, 237, 100), // White
//           //     // Color.fromRGBO(255, 255, 255, 100), // #7C82FF
//           //      // White
//           //   ],
//           // ),
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 150),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Logo
//               Image.asset(
//                 'images/spl1.png',
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 25.0),
//                 child: const Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Rozgar ka ',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Digital Saathi',
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 40),
//
//               // Show selected language in TextField
//               if (selectedLanguage.isNotEmpty)
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 20),
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(6),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 4,
//                       )
//                     ],
//                   ),
//                   child: TextField(
//                     enabled: false,
//                     controller: TextEditingController(text: selectedLanguage),
//                     decoration: const InputDecoration(
//                       hintText: 'Selected Language',
//                       border: InputBorder.none,
//                       icon: Icon(Icons.language),
//                     ),
//                   ),
//                 ),
//
//               // Language buttons
//               ...languages.map((lang) {
//                 bool isSelected = selectedLanguage == lang;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 6.0),
//                   child: SizedBox(
//                     width: buttonWidth,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                         isSelected ? Colors.orange : Colors.blue,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           selectedLanguage = lang;
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 12.0),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             lang,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//               const SizedBox(height: 30),
//
//               // Confirm Button
//               if (selectedLanguage.isNotEmpty)
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SelectJob(phone: '',),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     // padding:
//                     // const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                   ),
//                   child: Text(
//                     'SELECT ${selectedLanguage.toUpperCase()}',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
