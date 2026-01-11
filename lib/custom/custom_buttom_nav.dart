// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/custom/JobSearch.dart';
// import 'package:naukri_mitra_jobs/custom/ProfileScreen.dart';
// import 'package:naukri_mitra_jobs/custom/VideoScreen.dart';
// import 'package:naukri_mitra_jobs/custom/myActivity.dart';
//
// class CustomBottomNav extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//   const CustomBottomNav({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     final List<Widget> screens = [
//       Container(),
//       const JobSearch(),
//       const MyActivity(),
//       const VideoScreen(),
//       const ProfileScreen(),
//     ];
//
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) {
//         if (index == 0) {
//           // Home screen ke liye direct parent ka onTap call hoga
//           onTap(index);
//         } else {
//           // Baaki sab ek hi line me
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => screens[index]),
//           );
//         }
//       },
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       type: BottomNavigationBarType.fixed,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//         BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
//         BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Activity"),
//         BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "Video"),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//       ],
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:naukri_mitra_jobs/custom/JobSearch.dart';
// // import 'package:naukri_mitra_jobs/custom/ProfileScreen.dart';
// // import 'package:naukri_mitra_jobs/custom/VideoScreen.dart';
// // import 'package:naukri_mitra_jobs/custom/myActivity.dart';
// //
// // class CustomBottomNav extends StatelessWidget {
// //   final int currentIndex;
// //   final Function(int) onTap;
// //
// //   const CustomBottomNav({
// //     super.key,
// //     required this.currentIndex,
// //     required this.onTap,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomNavigationBar(
// //       currentIndex: currentIndex,
// //       onTap: (index) {
// //         if (index == 4) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const ProfileScreen()),
// //           );
// //         } else if (index == 1) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const JobSearch()),
// //           );
// //         } else if (index == 2) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const MyActivity()),
// //           );
// //         }
// //         else if (index == 3) {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => const VideoScreen()),
// //           );
// //         } else {
// //           onTap(index);
// //         }
// //       },
// //       selectedItemColor: Colors.blue,
// //       unselectedItemColor: Colors.grey,
// //       type: BottomNavigationBarType.fixed,
// //       items: const [
// //         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //         BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
// //         BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Activity"),
// //         BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "Video"),
// //         BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// //       ],
// //     );
// //   }
// // }
// //
//
//
//
// // if received
// //
// // class ke baad isko lagana hai
// // int _selectedIndex = 0;
// //
// // void _onBottomNavTap(int index) {
// //   setState(() {
// //     _selectedIndex = index;
// //   });
// // }
// //
// //  bottomNavigationBar: CustomBottomNav(
// //         currentIndex: _selectedIndex,
// //         onTap: _onBottomNavTap,
// //       ),
//   //  after safearea before scaffold