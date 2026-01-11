import 'package:flutter/material.dart';
import '../model/JobModel.dart';

import '../Services/JobService.dart';

class JobProvider with ChangeNotifier {
  List<JobModel> _jobs = [];
  List<JobModel> _filteredJobs = [];
  bool _isLoading = false;

  List<JobModel> get jobs =>
      _filteredJobs.isNotEmpty ? _filteredJobs : _jobs;

  bool get isLoading => _isLoading;

  /// Sab jobs fetch (HomePage open hote hi)
  Future<void> fetchJobs() async {
    _isLoading = true;
    notifyListeners();

    try {
      _jobs = await JobService.fetchJobs();
      _filteredJobs = [];
    } catch (e) {
      _jobs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Search (title, company, location se filter)
  void searchJobs(String query) {
    if (query.isEmpty) {
      _filteredJobs = [];
    } else {
      _filteredJobs = _jobs
          .where((job) =>
      job.title.toLowerCase().contains(query.toLowerCase()) ||
          job.companyName.toLowerCase().contains(query.toLowerCase()) ||
          job.workLocation.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}






// working JobProvider
// import 'package:flutter/material.dart';
// import '../ model/JobModel.dart';
//
// import '../Services/JobService.dart';
//
// class JobProvider with ChangeNotifier {
//   List<JobModel> _jobs = [];
//   List<JobModel> _filteredJobs = [];
//   bool _isLoading = false;
//
//   List<JobModel> get jobs =>
//       _filteredJobs.isNotEmpty ? _filteredJobs : _jobs;
//
//   bool get isLoading => _isLoading;
//
//   /// Sab jobs fetch (HomePage open hote hi)
//   Future<void> fetchJobs() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _jobs = await JobService.fetchJobs();
//       _filteredJobs = [];
//     } catch (e) {
//       _jobs = [];
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   /// Search (title, company, location se filter)
//   void searchJobs(String query) {
//     if (query.isEmpty) {
//       _filteredJobs = [];
//     } else {
//       _filteredJobs = _jobs
//           .where((job) =>
//       job.title.toLowerCase().contains(query.toLowerCase()) ||
//           job.companyName.toLowerCase().contains(query.toLowerCase()) ||
//           job.workLocation.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     notifyListeners();
//   }
// }
//



// data show direct not working search

// import 'package:flutter/material.dart';
// import '../ model/JobModel.dart';
//
// import '../Services/JobService.dart';
//
// class JobProvider with ChangeNotifier {
//   List<JobModel> _jobs = [];
//   List<JobModel> _filteredJobs = [];
//   bool _isLoading = false;
//
//   List<JobModel> get jobs =>
//       _filteredJobs.isEmpty ? _jobs : _filteredJobs;
//   bool get isLoading => _isLoading;
//
//   Future<void> fetchJobs() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _jobs = await JobService.fetchJobs();
//       _filteredJobs = [];
//     } catch (e) {
//       _jobs = [];
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   void searchJobs(String query) {
//     if (query.isEmpty) {
//       _filteredJobs = [];
//     } else {
//       _filteredJobs = _jobs
//           .where((job) =>
//       job.title.toLowerCase().contains(query.toLowerCase()) ||
//           job.companyName.toLowerCase().contains(query.toLowerCase()) ||
//           job.workLocation.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     notifyListeners();
//   }
// }
//




// import 'package:flutter/material.dart';
// import '../ model/JobModel.dart';
// import '../Services/JobService.dart';
//
//
// class JobProvider with ChangeNotifier {
//   List<JobModel> _jobs = [];
//   bool _isLoading = false;
//
//   List<JobModel> get jobs => _jobs;
//   bool get isLoading => _isLoading;
//
//   Future<void> searchJobs(String query) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _jobs = await JobService.fetchJobs(query);
//     } catch (e) {
//       _jobs = [];
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
// }
