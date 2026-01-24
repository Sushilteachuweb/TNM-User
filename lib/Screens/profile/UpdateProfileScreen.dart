import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/ProfileProvider.dart';
import '../../models/job_category_model.dart';

class UpdateProfileSheet extends StatefulWidget {
  final String fullName;
  final String email;
  final String gender;
  final String education;
  final String? userLocation;
  final String? jobCategory;
  final bool? isExperienced;
  final String? totalExperience;
  final String? currentSalary;
  final List<String>? skills;
  final List<String>? language;

  const UpdateProfileSheet({
    super.key,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.education,
    this.userLocation,
    this.jobCategory,
    this.isExperienced,
    this.totalExperience,
    this.currentSalary,
    this.skills,
    this.language,
  });

  @override
  State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
}

class _UpdateProfileSheetState extends State<UpdateProfileSheet> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  
  // Text Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _educationController;
  late TextEditingController _locationController;
  late TextEditingController _jobCategoryController;
  late TextEditingController _totalExperienceController;
  late TextEditingController _currentSalaryController;
  late TextEditingController _skillsController;
  late TextEditingController _languageController;
  
  // Dropdown values
  String? _selectedGender;
  bool? _isExperienced;
  String? _selectedJobCategoryId; // Add job category ID
  
  // File handling
  File? _profileImage;
  File? _resumeFile;
  final ImagePicker _picker = ImagePicker();
  
  // Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers
    _nameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _educationController = TextEditingController(text: widget.education);
    _locationController = TextEditingController(text: widget.userLocation ?? '');
    _jobCategoryController = TextEditingController(text: widget.jobCategory ?? '');
    _totalExperienceController = TextEditingController(text: widget.totalExperience ?? '');
    _currentSalaryController = TextEditingController(text: widget.currentSalary ?? '');
    _skillsController = TextEditingController(text: widget.skills?.join(', ') ?? '');
    _languageController = TextEditingController(text: widget.language?.join(', ') ?? '');
    
    // Initialize dropdown values
    if (widget.gender.isNotEmpty) {
      _selectedGender = widget.gender[0].toUpperCase() + widget.gender.substring(1);
    } else {
      _selectedGender = "Male";
    }
    _isExperienced = widget.isExperienced;
    
    // Initialize animations
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
    
    // Fetch job categories and initialize selected category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      if (provider.jobCategories.isEmpty) {
        provider.fetchJobCategories().then((_) {
          // After categories are loaded, try to find the matching category ID
          _initializeJobCategory(provider);
        });
      } else {
        _initializeJobCategory(provider);
      }
    });
  }
  
  void _initializeJobCategory(ProfileProvider provider) {
    if (widget.jobCategory != null && widget.jobCategory!.isNotEmpty) {
      // Try to find the category ID by matching the category name
      try {
        final matchingCategory = provider.jobCategories.firstWhere(
          (category) => category.jobCategory.toLowerCase() == widget.jobCategory!.toLowerCase(),
        );
        
        if (mounted) {
          setState(() {
            _selectedJobCategoryId = matchingCategory.id;
          });
        }
      } catch (e) {
        // If no matching category found by name, try by ID
        try {
          final matchingCategoryById = provider.jobCategories.firstWhere(
            (category) => category.id == widget.jobCategory,
          );
          
          if (mounted) {
            setState(() {
              _selectedJobCategoryId = matchingCategoryById.id;
            });
          }
        } catch (e) {
          // If still no match, leave it as null (no selection)
          print("No matching job category found for: ${widget.jobCategory}");
        }
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _educationController.dispose();
    _locationController.dispose();
    _jobCategoryController.dispose();
    _totalExperienceController.dispose();
    _currentSalaryController.dispose();
    _skillsController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  String _getFileSize(File? file) {
    if (file == null || !file.existsSync()) return "";
    final bytes = file.lengthSync();
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
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
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildImageSourceButton(
                        icon: Icons.camera_alt_outlined,
                        label: "Camera",
                        onTap: () => _pickProfileImage(ImageSource.camera),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildImageSourceButton(
                        icon: Icons.photo_library_outlined,
                        label: "Gallery",
                        onTap: () => _pickProfileImage(ImageSource.gallery),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Gradient gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickProfileImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 70,
      );
      
      if (mounted) Navigator.pop(context);

      if (image != null) {
        final file = File(image.path);
        final fileSize = file.lengthSync() / (1024 * 1024);
        
        if (fileSize > 5) {
          if (mounted) {
            _showSnackBar("Image too large: ${fileSize.toStringAsFixed(1)}MB. Max 5MB allowed.", Colors.orange);
          }
          return;
        }
        
        setState(() => _profileImage = file);
        if (mounted) {
          _showSnackBar("Profile image selected: ${_getFileSize(file)}", Colors.green);
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        _showSnackBar("Failed to pick image", Colors.red);
      }
    }
  }

  Future<void> _pickResumeFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final fileSize = file.lengthSync() / (1024 * 1024);
        
        if (fileSize > 5) {
          if (mounted) {
            _showSnackBar("Resume too large: ${fileSize.toStringAsFixed(1)}MB. Max 5MB allowed.", Colors.orange);
          }
          return;
        }
        
        setState(() => _resumeFile = file);
        if (mounted) {
          _showSnackBar("Resume selected: ${_getFileSize(file)}", Colors.green);
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar("Failed to pick resume file", Colors.red);
      }
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);

      try {
        bool success = await provider.updateProfile(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          gender: _selectedGender ?? "male",
          education: _educationController.text.trim(),
          userLocation: _locationController.text.trim().isNotEmpty ? _locationController.text.trim() : null,
          jobCategoryId: _selectedJobCategoryId, // Pass the selected job category ID
          isExperienced: _isExperienced, // Pass the experience level
          totalExperience: _isExperienced == true && _totalExperienceController.text.trim().isNotEmpty 
              ? _totalExperienceController.text.trim() 
              : null,
          currentSalary: _isExperienced == true && _currentSalaryController.text.trim().isNotEmpty 
              ? _currentSalaryController.text.trim() 
              : null,
          skills: _skillsController.text.trim().isNotEmpty ? _skillsController.text.trim() : null,
          language: _languageController.text.trim().isNotEmpty ? _languageController.text.trim() : null,
          profileImage: _profileImage,
          resumeFile: _resumeFile,
        );

        if (success) {
          if (mounted) {
            Navigator.pop(context);
            _showSnackBar("Profile updated successfully ✅", Colors.green);
          }
        } else {
          if (mounted) {
            _showSnackBar("Failed to update profile ❌", Colors.red);
          }
        }
      } catch (e) {
        if (mounted) {
          _showSnackBar(e.toString().replaceAll('Exception: ', ''), Colors.orange);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);

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
          bottom: 24, // Remove the viewInsets.bottom since it's already handled by ProfileScreen
        ),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Handle bar
                              Container(
                                width: 40,
                                height: 4,
                                margin: const EdgeInsets.only(bottom: 24),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              
                              // Header
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "Update Profile",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // Basic Information Section
                              _buildSectionHeader("Basic Information", Icons.person_outline),
                              const SizedBox(height: 12),
                              
                              _buildModernTextField(
                                controller: _nameController,
                                label: "Full Name",
                                icon: Icons.person_outline,
                              ),
                              const SizedBox(height: 16),
                              
                              _buildModernTextField(
                                controller: _emailController,
                                label: "Email",
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              
                              _buildModernDropdown(),
                              const SizedBox(height: 16),
                              
                              _buildModernTextField(
                                controller: _educationController,
                                label: "Education",
                                icon: Icons.school_outlined,
                              ),
                              const SizedBox(height: 16),
                              
                              _buildModernTextField(
                                controller: _locationController,
                                label: "Location",
                                icon: Icons.location_on_outlined,
                                validator: null,
                              ),
                              const SizedBox(height: 24),
                              
                              // Professional Information Section
                              _buildSectionHeader("Professional Information", Icons.work_outline),
                              const SizedBox(height: 12),
                              
                              _buildJobCategoryDropdown(),
                              const SizedBox(height: 16),
                              
                              _buildExperienceDropdown(),
                              const SizedBox(height: 12),
                              
                              // Experience Level Hint
                              _buildHintCard(),
                              const SizedBox(height: 16),
                              
                              if (_isExperienced == true) ...[
                                _buildModernTextField(
                                  controller: _totalExperienceController,
                                  label: "Total Experience (Years)",
                                  icon: Icons.timeline_outlined,
                                  keyboardType: TextInputType.number,
                                  validator: null,
                                  hintText: "e.g., 2, 3.5, 5",
                                ),
                                const SizedBox(height: 16),
                                
                                _buildModernTextField(
                                  controller: _currentSalaryController,
                                  label: "Current Salary (₹)",
                                  icon: Icons.currency_rupee_outlined,
                                  keyboardType: TextInputType.number,
                                  validator: null,
                                  hintText: "e.g., 25000, 50000, 100000",
                                ),
                                const SizedBox(height: 16),
                              ],
                              
                              if (_isExperienced == false) ...[
                                _buildInfoCard(
                                  "💡 Fresher Tip",
                                  "Don't worry about experience fields! As a fresher, focus on your skills and education. You can update experience details later as you grow in your career.",
                                  const LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)]),
                                ),
                                const SizedBox(height: 16),
                              ],
                              
                              // Skills Section
                              _buildSectionHeader("Skills & Languages", Icons.psychology_outlined),
                              const SizedBox(height: 12),
                              
                              _buildModernTextField(
                                controller: _skillsController,
                                label: "Skills (comma separated)",
                                icon: Icons.star_outline,
                                validator: null,
                                maxLines: 2,
                                hintText: "e.g., Flutter, Dart, Firebase, UI/UX",
                              ),
                              const SizedBox(height: 16),
                              
                              _buildModernTextField(
                                controller: _languageController,
                                label: "Languages (comma separated)",
                                icon: Icons.language_outlined,
                                validator: null,
                                maxLines: 2,
                                hintText: "e.g., English, Hindi, Gujarati",
                              ),
                              const SizedBox(height: 24),
                              
                              // Profile Image Section
                              _buildSectionHeader("Profile Image", Icons.image_outlined),
                              const SizedBox(height: 12),
                              
                              _buildModernFilePicker(
                                icon: Icons.image_outlined,
                                label: "Profile Image",
                                fileName: _profileImage != null
                                    ? "${_profileImage!.path.split('/').last} (${_getFileSize(_profileImage)})"
                                    : "No image selected",
                                onPressed: _showImagePickerSheet,
                                gradient: const LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
                              ),
                              const SizedBox(height: 24),
                              
                              // Resume Section
                              _buildSectionHeader("Resume", Icons.description_outlined),
                              const SizedBox(height: 12),
                              
                              _buildModernFilePicker(
                                icon: Icons.description_outlined,
                                label: "Resume (PDF, DOC, DOCX)",
                                fileName: _resumeFile != null
                                    ? "${_resumeFile!.path.split('/').last} (${_getFileSize(_resumeFile)})"
                                    : "No resume selected",
                                onPressed: _pickResumeFile,
                                gradient: const LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)]),
                              ),
                              const SizedBox(height: 24),
                              
                              // Save button
                              _buildModernSaveButton(),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon, 
            color: const Color(0xFF6B7280), 
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator ?? (v) => v!.isEmpty ? "Enter $label" : null,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF374151),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          labelStyle: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon, 
            color: const Color(0xFF6B7280), 
            size: 20,
          ),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFEF4444)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildModernDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        items: ["Male", "Female", "Other"]
            .map((g) => DropdownMenuItem(value: g, child: Text(g)))
            .toList(),
        onChanged: (val) => setState(() => _selectedGender = val),
        validator: (v) => v == null ? "Select gender" : null,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF374151),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: "Gender",
          labelStyle: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.person_outline, 
            color: Color(0xFF6B7280), 
            size: 20,
          ),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildJobCategoryDropdown() {
    final provider = Provider.of<ProfileProvider>(context);
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: provider.isCategoriesLoading
          ? Container(
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          : DropdownButtonFormField<String>(
              value: _selectedJobCategoryId,
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text("Select Job Category"),
                ),
                ...provider.jobCategories.map((category) => 
                  DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.jobCategory),
                  ),
                ).toList(),
              ],
              onChanged: (val) => setState(() => _selectedJobCategoryId = val),
              validator: null, // Make it optional
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: "Job Category",
                labelStyle: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.category_outlined, 
                  color: Color(0xFF6B7280), 
                  size: 20,
                ),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
            ),
    );
  }

  Widget _buildExperienceDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<bool>(
        value: _isExperienced,
        items: const [
          DropdownMenuItem(value: true, child: Text("Experienced")),
          DropdownMenuItem(value: false, child: Text("Fresher")),
        ],
        onChanged: (val) {
          setState(() {
            _isExperienced = val;
            // Clear experience fields when switching to fresher
            if (val == false) {
              _totalExperienceController.clear();
              _currentSalaryController.clear();
            }
          });
        },
        validator: (v) => v == null ? "Select experience level" : null,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF374151),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: "Experience Level",
          labelStyle: const TextStyle(
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.work_outline, 
            color: Color(0xFF6B7280), 
            size: 20,
          ),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildModernFilePicker({
    required IconData icon,
    required String label,
    required String fileName,
    required VoidCallback onPressed,
    required Gradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fileName,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      "Choose",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
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
  }

  Widget _buildHintCard() {
    if (_isExperienced == null) return const SizedBox.shrink();
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isExperienced == true
          ? _buildInfoCard(
              "✨ Experienced Professional",
              "You can add your skills to showcase your expertise and help employers find you for relevant opportunities.",
              const LinearGradient(colors: [Color(0xFF43e97b), Color(0xFF38f9d7)]),
            )
          : _buildInfoCard(
              "🌟 Fresh Start",
              "Complete your profile to increase your chances of getting hired! Add your skills, upload a resume, and keep your information updated.",
              const LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)]),
            ),
    );
  }

  Widget _buildInfoCard(String title, String message, Gradient gradient) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0F2FE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.info_outline,
              color: Color(0xFF3B82F6),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E40AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF1E40AF),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSaveButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _saveProfile,
          borderRadius: BorderRadius.circular(12),
          child: const Center(
            child: Text(
              "Save Changes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}