import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:naukri_mitra_jobs/Screens/Login.dart';
import '../main_Screen/main_screen.dart';
import '../provider/Auth_Provider.dart';
import '../generated/l10n/app_localizations.dart';
import 'CreateProfile.dart';

class OtpVerify extends StatefulWidget {
  final String phone;
  const OtpVerify({super.key, required this.phone});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> with TickerProviderStateMixin {
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;
  Timer? _timer;
  int _start = 60;
  bool _canResend = false;
  
  late AnimationController _animationController;
  late AnimationController _shakeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    startTimer();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
    
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));
    
    _animationController.forward();
  }

  void startTimer() {
    _canResend = false;
    _start = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // Show loading state
    setState(() => _isLoading = true);
    
    try {
      // Call the sendOtp API again with the same phone number
      final success = await authProvider.sendOtp(widget.phone);
      
      setState(() => _isLoading = false);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text("OTP resent successfully!"),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        startTimer(); // Restart the countdown timer
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 8),
                Text(authProvider.message ?? "Failed to resend OTP. Please try again."),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Network error. Please check your connection and try again."),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _verifyOtp() async {
    final otp = otpControllers.map((e) => e.text).join();
    if (otp.length < 4) {
      _shakeController.forward().then((_) => _shakeController.reverse());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Please enter complete OTP"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final result = await authProvider.verifyOtp(widget.phone, otp);
    setState(() => _isLoading = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.verified, color: Colors.white),
              const SizedBox(width: 8),
              Text(result['message'] ?? "OTP Verified Successfully!"),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      final bool isNewUser = result['isNewUser'] ?? true;
      if (isNewUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CreateProfile(phone: widget.phone),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(
              fullName: authProvider.fullName ?? "",
              gender: authProvider.gender ?? "",
              education: authProvider.education ?? "",
              workExperience: authProvider.workExperience ?? "",
              salary: authProvider.salary ?? "0",
              imageFile: null,
              imageUrl: authProvider.imageUrl,
              skills: authProvider.skills ?? [],
              title: '',
              image: '',
            ),
          ),
        );
      }
    } else {
      _shakeController.forward().then((_) => _shakeController.reverse());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Text(result['message'] ?? "Invalid OTP"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _shakeController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 20),
                  
                  // Professional Header with Back Button
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          color: Colors.grey[700],
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).verifyPhoneNumber,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance the back button
                    ],
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Security Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.security_rounded,
                      size: 40,
                      color: Colors.blue[600],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Main Title
                  Text(
                    AppLocalizations.of(context).enterVerificationCode,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Subtitle with phone number
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: '${AppLocalizations.of(context).weSentCodeTo}\n'),
                        TextSpan(
                          text: widget.phone,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Edit phone number
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(phone: widget.phone),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    label: Text(
                      AppLocalizations.of(context).changePhoneNumber,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Professional OTP Input
                  AnimatedBuilder(
                    animation: _shakeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_shakeAnimation.value, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: otpControllers[index].text.isNotEmpty
                                      ? const Color(0xFF2196F3)
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                controller: otpControllers[index],
                                focusNode: focusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (index < 3) {
                                      focusNodes[index + 1].requestFocus();
                                    } else {
                                      focusNodes[index].unfocus();
                                    }
                                  } else if (value.isEmpty && index > 0) {
                                    focusNodes[index - 1].requestFocus();
                                  }
                                  setState(() {});
                                },
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Resend OTP Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _canResend
                              ? "Didn't receive the code?"
                              : "${AppLocalizations.of(context).resendCode} 00:${_start.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (_canResend) ...[
                          const SizedBox(width: 8),
                          _isLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
                                  ),
                                )
                              : TextButton(
                                  onPressed: _resendOtp,
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    minimumSize: Size.zero,
                                  ),
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2196F3),
                                    ),
                                  ),
                                ),
                        ],
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Professional Verify Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isLoading ? Colors.grey[300] : const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        elevation: _isLoading ? 0 : 2,
                        shadowColor: const Color(0xFF2196F3).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
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
                                const Icon(Icons.verified_user_outlined, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context).verifyCode,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
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







// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/Screens/Login.dart';
// import '../main_Screen/main_screen.dart';
// import '../provider/Auth_Provider.dart';
// import 'CreateProfile.dart';
//
// class OtpVerify extends StatefulWidget {
//   final String phone;
//   const OtpVerify({super.key,required this.phone});
//
//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }
//
// class _OtpVerifyState extends State<OtpVerify> {
//   final List<TextEditingController> otpControllers = List.generate(
//     4,
//     (_) => TextEditingController(),
//   );
//
//   bool _isLoading = false;
//   Timer? _timer;
//   int _start = 60;
//   bool _canResend = false;
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   void startTimer() {
//     _canResend = false;
//     _start = 60;
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_start == 0) {
//         setState(() {
//           _canResend = true;
//         });
//         _timer?.cancel();
//       } else {
//         setState(() {
//           _start--;
//         });
//       }
//     });
//   }
//
//   void _resendOtp() {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text("OTP resent successfully!")));
//     startTimer();
//   }
//
//   void _verifyOtp() async {
//     final otp = otpControllers.map((e) => e.text).join();
//     if (otp.length < 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter complete OTP")),
//       );
//       return;
//     }
//
//     setState(() => _isLoading = true);
//
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final result = await authProvider.verifyOtp(widget.phone, otp);
//     setState(() => _isLoading = false);
//
//     if (result['success'] == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "OTP Verified")),
//       );
//
//       final bool isNewUser = result['isNewUser'] ?? true;
//       if (isNewUser) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CreateProfile(phone: widget.phone),
//           ),
//         );
//       } else {
//         // Existing user → MainScreen
//         var selectedImage;
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => MainScreen(
//               fullName: authProvider.fullName ?? "",
//               gender: authProvider.gender ?? "",
//               education: authProvider.education ?? "",
//               workExperience: authProvider.workExperience ?? "",
//               salary: authProvider.salary ?? "0",
//               imageFile: null, // ⚠️ File ke liye null rakho
//               imageUrl: authProvider.imageUrl, // ✅ server se aaya URL
//               skills: authProvider.skills ?? [],
//               title: '',
//               image: '',
//             ),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "Invalid OTP")),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     for (var controller in otpControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color.fromRGBO(236, 236, 245, 1),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                   color: Colors.blue,
//                   icon: const Icon(Icons.arrow_back),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 const SizedBox(height: 50),
//                 const Center(
//                   child: Text(
//                     '4-digit code was sent to',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Center(
//                   child: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: widget.phone,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff0156ce),
//                           ),
//                         ),
//                         const WidgetSpan(
//                           child: Icon(
//                             Icons.edit,
//                             size: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Enter OTP',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     4,
//                     (index) => Container(
//                       width: 50,
//                       margin: const EdgeInsets.only(right: 20),
//                       child: TextField(
//                         controller: otpControllers[index],
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         maxLength: 1,
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             if (index < 3) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               FocusScope.of(context).unfocus();
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: TextButton(
//                     onPressed: _canResend ? _resendOtp : null,
//                     child: Text(
//                       _canResend
//                           ? "Resend OTP"
//                           : "Resend OTP 00:${_start.toString().padLeft(2, '0')}",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: _canResend ? Colors.blue : Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff0156ce),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _verifyOtp,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             'Verify Phone Number',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// old and new wala hai nahi hai ye sirf otp verify

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/Auth_Provider.dart';
// import 'CreateProfile.dart';
//
// class OtpVerify extends StatefulWidget {
//   final String phone;
//
//   const OtpVerify({super.key, required this.phone});
//
//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }
//
// class _OtpVerifyState extends State<OtpVerify> {
//   final List<TextEditingController> otpControllers =
//   List.generate(4, (_) => TextEditingController());
//
//   bool _isLoading = false;
//   Timer? _timer;
//   int _start = 60; // 1 minute countdown
//   bool _canResend = false;
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   void startTimer() {
//     _canResend = false;
//     _start = 60;
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_start == 0) {
//         setState(() {
//           _canResend = true;
//         });
//         _timer?.cancel();
//       } else {
//         setState(() {
//           _start--;
//         });
//       }
//     });
//   }
//
//   void _resendOtp() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("OTP resent successfully!")),
//     );
//     startTimer(); // restart the timer
//   }
//
//   void _verifyOtp() async {
//     final otp = otpControllers.map((e) => e.text).join();
//     if (otp.length < 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter complete OTP")),
//       );
//       return;
//     }
//     setState(() => _isLoading = true);
//
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final result = await authProvider.verifyOtp(widget.phone, otp);
//     setState(() => _isLoading = false);
//
//     if (result['success'] == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "OTP Verified")),
//       );
//         Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CreateProfile(
//            phone: widget.phone,
//         )),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "Invalid OTP")),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     for (var controller in otpControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color.fromRGBO(236, 236, 245, 1),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                   color: Colors.blue,
//                   icon: const Icon(Icons.arrow_back),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 const SizedBox(height: 50),
//                 const Center(
//                   child: Text(
//                     '4-digit code was sent to',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Center(
//                   child: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: widget.phone,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff0156ce),
//                           ),
//                         ),
//                         const WidgetSpan(
//                           child: Icon(Icons.edit, size: 14, color: Colors.grey),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Enter OTP',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     4,
//                         (index) => Container(
//                       width: 50,
//                       margin: const EdgeInsets.only(right: 20),
//                       child: TextField(
//                         controller: otpControllers[index],
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         maxLength: 1,
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             if (index < 3) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               FocusScope.of(context).unfocus();
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: TextButton(
//                     onPressed: _canResend ? _resendOtp : null,
//                     child: Text(
//                       _canResend
//                           ? "Resend OTP"
//                           : "Resend OTP 00:${_start.toString().padLeft(2, '0')}",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: _canResend ? Colors.blue : Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff0156ce),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _verifyOtp,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                       'Verify Phone Number',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// resend without time use

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/Auth_Provider.dart';
// import 'CreateProfile.dart';
//
// class OtpVerify extends StatefulWidget {
//   final String phone;
//
//   const OtpVerify({
//     super.key,
//     required this.phone,
//   });
//
//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }
//
// class _OtpVerifyState extends State<OtpVerify> {
//   final List<TextEditingController> otpControllers =
//   List.generate(4, (_) => TextEditingController());
//
//   bool _isLoading = false;
//
//   void _verifyOtp() async {
//     final otp = otpControllers.map((e) => e.text).join(); // OTP combine
//     if (otp.length < 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter complete OTP")),
//       );
//       return;
//     }
//     setState(() => _isLoading = true);
//
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final result = await authProvider.verifyOtp(widget.phone, otp);
//     setState(() => _isLoading = false);
//
//     if (result['success'] == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "OTP Verified")),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const CreateProfile()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "Invalid OTP")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color.fromRGBO(236, 236, 245, 1),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                   color: Colors.blue,
//                   icon: const Icon(Icons.arrow_back),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 const SizedBox(height: 50),
//                 const Center(
//                   child: Text(
//                     '4-digit code was sent to ',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Center(
//                   child: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: widget.phone,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff0156ce),
//                           ),
//                         ),
//                         const WidgetSpan(
//                           child: Icon(Icons.edit, size: 14, color: Colors.grey),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Enter OTP',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     4,
//                         (index) => Container(
//                       width: 50,
//                       margin: const EdgeInsets.only(right: 20),
//                       child: TextField(
//                         controller: otpControllers[index],
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         maxLength: 1,
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             if (index < 3) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               FocusScope.of(context).unfocus();
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Resend OTP 00:29',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff0156ce),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _verifyOtp,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                       'Verify Phone Number',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/Auth_Provider.dart';
// import 'CreateProfile.dart';
//
// class OtpVerify extends StatefulWidget {
//   final String phone;
//
//   const OtpVerify({
//     super.key,
//     required this.phone,
//   });
//
//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }
//
// class _OtpVerifyState extends State<OtpVerify> {
//   final List<TextEditingController> otpControllers =
//   List.generate(4, (_) => TextEditingController());
//
//   bool _isLoading = false;
//
//   void _verifyOtp() async {
//     final otp = otpControllers.map((e) => e.text).join(); // OTP combine
//     if (otp.length < 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter complete OTP")),
//       );
//       return;
//     }
//     setState(() => _isLoading = true);
//
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final result = await authProvider.verifyOtp(widget.phone, otp);
//     setState(() => _isLoading = false);
//
//     if (result['success'] == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "OTP Verified")),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const CreateProfile()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'] ?? "Invalid OTP")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           color: Color.fromRGBO(236, 236, 245, 1),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                   color: Colors.blue,
//                   icon: const Icon(Icons.arrow_back),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 const SizedBox(height: 50),
//                 const Center(
//                   child: Text(
//                     '4-digit code was sent to ',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Center(
//                   child: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: widget.phone,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff0156ce),
//                           ),
//                         ),
//                         const WidgetSpan(
//                           child: Icon(Icons.edit, size: 14, color: Colors.grey),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Enter OTP',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     4,
//                         (index) => Container(
//                       width: 50,
//                       margin: const EdgeInsets.only(right: 20),
//                       child: TextField(
//                         controller: otpControllers[index],
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         maxLength: 1,
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             if (index < 3) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               FocusScope.of(context).unfocus();
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Resend OTP 00:29',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff0156ce),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _verifyOtp,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                       'Verify Phone Number',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'CreateProfile.dart';
//
// class OtpVerify extends StatefulWidget {
//   const OtpVerify({super.key});
//
//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }
// class _OtpVerifyState extends State<OtpVerify> {
//   final List<TextEditingController> otpControllers =
//   List.generate(4, (_) => TextEditingController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true, // Ensure the layout resizes for keyboard
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//             color: Color.fromRGBO(236, 236, 245, 1)
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors: [
//           //     Colors.white,
//           //     Color(0xFF7C82FF),
//           //   ],
//           // ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                   color: Colors.blue,
//                   icon: const Icon(Icons.arrow_back),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 const SizedBox(height: 50),
//                 const Center(
//                   child: Text(
//                     '4-digit code was sent to ',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const Center(
//                   child: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: '93880*****',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Color(0xff0156ce),
//                           ),
//                         ),
//                         WidgetSpan(
//                           child: Icon(Icons.edit, size: 14, color: Colors.grey),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Enter OTP',
//                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     4,
//                         (index) => Container(
//                       width: 50,
//                       margin: const EdgeInsets.only(right: 20),
//                       child: TextField(
//                         controller: otpControllers[index],
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.center,
//                         maxLength: 1,
//                         decoration: const InputDecoration(
//                           counterText: '',
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             if (index < 3) {
//                               FocusScope.of(context).nextFocus();
//                             } else {
//                               // If last digit entered, hide keyboard
//                               FocusScope.of(context).unfocus();
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Resend OTP 00:29',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff0156ce),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     onPressed: () {
//                       // Optionally validate OTP here before navigating
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const CreateProfile()),
//                       );
//                     },
//                     child: const Text(
//                       'Verify Phone Number',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
