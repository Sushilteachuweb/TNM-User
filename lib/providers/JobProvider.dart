import 'package:flutter/material.dart';
import '../models/job_model.dart';

import '../services/job_service.dart';

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

  /// Fetch jobs by category
  Future<void> fetchJobsByCategory(String categoryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Ensure we have all jobs first
      await fetchJobs();
      
      // Filter jobs by category ID or category name
      _filteredJobs = _jobs.where((job) => 
        job.jobCategory.toLowerCase().contains(categoryId.toLowerCase())
      ).toList();
    } catch (e) {
      _filteredJobs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Fetch jobs by type (Full Time, Part Time, Remote, etc.)
  Future<void> fetchJobsByType(String jobType) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Ensure we have all jobs first
      await fetchJobs();
      
      // Filter jobs by job type or work location
      _filteredJobs = _jobs.where((job) {
        final type = jobType.toLowerCase();
        final jobTypeMatch = job.jobType.toLowerCase().contains(type);
        final workLocationMatch = job.workLocation.toLowerCase().contains(type);
        
        // Special handling for different job types
        if (type.contains('remote') || type.contains('work from home')) {
          return job.workLocation.toLowerCase().contains('remote') ||
                 job.workLocation.toLowerCase().contains('home') ||
                 job.jobType.toLowerCase().contains('remote');
        } else if (type.contains('office') || type.contains('work from office')) {
          return job.workLocation.toLowerCase().contains('office') ||
                 job.workLocation.toLowerCase().contains('onsite') ||
                 (!job.workLocation.toLowerCase().contains('remote') && 
                  !job.workLocation.toLowerCase().contains('home'));
        } else if (type.contains('full time') || type.contains('fulltime')) {
          return job.jobType.toLowerCase().contains('full') ||
                 job.jobType.toLowerCase().contains('permanent');
        } else if (type.contains('part time') || type.contains('parttime')) {
          return job.jobType.toLowerCase().contains('part');
        } else if (type.contains('internship')) {
          return job.jobType.toLowerCase().contains('intern');
        } else if (type.contains('freelance')) {
          return job.jobType.toLowerCase().contains('freelance') ||
                 job.jobType.toLowerCase().contains('contract');
        }
        
        return jobTypeMatch || workLocationMatch;
      }).toList();
    } catch (e) {
      _filteredJobs = [];
    }

    _isLoading = false;
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
