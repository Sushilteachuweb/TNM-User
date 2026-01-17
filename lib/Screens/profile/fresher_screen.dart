// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Home_screens/home_screen.dart';
// import 'package:naukri_mitra_jobs/main_Screen/main_screen.dart';
//
// class FresherScreen extends StatefulWidget {
//   final String title;
//   final String image;
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final String salary;
//   final File imageFile;
//
//   const FresherScreen({
//     super.key,
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
//   State<FresherScreen> createState() => _FresherScreenState();
// }
//
// class _FresherScreenState extends State<FresherScreen> {
//   final TextEditingController _skillController = TextEditingController();
//
//   final List<String> _availableSkills = [
//     'AutoCad',
//     'Photoshop',
//     'Corel Draw',
//     'Animation',
//     'Video Editing',
//     'UI_UX'
//   ];
//
//   final List<String> _selectedSkills = [];
//
//   void _addSkill(String skill) {
//     if (skill.isNotEmpty && !_selectedSkills.contains(skill)) {
//       setState(() {
//         _selectedSkills.add(skill);
//       });
//     }
//     _skillController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFEFF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Back Button
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.blue),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//
//                 // Profile Card
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           widget.image,
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           widget.title,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Skill Input
//                 const Text("Skills",
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _skillController,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Add Your Skills',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     // ElevatedButton(
//                     //   onPressed: () => _addSkill(_skillController.text),
//                     //   style: ElevatedButton.styleFrom(
//                     //     backgroundColor: Colors.blue,
//                     //     shape: const CircleBorder(),
//                     //     padding: const EdgeInsets.all(14),
//                     //   ),
//                     //   // child: const Icon(Icons.add, color: Colors.white),
//                     // )
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 const Text("Select your skills",
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//
//                 // Skills Chips
//                 Center(
//                   child: Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: _availableSkills.map((skill) {
//                       return GestureDetector(
//                         onTap: () => _addSkill(skill),
//                         child: Chip(
//                           backgroundColor: Colors.orange.shade300,
//                           label: Text(skill,
//                               style: const TextStyle(color: Colors.white)),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 if (_selectedSkills.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Your Selected Skills:",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: _selectedSkills.map((skill) {
//                           return Chip(
//                             backgroundColor: Colors.blue.shade200,
//                             label: Text(skill),
//                             onDeleted: () {
//                               setState(() {
//                                 _selectedSkills.remove(skill);
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//
//                 const SizedBox(height: 100),
//
//                 // Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text(
//                         "Back",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: () {
//                         if (_selectedSkills.isEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text("Please add at least one skill")),
//                           );
//                           return;
//                         }
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             // MainScreen karna hai
//                             builder: (context) => HomeScreen(
//                               title: widget.title,
//                               image: widget.image,
//                               fullName: widget.fullName,
//                               gender: widget.gender,
//                               education: widget.education,
//                               workExperience: widget.workExperience,
//                               salary: widget.salary,
//                               imageFile: widget.imageFile,
//                               // skills: _selectedSkills, // 👈 yeh bhej raha hoon
//                             ),
//                           ),
//                         );
//
//                         print("Selected Skills: $_selectedSkills");
//                       },
//                       child: const Text(
//                         "Next",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








import 'dart:io';
import 'package:flutter/material.dart';
import 'package:naukri_mitra_jobs/Screens/home/main_screen.dart';
import '../../generated/l10n/app_localizations.dart';

class FresherScreen extends StatefulWidget {
  final String title;
  final String image;
  final String fullName;
  final String gender;
  final String education;
  final String workExperience;
  final String salary;
  final File imageFile;

  const FresherScreen({
    super.key,
    required this.title,
    required this.image,
    required this.fullName,
    required this.gender,
    required this.education,
    required this.workExperience,
    required this.salary,
    required this.imageFile,
  });

  @override
  State<FresherScreen> createState() => _FresherScreenState();
}

class _FresherScreenState extends State<FresherScreen> with TickerProviderStateMixin {
  final TextEditingController _skillController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<String> _availableSkills = [
    'AutoCAD',
    'Photoshop',
    'Corel Draw',
    'Animation',
    'Video Editing',
    'UI/UX Design',
    'Microsoft Office',
    'Data Entry',
    'Communication',
    'Problem Solving',
  ];

  final List<String> _selectedSkills = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill(String skill) {
    if (skill.isNotEmpty && !_selectedSkills.contains(skill)) {
      setState(() {
        _selectedSkills.add(skill);
      });
    }
    _skillController.clear();
  }

  void _removeSkill(String skill) {
    setState(() {
      _selectedSkills.remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      _buildHeader(),
                      const SizedBox(height: 32),

                      // Logo and title section
                      _buildLogoSection(),
                      const SizedBox(height: 32),

                      // Content
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Job info card
                              _buildJobInfoCard(),
                              const SizedBox(height: 24),

                              // Skills section
                              _buildSkillsSection(),
                              const SizedBox(height: 24),

                              // Selected skills
                              if (_selectedSkills.isNotEmpty) _buildSelectedSkills(),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),

                      // Bottom buttons
                      _buildBottomButtons(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2E3A59), size: 20),
            padding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          AppLocalizations.of(context)!.addYourSkills,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E3A59),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.62,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              'images/logomain.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.rozgarDigitalSaathi,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2E3A59),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildJobInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.image,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF2E3A59),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.fresherPosition,
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with gradient
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667eea).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Skills",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.addYourSkills,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Custom skill input with modern design
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _skillController,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E3A59),
                  ),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.typeCustomSkillPlaceholder,
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add_circle_outline_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  onSubmitted: (value) => _addSkill(value),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667eea).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _addSkill(_skillController.text),
                    borderRadius: BorderRadius.circular(12),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.add_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Popular skills section
        Text(
          AppLocalizations.of(context)!.popularSkills,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E3A59),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Tap to select or deselect skills",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        
        // Skills grid with modern design
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _availableSkills.map((skill) {
              final isSelected = _selectedSkills.contains(skill);
              return GestureDetector(
                onTap: () => isSelected ? _removeSkill(skill) : _addSkill(skill),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : Colors.grey[300]!,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected 
                            ? const Color(0xFF667eea).withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: isSelected ? 8 : 4,
                        offset: Offset(0, isSelected ? 4 : 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isSelected ? Icons.check_circle_rounded : Icons.add_circle_outline_rounded,
                          key: ValueKey(isSelected),
                          color: isSelected ? Colors.white : const Color(0xFF667eea),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        skill,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF2E3A59),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedSkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with count badge
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF43e97b).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.selectedSkills,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '${_selectedSkills.length}',
                  style: const TextStyle(
                    color: Color(0xFF43e97b),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Selected skills container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF43e97b).withOpacity(0.1),
                const Color(0xFF38f9d7).withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF43e97b).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _selectedSkills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      skill,
                      style: const TextStyle(
                        color: Color(0xFF2E3A59),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _removeSkill(skill),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 14,
                          color: Colors.red[600],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4A90E2)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocalizations.of(context)!.back,
                style: const TextStyle(
                  color: Color(0xFF4A90E2),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedSkills.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.pleaseAddAtLeastOneSkill),
                      backgroundColor: Colors.red[400],
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      title: widget.title,
                      image: widget.image,
                      fullName: widget.fullName,
                      gender: widget.gender,
                      education: widget.education,
                      workExperience: widget.workExperience,
                      salary: widget.salary,
                      imageFile: widget.imageFile,
                      skills: _selectedSkills,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.continueButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}






//without mainscreen add
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Home_screens/home_screen.dart';
//
// class FresherScreen extends StatefulWidget {
//   final String title;
//   final String image;
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final String salary;
//   final File imageFile;
//
//   const FresherScreen({
//     super.key,
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
//   State<FresherScreen> createState() => _FresherScreenState();
// }
//
// class _FresherScreenState extends State<FresherScreen> {
//   final TextEditingController _skillController = TextEditingController();
//
//   final List<String> _availableSkills = [
//     'AutoCad',
//     'Photoshop',
//     'Corel Draw',
//     'Animation',
//     'Video Editing',
//     'UI_UX'
//   ];
//
//   final List<String> _selectedSkills = [];
//
//   void _addSkill(String skill) {
//     if (skill.isNotEmpty && !_selectedSkills.contains(skill)) {
//       setState(() {
//         _selectedSkills.add(skill);
//       });
//     }
//     _skillController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFEFF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Back Button
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.blue),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//
//                 // Profile Card
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           widget.image,
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           widget.title,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Skill Input
//                 const Text("Skills",
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _skillController,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Add Your Skills',
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       onPressed: () => _addSkill(_skillController.text),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: const CircleBorder(),
//                         padding: const EdgeInsets.all(14),
//                       ),
//                       child: const Icon(Icons.add, color: Colors.white),
//                     )
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 const Text("Select your skills",
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//
//                 // Skills Chips
//                 Center(
//                   child: Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: _availableSkills.map((skill) {
//                       return GestureDetector(
//                         onTap: () => _addSkill(skill),
//                         child: Chip(
//                           backgroundColor: Colors.orange.shade300,
//                           label: Text(skill,
//                               style: const TextStyle(color: Colors.white)),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 if (_selectedSkills.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Your Selected Skills:",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: _selectedSkills.map((skill) {
//                           return Chip(
//                             backgroundColor: Colors.blue.shade200,
//                             label: Text(skill),
//                             onDeleted: () {
//                               setState(() {
//                                 _selectedSkills.remove(skill);
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//
//                 const SizedBox(height: 100),
//
//                 // Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text(
//                         "Back",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: () {
//                         if (_selectedSkills.isEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text("Please add at least one skill")),
//                           );
//                           return;
//                         }
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HomeScreen(
//                               // yahan tumhare HomeScreen ko data mil jayega
//                               title: widget.title,
//                               image: widget.image,
//                               fullName: widget.fullName,
//                               gender: widget.gender,
//                               education: widget.education,
//                               workExperience: widget.workExperience,
//                               salary: widget.salary,
//                               imageFile: widget.imageFile,
//                               skills: _selectedSkills, // 👈 yeh bhej raha hoon
//                             ),
//                           ),
//                         );
//
//                         print("Selected Skills: $_selectedSkills");
//                       },
//                       child: const Text(
//                         "Next",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//





// received data previous page

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Home_screens/home_screen.dart';
//
//
// class FresherScreen extends StatefulWidget {
//   final String title;
//   final String image;
//   final String fullName;
//   final String gender;
//   final String education;
//   final String workExperience;
//   final String salary;
//   final File imageFile;
//
//   const FresherScreen({super.key, required this.title, required this.image,
//     required this.fullName,
//     required this.gender,
//     required this.education,
//     required this.workExperience,
//     required this.salary,
//     required this.imageFile,
//
//   });
//
//   @override
//   State<FresherScreen> createState() => _FresherScreenState();
// }
//
// class _FresherScreenState extends State<FresherScreen> {
//   final TextEditingController _skillController = TextEditingController();
//   final List<String> _availableSkills = [
//     'AutoCad',
//     'Photoshop',
//     'Corel Draw',
//     'Animation',
//     'Video Editing',
//     'UI_UX'
//   ];
//   final List<String> _selectedSkills = [];
//
//   void _addSkill(String skill) {
//     if (!_selectedSkills.contains(skill)) {
//       setState(() {
//         _selectedSkills.add(skill);
//       });
//     }
//     _skillController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFEFF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Back Button
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.blue),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//
//                 // Profile Card with image and title
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           widget.image,
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           widget.title,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Skills input
//                 const Text("Skills", style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 6),
//                 Container(
//                   width: double.infinity,
//                   height: 50,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       focusColor: Colors.white,
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       hintText: 'Add Your Skills',
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       suffixIcon: Padding(
//                         padding: const EdgeInsets.only(right: 15.0),
//                         child: Icon(Icons.search),
//                       ),
//                     ),
//                   ),
//                 ),
//
//
//                 const SizedBox(height: 20),
//                 const Text("Select your skills", style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//
//                 // Skill Chips
//                 Center(
//                   child: Wrap(
//                     spacing: 20,
//                     runSpacing: 10,
//                     children: _availableSkills.map((skill) {
//                       return GestureDetector(
//                         onTap: () => _addSkill(skill),
//                         child: Chip(
//                           backgroundColor: Colors.orange.shade300,
//                           label: Text(skill, style: const TextStyle(color: Colors.white)),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//
//                 if (_selectedSkills.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Your Selected Skills:",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: _selectedSkills.map((skill) {
//                           return Chip(
//                             backgroundColor: Colors.blue.shade200,
//                             label: Text(skill),
//                             onDeleted: () {
//                               setState(() {
//                                 _selectedSkills.remove(skill);
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//
//                SizedBox(height: 300,),
//
//                 // Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("Back",
//                         style: TextStyle(color: Colors.white,
//                             fontWeight: FontWeight.bold,fontSize: 16),),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)
//                         )
//                       ),
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context)=>HomeScreen(
//                             )));
//
//                         print("Selected Skills: $_selectedSkills");
//                       },
//                       child: const Text("Next",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
//                     ),)
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Home_screens/home_screen.dart';
//
// import '../main_Screen/main_screen.dart';
//
//
// class FresherScreen extends StatefulWidget {
//   final String title;
//   final String image;
//
//   const FresherScreen({super.key, required this.title, required this.image});
//
//   @override
//   State<FresherScreen> createState() => _FresherScreenState();
// }
//
// class _FresherScreenState extends State<FresherScreen> {
//   final TextEditingController _skillController = TextEditingController();
//   final List<String> _availableSkills = [
//     'AutoCad',
//     'Photoshop',
//     'Corel Draw',
//     'Animation',
//     'Video Editing',
//     'UI_UX'
//   ];
//   final List<String> _selectedSkills = [];
//
//   void _addSkill(String skill) {
//     if (!_selectedSkills.contains(skill)) {
//       setState(() {
//         _selectedSkills.add(skill);
//       });
//     }
//     _skillController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFEFF6),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Back Button
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.blue),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//
//                 // Profile Card with image and title
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           widget.image,
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           widget.title,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Skills input
//                 const Text("Skills", style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 6),
//                 Container(
//                   width: double.infinity,
//                   height: 50,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       focusColor: Colors.white,
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.white, width: 2.0),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       hintText: 'Add Your Skills',
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       suffixIcon: Padding(
//                         padding: const EdgeInsets.only(right: 15.0),
//                         child: Icon(Icons.search),
//                       ),
//                     ),
//                   ),
//                 ),
//
//
//                 const SizedBox(height: 20),
//                 const Text("Select your skills", style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//
//                 // Skill Chips
//                 Center(
//                   child: Wrap(
//                     spacing: 20,
//                     runSpacing: 10,
//                     children: _availableSkills.map((skill) {
//                       return GestureDetector(
//                         onTap: () => _addSkill(skill),
//                         child: Chip(
//                           backgroundColor: Colors.orange.shade300,
//                           label: Text(skill, style: const TextStyle(color: Colors.white)),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//
//                 if (_selectedSkills.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Your Selected Skills:",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: _selectedSkills.map((skill) {
//                           return Chip(
//                             backgroundColor: Colors.blue.shade200,
//                             label: Text(skill),
//                             onDeleted: () {
//                               setState(() {
//                                 _selectedSkills.remove(skill);
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//
//                 SizedBox(height: 300,),
//
//                 // Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("Back",
//                         style: TextStyle(color: Colors.white,
//                             fontWeight: FontWeight.bold,fontSize: 16),),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)
//                           )
//                       ),
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const MainScreen(initialIndex: 0), // 👈 Home tab
//                           ),
//                         );
//
//
//                         print("Selected Skills: $_selectedSkills");
//                       },
//                       child: const Text("Next",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
//                       ),)
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
