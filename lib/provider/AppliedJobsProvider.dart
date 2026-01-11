

// working hai 09-09-2025
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/JobModel.dart';


class AppliedJobsProvider with ChangeNotifier {
  bool isLoading = false;
  List<JobModel> appliedJobs = [];
  int tabIndex = 0;
  
  // Constructor to load applied jobs on app start
  AppliedJobsProvider() {
    loadAppliedJobs();
  }
  
  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }

  // Load applied jobs from API on app start
  Future<void> loadAppliedJobs() async {
    isLoading = true;
    notifyListeners();

    // 1. Load from local storage first (so user sees data immediately)
    await _loadAppliedJobsLocally();

    try {
      final pref = await SharedPreferences.getInstance();
      final cookie = pref.getString("cookie") ?? "";

      if (cookie.isEmpty) {
        print("❌ No cookie found for loading applied jobs");
        isLoading = false;
        notifyListeners();
        return;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Cookie': cookie,
      };

      final response = await http.get(
        Uri.parse("https://api.thenaukrimitra.com/api/user/applied-jobs"),
        headers: headers,
      );

      print("📡 Load Applied Jobs Status: ${response.statusCode}");
      print("📩 Load Applied Jobs Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == true && data["appliedJobs"] != null) {
          appliedJobs = (data["appliedJobs"] as List)
              .map((job) => JobModel.fromJson(job))
              .toList();
          
          // 2. Save to local storage for persistence
          await _saveAppliedJobsLocally();
          
          print("✅ Loaded ${appliedJobs.length} applied jobs");
        } else {
          print("❌ Failed to load applied jobs: ${data["message"]}");
        }
      } else {
        print("❌ Server error loading applied jobs: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error loading applied jobs: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String> applyJob(String jobId) async {
    isLoading = true;
    notifyListeners();

    try {
      final pref = await SharedPreferences.getInstance();
      final cookie = pref.getString("cookie") ?? "";

      final headers = {
        'Content-Type': 'application/json',
        'Cookie': cookie,
      };

      final body = json.encode({"jobId": jobId});

      final response = await http.post(
        Uri.parse("https://api.thenaukrimitra.com/api/user/apply-job"),
        headers: headers,
        body: body,
      );

      isLoading = false;
      notifyListeners();

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == true && data["job"] != null) {
          appliedJobs.add(JobModel.fromJson(data["job"]));
          // Save applied jobs to local storage for persistence
          await _saveAppliedJobsLocally();
          notifyListeners();
          return "success";
        } else {
          return data["message"] ?? "Failed to apply job";
        }
      } else {
        return "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return "Error: $e";
    }
  }

  // Save applied jobs to local storage
  Future<void> _saveAppliedJobsLocally() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final jobsJson = appliedJobs.map((job) => job.toJson()).toList();
      await pref.setString("applied_jobs", json.encode(jobsJson));
      print("💾 Applied jobs saved locally");
    } catch (e) {
      print("❌ Error saving applied jobs locally: $e");
    }
  }

  // Load applied jobs from local storage (fallback)
  Future<void> _loadAppliedJobsLocally() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final jobsString = pref.getString("applied_jobs");
      if (jobsString != null) {
        final jobsJson = json.decode(jobsString) as List;
        appliedJobs = jobsJson.map((job) => JobModel.fromJson(job)).toList();
        print("📱 Loaded ${appliedJobs.length} applied jobs from local storage");
        notifyListeners();
      }
    } catch (e) {
      print("❌ Error loading applied jobs from local storage: $e");
    }
  }
}






// post and get dono integrate hai
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
// import '../ model/JobModel.dart';
//
//
// class AppliedJobsProvider with ChangeNotifier {
//   List<JobModel> appliedJobs = [];
//   bool isLoading = false;
//   int tabIndex = 0;
//
//   /// ✅ Apply Job (POST) and automatically fetch applied jobs
//   Future<bool> applyJob(String jobId, String cookie, {required String userId}) async {
//     isLoading = true;
//     notifyListeners();
//
//     final headers = {
//       'Content-Type': 'application/json',
//       'Cookie': cookie,
//     };
//
//     final body = json.encode({"jobId": jobId});
//
//     try {
//       final response = await http.post(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/apply-job"),
//         headers: headers,
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["job"] != null) {
//           JobModel appliedJob = JobModel.fromJson(data["job"]);
//           if (!appliedJobs.any((job) => job.id == appliedJob.id)) {
//             appliedJob.isApplied = true;
//             appliedJobs.add(appliedJob);
//           }
//           notifyListeners();
//
//           // ✅ Apply ke baad turant fetch kar do MyActivity ke liye
//           await fetchAppliedJobs(cookie, userId);
//
//           return true;
//         }
//       }
//       return false;
//     } catch (e) {
//       debugPrint("Error applying job: $e");
//       return false;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   /// ✅ Fetch Applied Jobs (GET)
//   Future<void> fetchAppliedJobs(String cookie, String userId) async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await http.get(
//         Uri.parse("http://api.thenaukrimitra.com/api/user/applied-job?userId=$userId"),
//         headers: {
//           "Content-Type": "application/json",
//           "Cookie": cookie,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data["success"] == true && data["data"] != null) {
//           // ✅ Filter jobs applied by this user
//           appliedJobs = (data["data"] as List)
//               .where((jobJson) => (jobJson["applications"] as List).contains(userId))
//               .map((jobJson) {
//             JobModel job = JobModel.fromJson(jobJson);
//             job.isApplied = true;
//             return job;
//           }).toList();
//         } else {
//           appliedJobs = [];
//         }
//       } else {
//         debugPrint("Failed to fetch applied jobs: ${response.statusCode}");
//       }
//     } catch (e) {
//       debugPrint("Error fetching applied jobs: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   /// Set selected tab index (optional, for bottom navigation)
//   void setTabIndex(int index) {
//     tabIndex = index;
//     notifyListeners();
//   }
// }



// import 'package:flutter/material.dart';
// import '../ model/JobModel.dart';
//
//
// class AppliedJobsProvider with ChangeNotifier {
//   List<JobModel> _appliedJobs = [];
//   int _currentTabIndex = 0;
//
//   List<JobModel> get appliedJobs => _appliedJobs;
//   int get currentTabIndex => _currentTabIndex;
//
//   void applyJob(JobModel job) {
//     if (!_appliedJobs.contains(job)) {
//       _appliedJobs.add(job);
//       notifyListeners();
//     }
//   }
//
//   void setTabIndex(int index) {
//     _currentTabIndex = index;
//     notifyListeners();
//   }
// }
//


// import 'package:flutter/material.dart';
// import '../ model/JobModel.dart';
//
//
// class AppliedJobsProvider with ChangeNotifier {
//   final List<JobModel> _appliedJobs = [];
//
//   List<JobModel> get appliedJobs => _appliedJobs;
//
//   void applyJob(JobModel job) {
//     // Avoid duplicates
//     if (!_appliedJobs.any((j) => j.id == job.id)) {
//       _appliedJobs.add(job);
//       notifyListeners();
//     }
//   }
//
//   void clearJobs() {
//     _appliedJobs.clear();
//     notifyListeners();
//   }
// }
