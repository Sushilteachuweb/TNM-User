import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naukri_mitra_jobs/Screens/jobs/job_categories.dart';
import '../../generated/l10n/app_localizations.dart';

class CreateProfile extends StatefulWidget {
  final String phone;
  const CreateProfile({
    super.key,
    required this.phone,
  });
  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedGender;
  String? selectedEducation;
  String? selectedExperience;
  
  // Helper methods to map localized values to API values
  String _getApiGenderValue(String localizedGender) {
    final context = this.context;
    if (localizedGender == AppLocalizations.of(context).male) return 'male';
    if (localizedGender == AppLocalizations.of(context).female) return 'female';
    if (localizedGender == AppLocalizations.of(context).other) return 'other';
    return 'male'; // default fallback
  }
  
  String _getApiEducationValue(String localizedEducation) {
    final context = this.context;
    if (localizedEducation == AppLocalizations.of(context).tenthPass) return '10th Pass';
    if (localizedEducation == AppLocalizations.of(context).twelfthPass) return '12th Pass';
    if (localizedEducation == AppLocalizations.of(context).diploma) return 'Diploma';
    if (localizedEducation == AppLocalizations.of(context).graduate) return 'Graduate';
    if (localizedEducation == AppLocalizations.of(context).postGraduate) return 'Post Graduate';
    return 'Graduate'; // default fallback
  }
  
  String _getApiExperienceValue(String localizedExperience) {
    final context = this.context;
    if (localizedExperience == AppLocalizations.of(context).iAmFresher) return 'Fresher';
    if (localizedExperience == AppLocalizations.of(context).iHaveExperience) return 'Experienced';
    return 'Fresher'; // default fallback
  }
  File? selectedImage;

  final ImagePicker picker = ImagePicker();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    languageController.dispose();
    locationController.dispose();
    super.dispose();
  }

  // 📸 Image Picker with compression and size validation
  Future<void> _pickImage(ImageSource source) async {
    try {
      // ✅ Pick image with compression for Play Store
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 800,        // Compress to max 800px width
        maxHeight: 800,       // Compress to max 800px height
        imageQuality: 70,     // 70% quality to reduce file size
      );
      
      if (image != null) {
        final File imageFile = File(image.path);
        
        // ✅ Check file size (max 5MB for server compatibility)
        final fileSize = await imageFile.length();
        final fileSizeInMB = fileSize / (1024 * 1024);
        
        print("📸 Image selected: ${fileSizeInMB.toStringAsFixed(2)} MB");
        
        if (fileSizeInMB > 5) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Image too large: ${fileSizeInMB.toStringAsFixed(1)}MB. Please choose an image smaller than 5MB."
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
          return;
        }
        
        setState(() {
          selectedImage = imageFile;
        });
        
        print("✅ Profile image added: ${imageFile.path}");
      }
    } catch (e) {
      print("❌ Error picking image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 8),
                Text("Error selecting image. Please try again."),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
    
    if (mounted) Navigator.pop(context);
  }

  // 📸 Professional BottomSheet to choose Camera/Gallery
  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Choose Profile Photo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _pickImage(ImageSource.camera),
                          borderRadius: BorderRadius.circular(12),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined, color: Color(0xFF2196F3)),
                              SizedBox(width: 8),
                              Text(
                                "Camera",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2196F3),
                                ),
                              ),
                            ],
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
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _pickImage(ImageSource.gallery),
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_library_outlined, color: Colors.grey[700]),
                              const SizedBox(width: 8),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
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
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Professional Option Selector
  Widget _buildOptions({
    required String title,
    required List<String> options,
    required String? selectedValue,
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return Container(
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2196F3) : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? const Color(0xFF2196F3) : Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onSelected(option),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  // Professional Header with Back Button
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          color: Colors.grey[700],
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context).createProfile,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance the back button
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Main Title
                  const Text(
                    'Tell us about yourself',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Complete your profile in a few simple steps',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // 📸 Professional Profile Photo Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[200]!, width: 1),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: selectedImage != null ? const Color(0xFF2196F3) : Colors.grey[300]!,
                                  width: 3,
                                ),
                              ),
                              child: selectedImage != null
                                  ? ClipOval(
                                      child: Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person_outline_rounded,
                                      size: 50,
                                      color: Colors.grey[400],
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2196F3),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _showImagePickerSheet,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          ),
                          child: Text(
                            selectedImage != null ? AppLocalizations.of(context).changePhoto : AppLocalizations.of(context).addPhoto,
                            style: const TextStyle(
                              color: Color(0xFF2196F3),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Professional Form Fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!, width: 1.5),
                        ),
                        child: TextField(
                          controller: nameController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your full name',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Email Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).emailAddress,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!, width: 1.5),
                        ),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'example@email.com',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Language Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).language,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!, width: 1.5),
                        ),
                        child: TextField(
                          controller: languageController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter languages (comma separated, e.g., English, Hindi)',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Location Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).location,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!, width: 1.5),
                        ),
                        child: TextField(
                          controller: locationController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your location (e.g., Mumbai, Delhi)',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      // Professional Option Sections
                      _buildOptions(
                        title: AppLocalizations.of(context).gender,
                        options: [AppLocalizations.of(context).male, AppLocalizations.of(context).female, AppLocalizations.of(context).other],
                        selectedValue: selectedGender,
                        onSelected: (val) => setState(() => selectedGender = val),
                      ),
                      _buildOptions(
                        title: AppLocalizations.of(context).workExperience,
                        options: [AppLocalizations.of(context).iAmFresher, AppLocalizations.of(context).iHaveExperience],
                        selectedValue: selectedExperience,
                        onSelected: (val) => setState(() => selectedExperience = val),
                      ),
                      _buildOptions(
                        title: AppLocalizations.of(context).education,
                        options: [
                          AppLocalizations.of(context).tenthPass,
                          AppLocalizations.of(context).twelfthPass,
                          AppLocalizations.of(context).diploma,
                          AppLocalizations.of(context).graduate,
                          AppLocalizations.of(context).postGraduate
                        ],
                        selectedValue: selectedEducation,
                        onSelected: (val) => setState(() => selectedEducation = val),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Professional Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        // ✅ Validate email format
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        
                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text("Please enter your full name"),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                          return;
                        }
                        
                        if (emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text("Please enter your email"),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                          return;
                        }
                        
                        if (!emailRegex.hasMatch(emailController.text.trim())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text("Please enter a valid email address"),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                          return;
                        }
                        
                        if (languageController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text("Please enter your language"),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                          return;
                        }
                        
                        if (locationController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text("Please enter your location"),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                          return;
                        }
                        
                        if (nameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            languageController.text.isNotEmpty &&
                            locationController.text.isNotEmpty &&
                            selectedGender != null &&
                            selectedEducation != null &&
                            selectedExperience != null &&
                            selectedImage != null) {
                          final boolExp = selectedExperience == AppLocalizations.of(context).iHaveExperience;

                          // TODO: Language and Location will be sent to API later
                          // languageController.text and locationController.text are collected but not sent yet
                          print("📝 Language entered: ${languageController.text}");
                          print("📝 Location entered: ${locationController.text}");
                          print("📝 Experience: $boolExp (isExperienced: $boolExp)");

                          // Navigate directly to JobCategories without API call
                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobCategories(
                                  fullName: nameController.text,
                                  gender: _getApiGenderValue(selectedGender!),
                                  education: _getApiEducationValue(selectedEducation!),
                                  workExperience: _getApiExperienceValue(selectedExperience!),
                                  imageFile: selectedImage!,
                                  skills: [],
                                  language: languageController.text, // Pass language
                                  userLocation: locationController.text, // Pass location
                                  email: emailController.text, // Pass email
                                  phone: widget.phone, // Pass phone from CreateProfile constructor
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(Icons.error, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text("Please complete all fields"),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: const Color(0xFF2196F3).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward_rounded, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





// 29-09-2025

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/Screens/job_categories.dart';
// import '../provider/CreateProfileProvider.dart';
//
//
// class CreateProfile extends StatefulWidget {
//   final String phone;
//   const CreateProfile({
//     super.key,
//     required this.phone,
//   });
//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }
//
// class _CreateProfileState extends State<CreateProfile> {
//   final TextEditingController nameController = TextEditingController();
//   String? selectedGender;
//   String? selectedEducation;
//   String? selectedExperience;
//   File? selectedImage;
//
//   final ImagePicker picker = ImagePicker();
//
//   // 📸 Image Picker with permission
//   Future<void> _pickImage(ImageSource source) async {
//     if (source == ImageSource.camera) {
//       var cameraStatus = await Permission.camera.request();
//       if (!cameraStatus.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Camera permission denied")),
//         );
//         return;
//       }
//     } else {
//       var storageStatus = await Permission.photos.request();
//       if (!storageStatus.isGranted) {
//         var androidStatus = await Permission.storage.request();
//         if (!androidStatus.isGranted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Storage permission denied")),
//           );
//           return;
//         }
//       }
//     }
//
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//     if (mounted) Navigator.pop(context);
//   }
//
//   // 📸 BottomSheet to choose Camera/Gallery
//   void _showImagePickerSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Choose Profile Photo",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Camera"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Gallery"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // 🔹 Reusable Option Selector
//   Widget _buildOptions({
//     required String title,
//     required List<String> options,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(title,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options.map((option) {
//             final isSelected = selectedValue == option;
//             return InkWell(
//               onTap: () => onSelected(option),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   option,
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<CreateProfileProvider>(context);
//
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(236, 236, 245, 1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.arrow_back, color: Colors.blue)),
//               const SizedBox(height: 15),
//
//               const Center(
//                 child: Text(
//                   'Introduce yourself in three easy steps.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//
//               // 📸 Profile Photo
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage:
//                       selectedImage != null ? FileImage(selectedImage!) : null,
//                       child: selectedImage == null
//                           ? const Icon(Icons.person,
//                           size: 60, color: Colors.white)
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//                     InkWell(
//                       onTap: _showImagePickerSheet,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.camera_alt,
//                               color: Colors.blue, size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             "Add Photo",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//               const Text("Full Name",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 5),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               // 🚻 Gender
//               _buildOptions(
//                 title: "Gender",
//                 options: ["Male", "Female", "Other"],
//                 selectedValue: selectedGender,
//                 onSelected: (val) => setState(() => selectedGender = val),
//               ),
//               _buildOptions(
//                 title: "Work Experience",
//                 options: ["I am a fresher", "I have experience"],
//                 selectedValue: selectedExperience,
//                 onSelected: (val) => setState(() => selectedExperience = val),
//               ),
//               _buildOptions(
//                 title: "Education",
//                 options: [
//                   "10th Pass",
//                   "12th Pass",
//                   "Diploma",
//                   "Graduate",
//                   "Post Graduate"
//                 ],
//                 selectedValue: selectedEducation,
//                 onSelected: (val) => setState(() => selectedEducation = val),
//               ),
//
//               const SizedBox(height: 40),
//               Center(
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: provider.isLoading
//                         ? null
//                         : () async {
//                       if (nameController.text.isNotEmpty &&
//                           selectedGender != null &&
//                           selectedEducation != null &&
//                           selectedExperience != null &&
//                           selectedImage != null) {
//                         final boolExp = selectedExperience == "I have experience";
//
//
//                         final result = await provider.saveProfile(
//                           context,
//                           fullName: nameController.text,
//                           gender: selectedGender!,
//                           education: selectedEducation!,
//                           isExperienced: boolExp,
//                           currentSalary: 50000,
//                           email: "Ali@gmail.com",
//                           totalExperience: 2,
//                           jobCategory: "Software",
//                           skills: "Flutter",
//                           image: selectedImage,
//                           phone: widget.phone,
//                         );
//
//                         if (mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(result['message'] ?? 'No message')),
//                           );
//                         }
//
//                         if (result['success'] == true) {
//                           if (mounted) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => JobCategories(
//
//                                   fullName: nameController.text,
//                                   gender: selectedGender!,
//                                   education: selectedEducation!,
//                                   workExperience: selectedExperience!,
//                                   imageFile: selectedImage!,
//
//                                   skills: [],
//                                 ),
//                               ),
//                             );
//                           }
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("⚠️ Please complete all fields")),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8))),
//                     child: provider.isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text("Next",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//













//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/Screens/job_categories.dart';
//
// import '../provider/CreateProfileProvider.dart';
// class CreateProfile extends StatefulWidget {
//   final phone;
//   const CreateProfile({super.key,
//   required this.phone,
//   });
//
//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }
//
// class _CreateProfileState extends State<CreateProfile> {
//   final TextEditingController nameController = TextEditingController();
//   String? selectedGender;
//   String? selectedEducation;
//   String? selectedExperience;
//   File? selectedImage;
//
//   final ImagePicker picker = ImagePicker();
//
//   // 📸 Image Picker with permission
//   Future<void> _pickImage(ImageSource source) async {
//     if (source == ImageSource.camera) {
//       var cameraStatus = await Permission.camera.request();
//       if (!cameraStatus.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Camera permission denied")),
//         );
//         return;
//       }
//     } else {
//       var storageStatus = await Permission.photos.request(); // iOS ke liye
//       if (!storageStatus.isGranted) {
//         var androidStatus = await Permission.storage.request(); // Android ke liye
//         if (!androidStatus.isGranted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Storage permission denied")),
//           );
//           return;
//         }
//       }
//     }
//
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//     if (mounted) Navigator.pop(context); // bottom sheet band
//   }
//
//   // 📸 BottomSheet to choose Camera/Gallery
//   void _showImagePickerSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Choose Profile Photo",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Camera"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Gallery"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // 🔹 Reusable Option Selector
//   Widget _buildOptions({
//     required String title,
//     required List<String> options,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(title,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options.map((option) {
//             final isSelected = selectedValue == option;
//             return InkWell(
//               onTap: () => onSelected(option),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   option,
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<CreateProfileProvider>(context);
//
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(236, 236, 245, 1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔙 Back Button
//               const SizedBox(height: 10),
//               InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.arrow_back, color: Colors.blue)),
//               const SizedBox(height: 15),
//
//               const Center(
//                 child: Text(
//                   'Introduce yourself in three easy steps.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//
//               // 📸 Profile Photo
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage:
//                       selectedImage != null ? FileImage(selectedImage!) : null,
//                       child: selectedImage == null
//                           ? const Icon(Icons.person,
//                           size: 60, color: Colors.white)
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//                     InkWell(
//                       onTap: _showImagePickerSheet,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.camera_alt,
//                               color: Colors.blue, size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             "Add Photo",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//               const Text("Full Name",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 5),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               // 🚻 Gender
//               _buildOptions(
//                 title: "Gender",
//                 options: ["Male", "Female", "Other"],
//                 selectedValue: selectedGender,
//                 onSelected: (val) => setState(() => selectedGender = val),
//               ),
//               _buildOptions(
//                 title: "Work Experience",
//                 options: ["I am a fresher", "I have experience"],
//                 selectedValue: selectedExperience,
//                 onSelected: (val) => setState(() => selectedExperience = val),
//               ),
//               _buildOptions(
//                 title: "Education",
//                 options: [
//                   "10th Pass",
//                   "12th Pass",
//                   "Diploma",
//                   "Graduate",
//                   "Post Graduate"
//                 ],
//                 selectedValue: selectedEducation,
//                 onSelected: (val) => setState(() => selectedEducation = val),
//               ),
//
//               const SizedBox(height: 40),
//               Center(
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: provider.isLoading
//                         ? null
//                         : () async {
//                       // validation same as before
//                       if (nameController.text.isNotEmpty &&
//                           selectedGender != null &&
//                           selectedEducation != null &&
//                           selectedExperience != null &&
//                           selectedImage != null) {
//                         // call provider to save
//                         final boolExp =
//                             selectedExperience == "I have experience";
//                         final result = await provider.saveProfile(
//                           fullName: nameController.text,
//                           gender: selectedGender!,
//                           education: selectedEducation!,
//                           isExperienced: boolExp,
//                           image: selectedImage,
//                         );
//
//                         // Show response message
//                         final msg = result['message'] ?? 'No message';
//                         final success = result['success'] == true;
//
//                         if (mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(msg)),
//                           );
//                         }
//
//                         if (success) {
//                           // Navigate to JobCategories passing current screen data (same as you had)
//                           if (mounted) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => JobCategories(
//                                   fullName: nameController.text,
//                                   gender: selectedGender!,
//                                   education: selectedEducation!,
//                                   workExperience: selectedExperience!,
//                                   imageFile: selectedImage!, skills: [],
//                                 ),
//                               ),
//                             );
//                           }
//                         } else {
//
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("⚠️ Please complete all fields")),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8))),
//                     child: provider.isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text("Next",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//












// Toaday correct code 01-09-2025
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/Screens/job_categories.dart';
// import '../main_Screen/main_screen.dart';
// import '../provider/create_provider.dart';
//
// class CreateProfile extends StatefulWidget {
//   final String phone;
//   const CreateProfile({
//     super.key,
//     required this.phone
//   });
//
//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }
//
// class _CreateProfileState extends State<CreateProfile> {
//   final TextEditingController nameController = TextEditingController();
//   String? selectedGender;
//   String? selectedEducation;
//   String? selectedExperience;
//   File? selectedImage;
//
//   final ImagePicker picker = ImagePicker();
//   // 📸 Image Picker with permission
//   Future<void> _pickImage(ImageSource source) async {
//     if (source == ImageSource.camera) {
//       var cameraStatus = await Permission.camera.request();
//       if (!cameraStatus.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Camera permission denied")),
//         );
//         return;
//       }
//     } else {
//       var storageStatus = await Permission.photos.request(); // iOS
//       if (!storageStatus.isGranted) {
//         var androidStatus = await Permission.storage.request(); // Android
//         if (!androidStatus.isGranted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Storage permission denied")),
//           );
//           return;
//         }
//       }
//     }
//
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//     if (mounted) Navigator.pop(context); // bottom sheet band
//   }
//
//   // 📸 BottomSheet to choose Camera/Gallery
//   void _showImagePickerSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Choose Profile Photo",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Camera"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Gallery"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // 🔹 Reusable Option Selector Widget
//   Widget _buildOptions({
//     required String title,
//     required List<String> options,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(title,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options.map((option) {
//             final isSelected = selectedValue == option;
//             return InkWell(
//               onTap: () => onSelected(option),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   option,
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(236, 236, 245, 1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔙 Back Button
//               const SizedBox(height: 10),
//               InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.arrow_back, color: Colors.blue)),
//               const SizedBox(height: 15),
//
//               const Center(
//                 child: Text(
//                   'Introduce yourself in three easy steps.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               // 📸 Profile Photo
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage: selectedImage != null
//                           ? FileImage(selectedImage!)
//                           : null,
//                       child: selectedImage == null
//                           ? const Icon(Icons.person,
//                           size: 60, color: Colors.white)
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//                     InkWell(
//                       onTap: _showImagePickerSheet,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.camera_alt,
//                               color: Colors.blue, size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             "Add Photo",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               const Text("Full Name",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 5),
//
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               // 🚻 Gender
//               _buildOptions(
//                 title: "Gender",
//                 options: ["Male", "Female", "Other"],
//                 selectedValue: selectedGender,
//                 onSelected: (val) => setState(() => selectedGender = val),
//               ),
//
//               // 🧑‍💼 Experience
//               _buildOptions(
//                 title: "Work Experience",
//                 options: ["I am a fresher", "I have experience"],
//                 selectedValue: selectedExperience,
//                 onSelected: (val) => setState(() => selectedExperience = val),
//               ),
//
//               // 🎓 Education
//               _buildOptions(
//                 title: "Education",
//                 options: [
//                   "10th Pass",
//                   "12th Pass",
//                   "Diploma",
//                   "Graduate",
//                   "Post Graduate"
//                 ],
//                 selectedValue: selectedEducation,
//                 onSelected: (val) => setState(() => selectedEducation = val),
//               ),
//               const SizedBox(height: 40),
//               Center(
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (nameController.text.isNotEmpty &&
//                           selectedGender != null &&
//                           selectedEducation != null &&
//                           selectedExperience != null) {
//
//                         final provider = Provider.of<CreateProvider>(context, listen: false);
//
//                         final bool success = await provider.createUserProfile(
//                           fullName: nameController.text,
//                           phone: widget.phone,
//                           gender: (selectedGender ?? "male").toLowerCase(),
//                           education: selectedEducation!,
//                           jobCategory: "fresher",
//                           skills: "python",
//                           isExperienced: selectedExperience == "I have experience",
//                           totalExperience: "4",
//                           currentSalary: "50000",
//                           email: "divya@gmail.com",
//                           imageFile: selectedImage,
//                         );
//
//                         if (success) {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => JobCategories(
//                                 fullName: nameController.text,
//                                 gender: selectedGender!,
//                                 education: selectedEducation!,
//                                 workExperience: selectedExperience!,
//                                 imageFile: File(selectedImage!.path),
//                                 skills: const [],
//                               ),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(provider.message ?? "⚠️ Server error!")),
//                           );
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("⚠️ Please complete all fields")),
//                         );
//                       }
//                     },
//
//
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       "Next",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






// old and new wala condition laga hai

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/Screens/job_categories.dart';
// import '../main_Screen/main_screen.dart';
// import '../provider/create_provider.dart';
//
// class CreateProfile extends StatefulWidget {
//   final String phone;
//   const CreateProfile({
//     super.key,
//     required this.phone
//   });
//
//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }
//
// class _CreateProfileState extends State<CreateProfile> {
//   final TextEditingController nameController = TextEditingController();
//   String? selectedGender;
//   String? selectedEducation;
//   String? selectedExperience;
//   File? selectedImage;
//
//   final ImagePicker picker = ImagePicker();
//   // 📸 Image Picker with permission
//   Future<void> _pickImage(ImageSource source) async {
//     if (source == ImageSource.camera) {
//       var cameraStatus = await Permission.camera.request();
//       if (!cameraStatus.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Camera permission denied")),
//         );
//         return;
//       }
//     } else {
//       var storageStatus = await Permission.photos.request(); // iOS
//       if (!storageStatus.isGranted) {
//         var androidStatus = await Permission.storage.request(); // Android
//         if (!androidStatus.isGranted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Storage permission denied")),
//           );
//           return;
//         }
//       }
//     }
//
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//     if (mounted) Navigator.pop(context); // bottom sheet band
//   }
//
//   // 📸 BottomSheet to choose Camera/Gallery
//   void _showImagePickerSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Choose Profile Photo",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Camera"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Gallery"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // 🔹 Reusable Option Selector Widget
//   Widget _buildOptions({
//     required String title,
//     required List<String> options,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(title,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options.map((option) {
//             final isSelected = selectedValue == option;
//             return InkWell(
//               onTap: () => onSelected(option),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   option,
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(236, 236, 245, 1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔙 Back Button
//               const SizedBox(height: 10),
//               InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.arrow_back, color: Colors.blue)),
//               const SizedBox(height: 15),
//
//               const Center(
//                 child: Text(
//                   'Introduce yourself in three easy steps.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               // 📸 Profile Photo
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage: selectedImage != null
//                           ? FileImage(selectedImage!)
//                           : null,
//                       child: selectedImage == null
//                           ? const Icon(Icons.person,
//                           size: 60, color: Colors.white)
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//                     InkWell(
//                       onTap: _showImagePickerSheet,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.camera_alt,
//                               color: Colors.blue, size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             "Add Photo",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               const Text("Full Name",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 5),
//
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               // 🚻 Gender
//               _buildOptions(
//                 title: "Gender",
//                 options: ["Male", "Female", "Other"],
//                 selectedValue: selectedGender,
//                 onSelected: (val) => setState(() => selectedGender = val),
//               ),
//
//               // 🧑‍💼 Experience
//               _buildOptions(
//                 title: "Work Experience",
//                 options: ["I am a fresher", "I have experience"],
//                 selectedValue: selectedExperience,
//                 onSelected: (val) => setState(() => selectedExperience = val),
//               ),
//
//               // 🎓 Education
//               _buildOptions(
//                 title: "Education",
//                 options: [
//                   "10th Pass",
//                   "12th Pass",
//                   "Diploma",
//                   "Graduate",
//                   "Post Graduate"
//                 ],
//                 selectedValue: selectedEducation,
//                 onSelected: (val) => setState(() => selectedEducation = val),
//               ),
//               const SizedBox(height: 40),
//               Center(
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (nameController.text.isNotEmpty &&
//                           selectedGender != null &&
//                           selectedEducation != null &&
//                           selectedExperience != null) {
//
//                         final provider = Provider.of<CreateProvider>(context, listen: false);
//
//                         final bool success = await provider.createUserProfile(
//                           fullName: nameController.text,
//                           phone: widget.phone,
//                           gender: (selectedGender ?? "male").toLowerCase(),
//                           education: selectedEducation!,
//                           jobCategory: "fresher",
//                           skills: "python",
//                           isExperienced: selectedExperience == "I have experience",
//                           totalExperience: "4",
//                           currentSalary: "50000",
//                           email: "divya@gmail.com",
//                           imageFile: selectedImage, // null bhi ho sakta hai
//                         );
//
//                         if (success) {
//                           // ✅ New user → JobCategories
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => JobCategories(
//                                 fullName: nameController.text,
//                                 gender: selectedGender!,
//                                 education: selectedEducation!,
//                                 workExperience: selectedExperience!,
//                                 imageFile:  File(selectedImage!.path),
//                                 skills: const [],
//                               ),
//                             ),
//                           );
//                         } else {
//                           final msg = (provider.message ?? "").toLowerCase();
//
//                           if (msg.contains("already") || msg.contains("exist")) {
//                             // ✅ Duplicate number → MainScreen
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => MainScreen(
//                                   title: '',
//                                   image: '',
//                                   fullName: nameController.text,
//                                   gender: selectedGender!,
//                                   education: selectedEducation!,
//                                   workExperience: selectedExperience!,
//                                   salary: "50000",
//                                   imageFile:  File(selectedImage!.path),
//                                   skills: const [],
//                                 ),
//                               ),
//                             );
//                           } else {
//                             // ⚠️ Any other error
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(provider.message ?? "⚠️ Server error!")),
//                             );
//                           }
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("⚠️ Please complete all fields")),
//                         );
//                       }
//                     },
//
//
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       "Next",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//





// ye bina server ka code hai

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:naukri_mitra_jobs/Screens/job_categories.dart';
//
// import '../provider/create_provider.dart';
//
// class CreateProfile extends StatefulWidget {
//   const CreateProfile({super.key});
//
//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }
//
// class _CreateProfileState extends State<CreateProfile> {
//   final TextEditingController nameController = TextEditingController();
//   String? selectedGender;
//   String? selectedEducation;
//   String? selectedExperience;
//   File? selectedImage;
//
//   final ImagePicker picker = ImagePicker();
//
//   // 📸 Image Picker with permission
//   Future<void> _pickImage(ImageSource source) async {
//     if (source == ImageSource.camera) {
//       var cameraStatus = await Permission.camera.request();
//       if (!cameraStatus.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Camera permission denied")),
//         );
//         return;
//       }
//     } else {
//       var storageStatus = await Permission.photos.request(); // iOS ke liye
//       if (!storageStatus.isGranted) {
//         var androidStatus = await Permission.storage.request(); // Android ke liye
//         if (!androidStatus.isGranted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Storage permission denied")),
//           );
//           return;
//         }
//       }
//     }
//
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//     if (mounted) Navigator.pop(context); // bottom sheet band
//   }
//
//   // 📸 BottomSheet to choose Camera/Gallery
//   void _showImagePickerSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Choose Profile Photo",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Camera"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Gallery"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // 🔹 Reusable Option Selector
//   Widget _buildOptions({
//     required String title,
//     required List<String> options,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(title,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options.map((option) {
//             final isSelected = selectedValue == option;
//             return InkWell(
//               onTap: () => onSelected(option),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   option,
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(236, 236, 245, 1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔙 Back Button
//               const SizedBox(height: 10),
//               InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.arrow_back, color: Colors.blue)),
//               const SizedBox(height: 15),
//
//               const Center(
//                 child: Text(
//                   'Introduce yourself in three easy steps.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//
//               // 📸 Profile Photo
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage:
//                       selectedImage != null ? FileImage(selectedImage!) : null,
//                       child: selectedImage == null
//                           ? const Icon(Icons.person,
//                           size: 60, color: Colors.white)
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//                     InkWell(
//                       onTap: _showImagePickerSheet,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.camera_alt,
//                               color: Colors.blue, size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             "Add Photo",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//               const Text("Full Name",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 5),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               // 🚻 Gender
//               _buildOptions(
//                 title: "Gender",
//                 options: ["Male", "Female", "Other"],
//                 selectedValue: selectedGender,
//                 onSelected: (val) => setState(() => selectedGender = val),
//               ),
//               _buildOptions(
//                 title: "Work Experience",
//                 options: ["I am a fresher", "I have experience"],
//                 selectedValue: selectedExperience,
//                 onSelected: (val) => setState(() => selectedExperience = val),
//               ),
//               _buildOptions(
//                 title: "Education",
//                 options: [
//                   "10th Pass",
//                   "12th Pass",
//                   "Diploma",
//                   "Graduate",
//                   "Post Graduate"
//                 ],
//                 selectedValue: selectedEducation,
//                 onSelected: (val) => setState(() => selectedEducation = val),
//               ),
//
//               const SizedBox(height: 40),
//               Center(
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (nameController.text.isNotEmpty &&
//                           selectedGender != null &&
//                           selectedEducation != null &&
//                           selectedExperience != null &&
//                           selectedImage != null) {
//
//                         final provider = Provider.of<CreateProvider>(context, listen: false);
//
//                         await provider.createUserProfile(
//                           fullName: nameController.text,
//                           phone: "9199527041",   // abhi static rakha hai
//                           gender: selectedGender!,
//                           education: selectedEducation!,
//                           workExperience: selectedExperience!,
//                           imageFile: selectedImage!,
//                         );
//
//                         // ✅ Ab directly JobCategories pe jao
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => JobCategories(
//                               fullName: provider.fullName!,
//                               gender: provider.gender!,
//                               education: provider.education!,
//                               workExperience: provider.workExperience!,
//                               imageFile: provider.imageFile!, // 👈 provider se bhejo
//                             ),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("⚠️ Please complete all fields")),
//                         );
//                       }
//                     },
//
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       "Next",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//










// bina api integration wala hai


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:naukri_mitra_jobs/Screens/job_categories.dart';
//
// class CreateProfile extends StatefulWidget {
//   const CreateProfile({super.key});
//
//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }
//
// class _CreateProfileState extends State<CreateProfile> {
//   final TextEditingController nameController = TextEditingController();
//   String? selectedGender;
//   String? selectedEducation;
//   String? selectedExperience;
//   File? selectedImage;
//
//   final ImagePicker picker = ImagePicker();
//
//   // 📸 Image Picker with permission
//   Future<void> _pickImage(ImageSource source) async {
//     if (source == ImageSource.camera) {
//       var cameraStatus = await Permission.camera.request();
//       if (!cameraStatus.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Camera permission denied")),
//         );
//         return;
//       }
//     } else {
//       var storageStatus = await Permission.photos.request(); // iOS ke liye
//       if (!storageStatus.isGranted) {
//         var androidStatus = await Permission.storage.request(); // Android ke liye
//         if (!androidStatus.isGranted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Storage permission denied")),
//           );
//           return;
//         }
//       }
//     }
//
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//     if (mounted) Navigator.pop(context); // bottom sheet band
//   }
//
//   // 📸 BottomSheet to choose Camera/Gallery
//   void _showImagePickerSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Choose Profile Photo",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera_alt),
//                     label: const Text("Camera"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Gallery"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // 🔹 Reusable Option Selector
//   Widget _buildOptions({
//     required String title,
//     required List<String> options,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(title,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options.map((option) {
//             final isSelected = selectedValue == option;
//             return InkWell(
//               onTap: () => onSelected(option),
//               child: Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   option,
//                   style: const TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(236, 236, 245, 1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔙 Back Button
//               const SizedBox(height: 10),
//               InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.arrow_back, color: Colors.blue)),
//               const SizedBox(height: 15),
//
//               const Center(
//                 child: Text(
//                   'Introduce yourself in three easy steps.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//
//               // 📸 Profile Photo
//               Center(
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey[300],
//                       backgroundImage:
//                       selectedImage != null ? FileImage(selectedImage!) : null,
//                       child: selectedImage == null
//                           ? const Icon(Icons.person,
//                           size: 60, color: Colors.white)
//                           : null,
//                     ),
//                     const SizedBox(height: 12),
//                     InkWell(
//                       onTap: _showImagePickerSheet,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.camera_alt,
//                               color: Colors.blue, size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             "Add Photo",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//               const Text("Full Name",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 5),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               // 🚻 Gender
//               _buildOptions(
//                 title: "Gender",
//                 options: ["Male", "Female", "Other"],
//                 selectedValue: selectedGender,
//                 onSelected: (val) => setState(() => selectedGender = val),
//               ),
//               _buildOptions(
//                 title: "Work Experience",
//                 options: ["I am a fresher", "I have experience"],
//                 selectedValue: selectedExperience,
//                 onSelected: (val) => setState(() => selectedExperience = val),
//               ),
//               _buildOptions(
//                 title: "Education",
//                 options: [
//                   "10th Pass",
//                   "12th Pass",
//                   "Diploma",
//                   "Graduate",
//                   "Post Graduate"
//                 ],
//                 selectedValue: selectedEducation,
//                 onSelected: (val) => setState(() => selectedEducation = val),
//               ),
//
//               const SizedBox(height: 40),
//               Center(
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (nameController.text.isNotEmpty &&
//                           selectedGender != null &&
//                           selectedEducation != null &&
//                           selectedExperience != null &&
//                           selectedImage != null) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => JobCategories(
//                               fullName: nameController.text,
//                               gender: selectedGender!,
//                               education: selectedEducation!,
//                               workExperience: selectedExperience!,
//                               imageFile: selectedImage!,
//                             ),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("⚠️ Please complete all fields")),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8))),
//                     child: const Text("Next",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//











// import 'package:flutter/material.dart';
// import 'package:naukri_mitra_jobs/Screens/job_categories.dart';
//
// class CreateProfile extends StatefulWidget {
//   const CreateProfile({super.key});
//
//   @override
//   State<CreateProfile> createState() => _CreateProfileState();
// }
//
// class _CreateProfileState extends State<CreateProfile> {
//   String? selectedGender;
//   String? selectedExperience;
//   String? selectedEducation;
//
//   final TextEditingController nameController = TextEditingController();
//
//   Widget _buildSelectableChip({
//     required String label,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     bool isSelected = selectedValue == label;
//     return InkWell(
//       onTap: () => onSelected(label),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue : Colors.orange,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(2, 2),
//             ),
//           ],
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection({
//     required String title,
//     required List<String> options,
//     required String? selectedValue,
//     required Function(String) onSelected,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(title, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options
//               .map((option) => _buildSelectableChip(
//             label: option,
//             selectedValue: selectedValue,
//             onSelected: onSelected,
//           ))
//               .toList(),
//         ),
//         if (selectedValue != null) ...[
//           const SizedBox(height: 6),
//           Text(
//             "Selected: $selectedValue",
//             style: const TextStyle(
//               fontSize: 13,
//               fontStyle: FontStyle.italic,
//               color: Colors.blueGrey,
//             ),
//           ),
//         ]
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromRGBO(236, 236, 245, 1),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(Icons.arrow_back, color: Colors.blue)),
//               const SizedBox(height: 10),
//               const Center(
//                 child: Text(
//                   'Introduce yourself in three easy steps.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.grey,
//                       child: const Icon(Icons.person,
//                           size: 60, color: Colors.white),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(Icons.camera_alt, color: Colors.blue, size: 20),
//                         SizedBox(width: 5),
//                         Text(
//                           "Add Photo",
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Full Name",
//                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
//               ),
//               const SizedBox(height: 5),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               // Gender Section
//               _buildSection(
//                 title: "Gender",
//                 options: ["Male", "Female", "Other"],
//                 selectedValue: selectedGender,
//                 onSelected: (val) {
//                   setState(() {
//                     selectedGender = val;
//                   });
//                 },
//               ),
//
//               // Work Experience Section
//               _buildSection(
//                 title: "Work Experience",
//                 options: ["I am a fresher", "I have experience"],
//                 selectedValue: selectedExperience,
//                 onSelected: (val) {
//                   setState(() {
//                     selectedExperience = val;
//                   });
//                 },
//               ),
//
//               // Education Section
//               _buildSection(
//                 title: "Education",
//                 options: [
//                   "10th Pass",
//                   "12th Pass",
//                   "Diploma",
//                   "Graduate",
//                   "Post Graduate"
//                 ],
//                 selectedValue: selectedEducation,
//                 onSelected: (val) {
//                   setState(() {
//                     selectedEducation = val;
//                   });
//                 },
//               ),
//
//               const SizedBox(height: 40),
//
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 10),
//                       child: SizedBox(
//                         height: 45,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                           child: const Text(
//                             "Back",
//                             style: TextStyle(
//                                 color: Colors.white,fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
//                       child: SizedBox(
//                         height: 45,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                     const JobCategories()));
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                           child: const Text(
//                             "Next",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
