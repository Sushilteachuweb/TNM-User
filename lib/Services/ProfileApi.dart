// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../ model/ProfileModel.dart';
//
//
// class ProfileApi {
//   Future<UserProfile?> getProfile() async {
//     var headers = {
//       'Cookie': 'connect.sid=s%3AWaSTPQ9yhoODYT0rgZ_bjgKTNNKIIdb6.T2uVzwygszN7%2BGtao%2Fs9QOvCl6dDUp4cFnCxsj2r%2Btc'
//     };
//
//     final url = Uri.parse('http://api.thenaukrimitra.com/api/user/get-profile');
//     final response = await http.get(url, headers: headers);
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return UserProfile.fromJson(data["user"]);
//     } else {
//       throw Exception("Failed to load profile");
//     }
//   }
// }
//
//
//
//
//
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import '../ model/ProfileModel.dart';
// //
// //
// // class ProfileApi {
// //   static const String baseUrl = "http://api.thenaukrimitra.com/api/user/get-profile";
// //
// //   static Future<UserProfileModel?> fetchProfile() async {
// //     try {
// //       var headers = {
// //         'Cookie':
// //         'connect.sid=s%3AWaSTPQ9yhoODYT0rgZ_bjgKTNNKIIdb6.T2uVzwygszN7%2BGtao%2Fs9QOvCl6dDUp4cFnCxsj2r%2Btc'
// //       };
// //
// //       final response = await http.get(Uri.parse(baseUrl), headers: headers);
// //
// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         if (data["success"] == true && data["user"] != null) {
// //           return UserProfileModel.fromJson(data["user"]);
// //         }
// //       }
// //       return null;
// //     } catch (e) {
// //       print("❌ Profile fetch error: $e");
// //       return null;
// //     }
// //   }
// // }
