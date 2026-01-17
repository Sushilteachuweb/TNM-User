// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:naukri_mitra_jobs/provider/ProfileProvider.dart';
//
// class CreateProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//
//   Future<Map<String, dynamic>> saveProfile(
//       BuildContext context, {
//         required String fullName,
//         required String phone,
//         required String gender,
//         required String education,
//         required bool isExperienced,
//         required int totalExperience,
//         required int currentSalary,
//         required String email,
//         File? image,
//         String jobCategory = 'Development',
//         String skills = 'Testing, Flutter',
//       }) async {
//     final uri = Uri.parse('http://api.thenaukrimitra.com/api/user/create');
//
//     try {
//       final request = http.MultipartRequest('POST', uri);
//
//       request.fields.addAll({
//         'fullName': fullName,
//         'phone': phone,
//         'gender': gender.toLowerCase(),
//         'education': education,
//         'jobCategory': jobCategory,
//         'skills': skills,
//         'isExperienced': isExperienced.toString(),
//         'totalExperience': totalExperience.toString(),
//         'currentSalary': currentSalary.toString(),
//         'email': email,
//         'userLocation': "Delhi",
//         'language': jsonEncode(["English", "Hindi"]),
//       });
//
//       // ✅ Image upload
//       // if (image != null) {
//       //   request.files.add(
//       //     await http.MultipartFile.fromPath('image', image.path),
//       //   );
//       // }
//
//       final streamedResponse = await request.send();
//       final respStr = await streamedResponse.stream.bytesToString();
//
//       if (kDebugMode) {
//         print("🔵 Status Code: ${streamedResponse.statusCode}");
//         print("🟢 Raw Response: $respStr");
//       }
//
//       if (streamedResponse.statusCode >= 200 &&
//           streamedResponse.statusCode < 300) {
//         if (respStr.isEmpty) {
//           return {
//             "success": true,
//             "message": "User profile created successfully (empty response)",
//             "data": {}
//           };
//         }
//         final data = json.decode(respStr);
//
//         // ✅ Cookie save
//         final rawCookie = streamedResponse.headers['set-cookie'];
//         if (rawCookie != null) {
//           final pref = await SharedPreferences.getInstance();
//           await pref.setString("cookie", rawCookie);
//           if (kDebugMode) print("Cookie saved = $rawCookie");
//         }
//
//         // ✅ Naya response handle
//         if (data['success'] == true && data['data'] != null) {
//           return {
//             "success": true,
//             "message": data['data']['message'] ?? "Profile created",
//             "session": data['data']['session'] ?? {},
//             "user": data['data']['user'] ?? {},
//           };
//         }
//
//         return {
//           "success": false,
//           "message": data['message'] ?? "Something went wrong",
//           "data": data
//         };
//       } else {
//         return {
//           "success": false,
//           "message": "Failed: ${streamedResponse.statusCode}",
//           "body": respStr
//         };
//       }
//     } catch (e, st) {
//       if (kDebugMode) print("❌ Exception: $e\n$st");
//       return {"success": false, "message": "Error: $e"};
//     }
//   }
// }
//

//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:naukri_mitra_jobs/provider/ProfileProvider.dart';
//
// class CreateProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//
//   Future<Map<String, dynamic>> saveProfile(
//       BuildContext context, {
//         required String fullName,
//         required String phone,
//         required String gender,
//         required String education,
//         required bool isExperienced,
//         required int totalExperience,
//         required int currentSalary,
//         required String email,
//         File? image,
//         String jobCategory = 'Development',
//         String skills = 'Testing, Flutter',
//       }) async {
//     final uri = Uri.parse('http://api.thenaukrimitra.com/api/user/create');
//
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       final request = http.MultipartRequest('POST', uri);
//
//       request.fields.addAll({
//         'fullName': fullName,
//         'phone': phone,
//         'gender': gender.toLowerCase(),
//         'education': education,
//         'jobCategory': jobCategory,
//         'skills': skills,
//         'isExperienced': isExperienced.toString(),
//         'totalExperience': totalExperience.toString(),
//         'currentSalary': currentSalary.toString(),
//         'email': email,
//         'userLocation': "Delhi",
//         'language': jsonEncode(["English", "Hindi"]),
//       });
//
//       // ✅ Image bhejna ho to
//       // if (image != null) {
//       //   request.files.add(
//       //     await http.MultipartFile.fromPath('image', image.path),
//       //   );
//       // }
//
//       if (kDebugMode) {
//         print("📤 Sending request to: $uri");
//         print("📑 Fields: ${request.fields}");
//       }
//
//       final streamedResponse = await request.send();
//       final respStr = await streamedResponse.stream.bytesToString();
//
//       if (kDebugMode) {
//         print("🔵 Status Code: ${streamedResponse.statusCode}");
//         print("🟢 Raw Response: $respStr");
//       }
//
//       isLoading = false;
//       notifyListeners();
//
//       if (streamedResponse.statusCode >= 200 &&
//           streamedResponse.statusCode < 300) {
//         final data = json.decode(respStr);
//
//         // ✅ Cookie Save (optional)
//         final rawCookie = streamedResponse.headers['set-cookie'];
//         if (rawCookie != null) {
//           final pref = await SharedPreferences.getInstance();
//           await pref.setString("cookie", rawCookie);
//           if (kDebugMode) print("🍪 Cookie saved = $rawCookie");
//         }
//
//         final bool success = data['success'] ?? false;
//         final String message = data['message'] ?? "Unknown error";
//
//         final session = data['data']?['session'];
//         final user = data['data']?['user'];
//
//         if (success) {
//           // ✅ Ab turant Profile fetch kar lo taaki UI update ho jaye
//           await Provider.of<ProfileProvider>(context, listen: false)
//               .fetchProfile();
//         }
//
//         return {
//           "success": success,
//           "message": message,
//           "session": session,
//           "user": user,
//         };
//       } else {
//         return {
//           "success": false,
//           "message": "Failed: ${streamedResponse.statusCode}",
//           "body": respStr
//         };
//       }
//     } catch (e, st) {
//       isLoading = false;
//       notifyListeners();
//
//       if (kDebugMode) {
//         print("❌ Exception: $e\n$st");
//       }
//       return {"success": false, "message": "Error: $e"};
//     }
//   }
// }
//






// 29 -09-2025

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naukri_mitra_jobs/providers/ProfileProvider.dart';

class CreateProfileProvider with ChangeNotifier {
  bool isLoading = false;

  Future<Map<String, dynamic>> saveProfile(
      BuildContext context, {
        required String fullName,
        required String phone,
        required String gender,
        required String education,
        required bool isExperienced,
        required int totalExperience,
        required int currentSalary,
        required String email,
        File? image,
        String jobCategory = 'Development',
        String skills = 'Testing, Flutter',
      }) async {
    final uri = Uri.parse('https://api.thenaukrimitra.com/api/user/create');

    try {
      final request = http.MultipartRequest('POST', uri);

      request.fields.addAll({
        'fullName': fullName,
        'phone': phone,
        'gender': gender.toLowerCase(),
        'education': education,
        'jobCategory': jobCategory,
        'skills': skills,
        'isExperienced': isExperienced.toString(),
        'totalExperience': totalExperience.toString(),
        'currentSalary': currentSalary.toString(),
        'email': email,
        'userLocation': "Delhi",
        'language': jsonEncode(["English", "Hindi"]),
      });

      // ✅ Add profile image with size validation
      if (image != null && image.existsSync()) {
        // Check image size before upload (max 5MB)
        final fileSize = await image.length();
        final fileSizeInMB = fileSize / (1024 * 1024);
        
        if (kDebugMode) print("🖼️ Profile image size: ${fileSizeInMB.toStringAsFixed(2)} MB");
        
        if (fileSizeInMB > 5) {
          if (kDebugMode) print("❌ Profile image too large: ${fileSizeInMB.toStringAsFixed(2)} MB (max 5MB)");
          return {
            "success": false,
            "message": "Profile image is too large. Maximum size is 5MB. Your file is ${fileSizeInMB.toStringAsFixed(1)}MB",
          };
        }
        
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
        if (kDebugMode) print("🖼️ Profile image added: ${image.path} (${fileSizeInMB.toStringAsFixed(2)} MB)");
      } else {
        if (kDebugMode) print("⚠️ No profile image provided");
      }

      if (kDebugMode) {
        print("📤 Sending request to: $uri");
        print("📑 Fields: ${request.fields}");
      }

      final streamedResponse = await request.send();
      final respStr = await streamedResponse.stream.bytesToString();

      if (kDebugMode) {
        print("🔵 Status Code: ${streamedResponse.statusCode}");
        print("🟢 Raw Response: $respStr");
      }

      if (streamedResponse.statusCode >= 200 &&
          streamedResponse.statusCode < 300) {
        
        if (respStr.isEmpty) {
          return {
            "success": true,
            "message": "User profile created successfully (empty response)",
            "data": {},
          };
        }

        if (streamedResponse.headers['content-type']?.contains('application/json') ?? false) {
          final data = json.decode(respStr);
          if (kDebugMode) print('Response ===> $data');

          // ✅ Check for nested error in data.success
          if (data['data'] != null && data['data']['success'] == false) {
            if (kDebugMode) print("❌ Backend returned nested error: ${data['data']['message']}");
            return {
              "success": false,
              "message": data['data']['message'] ?? "Profile creation failed",
              "data": data['data'],
            };
          }

          // ✅ FIRST: Save the new cookie
          final rawCookie = streamedResponse.headers['set-cookie'];
          if (rawCookie != null) {
            final pref = await SharedPreferences.getInstance();
            await pref.setString("cookie", rawCookie);
            if (kDebugMode) print("🍪 New cookie saved after profile creation: $rawCookie");
            
            // Small delay to ensure cookie is persisted
            await Future.delayed(const Duration(milliseconds: 200));
            
            // ✅ THEN: Fetch profile with the new cookie
            if (kDebugMode) print("📡 Fetching profile with new cookie...");
            await Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
          } else {
            if (kDebugMode) print("⚠️ No new cookie received from profile creation API");
          }

          // ✅ New Response Structure Handle
          final bool success = data['success'] ?? false;
          final String message = data['message'] ?? "Unknown error";

          final session = data['data']?['session'];
          final user = data['data']?['user'];

          return {
            "success": success,
            "message": message,
            "session": session,
            "user": user,
          };
        } else {
          return {
            "success": false,
            "message": "Invalid response format",
            "body": respStr,
          };
        }
      } else {
        String errorMessage;
        switch (streamedResponse.statusCode) {
          case 400:
            errorMessage = "Bad Request: Invalid data provided";
            break;
          case 401:
            errorMessage = "Unauthorized: Authentication required";
            break;
          case 413:
            errorMessage = "File size exceeds server limit. Please choose a smaller image (max 5MB).";
            if (kDebugMode) print("❌ 413 Error: Request Entity Too Large");
            break;
          case 500:
            errorMessage = "Server error. Please try again later.";
            break;
          default:
            errorMessage = "Failed: ${streamedResponse.statusCode}";
        }
        return {"success": false, "message": errorMessage, "body": respStr};
      }
    } catch (e, st) {
      if (kDebugMode) {
        print("❌ Exception: $e\n$st");
      }
      return {"success": false, "message": "Error: $e"};
    }
  }
}















// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:naukri_mitra_jobs/provider/ProfileProvider.dart';
//
// class CreateProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//
//   Future<Map<String, dynamic>> saveProfile(
//       context, {
//         required String fullName,
//         required String phone,
//         required String gender,
//         required String education,
//         required bool isExperienced,
//         required int totalExperience,
//         required int currentSalary,
//         required String email,
//         File? image,
//         String jobCategory = 'Development',
//         String skills = 'Testing, Flutter',
//       }) async {
//     final uri = Uri.parse('http://api.thenaukrimitra.com/api/user/create');
//
//     try {
//       final request = http.MultipartRequest('POST', uri);
//
//       request.fields.addAll({
//         'fullName': fullName,
//         'phone': phone,
//         'gender': "male",
//         'education': education,
//         'jobCategory': jobCategory,
//         'skills': skills,
//         'isExperienced': isExperienced.toString(),
//         'totalExperience': totalExperience.toString(),
//         'currentSalary': currentSalary.toString(),
//         'email': email,
//       });
//
//       if (kDebugMode) {
//         print("📤 Sending request to: $uri");
//         print("📑 Fields: ${request.fields}");
//       }
//       final streamedResponse = await request.send();
//       final respStr = await streamedResponse.stream.bytesToString();
//
//       if (kDebugMode) {
//         print("🔵 Status Code: ${streamedResponse.statusCode}");
//         print("🟢 Raw Response: $respStr");
//       }
//
//       if (streamedResponse.statusCode >= 200 &&
//           streamedResponse.statusCode < 300) {
//         Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
//
//         if (respStr.isEmpty) {
//           return {
//             "success": true,
//             "message": "User profile created successfully (empty response)",
//             "data": {},
//           };
//         }
//         if (streamedResponse.headers['content-type']?.contains(
//           'application/json',
//         ) ??
//             false) {
//           final data = json.decode(respStr);
//           print('Response===>${data}');
//           final rawCookie = streamedResponse.headers['set-cookie'];
//           print("cookie=$rawCookie");
//
//           if (rawCookie != null) {
//             final pref = await SharedPreferences.getInstance();
//             await pref.setString("cookie", rawCookie);
//             print("cookiesaved=$rawCookie");
//           }
//           if (data['data'] != null && data['data']['success'] == false) {
//             return {
//               "success": false,
//               "message": data['data']['message'] ?? "Unknown error",
//               "data": data,
//             };
//           }
//           return {
//             "success": data['success'] ?? true,
//             "message": data['message'] ?? "User profile created successfully",
//             "data": data,
//           };
//         } else {
//           return {
//             "success": false,
//             "message": "Invalid response format",
//             "body": respStr,
//           };
//         }
//       } else {
//         String errorMessage;
//         switch (streamedResponse.statusCode) {
//           case 400:
//             errorMessage = "Bad Request: Invalid data provided";
//             break;
//           case 401:
//             errorMessage = "Unauthorized: Authentication required";
//             break;
//           default:
//             errorMessage = "Failed: ${streamedResponse.statusCode}";
//         }
//         return {"success": false, "message": errorMessage, "body": respStr};
//       }
//     } catch (e, st) {
//       if (kDebugMode) {
//         print("❌ Exception: $e\n$st");
//       }
//       return {"success": false, "message": "Error: $e"};
//     }
//   }
// }






// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
//
// class CreateProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//
//   Future<Map<String, dynamic>> saveProfile({
//     required String fullName,
//     required String gender,
//     required String education,
//     required bool isExperienced,
//     required File? image,
//     required String phone,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//     final uri = Uri.parse('http://api.thenaukrimitra.com/api/user/create');
//
//     try {
//       final request = http.MultipartRequest('POST', uri);
//       request.fields.addAll({
//         'fullName': fullName,
//         'phone': phone,
//         'gender': gender,
//         'education': education,
//         'jobCategory': 'Development',
//         'skills': 'Testing, Python',
//         'isExperienced': isExperienced.toString(),
//         'totalExperience': isExperienced ? '5' : '0',
//         'currentSalary': isExperienced ? '50000' : '0',
//         'email': '${fullName.toLowerCase().replaceAll(" ", "")}@gmail.com',
//       });
//
//       // 👉 Add file only if present
//       // if (image != null) {
//       //   final filename = path.basename(image.path);
//       //   print("📂 Attaching file: $filename");
//       //   request.files.add(
//       //     await http.MultipartFile.fromPath('image', image.path, filename: filename),
//       //   );
//       // } else {
//       //   print("📂 No file attached.");
//       // }
//
//       // 👉 Debug: print what’s being sent
//       print("📤 Sending request to: $uri");
//       print("📑 Fields: ${request.fields}");
//
//       // 👉 Send
//       final streamedResponse = await request.send();
//       final respStr = await streamedResponse.stream.bytesToString();
//
//       print("🔵 Status Code: ${streamedResponse.statusCode}");
//       print("🟢 Raw Response: $respStr");
//
//       isLoading = false;
//       notifyListeners();
//
//       if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
//         final data = json.decode(respStr);
//         return {
//           "success": true,
//           "message": data["message"] ?? "User successfully",
//           "data": data,
//         };
//       } else {
//         return {
//           "success": false,
//           "message": "Failed: ${streamedResponse.statusCode}",
//           "body": respStr,
//         };
//       }
//     } catch (e, st) {
//       print("❌ Exception: $e\n$st");
//       isLoading = false;
//       notifyListeners();
//       return {"success": false, "message": "Error: $e"};
//     }
//   }
// }
