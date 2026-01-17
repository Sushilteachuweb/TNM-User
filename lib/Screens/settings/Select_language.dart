import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../jobs/Select_job.dart';
import 'package:naukri_mitra_jobs/providers/LocalizationProvider.dart';
import '../../generated/l10n/app_localizations.dart';
import '../../utils/app_colors.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> languages = [
    {'name': 'English', 'native': 'English', 'icon': '🇺🇸'},
    {'name': 'हिंदी', 'native': 'Hindi', 'icon': '🇮🇳'},
    {'name': 'ਪੰਜਾਬੀ', 'native': 'Punjabi', 'icon': '🇮🇳'},
    {'name': 'ગુજરાતી', 'native': 'Gujarati', 'icon': '🇮🇳'},
    {'name': 'मराठी', 'native': 'Marathi', 'icon': '🇮🇳'},
  ];
  
  String selectedLanguage = 'English';
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
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F9FF),
              Color(0xFFEEF2FF),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  // Header Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Language Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.language_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          AppLocalizations.of(context).selectYourLanguage,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.headingText,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose your preferred language for the best experience',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.bodyText.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Languages List
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Language Options
                          Expanded(
                            child: ListView.builder(
                              itemCount: languages.length,
                              itemBuilder: (context, index) {
                                final language = languages[index];
                                final isSelected = selectedLanguage == language['name'];
                                
                                return TweenAnimationBuilder<double>(
                                  duration: Duration(milliseconds: 400 + (index * 100)),
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0, 30 * (1 - value)),
                                      child: Opacity(
                                        opacity: value,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: Material(
                                      elevation: isSelected ? 8 : 2,
                                      shadowColor: isSelected 
                                          ? AppColors.primary.withOpacity(0.3)
                                          : Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedLanguage = language['name'];
                                          });
                                          context.read<LocalizationProvider>()
                                              .changeLanguageByName(language['name']);
                                        },
                                        borderRadius: BorderRadius.circular(20),
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            gradient: isSelected
                                                ? AppColors.primaryGradient
                                                : const LinearGradient(
                                                    colors: [Colors.white, Colors.white],
                                                  ),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.transparent
                                                  : AppColors.divider,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              // Flag/Icon
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colors.white.withOpacity(0.2)
                                                      : AppColors.background,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    language['icon'],
                                                    style: const TextStyle(fontSize: 24),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              
                                              // Language Names
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      language['name'],
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: isSelected
                                                            ? Colors.white
                                                            : AppColors.headingText,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      language['native'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: isSelected
                                                            ? Colors.white.withOpacity(0.8)
                                                            : AppColors.bodyText.withOpacity(0.7),
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
                                                        : AppColors.divider,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: isSelected
                                                    ? Icon(
                                                        Icons.check,
                                                        size: 16,
                                                        color: AppColors.primary,
                                                      )
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Continue Button
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: AnimatedScale(
                      scale: selectedLanguage.isNotEmpty ? 1.0 : 0.95,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedOpacity(
                        opacity: selectedLanguage.isNotEmpty ? 1.0 : 0.6,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: selectedLanguage.isNotEmpty
                                ? const LinearGradient(
                                    colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                                  )
                                : LinearGradient(
                                    colors: [
                                      AppColors.buttonDisabled,
                                      AppColors.buttonDisabled,
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: selectedLanguage.isNotEmpty
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF4CAF50).withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: selectedLanguage.isNotEmpty
                                  ? () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) =>
                                              const SelectJob(phone: ''),
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            return SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(1.0, 0.0),
                                                end: Offset.zero,
                                              ).animate(animation),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  : null,
                              borderRadius: BorderRadius.circular(16),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context).continueButton,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
