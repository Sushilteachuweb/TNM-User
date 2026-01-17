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
  final List<String> perks;
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
    required this.perks,
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
    // Helper function to safely parse integers
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    // Helper function to safely parse strings
    String parseString(dynamic value) {
      if (value == null) return "";
      return value.toString().trim();
    }

    // Helper function to parse skills (NOT perks)
    List<String> parseSkills(Map<String, dynamic> json) {
      List<String> skills = [];
      
      // Try skills-specific field names first (avoid perks)
      if (json["skills"] != null && json["skills"] is List) {
        skills.addAll(List<String>.from(json["skills"]));
      }
      if (json["requiredSkills"] != null && json["requiredSkills"] is List) {
        skills.addAll(List<String>.from(json["requiredSkills"]));
      }
      if (json["skillsRequired"] != null && json["skillsRequired"] is List) {
        skills.addAll(List<String>.from(json["skillsRequired"]));
      }
      
      // Remove duplicates and empty strings
      return skills.where((skill) => skill.trim().isNotEmpty).toSet().toList();
    }

    // Helper function to parse perks separately
    List<String> parsePerks(Map<String, dynamic> json) {
      List<String> perks = [];
      
      if (json["additionalPerks"] != null && json["additionalPerks"] is List) {
        perks.addAll(List<String>.from(json["additionalPerks"]));
      }
      if (json["perks"] != null && json["perks"] is List) {
        perks.addAll(List<String>.from(json["perks"]));
      }
      if (json["benefits"] != null && json["benefits"] is List) {
        perks.addAll(List<String>.from(json["benefits"]));
      }
      
      return perks.where((perk) => perk.trim().isNotEmpty).toSet().toList();
    }

    return JobModel(
      id: parseString(json["_id"]),
      title: parseString(json["title"]),
      companyName: parseString(json["companyName"]),
      jobType: parseString(json["jobType"]),
      workLocation: parseString(json["workLocation"]),
      minSalary: parseInt(json["salaryRange"]?["min"]),
      maxSalary: parseInt(json["salaryRange"]?["max"]),
      vacancies: parseInt(json["openings"] ?? json["vacancies"]),
      experience: parseString(json["totalExperience"] ?? json["experience"] ?? "Any Experience"),
      postedDate: parseString(json["postedDate"] ?? json["createdAt"]),
      skills: parseSkills(json),
      perks: parsePerks(json),
      education: parseString(json["minimumEducation"] ?? json["education"]),
      description: parseString(json["jobDescription"] ?? json["description"]),
      salaryType: parseString(json["salaryType"]),
      jobCategory: parseString(json["jobCategory"]),
      jobLocation: parseString(json["jobLocation"]),
      officeAddress: parseString(json["officeAddress"]),
      floorDetails: parseString(json["floorDetails"]),
      communicationPreference: parseString(json["communicationPreference"]),
      englishLevel: parseString(json["englishLevel"]),
      preferredLocation: parseString(json["preferredLocation"]),
      gender: parseString(json["gender"]),
      planType: (json["planType"] != null && json["planType"] is List)
          ? json["planType"].join(", ")
          : parseString(json["planType"]),
      hrId: parseString(json["hrId"]),
      createdAt: DateTime.tryParse(parseString(json["createdAt"])) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(parseString(json["updatedAt"])) ?? DateTime.now(),
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
      "skills": skills,
      "additionalPerks": perks,
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