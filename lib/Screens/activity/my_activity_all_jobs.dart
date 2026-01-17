import 'package:flutter/material.dart';
import 'package:naukri_mitra_jobs/Screens/jobs/job_full_details.dart';
import 'package:naukri_mitra_jobs/Screens/custom/custom_buttom_nav.dart';
// import 'package:naukri_mitra_jobs/filter/filter_row.dart'; // File doesn't exist
import '../../utils/custom_header.dart';

class MyActivityAllJobs extends StatefulWidget {
  const MyActivityAllJobs({super.key});
  @override
  State<MyActivityAllJobs> createState() => _MyActivityAllJobsState();
}

class _MyActivityAllJobsState extends State<MyActivityAllJobs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7EAF6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(showNotification: false),
              const SizedBox(height: 12),
               _buildSearchBar(),
               const SizedBox(height: 12),
              // Filter Row commented out for Play Store deployment (not working)
              // const FilterRow(),
              // const SizedBox(height: 8),
              // Scrollable Job Cards
               Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildJobCard(
                        context,
                        title: "PHP Laravel Developer",
                        company: "Techuweb pvt ltd",
                        location: "Noida, Sector 63",
                        salary: "₹ 10000 - 150000",
                        urgent: true,
                        vacancies: 10,
                      ),
                      _buildJobCard(
                        context,
                        title: "Backend Developer",
                        company: "Techuweb pvt ltd",
                        location: "Noida, Sector 63",
                        salary: "₹ 10000 - 150000",
                        urgent: true,
                        vacancies: 8,
                      ),
                      _buildJobCard(
                        context,
                        title: "Backend Developer",
                        company: "Techuweb pvt ltd",
                        location: "Noida, Sector 63",
                        salary: "₹ 10000 - 150000",
                        urgent: true,
                        vacancies: 8,
                      ),_buildJobCard(
                        context,
                        title: "Backend Developer",
                        company: "Techuweb pvt ltd",
                        location: "Noida, Sector 63",
                        salary: "₹ 10000 - 150000",
                        urgent: true,
                        vacancies: 8,
                      ),
                      _buildJobCard(
                        context,
                        title: "Backend Developer",
                        company: "Techuweb pvt ltd",
                        location: "Noida, Sector 63",
                        salary: "₹ 10000 - 150000",
                        urgent: true,
                        vacancies: 8,
                      ),
                      _buildJobCard(
                        context,
                        title: "Office Boy",
                        company: "Techuweb pvt ltd",
                        location: "Noida, Sector 63",
                        salary: "₹ 10000 - 150000",
                        urgent: true,
                        vacancies: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- SEARCH BAR ----------------
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E9EFD), Color(0xFF4A64FE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search Job",
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.search, color: Colors.white),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // ---------------- FILTER ROW ----------------
  // ---------------- JOB CARD ----------------
  Widget _buildJobCard(
      BuildContext context, {
        required String title,
        required String company,
        required String location,
        required String salary,
        required bool urgent,
        required int vacancies,
      }) {
    return GestureDetector(
      onTap: () {
        var job;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JobFullDetails(job: job),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                if (urgent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Urgent Hiring",
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(company, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.blue),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              salary,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                _buildTag("New Job", Colors.orange),
                const SizedBox(width: 6),
                _buildTag("$vacancies Vacancies", Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: color),
      ),
    );
  }
}










