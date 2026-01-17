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
      totalExperience: json["totalExperience"] != null
          ? json["totalExperience"].toString()
          : null,
      currentSalary: json["currentSalary"] != null
          ? json["currentSalary"].toString()
          : null,
      userLocation: json["userLocation"]?.toString(),
      skills: json["skills"] != null ? List<String>.from(json["skills"]) : null,
      language: json["language"] != null ? List<String>.from(json["language"]) : null,
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