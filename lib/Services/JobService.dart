import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/JobModel.dart';


class JobService {
  static Future<List<JobModel>> fetchJobs() async {
    final url = Uri.parse("https://api.thenaukrimitra.com/api/jobs/fetch");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List jobs = body["data"];
      return jobs.map((job) => JobModel.fromJson(job)).toList();
    } else {
      throw Exception("Failed to load jobs");
    }
  }
}














// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../ model/JobModel.dart';
//
//
// class JobService {
//   static Future<List<JobModel>> fetchJobs(String query) async {
//     final url = Uri.parse("http://api.thenaukrimitra.com/api/jobs/fetch");
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       final List jobs = body["data"];
//       return jobs.map((job) => JobModel.fromJson(job)).toList();
//     } else {
//       throw Exception("Failed to load jobs");
//     }
//   }
// }
