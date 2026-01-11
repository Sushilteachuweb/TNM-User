import 'dart:io';
import 'package:flutter/material.dart';
import '../Services/Api_service.dart';
import '../SessionManager/SessionManager.dart';

class AuthProvider with ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;
  String? _otp;
  String? _message;

  // ✅ Existing user profile data
  String? fullName;
  String? gender;
  String? education;
  String? workExperience;
  String? salary;
  List<String>? skills;
  String? imageUrl; // optional

  bool get isLoading => _isLoading;

  String? get otp => _otp;

  String? get message => _message;

  // -------- Send OTP ---------------------
  Future<bool> sendOtp(String phone) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _apiServices.sendOtp(phone);

      if (response["success"] == true) {
        print('oottpp ${response["otp"]?.toString()}');
        _otp = response["otp"]?.toString();
        _message = response["message"];
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _message = response["message"];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;

      if (e is SocketException) {
        _message = "Please connect to the internet";
      } else {
        _message = e.toString();
      }

      notifyListeners();
      return false;
    }
  }

// -------- Verify OTP ---------------------
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiServices.verifyOtp(phone, otp);

      if (response['success'] == true) {
        print("printttttttt${response['Result']}");
        // ✅ Agar login success hua to session save karo
        await SessionManager.saveLogin(phone);

        if (response['isNewUser'] == false) {
          fullName = response['fullName'] ?? '';
          gender = response['gender'] ?? '';
          education = response['education'] ?? '';
          workExperience = response['workExperience'] ?? '';
          salary = response['salary'] ?? '';
          skills = List<String>.from(response['skills'] ?? []);
          imageUrl = response['imageUrl'] ?? '';
        }
      }

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;

      if (e is SocketException) {
        _message = "Please connect to the internet";
        notifyListeners();
        return {
          "success": false,
          "message": "Please connect to the internet",
        };
      }

      notifyListeners();
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}





// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../Services/Api_service.dart';
//
// class AuthProvider with ChangeNotifier {
//   final ApiServices _apiServices = ApiServices();
//
//   bool _isLoading = false;
//   String? _otp;
//   String? _message;
//
//   // ✅ Existing user profile data
//   String? fullName;
//   String? gender;
//   String? education;
//   String? workExperience;
//   String? salary;
//   List<String>? skills;
//   String? imageUrl; // optional
//
//   bool get isLoading => _isLoading;
//   String? get otp => _otp;
//   String? get message => _message;
//
//   // -------- Send OTP ---------------------
//   Future<bool> sendOtp(String phone) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await _apiServices.sendOtp(phone);
//
//       if (response["success"] == true) {
//         _otp = response["otp"]?.toString();
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//
//       if (e is SocketException) {
//         _message = "Please connect to the internet";
//       } else {
//         _message = e.toString();
//       }
//
//       notifyListeners();
//       return false;
//     }
//   }
//
//   // -------- Verify OTP ---------------------
//   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await _apiServices.verifyOtp(phone, otp);
//
//       // ✅ Agar existing user hai, unka profile data store kare
//       if (response['success'] == true && response['isNewUser'] == false) {
//         fullName = response['fullName'] ?? '';
//         gender = response['gender'] ?? '';
//         education = response['education'] ?? '';
//         workExperience = response['workExperience'] ?? '';
//         salary = response['salary'] ?? '';
//         skills = List<String>.from(response['skills'] ?? []);
//         imageUrl = response['imageUrl'] ?? '';
//       }
//
//       _isLoading = false;
//       notifyListeners();
//       return response;
//     } catch (e) {
//       _isLoading = false;
//
//       if (e is SocketException) {
//         _message = "Please connect to the internet";
//         notifyListeners();
//         return {
//           "success": false,
//           "message": "Please connect to the internet",
//         };
//       }
//
//       notifyListeners();
//       return {
//         "success": false,
//         "message": e.toString(),
//       };
//     }
//   }
// }
//




// import 'package:flutter/material.dart';
// import '../Services/Api_service.dart';
//
// class AuthProvider with ChangeNotifier {
//   final ApiServices _apiServices = ApiServices();
//
//   bool _isLoading = false;
//   String? _otp;
//   String? _message;
//
//   // ✅ Existing user profile data
//   String? fullName;
//   String? gender;
//   String? education;
//   String? workExperience;
//   String? salary;
//   List<String>? skills;
//   String? imageUrl; // optional
//
//   bool get isLoading => _isLoading;
//   String? get otp => _otp;
//   String? get message => _message;
//
//
//   // -------- Send OTP ---------------------
//   Future<bool> sendOtp(String phone) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await _apiServices.sendOtp(phone);
//
//       if (response["success"] == true) {
//         _otp = response["otp"]?.toString();
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _message = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }
//
//   // -------- Verify OTP ---------------------
//   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await _apiServices.verifyOtp(phone, otp);
//
//       // ✅ Agar existing user hai, unka profile data store kare
//       if (response['success'] == true && response['isNewUser'] == false) {
//         fullName = response['fullName'] ?? '';
//         gender = response['gender'] ?? '';
//         education = response['education'] ?? '';
//         workExperience = response['workExperience'] ?? '';
//         salary = response['salary'] ?? '';
//         skills = List<String>.from(response['skills'] ?? []);
//         imageUrl = response['imageUrl'] ?? '';
//       }
//
//       _isLoading = false;
//       notifyListeners();
//       return response;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return {
//         "success": false,
//         "message": e.toString(),
//       };
//     }
//   }
// }










// old and new user conditon nahi laga hai isme

// import 'package:flutter/material.dart';
// import '../Services/Api_service.dart';
//
// class AuthProvider with ChangeNotifier {
//   final ApiServices _apiServices = ApiServices();
//
//   bool _isLoading = false;
//   String? _otp;
//   String? _message;
//
//   bool get isLoading => _isLoading;
//   String? get otp => _otp;
//   String? get message => _message;
//
//   // -------- ------- Send OTP ---------------------
//   Future<bool> sendOtp(String phone) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await _apiServices.sendOtp(phone);
//
//       if (response["success"] == true) {
//         _otp = response["otp"]?.toString();
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _message = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }
//
//   // --- Verify OTP ---
//   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await _apiServices.verifyOtp(phone, otp);
//
//       _isLoading = false;
//       notifyListeners();
//
//       return response;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return {
//         "success": false,
//         "message": e.toString(),
//       };
//     }
//   }
// }






//
// // Check if user exists
// Future<bool> isExistingUser(String phone) async {
//   try {
//     return await _apiServices.isExistingUser(phone);
//   } catch (e) {
//     _message = e.toString();
//     return false;
//   }
// }





















//
// import 'package:flutter/material.dart';
// import '../Services/Api_service.dart';
//
// class AuthProvider with ChangeNotifier {
//   final ApiServices _apiServices = ApiServices();
//
//   bool _isLoading = false;
//   String? _otp;
//   String? _message;
//
//   bool get isLoading => _isLoading;
//   String? get otp => _otp;
//   String? get message => _message;
//
//   // --- Send OTP ---
//   Future<bool> sendOtp(String phone) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await _apiServices.sendOtp(phone);
//
//       if (response["success"] == true) {
//         _otp = response["otp"]?.toString();
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _message = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }
//
//   // --- Verify OTP ---
//   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await _apiServices.verifyOtp(phone, otp);
//
//       _isLoading = false;
//       notifyListeners();
//
//       return response;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       return {
//         "success": false,
//         "message": e.toString(),
//       };
//     }
//   }
// }





// import 'package:flutter/material.dart';
// import '../Services/Api_service.dart';
// class AuthProvider with ChangeNotifier {
//   final ApiServices _apiServices = ApiServices();
//
//   bool _isLoading = false;
//   String? _otp;
//   String? _message;
//
//   bool get isLoading => _isLoading;
//   String? get otp => _otp;
//   String? get message => _message;
//
//   Future<bool> sendOtp(String phone) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await _apiServices.sendOtp(phone);
//
//       if (response["success"] == true) {
//         _otp = response["otp"].toString();
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         _message = response["message"];
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _message = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }
// }
