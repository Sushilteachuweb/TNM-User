
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:naukri_mitra_jobs/custom/JobSearch.dart';
import 'package:naukri_mitra_jobs/custom/ProfileScreen.dart';
import 'package:naukri_mitra_jobs/custom/VideoScreen.dart';
import 'package:naukri_mitra_jobs/custom/myActivity.dart';
import '../Home_screens/home_screen.dart';
import '../widgets/modern_bottom_nav.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  final String title;
  final String image;

  final String fullName;
  final String gender;
  final String education;
  final String workExperience;
  final String salary;
  final File? imageFile;// agr changes karna hai tho ? remove kr denge

  const MainScreen({
    super.key,
    this.initialIndex = 0,
    required this.title,
    required this.image,
    required this.fullName,
    required this.gender,
    required this.education,
    required this.workExperience,
    required this.salary,
    required this.imageFile, required List<String> skills, String? imageUrl,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              title: '',
              image: '',
              fullName: '',
              gender: '',
              education: '',
              workExperience: '',
              salary: '',
              imageFile: null,
              skills: [],
            ),
            JobSearch(jobs: []),
            // Corrected MyActivity
            MyActivity(
              // appliedJobs: Provider.of<AppliedJobsProvider>(context).appliedJobs,
            ),
            VideoScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: ModernBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }
}

// Post And Get both condition full fill

// // main_screen.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:naukri_mitra_jobs/custom/JobSearch.dart';
// import 'package:naukri_mitra_jobs/custom/ProfileScreen.dart';
// import 'package:naukri_mitra_jobs/custom/VideoScreen.dart';
// import 'package:naukri_mitra_jobs/custom/MyActivity.dart';
// import '../Home_screens/home_screen.dart';
// import '../provider/AppliedJobsProvider.dart';
//
// class MainScreen extends StatefulWidget {
//   final int initialIndex;
//   final String title;
//   final String image;
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final String salary;
//   final File? imageFile;
//
//   const MainScreen({
//     super.key,
//     this.initialIndex = 0,
//     required this.title,
//     required this.image,
//     required this.fullName,
//     required this.gender,
//     required this.education,
//     required this.workExperience,
//     required this.salary,
//     required this.imageFile,
//     required List<String> skills,
//     String? imageUrl,
//   });
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
// // ✅ Corrected MainScreen
// class _MainScreenState extends State<MainScreen> {
//   late int _currentIndex;
//   String cookie = "";
//   String userId = ""; // ✅ Add userId
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//     _loadPrefs();
//   }
//
//   Future<void> _loadPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       cookie = prefs.getString("cookie") ?? "";
//       userId = prefs.getString("userId") ?? ""; // ✅ Load userId
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_currentIndex != 0) {
//           setState(() {
//             _currentIndex = 0;
//           });
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: IndexedStack(
//           index: _currentIndex,
//           children: [
//             HomeScreen(
//               title: '',
//               image: '',
//               fullName: '',
//               gender: '',
//               education: '',
//               workExperience: '',
//               salary: '',
//               imageFile: null,
//               skills: [],
//             ),
//             JobSearch(jobs: []),
//
//             // ✅ Pass both cookie & userId to MyActivity
//             Consumer<AppliedJobsProvider>(
//               builder: (context, provider, _) {
//                 return MyActivity(
//                   cookie: cookie,
//                   userId: userId,
//                 );
//               },
//             ),
//
//             VideoScreen(),
//             ProfileScreen(),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() => _currentIndex = index);
//           },
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
//             BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Activity"),
//             BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//           ],
//         ),
//       ),
//     );
//   }
// }


//
// ye code hai Without MyActivity add kiye
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/custom/JobSearch.dart';
// import 'package:naukri_mitra_jobs/custom/ProfileScreen.dart';
// import 'package:naukri_mitra_jobs/custom/VideoScreen.dart';
// import 'package:naukri_mitra_jobs/custom/myActivity.dart';
// import '../Home_screens/home_screen.dart';
//
// class MainScreen extends StatefulWidget {
//   final int initialIndex;
//   final String title;
//   final String image;
//
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final String salary;
//   final File? imageFile;// agr changes karna hai tho ? remove kr denge
//
//   const MainScreen({
//     super.key,
//     this.initialIndex = 0,
//     required this.title,
//     required this.image,
//     required this.fullName,
//     required this.gender,
//     required this.education,
//     required this.workExperience,
//     required this.salary,
//     required this.imageFile, required List<String> skills, String? imageUrl,
//   });
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   late int _currentIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//   }
//
//   final List<Widget> _screens = [
//     HomeScreen(
//       title: '',
//       image: '',
//       fullName: '',
//       gender: '',
//       education: '',
//       workExperience: '',
//       salary: '',
//       imageFile: null,
//       skills: [],
//     ),
//     JobSearch(jobs: [],),
//     MyActivity(appliedJobs: []),
//     VideoScreen(),
//     ProfileScreen(
//
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_currentIndex != 0) {
//           setState(() {
//             _currentIndex = 0;
//           });
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         body: _screens[_currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() => _currentIndex = index);
//           },
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
//             BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Activity"),
//             BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//           ],
//         ),
//       ),
//     );
//   }
// }




// yahan data bhej rahe hai

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/custom/JobSearch.dart';
// import 'package:naukri_mitra_jobs/custom/ProfileScreen.dart';
// import 'package:naukri_mitra_jobs/custom/VideoScreen.dart';
// import 'package:naukri_mitra_jobs/custom/myActivity.dart';
// import '../Home_screens/home_screen.dart';
//
// class MainScreen extends StatefulWidget {
//   final int initialIndex;
//   final String title;
//   final String image;
//
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final String salary;
//   final File? imageFile;
//
//   const MainScreen({
//     super.key,
//     this.initialIndex = 0,
//     required this.title,
//     required this.image,
//     required this.fullName,
//     required this.gender,
//     required this.education,
//     required this.workExperience,
//     required this.salary,
//     required this.imageFile,
//     required List<String> skills,
//     String? imageUrl,
//   });
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   late int _currentIndex;
//   late List<Widget> _screens; // 👈 ab late initialize karenge
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex;
//
//     // 👇 Yaha initialize karenge taki widget. properties accessible ho
//     _screens = [
//       HomeScreen(
//         title: widget.title,
//         image: widget.image,
//         fullName: widget.fullName,
//         gender: widget.gender,
//         education: widget.education,
//         workExperience: widget.workExperience,
//         salary: widget.salary,
//         imageFile: widget.imageFile,
//         skills: [],
//       ),
//       JobSearch(),
//       MyActivity(),
//       VideoScreen(),
//       ProfileScreen(
//         fullName: widget.fullName,
//         gender: widget.gender,
//         education: widget.education,
//         workExperience: widget.workExperience,
//         salary: "widget.salary",
//         imageFile: widget.imageFile, skills: [],
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_currentIndex != 0) {
//           setState(() {
//             _currentIndex = 0; // 👈 Pehle Home tab pe le jao
//           });
//           return false; // 👈 App exit na ho
//         }
//         return true; // 👈 Agar already Home pe ho to exit allow
//       },
//       child: Scaffold(
//         body: _screens[_currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() => _currentIndex = index);
//           },
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
//             BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Activity"),
//             BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//










// uncomment karna hai
// without use willpopscope

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/custom/JobSearch.dart';
// import 'package:naukri_mitra_jobs/custom/ProfileScreen.dart';
// import 'package:naukri_mitra_jobs/custom/VideoScreen.dart';
// import 'package:naukri_mitra_jobs/custom/myActivity.dart';
// import '../Home_screens/home_screen.dart'; // ✅ Correct import
//
// class MainScreen extends StatefulWidget {
//   final int initialIndex;
//   final String title;
//   final String image;
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final String salary;
//   final File imageFile;
//
//   const MainScreen({super.key,
//     this.initialIndex = 0,
//     required this.title,
//     required this.image,
//     required this.fullName,
//     required this.gender,
//     required this.education,
//     required this.workExperience,
//     required this.salary,
//     required this.imageFile,
//   });
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   late int _currentIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialIndex; // 👈 default tab
//   }
//
//   final List<Widget> _screens = [
//     HomeScreen(title: '', image: '', fullName: '', gender: '', education: '', workExperience: '', salary: '', imageFile: null, skills: [],),
//     JobSearch(),
//     MyActivity(),
//     VideoScreen(),
//     ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() => _currentIndex = index);
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
//           BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Activity"),
//           BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Video"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
//



// uncomment karna hai