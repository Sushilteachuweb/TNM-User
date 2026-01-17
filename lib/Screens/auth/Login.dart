import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/home_screen.dart';
import '../../providers/Auth_Provider.dart';
import '../../generated/l10n/app_localizations.dart';
import 'OtpVerify.dart';

class Login extends StatefulWidget {
  final String phone;
  const Login({super.key, required this.phone});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  bool _agreeToTerms = false;
  
  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
      curve: Curves.easeOutBack,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.elasticOut,
    ));
    
    _startAnimations();
  }
  
  void _startAnimations() async {
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    _buttonAnimationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  // ✅ Indian phone validation: 10 digits, starting with 6-9
  String? _normalizeToTenDigits(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), ''); // remove non-digits

    if (digits.length == 12 && digits.startsWith('91')) {
      digits = digits.substring(2);
    }
    if (digits.length == 11 && digits.startsWith('0')) {
      digits = digits.substring(1);
    }

    if (digits.length == 10 && RegExp(r'^[6-9]\d{9}$').hasMatch(digits)) {
      return digits;
    }

    return null;
  }

  // Launch URL in browser
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final logoSize = screenWidth * 0.62; // Match splash screen

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  
                  // Logo - matching splash screen
                  SizedBox(
                    width: logoSize,
                    child: Image.asset(
                      'images/spl1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
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
                  // const SizedBox(height: 8),
                  // Text(
                  //   'Your Job Search Partner',
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w500,
                  //     color: Colors.grey[600],
                  //     letterSpacing: 0.3,
                  //   ),
                  // ),
                  
                  const SizedBox(height: 60),
                  
                  // Welcome Back Section
                  Text(
                    AppLocalizations.of(context).welcomeBack,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[900],
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context).signInToContinue,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Phone Number Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context).phoneNumber,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Clean Phone Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      maxLength: 10,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Icon(
                            Icons.phone_outlined,
                            color: Colors.grey[600],
                            size: 22,
                          ),
                        ),
                        hintText: AppLocalizations.of(context).enter10DigitNumber,
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Clean Checkbox with clickable Terms and Privacy Policy
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: _agreeToTerms ? const Color(0xFF4CAF50) : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _agreeToTerms ? const Color(0xFF4CAF50) : Colors.grey[400]!,
                            width: 2,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _agreeToTerms = !_agreeToTerms;
                              });
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: _agreeToTerms
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: const TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _launchURL('https://thenaukrimitra.com/termandconditions'),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: const TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _launchURL('https://thenaukrimitra.com/privacypolicy'),
                              ),
                              const TextSpan(text: ' to log in to the app'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Professional Verify Button
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : _agreeToTerms
                                ? () => _verifyPhoneNumber(authProvider)
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _agreeToTerms 
                              ? const Color(0xFF2196F3)
                              : Colors.grey[300],
                          foregroundColor: Colors.white,
                          elevation: _agreeToTerms ? 2 : 0,
                          shadowColor: const Color(0xFF2196F3).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.verified_user_outlined,
                                    size: 20,
                                    color: _agreeToTerms ? Colors.white : Colors.grey[600],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context).verifyPhoneNumber,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: _agreeToTerms ? Colors.white : Colors.grey[600],
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verifyPhoneNumber(AuthProvider provider) async {
    // ✅ Internet check before calling API
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please connect to the internet')),
      );
      return;
    }

    final rawInput = _phoneController.text.trim();

    // ✅ Validate Indian phone number
    final apiPhone = _normalizeToTenDigits(rawInput);

    if (apiPhone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid Indian phone number')),
      );
      return;
    }

    // ✅ Abhi sirf internet connected hone ke baad hi API call hogi
    final success = await provider.sendOtp(apiPhone);

    if (!mounted) return; // safety check

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerify(phone: apiPhone),
        ),
      );
    } else {
      // ✅ yahan sirf API ka error show hoga, internet wala msg nahi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.message ?? "Something went wrong")),
      );
    }
  }
}





// without use Internet connections msg show
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../Home_screens/home_screen.dart';
// import '../provider/Auth_Provider.dart';
// import 'OtpVerify.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final TextEditingController _phoneController = TextEditingController();
//   bool _agreeToTerms = false;
//
//   // ✅ Indian phone validation: 10 digits, starting with 6-9
//   String? _normalizeToTenDigits(String input) {
//     String digits = input.replaceAll(RegExp(r'\D'), ''); // remove non-digits
//
//     if (digits.length == 12 && digits.startsWith('91')) {
//       digits = digits.substring(2);
//     }
//     if (digits.length == 11 && digits.startsWith('0')) {
//       digits = digits.substring(1);
//     }
//
//     if (digits.length == 10 && RegExp(r'^[6-9]\d{9}$').hasMatch(digits)) {
//       return digits;
//     }
//
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             children: [
//               const SizedBox(height: 120),
//               Image.asset('images/spl1.png'),
//               const SizedBox(height: 1),
//               Padding(
//                 padding: const EdgeInsets.only(left: 25.0),
//                 child: const Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Rozgar Ka ',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Digital Saathi',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 70),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Enter Phone Number',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 maxLength: 10,
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.phone_android),
//                   hintText: 'Phone Number',
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(6),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Checkbox(
//                     value: _agreeToTerms,
//                     onChanged: (value) {
//                       setState(() {
//                         _agreeToTerms = value ?? false;
//                       });
//                     },
//                   ),
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 12),
//                       child: Text(
//                         'I agree to the terms and conditions to log in to the app.',
//                         style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: authProvider.isLoading
//                       ? null
//                       : _agreeToTerms
//                       ? () => _verifyPhoneNumber(authProvider)
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                   ),
//                   child: authProvider.isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                     'Verify Phone Number',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
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
//   void _verifyPhoneNumber(AuthProvider provider) async {
//     final rawInput = _phoneController.text.trim();
//
//     // ✅ Validate Indian phone number
//     final apiPhone = _normalizeToTenDigits(rawInput);
//
//     if (apiPhone == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid Indian phone number')),
//       );
//       return;
//     }
//
//     final success = await provider.sendOtp(apiPhone);
//
//     if (success) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => OtpVerify(phone: apiPhone),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(provider.message ?? "Something went wrong")),
//       );
//     }
//   }
// }
//






// validation use
// void _verifyPhoneNumber(AuthProvider provider) async {
//   final rawInput = _phoneController.text.trim();
//
//   // Validate Indian phone number
//   final apiPhone = _normalizeToTenDigits(rawInput);
//
//   if (apiPhone == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please enter a valid Indian phone number')),
//     );
//     return;
//   }
//
//   final success = await provider.sendOtp(apiPhone);
//
//   if (!success) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(provider.message ?? "Something went wrong")),
//     );
//     return;
//   }
//
//   // Check if user exists in database
//   final exists = await provider.isExistingUser(apiPhone);
//
//   if (exists) {
//     // Existing user → Navigate to HomeScreen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const HomeScreen()),
//     );
//   } else {
//     // New user → Navigate to OTP verification
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => OtpVerify(phone: apiPhone)),
//     );
//   }
// }
// }


// checker user

  // void _verifyPhoneNumber(AuthProvider provider) async {
  //   final rawInput = _phoneController.text.trim();
  //
  //   // Normalize to 10-digit
  //   final apiPhone = _normalizeToTenDigits(rawInput);
  //
  //   if (apiPhone == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
  //     );
  //     return;
  //   }
  //
  //   final success = await provider.sendOtp(apiPhone);
  //
  //   if (!success) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(provider.message ?? "Something went wrong")),
  //     );
  //     return;
  //   }
  //
  //   // Check if user already exists
  //   final exists = await provider.isExistingUser(apiPhone);
  //
  //   if (exists) {
  //     // User exists → Navigate to HomeScreen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const HomeScreen(title: '', image: '', fullName: '', gender: '', education: '', workExperience: '', salary: '', imageFile: null, skills: [],)), // Replace with your actual HomeScreen
  //     );
  //   } else {
  //     // New user → Navigate to OTP verification
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (_) => OtpVerify(phone: apiPhone)),
  //     );
  //   }
  // }}
  //







// bina checker lagaye
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/Auth_Provider.dart';
// import 'OtpVerify.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final TextEditingController _phoneController = TextEditingController();
//   bool _agreeToTerms = false;
//
//   String? _normalizeToTenDigits(String input) {
//
//
//     String digits = input.replaceAll(RegExp(r'\D'), '');
//
//     if (digits.length == 12 && digits.startsWith('91')) {
//       digits = digits.substring(2);
//     }
//     if (digits.length == 11 && digits.startsWith('0')) {
//       digits = digits.substring(1);
//     }
//
//     if (digits.length == 10) return digits;
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             children: [
//               const SizedBox(height: 120),
//               Image.asset('images/spl1.png'),
//               SizedBox(height: 1,),
//               Padding(
//                 padding: const EdgeInsets.only(left: 25.0),
//                 child: const Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'Rozgar Ka ',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Digital Saathi',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 70),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Enter Phone Number',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               TextField(
//                 maxLength: 10,
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.phone_android),
//                   hintText: 'Phone Number',
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(6),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Checkbox(
//                     value: _agreeToTerms,
//                     onChanged: (value) {
//                       setState(() {
//                         _agreeToTerms = value ?? false;
//                       });
//                     },
//                   ),
//                   const Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 12),
//                       child: Text(
//                         'I agree to the terms and conditions to log in to the app.',
//                         style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 16),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: authProvider.isLoading
//                       ? null
//                       : _agreeToTerms
//                       ? () => _verifyPhoneNumber(authProvider)
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                   ),
//                   child: authProvider.isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                     'Verify Phone Number',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
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
//   void _verifyPhoneNumber(AuthProvider provider) async {
//     final rawInput = _phoneController.text.trim();
//
//     // 10-digit normalize
//     final apiPhone = _normalizeToTenDigits(rawInput);
//
//     if (apiPhone == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
//       );
//       return;
//     }
//
//
//     final success = await provider.sendOtp(apiPhone);
//
//     if (success) {
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => OtpVerify(phone: apiPhone),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(provider.message ?? "Something went wrong")),
//       );
//     }
//   }
// }
//
//





// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Screens/OtpVerify.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final TextEditingController _phoneController = TextEditingController();
//   bool _agreeToTerms = false;
//
//   @override
//   Widget build(BuildContext context) {
//     // final loginProvider = Provider.of<LoginProvider>(context);
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//            color:Color.fromRGBO(236, 236, 245, 1)
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors: [
//           //     Color.fromRGBO(236, 236, 245, 1)
//           //   ],
//           // ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               children: [
//                 const SizedBox(height: 120),
//                 // Logo Image
//                 Image.asset(
//                   'images/spl1.png',
//                 ),
//
//                 const SizedBox(height: 1),
//
//                 // Rozgar Ka Digital Saathi
//                 Padding(
//                   padding: const EdgeInsets.only(left: 25.0),
//                   child: const Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Rozgar Ka ',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'Digital Saathi',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.orange,
//                           ),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 70),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Enter Phone Number',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 TextField(
//                   maxLength: 10,
//                   controller: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.phone_android),
//                     hintText: 'Phone Number',
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Terms and Conditions Checkbox
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Checkbox(
//                       value: _agreeToTerms,
//                       onChanged: (value) {
//                         setState(() {
//                           _agreeToTerms = value ?? false;
//                         });
//                       },
//                     ),
//                     const Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 12),
//                         child: Text(
//                           'I agree to the terms and conditions to log in to the app.',
//                           style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Verify Phone Number Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _agreeToTerms ? _verifyPhoneNumber : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       // padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     child: const Text(
//                       'Verify Phone Number',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   void _verifyPhoneNumber() {
//     final phone = _phoneController.text.trim();
//     if (phone.isEmpty || phone.length < 10) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid phone number')),
//       );
//       return;
//     }
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const OtpVerify()),
//     );
//   }
// }
//
//
