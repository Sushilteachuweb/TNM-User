import 'package:flutter/material.dart';

class BottomSheetHelper {
  /// Simple info bottom sheet (title + content or custom body)
  static void show({
    required BuildContext context,
    required String title,
    String? content,
    Widget? body,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag handle
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              body ??
                  Text(content ?? "",
                      style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Skills selector
  static Future<List<String>?> showSkillsSelector({
    required BuildContext context,
    required List<String> currentSkills,
  }) async {
    final List<String> selectedSkills = List.from(currentSkills);

    return await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final allSkills = [
              "Flutter",
              "Dart",
              "PHP",
              "Java",
              "Kotlin",
              "Python",
              "JavaScript"
            ];

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Text(
                    "Select Skills",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allSkills.length,
                      itemBuilder: (context, index) {
                        final skill = allSkills[index];
                        final isSelected = selectedSkills.contains(skill);

                        return CheckboxListTile(
                          title: Text(skill),
                          value: isSelected,
                          onChanged: (val) {
                            setModalState(() {
                              if (val == true) {
                                selectedSkills.add(skill);
                              } else {
                                selectedSkills.remove(skill);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, selectedSkills);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}













// import 'package:flutter/material.dart';
//
// class BottomSheetHelper {
//   static void show({
//     required BuildContext context,
//     required String title,
//     String? content,
//     Widget? body, // <-- NEW (to add custom content)
//   }) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       isScrollControlled: true,
//       builder: (_) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height * 0.5, // adaptive height
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // drag handle
//                 Center(
//                   child: Container(
//                     height: 5,
//                     width: 40,
//                     margin: const EdgeInsets.only(bottom: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//
//                 // Title
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Content (either text or custom widget)
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: body ??
//                         Text(
//                           content ?? "",
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Close button
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     minimumSize: const Size(double.infinity, 48),
//                   ),
//                   child: const Text("Close"),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
