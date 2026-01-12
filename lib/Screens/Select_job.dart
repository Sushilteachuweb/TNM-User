import 'package:flutter/material.dart';
import 'package:naukri_mitra_jobs/Screens/CreateProfile.dart';
import 'package:naukri_mitra_jobs/Screens/Login.dart';
import 'package:url_launcher/url_launcher.dart';
import '../generated/l10n/app_localizations.dart';

class SelectJob extends StatefulWidget {
  final String phone;
  const SelectJob({super.key,required this.phone});
  @override
  State<SelectJob> createState() => _SelectJobState();
}
class _SelectJobState extends State<SelectJob> with TickerProviderStateMixin {
  
  late AnimationController _buttonAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.elasticOut,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeInOut,
    ));
    
    // Start button animations after a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _buttonAnimationController.forward();
    });
  }
  
  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }
  
  // Function to launch Play Store URL
  Future<void> _launchRecruiterApp() async {
    final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.techuweb.hrportal');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // Show error message if can't launch URL
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open Play Store. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Show error message if exception occurs
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening Play Store. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildProfessionalButton({
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
    required Color shadowColor,
    bool isExternal = false,
  }) {
    return AnimatedBuilder(
      animation: _buttonAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Material(
                elevation: 0,
                color: Colors.transparent,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: shadowColor.withOpacity(0.1),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Colors.white.withOpacity(0.2),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            // Icon container with glassmorphism effect
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                icon,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            
                            const SizedBox(width: 20),
                            
                            // Title
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            
                            // Arrow or external link icon
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                isExternal ? Icons.launch_rounded : Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(236, 236, 245, 1)
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color.fromRGBO(236, 236, 245, 1)
          //     // Color.fromRGBO(237, 237, 237, 100), // White
          //     // Color.fromRGBO(255, 255, 255, 100),
          //     // Colors.white,
          //     // Color(0xFF7C82FF),
          //   ],
          // ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(

              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    // Logo - matching splash screen width
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.62,
                      child: Image.asset(
                        'images/spl1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Text - matching splash screen styling
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Rozgar ka ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          TextSpan(
                            text: 'Digital Saathi',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context).jobSearchPartner,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                        letterSpacing: 0.3,
                      ),
                    ),

                    const SizedBox(height: 60),
                    
                    // Professional Job Button
                    _buildProfessionalButton(
                      title: AppLocalizations.of(context).iWantJob,
                      icon: Icons.work_outline_rounded,
                      gradientColors: [
                        const Color(0xFFFF6B35),
                        const Color(0xFFFF8E53),
                        const Color(0xFFFFA726),
                      ],
                      shadowColor: const Color(0xFFFF6B35),
                      onTap: () {
                        Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Login(phone: widget.phone),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Professional Hire Button
                    _buildProfessionalButton(
                      title: AppLocalizations.of(context).iWantToHire,
                      icon: Icons.business_center_outlined,
                      gradientColors: [
                        const Color(0xff2196f3),
                        const Color(0xff1390ef),
                        const Color(0xFF1A7BC7),
                      ],
                      shadowColor: const Color(0xff2196f3),
                      isExternal: true,
                      onTap: _launchRecruiterApp,
                    ),
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



// redirect the CreateProfile
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Screens/CreateProfile.dart';
// import 'package:naukri_mitra_jobs/Screens/Login.dart';
//
// class SelectJob extends StatefulWidget {
//   const SelectJob({super.key});
//   @override
//   State<SelectJob> createState() => _SelectJobState();
// }
// class _SelectJobState extends State<SelectJob> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//             color: Color.fromRGBO(236, 236, 245, 1)
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors: [
//           //     Color.fromRGBO(236, 236, 245, 1)
//           //     // Color.fromRGBO(237, 237, 237, 100), // White
//           //     // Color.fromRGBO(255, 255, 255, 100),
//           //     // Colors.white,
//           //     // Color(0xFF7C82FF),
//           //   ],
//           // ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Container(
//
//               child: Center(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 120),
//                     // Logo
//                     Image.asset(
//                       'images/spl1.png',
//
//
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 25.0),
//                       child: const Text.rich(
//                         TextSpan(
//                           children: [
//                             TextSpan(
//                               text: 'Rozgar ka ',
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//
//                             TextSpan(
//                               text: 'Digital Saathi',
//                               style: TextStyle(
//                                 color: Colors.orange,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//
//                     const SizedBox(height: 100),
//                     // Button: I want to Job
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                             context, MaterialPageRoute(
//                             builder: (context)=>CreateProfile(phone: '',)));
//                       },
//                       icon: Padding(
//                         padding: const EdgeInsets.only(right: 10.0),
//                         child: const Icon(Icons.work, color: Colors.white,size: 30,),
//                       ),
//                       label: const Text(
//                         'I want to Job',
//                         style: TextStyle(fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orangeAccent,
//                         minimumSize: const Size(double.infinity, 48),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Button: I want to Hire
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         // Action for "I want to Hire"
//                       },
//                       icon: Padding(
//                         padding: const EdgeInsets.only(right: 10.0),
//                         child: const Icon(Icons.person, color: Colors.white,size: 30,),
//                       ),
//                       label: const Text(
//                         'I want to Hire',
//                         style: TextStyle(fontSize: 18,
//                             color: Colors.white,fontWeight: FontWeight.bold),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orangeAccent,
//                         minimumSize: const Size(double.infinity, 48),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
