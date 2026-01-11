import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CreateApi {
  static const String baseUrl = "https://api.thenaukrimitra.com/api/user/create";

  static Future<Map<String, dynamic>> createProfile({
    required String fullName,
    required String phone,
    required String gender,
    required String education,
    required String jobCategory,
    required String skills,
    required bool isExperienced,
    required String totalExperience,
    required String currentSalary,
    required String email,
    File? imageFile, // ✅ optional
  }) async {
    try {
      final uri = Uri.parse(baseUrl);
      final request = http.MultipartRequest('POST', uri);
      final fixedGender = gender.trim().toLowerCase(); // "Male" -> "male"
      final fixedJobCategory = jobCategory.trim();
      final fixedSkills = skills.trim();

      request.fields.addAll({
        'fullName': fullName.trim(),
        'phone': phone.trim(),
        'gender': fixedGender,
        'education': education.trim(),
        'jobCategory': fixedJobCategory,
        'skills': fixedSkills,
        'isExperienced': isExperienced ? "true" : "false",
        'totalExperience': (totalExperience.isEmpty ? "0" : totalExperience).trim(),
        'currentSalary': (currentSalary.isEmpty ? "0" : currentSalary).trim(),
        'email': email.trim(),
      });

      // if (imageFile != null && imageFile.path.isNotEmpty) {
      //   request.files.add(
      //     await http.MultipartFile.fromPath('image', imageFile.path),
      //   );
      // }

      print("📤 URL: $baseUrl");
      print("📤 Method: POST");
      print("📤 Sending fields: ${request.fields}");
      if (imageFile != null) print("📤 Sending file: ${imageFile.path}");

      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      print("📥 Server status: ${response.statusCode}");
      print("📥 Server response: $resBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return json.decode(resBody) as Map<String, dynamic>;
        } catch (_) {
          return {"success": false, "message": "Invalid JSON from server", "raw": resBody};

        }
      } else {
        return {
          "success": false,
          "statusCode": response.statusCode,
          "message": resBody,
        };
      }
    } catch (e) {
      print("❌ Exception: $e");
      return {"success": false, "message": e.toString()};
    }
  }
}









// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// class CreateApi {
//   static const String baseUrl = "http://93.127.166.119:3000/api/user/create";
//
//   Future<Map<String, dynamic>> createUser({
//     required String fullName,
//     required String phone,
//     required String gender,
//     required String education,
//     required String workExperience,
//     required File imageFile,
//   }) async {
//     var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
//
//     request.fields.addAll({
//       'fullName': fullName,
//       'phone': phone,
//       'gender': gender,
//       'education': education,
//       'workExperience': workExperience,
//     });
//
//     // 👇 Attach image
//     request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
//
//     try {
//       http.StreamedResponse response = await request.send();
//       String respStr = await response.stream.bytesToString();
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return jsonDecode(respStr);
//       } else {
//         throw Exception("Failed: ${response.statusCode}, Body: $respStr");
//       }
//     } catch (e) {
//       throw Exception("API Error: $e");
//     }
//   }
// }
//



// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// class CreateApi {
//   static const String baseUrl = "http://93.127.166.119:3000/api/user/create";
//
//   Future<Map<String, dynamic>> createUser({
//     required String fullName,
//     required String phone,
//     required String gender,
//     required String education,
//     required String workExperience,
//     required File imageFile,
//   }) async {
//     var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
//
//     request.fields.addAll({
//       'fullName': fullName,
//       'phone': phone,
//       'gender': gender,
//       'education': education,
//       'workExperience': workExperience,
//     });
//
//     // 👇 Attach image
//     request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       String respStr = await response.stream.bytesToString();
//       return jsonDecode(respStr);
//     } else {
//       String respStr = await response.stream.bytesToString();
//       throw Exception("Failed: ${response.statusCode}, Body: $respStr");
//     }
//   }
// }



// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// class CreateApi {
//   static const String baseUrl = "http://93.127.166.119:3000/api/user/create";
//
//   Future<Map<String, dynamic>> createUser({
//     required String fullName,
//     required String phone,
//     required String gender,
//     required String education,
//     required String jobCategory,
//     required String skills,
//     required bool isExperienced,
//     required int totalExperience,
//     required String currentSalary,
//     required String email,
//     required File imageFile,
//   }) async {
//     var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
//
//     request.fields.addAll({
//       'fullName': fullName,
//       'phone': phone,
//       'gender': gender,
//       'education': education,
//       'jobCategory': jobCategory,
//       'skills': skills,
//       'isExperienced': isExperienced.toString(),
//       'totalExperience': totalExperience.toString(),
//       'currentSalary': currentSalary,
//       'email': email,
//     });
//
//     // 👇 Attach image
//     request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
//
//     http.StreamedResponse response = await request.send();
//
//     // ✅ Accept both 200 and 201
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       String respStr = await response.stream.bytesToString();
//       return jsonDecode(respStr);
//     } else {
//       String respStr = await response.stream.bytesToString();
//       throw Exception("Failed: ${response.statusCode}, Body: $respStr");
//     }
//   }
// }
