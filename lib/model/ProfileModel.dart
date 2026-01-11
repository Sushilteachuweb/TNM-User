//
// class ProfileModel {
//   final String id;
//   final String fullName;
//   final String phone;
//   final String gender;
//   final String email;
//   final String? image;
//   final String? resume;
//   final String education;
//   final String jobCategory;
//   final bool isExperienced;
//   final int totalExperience;
//
//   ProfileModel({
//     required this.id,
//     required this.fullName,
//     required this.phone,
//     required this.gender,
//     required this.email,
//     this.image,
//     this.resume,
//     required this.education,
//     required this.jobCategory,
//     required this.isExperienced,
//     required this.totalExperience,
//   });
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       id: json["_id"] ?? "",
//       fullName: json["fullName"] ?? "",
//       phone: json["phone"] ?? "",
//       gender: json["gender"] ?? "",
//       email: json["email"] ?? "",
//       image: json["image"],
//       resume: json["resume"],
//       education: json["education"] ?? "",
//       jobCategory: json["jobCategory"] ?? "",
//       isExperienced: json["isExperienced"] ?? false,
//       totalExperience: json["totalExperience"] ?? 0,
//     );
//   }
// }
//


// class ProfileModel {
//   final String? id;
//   final String fullName;
//   final String phone;
//   final String gender;
//   final String email;
//   final String? image;
//   final String? resume;
//   final String education;
//   final String? jobCategory;
//   final bool? isExperienced;
//   final String? totalExperience;
//   final String? currentSalary;
//   final List<String>? skills;
//   final List<String>? language;
//   final String? userLocation;
//   final String? role;
//   final String? createdAt;
//   final String? updatedAt;
//
//   ProfileModel({
//     required this.id,
//     required this.fullName,
//     required this.phone,
//     required this.gender,
//     required this.email,
//     this.image,
//     this.resume,
//     required this.education,
//     this.jobCategory,
//     this.isExperienced,
//     this.totalExperience,
//     this.currentSalary,
//     this.skills,
//     this.language,
//     this.userLocation,
//     this.role,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       id: json["_id"]?.toString(),
//       fullName: json["fullName"]?.toString() ?? "",
//       phone: json["phone"]?.toString() ?? "",
//       gender: json["gender"]?.toString() ?? "",
//       email: json["email"]?.toString() ?? "",
//       image: json["image"]?.toString(),
//       resume: json["resume"]?.toString(),
//       education: json["education"]?.toString() ?? "",
//       jobCategory: json["jobCategory"]?.toString(),
//       isExperienced: json["isExperienced"],
//       totalExperience: json["totalExperience"] != null
//           ? json["totalExperience"].toString()
//           : null,
//       currentSalary: json["currentSalary"] != null
//           ? json["currentSalary"].toString()
//           : null,
//       skills: json["skills"] != null
//           ? List<String>.from(json["skills"])
//           : null,
//       language: json["language"] != null
//           ? List<String>.from(json["language"])
//           : null,
//       userLocation: json["userLocation"]?.toString(),
//       role: json["role"]?.toString(),
//       createdAt: json["createdAt"]?.toString(),
//       updatedAt: json["updatedAt"]?.toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "fullName": fullName,
//       "phone": phone,
//       "gender": gender,
//       "email": email,
//       "image": image,
//       "resume": resume,
//       "education": education,
//       "jobCategory": jobCategory,
//       "isExperienced": isExperienced,
//       "totalExperience": totalExperience,
//       "currentSalary": currentSalary,
//       "skills": skills,
//       "language": language,
//       "userLocation": userLocation,
//       "role": role,
//       "createdAt": createdAt,
//       "updatedAt": updatedAt,
//     };
//   }
// }
//


// class ProfileModel {
//   final String? id;
//   final String fullName;
//   final String phone;
//   final String gender;
//   final String email;
//   final String? image;
//   final String? resume;
//   final String education;
//   final String? jobCategory;
//   final bool? isExperienced;
//   final String? totalExperience;
//   final String? currentSalary;
//
//   // ✅ Add missing fields
//   final String? userLocation;
//   final List<String>? language;
//   late final List<String>? skills;
//
//   ProfileModel({
//     required this.id,
//     required this.fullName,
//     required this.phone,
//     required this.gender,
//     required this.email,
//     this.image,
//     this.resume,
//     required this.education,
//     this.jobCategory,
//     this.isExperienced,
//     this.totalExperience,
//     this.currentSalary,
//     this.userLocation,
//     this.language,
//     this.skills,
//   });
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       id: json["_id"]?.toString(),
//       fullName: json["fullName"]?.toString() ?? "",
//       phone: json["phone"]?.toString() ?? "",
//       gender: json["gender"]?.toString() ?? "",
//       email: json["email"]?.toString() ?? "",
//       image: json["image"]?.toString(),
//       resume: json["resume"]?.toString(),
//       education: json["education"]?.toString() ?? "",
//       jobCategory: json["jobCategory"]?.toString(),
//       isExperienced: json["isExperienced"],
//       totalExperience: json["totalExperience"] != null
//           ? json["totalExperience"].toString()
//           : null,
//       currentSalary: json["currentSalary"] != null
//           ? json["currentSalary"].toString()
//           : null,
//       userLocation: json["userLocation"]?.toString(),
//       language: json["language"] != null
//           ? List<String>.from(json["language"])
//           : null,
//       skills: json["skills"] != null ? List<String>.from(json["skills"]) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "fullName": fullName,
//       "phone": phone,
//       "gender": gender,
//       "email": email,
//       "image": image,
//       "resume": resume,
//       "education": education,
//       "jobCategory": jobCategory,
//       "isExperienced": isExperienced,
//       "totalExperience": totalExperience,
//       "currentSalary": currentSalary,
//       "userLocation": userLocation,
//       "language": language,
//       "skills": skills,
//     };
//   }
//
//
//   ProfileModel copyWith({
//     List<String>? skills,
//   }) {
//     return ProfileModel(
//       id: id,
//       fullName: fullName,
//       phone: phone,
//       gender: gender,
//       email: email,
//       image: image,
//       resume: resume,
//       education: education,
//       jobCategory: jobCategory,
//       isExperienced: isExperienced,
//       totalExperience: totalExperience,
//       currentSalary: currentSalary,
//       userLocation: userLocation,
//       language: language,
//       skills: skills ?? this.skills,
//     );
//   }
// }
//





// ye sahi hai
// Ye resume upload bhi hai

class ProfileModel {
  final String? id;
  final String fullName;
  final String phone;
  final String gender;
  final String email;
  final String? image;
  final String? resume;
  final String education;
  final String? jobCategory;
  final bool? isExperienced;
  final String? totalExperience;
  final String? currentSalary;


  final String? userLocation;
  final List<String>? skills;
  final List<String>? language;
  final String? role;
  ProfileModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.gender,
    required this.email,
    this.image,
    this.resume,
    required this.education,
    this.jobCategory,
    this.isExperienced,
    this.totalExperience,
    this.currentSalary,
    this.userLocation,
    this.skills,
    this.language,
    this.role,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["_id"].toString(),
      fullName: json["fullName"].toString(),
      phone: json["phone"].toString(),
      gender: json["gender"].toString(),
      email: json["email"].toString(),
      image: json["image"]?.toString(),
      resume: json["resume"]?.toString(),
      education: json["education"].toString(),
      jobCategory: json["jobCategory"]?.toString(),
      isExperienced: json["isExperienced"],
      // 🔥 Convert totalExperience to string
      totalExperience: json["totalExperience"] != null
          ? json["totalExperience"].toString()
          : null,
      currentSalary: json["currentSalary"] != null
          ? json["currentSalary"].toString()
          : null,
      userLocation: json["userLocation"]?.toString(),
      skills: json["skills"] != null ? List<String>.from(json["skills"]) : null,
      language:
          json["language"] != null ? List<String>.from(json["language"]) : null,
      role: json["role"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "fullName": fullName,
      "phone": phone,
      "gender": gender,
      "email": email,
      "image": image,
      "resume": resume,
      "education": education,
      "jobCategory": jobCategory,
      "isExperienced": isExperienced,
      "totalExperience": totalExperience,
      "currentSalary": currentSalary,
      "userLocation": userLocation,
      "skills": skills,
      "language": language,
      "role": role,
    };
  }
}







// working without add Update profile
// class ProfileModel {
//   final String id;
//   final String fullName;
//   final String phone;
//   final String gender;
//   final String email;
//   final String? image;
//   final String? resume;
//   final String education;
//   final String jobCategory;
//   final bool isExperienced;
//   final int totalExperience;
//
//   ProfileModel({
//     required this.id,
//     required this.fullName,
//     required this.phone,
//     required this.gender,
//     required this.email,
//     this.image,
//     this.resume,
//     required this.education,
//     required this.jobCategory,
//     required this.isExperienced,
//     required this.totalExperience,
//   });
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       id: json["_id"] ?? "",
//       fullName: json["fullName"] ?? "",
//       phone: json["phone"] ?? "",
//       gender: json["gender"] ?? "",
//       email: json["email"] ?? "",
//       image: json["image"],
//       resume: json["resume"],
//       education: json["education"] ?? "",
//       jobCategory: json["jobCategory"] ?? "",
//       isExperienced: json["isExperienced"] ?? false,
//       totalExperience: json["totalExperience"] ?? 0,
//     );
//   }
// }
