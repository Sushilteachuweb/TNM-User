// class JobModel {
//   final String id;
//   final String title;
//   final String companyName;
//   final String jobType;
//   final String workLocation;
//   final int minSalary;
//   final int maxSalary;
//   final int vacancies;
//   final String experience;
//   final String postedDate;
//   final List<String> skills;
//   final String education;
//   final String description;
//   final String salaryType;
//   final String jobCategory;
//   final String jobLocation;
//   final String officeAddress;
//   final String floorDetails;
//   final String communicationPreference;
//   final String englishLevel;
//   final String preferredLocation;
//   final String gender;
//   final String planType;
//   final String hrId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   bool isApplied;
//
//   JobModel({
//     required this.id,
//     required this.title,
//     required this.companyName,
//     required this.jobType,
//     required this.workLocation,
//     required this.minSalary,
//     required this.maxSalary,
//     required this.vacancies,
//     required this.experience,
//     required this.postedDate,
//     required this.skills,
//     required this.education,
//     required this.description,
//     required this.salaryType,
//     required this.jobCategory,
//     required this.jobLocation,
//     required this.officeAddress,
//     required this.floorDetails,
//     required this.communicationPreference,
//     required this.englishLevel,
//     required this.preferredLocation,
//     required this.gender,
//     required this.planType,
//     required this.hrId,
//     required this.createdAt,
//     required this.updatedAt,
//     this.isApplied = false,
//   });
//
//   factory JobModel.fromJson(Map<String, dynamic> json) {
//     int parseInt(dynamic value) {
//       if (value == null) return 0;
//       if (value is int) return value;
//       if (value is String) return int.tryParse(value) ?? 0;
//       return 0;
//     }
//
//     List<String> parseSkills(Map<String, dynamic> json) {
//       if (json["additionalPerks"] != null) {
//         return List<String>.from(json["additionalPerks"]);
//       } else if (json["skills"] != null) {
//         return List<String>.from(json["skills"]);
//       }
//       return [];
//     }
//
//     return JobModel(
//       id: json["_id"] ?? "",
//       title: json["title"] ?? "",
//       companyName: json["companyName"] ?? "",
//       jobType: json["jobType"] ?? "",
//       workLocation: json["workLocation"] ?? "",
//       minSalary: parseInt(json["salaryRange"]?["min"]),
//       maxSalary: parseInt(json["salaryRange"]?["max"]),
//       vacancies: parseInt(json["vacancies"]),
//       experience: json["totalExperience"] ?? json["experience"] ?? "Not specified",
//       postedDate: json["postedDate"] ?? json["createdAt"] ?? "N/A",
//       skills: parseSkills(json),
//       education: json["minimumEducation"] ?? json["education"] ?? "Not specified",
//       description: json["description"] ?? "",
//       salaryType: json["salaryType"] ?? "",
//       jobCategory: json["jobCategory"] ?? "",
//       jobLocation: json["jobLocation"] ?? "",
//       officeAddress: json["officeAddress"] ?? "",
//       floorDetails: json["floorDetails"] ?? "",
//       communicationPreference: json["communicationPreference"] ?? "",
//       englishLevel: json["englishLevel"] ?? "",
//       preferredLocation: json["preferredLocation"] ?? "",
//       gender: json["gender"] ?? "",
//       planType: json["planType"] ?? "",
//       hrId: json["hrId"] ?? "",
//       createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
//       isApplied: false,
//     );
//   }
// }


// working hai 09-09-2025

class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String jobType;
  final String workLocation;
  final int minSalary;
  final int maxSalary;
  final int vacancies;
  final String experience;
  final String postedDate;
  final List<String> skills;
  final String education;
  final String description;
  final String salaryType;
  final String jobCategory;
  final String jobLocation;
  final String officeAddress;
  final String floorDetails;
  final String communicationPreference;
  final String englishLevel;
  final String preferredLocation;
  final String gender;
  final String planType;
  final String hrId;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isApplied;

  JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.jobType,
    required this.workLocation,
    required this.minSalary,
    required this.maxSalary,
    required this.vacancies,
    required this.experience,
    required this.postedDate,
    required this.skills,
    required this.education,
    required this.description,
    required this.salaryType,
    required this.jobCategory,
    required this.jobLocation,
    required this.officeAddress,
    required this.floorDetails,
    required this.communicationPreference,
    required this.englishLevel,
    required this.preferredLocation,
    required this.gender,
    required this.planType,
    required this.hrId,
    required this.createdAt,
    required this.updatedAt,
    this.isApplied = false,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      companyName: json["companyName"] ?? "",
      jobType: json["jobType"] ?? "",
      workLocation: json["workLocation"] ?? "",
      minSalary: json["salaryRange"]?["min"] ?? 0,
      maxSalary: json["salaryRange"]?["max"] ?? 0,

      vacancies: json["openings"] ?? 0,
      experience: json["totalExperience"] ?? json["experience"] ?? "Not specified",
      postedDate: json["postedDate"] ?? json["createdAt"] ?? "N/A",
      skills: json["additionalPerks"] != null
          ? List<String>.from(json["additionalPerks"])
          : (json["skills"] != null ? List<String>.from(json["skills"]) : []),
      education: json["minimumEducation"] ?? json["education"] ?? "Not specified",

      description: json["jobDescription"] ?? "",
      salaryType: json["salaryType"] ?? "",
      jobCategory: json["jobCategory"] ?? "",
      jobLocation: json["jobLocation"] ?? "",
      officeAddress: json["officeAddress"] ?? "",
      floorDetails: json["floorDetails"] ?? "",
      communicationPreference: json["communicationPreference"] ?? "",
      englishLevel: json["englishLevel"] ?? "",
      preferredLocation: json["preferredLocation"] ?? "",
      gender: json["gender"] ?? "",
      planType: (json["planType"] != null && json["planType"] is List)
          ? json["planType"].join(", ")
          : "",   //
      hrId: json["hrId"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      isApplied: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "companyName": companyName,
      "jobType": jobType,
      "workLocation": workLocation,
      "salaryRange": {
        "min": minSalary,
        "max": maxSalary,
      },
      "openings": vacancies,
      "totalExperience": experience,
      "createdAt": createdAt.toIso8601String(),
      "additionalPerks": skills,
      "minimumEducation": education,
      "jobDescription": description,
      "salaryType": salaryType,
      "jobCategory": jobCategory,
      "jobLocation": jobLocation,
      "officeAddress": officeAddress,
      "floorDetails": floorDetails,
      "communicationPreference": communicationPreference,
      "englishLevel": englishLevel,
      "preferredLocation": preferredLocation,
      "gender": gender,
      "planType": planType,
      "hrId": hrId,
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}






//bina hrPost api use
// class JobModel {
//   final String id;
//   final String title;
//   final String companyName;
//   final String jobType;
//   final String workLocation;
//   final int minSalary;
//   final int maxSalary;
//   final int vacancies;
//   final String experience;
//   final String postedDate;
//   final List<String> skills;
//   final String education;
//   final String description;
//   bool isApplied; // new field to track applied jobs
//
//   JobModel({
//     required this.id,
//     required this.title,
//     required this.companyName,
//     required this.jobType,
//     required this.workLocation,
//     required this.minSalary,
//     required this.maxSalary,
//     required this.vacancies,
//     required this.experience,
//     required this.postedDate,
//     required this.skills,
//     required this.education,
//     required this.description,
//     this.isApplied = false, // default false
//   });
//
//   factory JobModel.fromJson(Map<String, dynamic> json) {
//     return JobModel(
//       id: json["_id"] ?? "",
//       title: json["title"] ?? "",
//       companyName: json["companyName"] ?? "",
//       jobType: json["jobType"] ?? "",
//       workLocation: json["workLocation"] ?? "",
//       minSalary: json["salaryRange"]?["min"] ?? 0,
//       maxSalary: json["salaryRange"]?["max"] ?? 0,
//       vacancies: json["vacancies"] ?? 0,
//       experience: json["experience"] ?? "Not specified",
//       postedDate: json["postedDate"] ?? "N/A",
//       skills: json["skills"] != null
//           ? List<String>.from(json["skills"])
//           : <String>['Dart','Design','UI_UX','Flutter'],
//       education: json["education"] ?? "MCA , B.tech, BBA,",
//       description: json["description"] ?? "Web Development , React js, Python...etc",
//       isApplied: false, // initially false
//     );
//   }
// }



// class JobModel {
//   final String id;
//   final String title;
//   final String companyName;
//   final String jobType;
//   final String workLocation;
//   final int minSalary;
//   final int maxSalary;
//   final int vacancies;
//   final String experience;
//   final String postedDate;
//   final List<String> skills;
//   final String education;
//   final String description;
//
//   JobModel({
//     required this.id,
//     required this.title,
//     required this.companyName,
//     required this.jobType,
//     required this.workLocation,
//     required this.minSalary,
//     required this.maxSalary,
//     required this.vacancies,
//     required this.experience,
//     required this.postedDate,
//     required this.skills,
//     required this.education,
//     required this.description,
//   });
//
//   factory JobModel.fromJson(Map<String, dynamic> json) {
//     return JobModel(
//       id: json["_id"] ?? "",
//       title: json["title"] ?? "",
//       companyName: json["companyName"] ?? "",
//       jobType: json["jobType"] ?? "",
//       workLocation: json["workLocation"] ?? "",
//       minSalary: json["salaryRange"]?["min"] ?? 0,
//       maxSalary: json["salaryRange"]?["max"] ?? 0,
//       vacancies: json["vacancies"] ?? 0,
//       experience: json["experience"] ?? "Not specified",
//       postedDate: json["postedDate"] ?? "N/A",
//       skills: json["skills"] != null
//           ? List<String>.from(json["skills"])
//           : <String>['Dart','Design','UI_UX','Flutter'],
//       education: json["education"] ?? "MCA , B.tech, BBA,",
//       description: json["description"] ?? "Web Development , React js, Python...etc",
//     );
//   }
// }






// ye code JobSearch add nhi hua tab ka hai
// class JobModel {
//   final String id;
//   final String title;
//   final String companyName;
//   final String jobType;
//   final String workLocation;
//   final int minSalary;
//   final int maxSalary;
//
//   var vacancies;
//
//   JobModel({
//     required this.id,
//     required this.title,
//     required this.companyName,
//     required this.jobType,
//     required this.workLocation,
//     required this.minSalary,
//     required this.maxSalary,
//   });
//
//   factory JobModel.fromJson(Map<String, dynamic> json) {
//     return JobModel(
//       id: json["_id"],
//       title: json["title"] ?? "",
//       companyName: json["companyName"] ?? "",
//       jobType: json["jobType"] ?? "",
//       workLocation: json["workLocation"] ?? "",
//       minSalary: json["salaryRange"]?["min"] ?? 0,
//       maxSalary: json["salaryRange"]?["max"] ?? 0,
//     );
//   }
// }
