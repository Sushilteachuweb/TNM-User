//
// bina resume ka hai
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/ProfileModel.dart';
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("🍪 get cookie= $cookie");
//
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//       );
//
//       print("📡 Fetch Profile Status: ${response.statusCode}");
//       print("📩 Fetch Profile Response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//           print("👤 User loaded: ${user!.fullName}");
//         }
//       } else {
//         print("❌ Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Exception in fetchProfile: $e");
//     }
//     isLoading = false;
//     notifyListeners();
//   }
//
//   // ✅ Update Profile (Multipart + PUT with gender normalize)
//   Future<bool> updateProfile(Map<String, dynamic> updatedData) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("🍪 Update cookie = $cookie");
//
//       var request = http.MultipartRequest(
//         "PUT",
//         Uri.parse("http://api.thenaukrimitra.com/api/user/update-profile"),
//       );
//
//       // ✅ Gender ko lowercase bhejna (server enum fix ke liye)
//       if (updatedData["gender"] != null) {
//         updatedData["gender"] =
//             updatedData["gender"].toString().toLowerCase();
//       }
//
//       updatedData.forEach((key, value) {
//         if (value != null) {
//           request.fields[key] = value.toString();
//         }
//       });
//
//       print("📤 Sending fields to Update API:");
//       request.fields.forEach((key, value) {
//         print("   ➡️ $key = $value");
//       });
//
//       request.headers.addAll({
//         "Cookie": cookie,
//         "Accept": "application/json",
//       });
//
//       print("📡 Sending Update request...");
//       var response = await request.send();
//       final respStr = await response.stream.bytesToString();
//
//       print("✅ Update API status: ${response.statusCode}");
//       print("📩 Update API raw response: $respStr");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(respStr);
//
//         if (data["success"] == true) {
//           if (data["user"] != null) {
//             user = ProfileModel.fromJson(data["user"]);
//             print("🎉 User updated successfully: ${user!.fullName}");
//           }
//           await fetchProfile(); // 🔄 Refresh profile
//           isLoading = false;
//           notifyListeners();
//           return true;
//         } else {
//           print("⚠️ Update failed: ${data["message"]}");
//         }
//       } else {
//         print("❌ Server error in update: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Exception in updateProfile: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }




// resume ke sath use hai correct

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../ model/ProfileModel.dart';
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("🍪 get cookie= $cookie");
//
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//       );
//
//       print("📡 Fetch Profile Status: ${response.statusCode}");
//       print("📩 Fetch Profile Response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//           print("👤 User loaded: ${user!.fullName}");
//         }
//       } else {
//         print("❌ Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Exception in fetchProfile: $e");
//     }
//     isLoading = false;
//     notifyListeners();
//   }
//
//   /// Update Profile with optional profile image & resume
//   Future<bool> updateProfile({
//     required Map<String, dynamic> updatedData,
//     File? profileImage,
//     File? resumeFile,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("🍪 Update cookie = $cookie");
//
//       var request = http.MultipartRequest(
//         "PUT",
//         Uri.parse("http://api.thenaukrimitra.com/api/user/update-profile"),
//       );
//
//       // ✅ Gender normalize
//       if (updatedData["gender"] != null) {
//         updatedData["gender"] = updatedData["gender"].toString().toLowerCase();
//       }
//
//       // ✅ Add text fields
//       updatedData.forEach((key, value) {
//         if (value != null) {
//           request.fields[key] = value.toString();
//         }
//       });
//
//       // ✅ Add profile image if provided
//       if (profileImage != null && profileImage.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'image', // API field name
//           profileImage.path,
//         ));
//         print("🖼️ Profile image added: ${profileImage.path}");
//       }
//
//       // ✅ Add resume file if provided
//       if (resumeFile != null && resumeFile.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'resume', // API field name
//           resumeFile.path,
//         ));
//         print("📄 Resume added: ${resumeFile.path}");
//       }
//
//       request.headers.addAll({
//         "Cookie": cookie,
//         "Accept": "application/json",
//       });
//
//       print("📡 Sending Update request...");
//       var response = await request.send();
//       final respStr = await response.stream.bytesToString();
//
//       print("✅ Update API status: ${response.statusCode}");
//       print("📩 Update API raw response: $respStr");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(respStr);
//
//         if (data["success"] == true) {
//           if (data["user"] != null) {
//             user = ProfileModel.fromJson(data["user"]);
//             print("🎉 User updated successfully: ${user!.fullName}");
//           } else if (user != null) {
//             // ⚡ Local merge if API user not returned
//             user = ProfileModel(
//               id: user!.id,
//               fullName: updatedData["fullName"] ?? user!.fullName,
//               phone: updatedData["phone"] ?? user!.phone,
//               gender: updatedData["gender"] ?? user!.gender,
//               email: updatedData["email"] ?? user!.email,
//               image: profileImage?.path ?? user!.image,
//               resume: resumeFile?.path ?? user!.resume,
//               education: updatedData["education"] ?? user!.education,
//               jobCategory: updatedData["jobCategory"] ?? user!.jobCategory,
//               isExperienced:
//               updatedData["isExperienced"] ?? user!.isExperienced,
//               totalExperience:
//               updatedData["totalExperience"] ?? user!.totalExperience,
//               currentSalary:
//               updatedData["currentSalary"] ?? user!.currentSalary,
//             );
//             print("🔄 Local user object merged with updated data");
//           }
//
//           await fetchProfile(); // Refresh profile after update
//           isLoading = false;
//           notifyListeners();
//           return true;
//         } else {
//           print("⚠️ Update failed: ${data["message"]}");
//         }
//       } else {
//         print("❌ Server error in update: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Exception in updateProfile: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }



// working code 10-09-2025
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/ProfileModel.dart';
//
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   // Fetch profile
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//         }
//       } else {
//         print("Fetch profile failed: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Fetch profile error: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   // Update profile - only text fields
//   Future<bool> updateProfile({
//     required String fullName,
//     required String email,
//     required String gender,
//     required String education,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//
//       final response = await http.put(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/update-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//         body: json.encode({
//           "fullName": fullName,
//           "email": email,
//           "gender": gender.toLowerCase(),
//           "education": education,
//         }),
//       );
//
//       final data = json.decode(response.body);
//       if (response.statusCode == 200 && data["success"] == true) {
//         if (data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//         }
//         await fetchProfile();
//         return true;
//       } else {
//         print("Update failed: ${response.body}");
//       }
//     } catch (e) {
//       print("Update profile error: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }







// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/ProfileModel.dart';
//
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   /// Fetch profile
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//         }
//       } else {
//         print("Fetch profile failed: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Fetch profile exception: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   /// Update profile (text fields + optional image/resume)
//   Future<bool> updateProfile({
//     required String fullName,
//     required String email,
//     required String gender,
//     required String education,
//     File? profileImage,
//     File? resumeFile,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//
//       // Create Multipart request
//       var request = http.MultipartRequest(
//         "PUT",
//         Uri.parse("http://api.thenaukrimitra.com/api/user/update-profile"),
//       );
//
//       // Add text fields
//       request.fields['fullName'] = fullName;
//       request.fields['email'] = email;
//       request.fields['gender'] = gender.toLowerCase();
//       request.fields['education'] = education;
//
//       // Add profile image if exists
//       if (profileImage != null && profileImage.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'image',
//           profileImage.path,
//         ));
//       }
//
//       // Add resume if exists
//       if (resumeFile != null && resumeFile.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'resume',
//           resumeFile.path,
//         ));
//       }
//
//       // Headers
//       request.headers.addAll({
//         "Cookie": cookie,
//         "Accept": "application/json",
//       });
//
//       // Send request
//       var response = await request.send();
//       final respStr = await response.stream.bytesToString();
//
//       if (response.statusCode == 200) {
//         final data = json.decode(respStr);
//         if (data["success"] == true) {
//           if (data["user"] != null) {
//             user = ProfileModel.fromJson(data["user"]);
//           }
//           await fetchProfile(); // refresh profile
//           isLoading = false;
//           notifyListeners();
//           return true;
//         } else {
//           print("Update failed: ${data['message']}");
//         }
//       } else {
//         print("Server error: ${response.statusCode}, $respStr");
//       }
//     } catch (e) {
//       print("Update profile exception: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }



// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http_parser/http_parser.dart';
//
// import '../ model/ProfileModel.dart';
//
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//           if (kDebugMode) print("✅ Profile fetched: ${user?.fullName}");
//         }
//       } else {
//         if (kDebugMode) print("Failed to fetch profile: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Fetch profile error: $e");
//     }
//     isLoading = false;
//     notifyListeners();
//   }
//
//   Future<bool> updateProfile({
//     required String fullName,
//     required String email,
//     required String gender,
//     required String education,
//     File? profileImage,
//     File? resumeFile,
//   }) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//
//       var request = http.MultipartRequest(
//         "PUT",
//         Uri.parse("http://api.thenaukrimitra.com/api/user/update-profile"),
//       );
//
//       request.fields["fullName"] = fullName;
//       request.fields["email"] = email;
//       request.fields["gender"] = gender.toLowerCase();
//       request.fields["education"] = education;
//
//       if (profileImage != null && profileImage.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'image',
//           profileImage.path,
//           contentType: MediaType('image', 'jpeg'),
//         ));
//       }
//
//       if (resumeFile != null && resumeFile.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'resume',
//           resumeFile.path,
//         ));
//       }
//
//       request.headers.addAll({
//         "Cookie": cookie,
//         "Accept": "application/json",
//       });
//
//       var response = await request.send();
//       final respStr = await response.stream.bytesToString();
//       final data = json.decode(respStr);
//
//       if (response.statusCode == 200 && data["success"] == true) {
//         if (data["user"] != null) user = ProfileModel.fromJson(data["user"]);
//         await fetchProfile();
//         isLoading = false;
//         notifyListeners();
//         return true;
//       } else {
//         print("Update failed: $respStr");
//       }
//     } catch (e) {
//       print("UpdateProfile error: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }





//ye sahi hai 29-09-2025


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../models/profile_model.dart';
import '../models/job_category_model.dart';

class ProfileProvider with ChangeNotifier {

  bool isLoading = false;
  bool hasSessionError = false; // Track session errors to prevent infinite loops
  ProfileModel? user;
  
  // Job Categories
  List<JobCategoryModel> jobCategories = [];
  bool isCategoriesLoading = false;

  Future<void> fetchProfile() async {
    // Prevent multiple simultaneous calls
    if (isLoading) {
      print("🔄 fetchProfile already in progress, skipping...");
      return;
    }
    
    isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final cookie = prefs.getString("cookie") ?? "";
      print("🍪 Cookie used for fetchProfile: $cookie");

      if (cookie.isEmpty) {
        print("❌ No cookie found! User might not be logged in.");
        hasSessionError = true;
        isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(
        Uri.parse("https://api.thenaukrimitra.com/api/user/get-profile"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Cookie": cookie,
        },
      );

      print("📡 Response status: ${response.statusCode}");
      print("📩 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("📦 Decoded JSON: $data");

        if (data["success"] == true && data["user"] != null) {
          user = ProfileModel.fromJson(data["user"]);
          hasSessionError = false; // Reset session error flag
          print("✅ User profile loaded successfully!");
          print("   Name: ${user?.fullName}");
          print("   Email: ${user?.email}");
          print("   Phone: ${user?.phone}");
          print("   Skills: ${user?.skills}");
          print("   Languages: ${user?.language}");
          print("   Current Salary: ${user?.currentSalary}");
          print("   User Location: ${user?.userLocation}");
          print("   Job Category: ${user?.jobCategory}");
          print("   Image URL from API: ${data["user"]["image"]}");
          print("   Image in model: ${user?.image}");
        } else {
          print("❌ Backend Error: ${data["message"]}");
          if (data["message"]?.toString().contains("role=user") == true) {
            print("⚠️ User role issue - contact backend team");
          }
          // Check for session errors
          if (data["message"]?.toString().contains("session not found") == true ||
              data["message"]?.toString().contains("Please login again") == true) {
            print("🚨 Session expired - marking hasSessionError = true");
            hasSessionError = true;
            await _clearInvalidSession();
          }
        }
      } else if (response.statusCode == 400) {
        final data = json.decode(response.body);
        if (data["message"]?.toString().contains("session not found") == true ||
            data["message"]?.toString().contains("Please login again") == true) {
          print("🚨 Session expired (400) - marking hasSessionError = true");
          hasSessionError = true;
          await _clearInvalidSession();
        }
        print("❌ Bad request: ${response.statusCode}");
      } else if (response.statusCode == 401) {
        print("❌ Unauthorized - Cookie might be expired or invalid");
        hasSessionError = true;
        await _clearInvalidSession();
      } else {
        print("❌ Server error: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("❌ Fetch profile error: $e");
      print("Stack trace: $stackTrace");
    }
    isLoading = false;
    notifyListeners();
  }

  // Helper method to clear invalid session data
  Future<void> _clearInvalidSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("cookie");
      user = null;
      print("🧹 Cleared invalid session data");
    } catch (e) {
      print("❌ Error clearing session: $e");
    }
  }

  // Method to reset session error (call after successful login)
  void resetSessionError() {
    hasSessionError = false;
    notifyListeners();
    print("✅ Session error flag reset");
  }

  // Fetch Job Categories
  Future<void> fetchJobCategories() async {
    isCategoriesLoading = true;
    notifyListeners();
    
    try {
      final response = await http.get(
        Uri.parse("https://api.thenaukrimitra.com/api/jobs/categories"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      print("📡 Categories response status: ${response.statusCode}");
      print("📩 Categories response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data["success"] == true && data["data"] != null) {
          final List<dynamic> categoriesJson = data["data"];
          jobCategories = categoriesJson
              .map((json) => JobCategoryModel.fromJson(json))
              .toList();
          print("✅ Loaded ${jobCategories.length} job categories");
        } else {
          print("❌ Failed to load categories: ${data["message"]}");
        }
      } else {
        print("❌ Server error loading categories: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("❌ Error fetching job categories: $e");
      print("Stack trace: $stackTrace");
    }
    
    isCategoriesLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile({
    required String fullName,
    required String email,
    required String gender,
    required String education,
    String? userLocation,
    String? jobCategoryId, // Add job category ID parameter
    bool? isExperienced, // Add experience level parameter
    String? totalExperience, // Add total experience parameter
    String? currentSalary, // Add current salary parameter
    String? skills, // Add skills parameter
    String? language, // Add language parameter
    File? profileImage,
    File? resumeFile,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cookie = prefs.getString("cookie") ?? "";
      print("🍪 Cookie used for updateProfile: $cookie");

      if (cookie.isEmpty) {
        print("❌ No cookie found! Cannot update profile.");
        isLoading = false;
        notifyListeners();
        return false;
      }

      var request = http.MultipartRequest(
        "PUT",
        Uri.parse("https://api.thenaukrimitra.com/api/user/update-profile"),
      );

      // Add text fields
      request.fields["fullName"] = fullName;
      request.fields["email"] = email;
      request.fields["gender"] = gender.toLowerCase();
      request.fields["education"] = education;
      if (userLocation != null && userLocation.isNotEmpty) {
        request.fields["userLocation"] = userLocation;
      }
      if (jobCategoryId != null && jobCategoryId.isNotEmpty) {
        request.fields["jobCategory"] = jobCategoryId; // Send category ID
      }
      if (isExperienced != null) {
        request.fields["isExperienced"] = isExperienced.toString();
      }
      if (totalExperience != null && totalExperience.isNotEmpty) {
        request.fields["totalExperience"] = totalExperience;
      }
      if (currentSalary != null && currentSalary.isNotEmpty) {
        request.fields["currentSalary"] = currentSalary;
      }
      if (skills != null && skills.isNotEmpty) {
        request.fields["skills"] = skills;
      }
      if (language != null && language.isNotEmpty) {
        request.fields["language"] = language;
      }

      print("📤 Updating profile with:");
      print("   Name: $fullName");
      print("   Email: $email");
      print("   Gender: ${gender.toLowerCase()}");
      print("   Education: $education");
      print("   Location: $userLocation");
      print("   Job Category ID: $jobCategoryId");
      print("   Is Experienced: $isExperienced");
      print("   Total Experience: $totalExperience");
      print("   Current Salary: $currentSalary");
      print("   Skills: $skills");
      print("   Language: $language");

      if (profileImage != null && profileImage.existsSync()) {
        // Check image size (limit to 5MB)
        final fileSize = profileImage.lengthSync();
        final fileSizeInMB = fileSize / (1024 * 1024);
        print("🖼️ Profile image size: ${fileSizeInMB.toStringAsFixed(2)} MB");
        
        if (fileSizeInMB > 5) {
          print("❌ Profile image too large: ${fileSizeInMB.toStringAsFixed(2)} MB (max 5MB)");
          isLoading = false;
          notifyListeners();
          throw Exception("Profile image is too large. Maximum size is 5MB. Your file is ${fileSizeInMB.toStringAsFixed(1)}MB");
        }
        
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          profileImage.path,
          contentType: MediaType('image', 'jpeg'),
        ));
        print("🖼️ Profile image added (${fileSizeInMB.toStringAsFixed(2)} MB)");
      }

      if (resumeFile != null && resumeFile.existsSync()) {
        // Check file size (limit to 5MB)
        final fileSize = resumeFile.lengthSync();
        final fileSizeInMB = fileSize / (1024 * 1024);
        print("📄 Resume file size: ${fileSizeInMB.toStringAsFixed(2)} MB");
        
        if (fileSizeInMB > 5) {
          print("❌ Resume file too large: ${fileSizeInMB.toStringAsFixed(2)} MB (max 5MB)");
          isLoading = false;
          notifyListeners();
          throw Exception("Resume file is too large. Maximum size is 5MB. Your file is ${fileSizeInMB.toStringAsFixed(1)}MB");
        }
        
        request.files.add(await http.MultipartFile.fromPath(
          'resume',
          resumeFile.path,
        ));
        print("📄 Resume file added (${fileSizeInMB.toStringAsFixed(2)} MB)");
      }

      request.headers.addAll({
        "Cookie": cookie,
        "Accept": "application/json",
      });

      print("📡 Sending update request...");
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      
      print("📡 Update response status: ${response.statusCode}");
      print("📩 Update response body: $respStr");

      if (response.statusCode == 200) {
        final data = json.decode(respStr);
        if (data["success"] == true) {
          print("✅ Profile updated successfully!");
          if (data["user"] != null) {
            user = ProfileModel.fromJson(data["user"]);
            print("🖼️ Updated image URL: ${user?.image}");
          }
          await fetchProfile(); // Refresh profile data
          isLoading = false;
          notifyListeners();
          return true;
        } else {
          print("❌ Update failed: ${data["message"]}");
        }
      } else if (response.statusCode == 413) {
        print("❌ File too large (413): Server rejected the upload");
        isLoading = false;
        notifyListeners();
        throw Exception("File size exceeds server limit. Please choose a smaller file (max 5MB).");
      } else {
        print("❌ Server error during update: ${response.statusCode}");
        print("Response: $respStr");
      }
    } catch (e, stackTrace) {
      print("❌ UpdateProfile error: $e");
      print("Stack trace: $stackTrace");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  // Check if user has already submitted a rating
  Future<bool> hasUserRated() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cookie = prefs.getString("cookie") ?? "";

      if (cookie.isEmpty) {
        return false;
      }

      final response = await http.get(
        Uri.parse("https://api.thenaukrimitra.com/api/rating/check"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Cookie": cookie,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["hasRated"] == true;
      }
    } catch (e) {
      print("❌ Error checking rating status: $e");
    }
    
    return false;
  }

  // Submit Rating
  Future<Map<String, dynamic>> submitRating(int rating) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cookie = prefs.getString("cookie") ?? "";
      print("🍪 Cookie used for rating: $cookie");

      if (cookie.isEmpty) {
        print("❌ No cookie found! Cannot submit rating.");
        return {"success": false, "message": "Authentication required"};
      }

      final response = await http.post(
        Uri.parse("https://api.thenaukrimitra.com/api/rating"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Cookie": cookie,
        },
        body: json.encode({
          "rating": rating,
        }),
      );

      print("📡 Rating response status: ${response.statusCode}");
      print("📩 Rating response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data["success"] == true) {
          print("✅ Rating submitted successfully!");
          print("   Rating: $rating");
          print("   User ID: ${data["data"]["userId"]}");
          return {"success": true, "message": "Rating submitted successfully"};
        } else {
          print("❌ Rating submission failed: ${data["message"]}");
          return {"success": false, "message": data["message"] ?? "Unknown error"};
        }
      } else if (response.statusCode == 409) {
        final data = json.decode(response.body);
        print("⚠️ User has already submitted a rating");
        return {"success": false, "message": data["message"] ?? "You have already submitted a rating", "alreadyRated": true};
      } else {
        print("❌ Server error during rating submission: ${response.statusCode}");
        final data = json.decode(response.body);
        return {"success": false, "message": data["message"] ?? "Server error"};
      }
    } catch (e, stackTrace) {
      print("❌ SubmitRating error: $e");
      print("Stack trace: $stackTrace");
      return {"success": false, "message": "Network error. Please try again."};
    }
  }

  // Dedicated method for resume upload only
  Future<bool> uploadResume(File resumeFile) async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cookie = prefs.getString("cookie") ?? "";
      print("🍪 Cookie used for resume upload: $cookie");

      if (cookie.isEmpty) {
        print("❌ No cookie found! Cannot upload resume.");
        isLoading = false;
        notifyListeners();
        return false;
      }

      var request = http.MultipartRequest(
        "PUT",
        Uri.parse("https://api.thenaukrimitra.com/api/user/update-profile"),
      );

      // Check file size (limit to 5MB)
      final fileSize = resumeFile.lengthSync();
      final fileSizeInMB = fileSize / (1024 * 1024);
      print("📄 Resume file size: ${fileSizeInMB.toStringAsFixed(2)} MB");
      
      if (fileSizeInMB > 5) {
        print("❌ Resume file too large: ${fileSizeInMB.toStringAsFixed(2)} MB (max 5MB)");
        isLoading = false;
        notifyListeners();
        throw Exception("Resume file is too large. Maximum size is 5MB. Your file is ${fileSizeInMB.toStringAsFixed(1)}MB");
      }
      
      // Add only the resume file
      request.files.add(await http.MultipartFile.fromPath(
        'resume',
        resumeFile.path,
      ));
      print("📄 Resume file added for upload (${fileSizeInMB.toStringAsFixed(2)} MB)");

      request.headers.addAll({
        "Cookie": cookie,
        "Accept": "application/json",
      });

      print("📡 Sending resume upload request...");
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      
      print("📡 Resume upload response status: ${response.statusCode}");
      print("📩 Resume upload response body: $respStr");

      if (response.statusCode == 200) {
        final data = json.decode(respStr);
        if (data["success"] == true) {
          print("✅ Resume uploaded successfully!");
          if (data["user"] != null) {
            user = ProfileModel.fromJson(data["user"]);
            print("📄 Updated resume URL: ${user?.resume}");
          }
          await fetchProfile(); // Refresh profile data
          isLoading = false;
          notifyListeners();
          return true;
        } else {
          print("❌ Resume upload failed: ${data["message"]}");
        }
      } else if (response.statusCode == 413) {
        print("❌ File too large (413): Server rejected the resume upload");
        isLoading = false;
        notifyListeners();
        throw Exception("Resume file size exceeds server limits. Please use a smaller file.");
      } else {
        print("❌ Server error during resume upload: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("❌ Resume upload error: $e");
      print("Stack trace: $stackTrace");
    }
    
    isLoading = false;
    notifyListeners();
    return false;
  }
}












// bina UpdateProfile use code correct duplicate

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/ProfileModel.dart';
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("get cookie= $cookie");
//
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//           print("👤 User loaded: ${user!.fullName}");
//         }
//       } else {
//         print("❌ Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Exception: $e");
//     }
//     isLoading = false;
//     notifyListeners();
//   }
//
//   // ✅ Update Profile (Multipart + PUT)
//   Future<bool> updateProfile(Map<String, dynamic> updatedData) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("Update cookie = $cookie");
//
//       var request = http.MultipartRequest(
//         "PUT",
//         Uri.parse("http://api.thenaukrimitra.com/api/user/update-profile"),
//       );
//
//       // Fields add karna (sirf wahi jo null nahi hain)
//       updatedData.forEach((key, value) {
//         if (value != null) {
//           request.fields[key] = value.toString();
//         }
//       });
//
//       request.headers.addAll({
//         "Cookie": cookie,
//         "Accept": "application/json",
//       });
//
//       var response = await request.send();
//       final respStr = await response.stream.bytesToString();
//       print("Update API status: ${response.statusCode}");
//       print("Update API response: $respStr");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(respStr);
//
//         if (data["success"] == true) {
//           if (data["user"] != null) {
//             user = ProfileModel.fromJson(data["user"]);
//           } else if (user != null) {
//             // Agar user object null nahi hai to updated fields merge karo
//             user = ProfileModel(
//               id: user!.id,
//               fullName: updatedData["fullName"] ?? user!.fullName,
//               phone: updatedData["phone"] ?? user!.phone,
//               gender: updatedData["gender"] ?? user!.gender,
//               email: updatedData["email"] ?? user!.email,
//               image: updatedData["image"] ?? user!.image,
//               resume: updatedData["resume"] ?? user!.resume,
//               education: updatedData["education"] ?? user!.education,
//               jobCategory: updatedData["jobCategory"] ?? user!.jobCategory,
//               isExperienced: updatedData["isExperienced"] ?? user!.isExperienced,
//               totalExperience: updatedData["totalExperience"] ?? user!.totalExperience,
//             );
//           }
//
//           await fetchProfile(); // 🔄 Refresh profile after update
//           isLoading = false;
//           notifyListeners();
//           return true;
//         }
//       }
//     } catch (e) {
//       print("❌ Update error: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }



// bina UpdateProfile use code correct

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/ProfileModel.dart';
//
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("get cookie= $cookie");
//
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//           print("👤 User loaded: ${user!.fullName}");
//         }
//       } else {
//         print("❌ Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ Exception: $e");
//     }
//     isLoading = false;
//     notifyListeners();
//   }
//
//   // ✅ Update Profile (Flexible: Map-based)
//   Future<bool> updateProfile(Map<String, dynamic> updatedData) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cookie = prefs.getString("cookie") ?? "";
//       print("Update cookie = $cookie");
//
//       final response = await http.post(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/update-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//         body: json.encode(updatedData),
//       );
//
//       print("Update API status: ${response.statusCode}");
//       print("Update API response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//
//         if (data["success"] == true) {
//           if (data["user"] != null) {
//
//             user = ProfileModel.fromJson(data["user"]);
//           } else if (user != null) {
//
//             user = ProfileModel(
//               id: user!.id,
//               fullName: updatedData["fullName"] ?? user!.fullName,
//               phone: updatedData["phone"] ?? user!.phone,
//               gender: updatedData["gender"] ?? user!.gender,
//               email: updatedData["email"] ?? user!.email,
//               image: updatedData["image"] ?? user!.image,
//               resume: updatedData["resume"] ?? user!.resume,
//               education: updatedData["education"] ?? user!.education,
//               jobCategory: updatedData["jobCategory"] ?? user!.jobCategory,
//               isExperienced: updatedData["isExperienced"] ??
//                   user!.isExperienced,
//               totalExperience: updatedData["totalExperience"] ??
//                   user!.totalExperience,
//             );
//           }
//           await fetchProfile();
//           isLoading = false;
//           notifyListeners();
//           return true;
//         }
//       }
//     } catch (e) {
//       print("❌ Update error: $e");
//     }
//
//     isLoading = false;
//     notifyListeners();
//     return false;
//   }
// }
//





// Ehatsam sir code complete working
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/ProfileModel.dart';
//
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   // var profile;
//
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final prefs =await SharedPreferences.getInstance();
//       final cookie=prefs.getString("cookie")??"";
//       print("get cookie= $cookie");
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie
//         },
//       );
//       print("api hit");
//       if (response.statusCode == 200) {
//         print("status code ${response.statusCode}");
//         print("🟢 Raw Response: ${response.body}");
//
//         final data = json.decode(response.body);
//         print("Decoded Data: $data");
//
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//           print("👤 User loaded: ${user!.fullName}");
//         } else {
//           print("⚠️ API success false ya user null aaya");
//         }
//       } else {
//         print("❌ Server error: ${response.statusCode}");
//       }
//     } catch (e, stack) {
//       print("❌ Exception: $e");
//       print("❌ StackTrace: $stack");
//     }
//     isLoading = false;
//     notifyListeners();
//
//
//   }
// }
//
















// shruti code

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ model/ProfileModel.dart';
//
//
// class ProfileProvider with ChangeNotifier {
//   bool isLoading = false;
//   ProfileModel? user;
//
//   Future<void> fetchProfile() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       final prefs =await SharedPreferences.getInstance();
//       final cookie=prefs.getString("cookie")??"";
//       print("get cookie= $cookie");
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/get-profile"),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/json",
//           "Cookie": cookie
//         },
//       );
//       print("api hit");
//       if (response.statusCode == 200) {
//         print("status code ${response.statusCode}");
//         print("🟢 Raw Response: ${response.body}");
//
//         final data = json.decode(response.body);
//         print("Decoded Data: $data");
//
//         if (data["success"] == true && data["user"] != null) {
//           user = ProfileModel.fromJson(data["user"]);
//           print("👤 User loaded: ${user!.fullName}");
//         } else {
//           print("⚠️ API success false ya user null aaya");
//         }
//       } else {
//         print("❌ Server error: ${response.statusCode}");
//       }
//     } catch (e, stack) {
//       print("❌ Exception: $e");
//       print("❌ StackTrace: $stack");
//     }
//     isLoading = false;
//     notifyListeners();
//
//
//   }
//   }