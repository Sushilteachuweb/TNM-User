// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:naukri_mitra_jobs/Services/create_api.dart';
//
// class CreateProvider with ChangeNotifier {
//   bool isLoading = false;
//   String? message;
//
//   Future<bool> createUserProfile({
//     required String fullName,
//     required String phone,
//     required String gender,
//     required String education,
//     required String jobCategory,
//     required String skills,
//     required bool isExperienced,
//     required String totalExperience,
//     required String currentSalary,
//     required String email,
//     File? imageFile, // ✅ optional
//   }) async {
//     isLoading = true;
//     message = null;
//     notifyListeners();
//     final response = await CreateApi.createProfile(
//       fullName: fullName,
//       phone: phone,
//       gender: gender,
//       education: education,
//       jobCategory: jobCategory,
//       skills: skills,
//       isExperienced: isExperienced,
//       totalExperience: totalExperience,
//       currentSalary: currentSalary,
//       email: email,
//       imageFile: imageFile,
//     );
//
//     isLoading = false;
//
//     final ok = response["success"] == true;
//     message = response["message"]?.toString();
//     notifyListeners();
//     return ok;
//   }
// }
//
//
//
//
// //
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import '../Services/create_api.dart';
// //
// // class CreateProvider with ChangeNotifier {
// //   final CreateApi _api = CreateApi();
// //
// //   String? _fullName;
// //   String? _gender;
// //   String? _education;
// //   String? _workExperience;
// //   File? _imageFile;
// //
// //   bool isLoading = false;
// //
// //   // Getters
// //   String? get fullName => _fullName;
// //   String? get gender => _gender;
// //   String? get education => _education;
// //   String? get workExperience => _workExperience;
// //   File? get imageFile => _imageFile;
// //
// //   Future<bool> createUserProfile({
// //     required String fullName,
// //     required String phone,
// //     required String gender,
// //     required String education,
// //     required String workExperience,
// //     required File imageFile,
// //   }) async {
// //     isLoading = true;
// //     notifyListeners();
// //
// //     try {
// //       final response = await _api.createUser(
// //         fullName: fullName,
// //         phone: phone,
// //         gender: gender,
// //         education: education,
// //         workExperience: workExperience,
// //         imageFile: imageFile,
// //       );
// //
// //       if (response["success"] == true) {
// //         final user = response["user"];
// //         _fullName = user["fullName"];
// //         _gender = user["gender"];
// //         _education = user["education"];
// //         _workExperience = user["workExperience"];
// //         _imageFile = imageFile;
// //
// //         isLoading = false;
// //         notifyListeners();
// //         return true;
// //       } else {
// //         debugPrint("Server response: $response");
// //       }
// //     } catch (e) {
// //       debugPrint("❌ Provider Error: $e");
// //     }
// //
// //     isLoading = false;
// //     notifyListeners();
// //     return false;
// //   }
// // }
// //
//
//
//
//
//
//
// // ye bina server connect hai
//
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import '../Services/create_api.dart';
// //
// // class CreateProvider with ChangeNotifier {
// //   final CreateApi _api = CreateApi();
// //
// //   String? fullName;
// //   String? gender;
// //   String? education;
// //   String? workExperience;
// //   File? imageFile; // 👈 Add kiya
// //
// //   bool isLoading = false;
// //
// //   Future<void> createUserProfile({
// //     required String fullName,
// //     required String phone,
// //     required String gender,
// //     required String education,
// //     required String workExperience,
// //     required File imageFile,
// //   }) async {
// //     // API call skip karna hai to direct values set kar do
// //     this.fullName = fullName;
// //     this.gender = gender;
// //     this.education = education;
// //     this.workExperience = workExperience;
// //     this.imageFile = imageFile;
// //
// //     notifyListeners();
// //   }
// // }
//
//
//
//
//
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import '../Services/create_api.dart';
// //
// // class CreateProvider with ChangeNotifier {
// //   final CreateApi _api = CreateApi();
// //
// //   String? fullName;
// //   String? gender;
// //   String? education;
// //   bool isLoading = false;
// //
// //   Future<void> createUserProfile({
// //     required String fullName,
// //     required String phone,
// //     required String gender,
// //     required String education,
// //     required String jobCategory,
// //     required String skills,
// //     required bool isExperienced,
// //     required int totalExperience,
// //     required String currentSalary,
// //     required String email,
// //     required File imageFile,  // 👈 Add image
// //   }) async {
// //     isLoading = true;
// //     notifyListeners();
// //
// //     try {
// //       final response = await _api.createUser(
// //         fullName: fullName,
// //         phone: phone,
// //         gender: gender,
// //         education: education,
// //         jobCategory: jobCategory,
// //         skills: skills,
// //         isExperienced: isExperienced,
// //         totalExperience: totalExperience,
// //         currentSalary: currentSalary,
// //         email: email,
// //         imageFile: imageFile, // 👈 Pass image
// //       );
// //
// //       if (response["success"] == true) {
// //         final user = response["user"];
// //         this.fullName = user["fullName"];
// //         this.gender = user["gender"];
// //         this.education = user["education"];
// //       }
// //     } catch (e) {
// //       debugPrint("Error: $e");
// //     }
// //
// //     isLoading = false;
// //     notifyListeners();
// //   }
// // }
