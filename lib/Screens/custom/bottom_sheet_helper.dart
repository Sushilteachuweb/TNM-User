import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headingText,
                  ),
                ),
                const SizedBox(height: 16),

                body ??
                    Text(
                      content ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.bodyText,
                      ),
                    ),
                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: const Center(
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Enhanced Skills selector with modern design
  static Future<List<String>?> showSkillsSelector({
    required BuildContext context,
    required List<String> currentSkills,
  }) async {
    final List<String> selectedSkills = List.from(currentSkills);

    return await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final allSkills = [
              {"name": "Flutter", "icon": "📱", "category": "Mobile"},
              {"name": "Dart", "icon": "🎯", "category": "Language"},
              {"name": "PHP", "icon": "🐘", "category": "Backend"},
              {"name": "Java", "icon": "☕", "category": "Language"},
              {"name": "Kotlin", "icon": "🤖", "category": "Mobile"},
              {"name": "Python", "icon": "🐍", "category": "Language"},
              {"name": "JavaScript", "icon": "🌐", "category": "Web"},
              {"name": "React", "icon": "⚛️", "category": "Web"},
              {"name": "Node.js", "icon": "🟢", "category": "Backend"},
              {"name": "Swift", "icon": "🍎", "category": "Mobile"},
            ];

            return DraggableScrollableSheet(
              initialChildSize: 0.85,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primary.withOpacity(0.1),
                              AppColors.secondary.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: Column(
                          children: [
                            // Drag handle
                            Container(
                              height: 4,
                              width: 40,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: AppColors.divider,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            
                            // Header content
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Icon(
                                    Icons.psychology_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Select Skills",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.headingText,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Choose skills that match your expertise",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.bodyText.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            // Selected count
                            if (selectedSkills.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.success.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      size: 16,
                                      color: AppColors.success,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${selectedSkills.length} skill${selectedSkills.length > 1 ? 's' : ''} selected",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.success,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Skills Grid - Now scrollable
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(24),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: allSkills.length,
                            itemBuilder: (context, index) {
                              final skill = allSkills[index];
                              final isSelected = selectedSkills.contains(skill['name'] as String);

                              return TweenAnimationBuilder<double>(
                                duration: Duration(milliseconds: 200 + (index * 50)),
                                tween: Tween(begin: 0.0, end: 1.0),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: 0.8 + (0.2 * value),
                                    child: Opacity(
                                      opacity: value,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Material(
                                  elevation: isSelected ? 6 : 2,
                                  shadowColor: isSelected 
                                      ? AppColors.primary.withOpacity(0.3)
                                      : Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  child: InkWell(
                                    onTap: () {
                                      setModalState(() {
                                        if (isSelected) {
                                          selectedSkills.remove(skill['name'] as String);
                                        } else {
                                          selectedSkills.add(skill['name'] as String);
                                        }
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      decoration: BoxDecoration(
                                        gradient: isSelected
                                            ? AppColors.primaryGradient
                                            : const LinearGradient(
                                                colors: [Colors.white, Colors.white],
                                              ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.transparent
                                              : AppColors.divider,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  skill['icon'] as String,
                                                  style: const TextStyle(fontSize: 18),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    skill['name'] as String,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: isSelected
                                                          ? Colors.white
                                                          : AppColors.headingText,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                AnimatedContainer(
                                                  duration: const Duration(milliseconds: 300),
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    borderRadius: BorderRadius.circular(9),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Colors.white
                                                          : AppColors.divider,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: isSelected
                                                      ? Icon(
                                                          Icons.check,
                                                          size: 10,
                                                          color: AppColors.primary,
                                                        )
                                                      : null,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                skill['category'] as String,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: isSelected
                                                      ? Colors.white.withOpacity(0.8)
                                                      : AppColors.bodyText.withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Bottom Action - Fixed at bottom
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Selected Skills Preview
                            if (selectedSkills.isNotEmpty) ...[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Selected Skills:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.bodyText,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 32,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedSkills.length,
                                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        selectedSkills[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                            
                            // Save Button
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: selectedSkills.isNotEmpty
                                    ? const LinearGradient(
                                        colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
                                      )
                                    : LinearGradient(
                                        colors: [
                                          AppColors.buttonDisabled,
                                          AppColors.buttonDisabled,
                                        ],
                                      ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: selectedSkills.isNotEmpty
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF4CAF50).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context, selectedSkills);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.save_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          selectedSkills.isNotEmpty
                                              ? "Save ${selectedSkills.length} Skill${selectedSkills.length > 1 ? 's' : ''}"
                                              : "Save",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
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
