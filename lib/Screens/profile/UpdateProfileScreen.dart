//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// class UpdateProfileSheet extends StatefulWidget {
//   final String fullName;
//   final String email;
//   final String gender;
//   final String education;
//
//   const UpdateProfileSheet({
//     super.key,
//     required this.fullName,
//     required this.email,
//     required this.gender,
//     required this.education,
//   });
//
//   @override
//   State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
// }
//
// class _UpdateProfileSheetState extends State<UpdateProfileSheet> {
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _educationController;
//   String? _selectedGender;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.fullName);
//     _emailController = TextEditingController(text: widget.email);
//     _educationController = TextEditingController(text: widget.education);
//
//     // ✅ Normalize incoming gender
//     String g = widget.gender.trim().toLowerCase();
//     if (g == "male") {
//       _selectedGender = "Male";
//     } else if (g == "female") {
//       _selectedGender = "Female";
//     } else if (g == "other") {
//       _selectedGender = "Other";
//     } else {
//       _selectedGender = null;
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _educationController.dispose();
//     super.dispose();
//   }
//
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final provider = Provider.of<ProfileProvider>(context, listen: false);
//
//       bool success = await provider.updateProfile({
//         "fullName": _nameController.text.trim(),
//         "email": _emailController.text.trim(),
//         "gender": _selectedGender, // Provider auto lowercase karega ✅
//         "education": _educationController.text.trim(),
//       });
//
//       if (success) {
//         if (mounted) {
//           Navigator.pop(context); // ✅ sheet close
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Profile updated successfully ✅")),
//           );
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Failed to update profile ❌")),
//           );
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ✅ Drag handle
//               Container(
//                 width: 40,
//                 height: 5,
//                 margin: const EdgeInsets.only(bottom: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//
//               const Text(
//                 "Update Profile",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: "Full Name",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter full name" : null,
//               ),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter email" : null,
//               ),
//               const SizedBox(height: 12),
//
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ["Male", "Female", "Other"]
//                     .map((g) =>
//                     DropdownMenuItem(value: g, child: Text(g)))
//                     .toList(),
//                 onChanged: (val) =>
//                     setState(() => _selectedGender = val),
//                 decoration: const InputDecoration(
//                   labelText: "Gender",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v == null ? "Select gender" : null,
//               ),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: _educationController,
//                 decoration: const InputDecoration(
//                   labelText: "Education",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter education" : null,
//               ),
//               const SizedBox(height: 20),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveProfile,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue.shade300,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: const Text(
//                     "Save",
//                     style: TextStyle(
//                         color: Colors.white, fontSize: 16),
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


// resume ke sath Update hoga
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// class UpdateProfileSheet extends StatefulWidget {
//   final String fullName;
//   final String email;
//   final String gender;
//   final String education;
//
//   const UpdateProfileSheet({
//     super.key,
//     required this.fullName,
//     required this.email,
//     required this.gender,
//     required this.education,
//   });
//
//   @override
//   State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
// }
//
// class _UpdateProfileSheetState extends State<UpdateProfileSheet> {
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _educationController;
//   String? _selectedGender;
//
//   File? _profileImage;
//   File? _resumeFile;
//
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.fullName);
//     _emailController = TextEditingController(text: widget.email);
//     _educationController = TextEditingController(text: widget.education);
//
//     String g = widget.gender.trim().toLowerCase();
//     if (g == "male") {
//       _selectedGender = "Male";
//     } else if (g == "female") {
//       _selectedGender = "Female";
//     } else if (g == "other") {
//       _selectedGender = "Other";
//     } else {
//       _selectedGender = null;
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _educationController.dispose();
//     super.dispose();
//   }
//
//   Future<void> pickProfileImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() => _profileImage = File(image.path));
//     }
//   }
//
//   Future<void> pickResumeFile() async {
//     final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       setState(() => _resumeFile = File(file.path));
//     }
//   }
//
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final provider = Provider.of<ProfileProvider>(context, listen: false);
//
//       bool success = await provider.updateProfile(
//         updatedData: {
//           "fullName": _nameController.text.trim(),
//           "email": _emailController.text.trim(),
//           "gender": _selectedGender,
//           "education": _educationController.text.trim(),
//         },
//         profileImage: _profileImage,
//         resumeFile: _resumeFile,
//       );
//
//       if (success) {
//         if (mounted) {
//           Navigator.pop(context); // close sheet
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Profile updated successfully ✅")),
//           );
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Failed to update profile ❌")),
//           );
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 50,
//                 height: 5,
//                 margin: const EdgeInsets.only(bottom: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               const Text(
//                 "Update Profile",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Name field
//               _buildInputField(
//                 controller: _nameController,
//                 label: "Full Name",
//                 icon: Icons.person,
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter full name" : null,
//               ),
//               const SizedBox(height: 12),
//
//               // Email field
//               _buildInputField(
//                 controller: _emailController,
//                 label: "Email",
//                 icon: Icons.email,
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter email" : null,
//               ),
//               const SizedBox(height: 12),
//
//               // Gender Dropdown
//               Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: DropdownButtonFormField<String>(
//                     value: _selectedGender,
//                     items: ["Male", "Female", "Other"]
//                         .map((g) =>
//                         DropdownMenuItem(value: g, child: Text(g)))
//                         .toList(),
//                     onChanged: (val) =>
//                         setState(() => _selectedGender = val),
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       labelText: "Gender",
//                       prefixIcon:
//                       Icon(Icons.transgender, color: Colors.blue),
//                     ),
//                     validator: (v) =>
//                     v == null ? "Select gender" : null,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//
//               // Education field
//               _buildInputField(
//                 controller: _educationController,
//                 label: "Education",
//                 icon: Icons.school,
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter education" : null,
//               ),
//               const SizedBox(height: 12),
//
//               // Profile Image picker
//               _buildFilePicker(
//                 icon: Icons.image,
//                 label: "Choose Profile Image",
//                 fileName: _profileImage != null
//                     ? _profileImage!.path.split('/').last
//                     : "No image selected",
//                 onPressed: pickProfileImage,
//                 color: Colors.blue.shade300,
//               ),
//               const SizedBox(height: 12),
//
//               // Resume picker
//               _buildFilePicker(
//                 icon: Icons.description,
//                 label: "Choose Resume",
//                 fileName: _resumeFile != null
//                     ? _resumeFile!.path.split('/').last
//                     : "No resume selected",
//                 onPressed: pickResumeFile,
//                 color: Colors.green.shade300,
//               ),
//               const SizedBox(height: 20),
//
//               // Save button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveProfile,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text(
//                     "Save Changes",
//                     style: TextStyle(
//                         color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Reusable input field widget
//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     String? Function(String?)? validator,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: TextFormField(
//         controller: controller,
//         validator: validator,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.blue),
//           labelText: label,
//           border: InputBorder.none,
//           contentPadding:
//           const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Reusable file picker widget
//   Widget _buildFilePicker({
//     required IconData icon,
//     required String label,
//     required String fileName,
//     required VoidCallback onPressed,
//     required Color color,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: ListTile(
//         leading: Icon(icon, color: color),
//         title: Text(
//           fileName,
//           overflow: TextOverflow.ellipsis,
//         ),
//         trailing: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: const Text("Choose"),
//         ),
//       ),
//     );
//   }
// }




// working code 10-09-2025
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// class UpdateProfileSheet extends StatefulWidget {
//   final String fullName;
//   final String email;
//   final String gender;
//   final String education;
//
//   const UpdateProfileSheet({
//     super.key,
//     required this.fullName,
//     required this.email,
//     required this.gender,
//     required this.education,
//   });
//
//   @override
//   State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
// }
//
// class _UpdateProfileSheetState extends State<UpdateProfileSheet> {
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _educationController;
//   String? _selectedGender;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.fullName);
//     _emailController = TextEditingController(text: widget.email);
//     _educationController = TextEditingController(text: widget.education);
//
//     _selectedGender = widget.gender[0].toUpperCase() + widget.gender.substring(1);
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _educationController.dispose();
//     super.dispose();
//   }
//
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final provider = Provider.of<ProfileProvider>(context, listen: false);
//
//       bool success = await provider.updateProfile(
//         fullName: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         gender: _selectedGender ?? "male",
//         education: _educationController.text.trim(),
//       );
//
//       if (success) {
//         if (mounted) {
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Profile updated successfully ✅")),
//           );
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Failed to update profile ❌")),
//           );
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Update Profile",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Name
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: "Full Name",
//                   prefixIcon: Icon(Icons.person),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v!.isEmpty ? "Enter full name" : null,
//               ),
//               const SizedBox(height: 12),
//
//               // Email
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   prefixIcon: Icon(Icons.email),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v!.isEmpty ? "Enter email" : null,
//               ),
//               const SizedBox(height: 12),
//
//               // Gender
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ["Male", "Female", "Other"]
//                     .map((g) => DropdownMenuItem(value: g, child: Text(g)))
//                     .toList(),
//                 onChanged: (val) => setState(() => _selectedGender = val),
//                 decoration: const InputDecoration(
//                   labelText: "Gender",
//                   prefixIcon: Icon(Icons.transgender),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v == null ? "Select gender" : null,
//               ),
//               const SizedBox(height: 12),
//
//               // Education
//               TextFormField(
//                 controller: _educationController,
//                 decoration: const InputDecoration(
//                   labelText: "Education",
//                   prefixIcon: Icon(Icons.school),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v!.isEmpty ? "Enter education" : null,
//               ),
//               const SizedBox(height: 20),
//
//               // Save button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveProfile,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text(
//                     "Save Changes",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
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






import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/ProfileProvider.dart';
import '../../utils/app_colors.dart';

class UpdateProfileSheet extends StatefulWidget {
  final String fullName;
  final String email;
  final String gender;
  final String education;

  const UpdateProfileSheet({
    super.key,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.education,
  });

  @override
  State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
}

class _UpdateProfileSheetState extends State<UpdateProfileSheet> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _educationController;
  String? _selectedGender;

  File? _profileImage;
  File? _resumeFile;
  final ImagePicker _picker = ImagePicker();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _educationController = TextEditingController(text: widget.education);
    
    // Fix: Check if gender is not empty before accessing
    if (widget.gender.isNotEmpty) {
      _selectedGender =
          widget.gender[0].toUpperCase() + widget.gender.substring(1);
    } else {
      _selectedGender = "Male"; // Default value
    }
    
    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
    _nameController.dispose();
    _emailController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  String _getFileSize(File? file) {
    if (file == null || !file.existsSync()) return "";
    final bytes = file.lengthSync();
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  }

  // 📸 BottomSheet to choose Camera/Gallery
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
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                
                Text(
                  "Choose Profile Photo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headingText,
                  ),
                ),
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildImageSourceButton(
                        icon: Icons.camera_alt_rounded,
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
                        icon: Icons.photo_library_rounded,
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
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 32),
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
      
      if (mounted) Navigator.pop(context); // Close sheet

      if (image != null) {
        final file = File(image.path);
        final fileSize = file.lengthSync() / (1024 * 1024); // MB
        
        if (fileSize > 5) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Image too large: ${fileSize.toStringAsFixed(1)}MB. Max 5MB allowed."),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
          return;
        }
        
        setState(() => _profileImage = file);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close sheet on error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Failed to pick image"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> pickResumeFile() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final resumeFile = File(file.path);
      final fileSize = resumeFile.lengthSync() / (1024 * 1024); // MB
      
      if (fileSize > 5) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Resume too large: ${fileSize.toStringAsFixed(1)}MB. Max 5MB allowed."),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
        return;
      }
      
      setState(() => _resumeFile = resumeFile);
      
      // Show success message with file size
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Resume selected: ${_getFileSize(resumeFile)}"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);

      try {
        // ✅ Now sending image and resume files if selected
        bool success = await provider.updateProfile(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          gender: _selectedGender ?? "male",
          education: _educationController.text.trim(),
          profileImage: _profileImage, // ✅ Send selected image
          resumeFile: _resumeFile,     // ✅ Send selected resume
        );

        if (success) {
          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Profile updated successfully ✅"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Failed to update profile ❌"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll('Exception: ', '')),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
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
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
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
                              
                              // Header with gradient text
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                  ).createShader(bounds),
                                  child: const Text(
                                    "Update Profile",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              
                              // Form fields
                              _buildModernTextField(
                                controller: _nameController,
                                label: "Full Name",
                                icon: Icons.person_rounded,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                ),
                              ),
                              const SizedBox(height: 20),
                              
                              _buildModernTextField(
                                controller: _emailController,
                                label: "Email",
                                icon: Icons.email_rounded,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                                ),
                              ),
                              const SizedBox(height: 20),
                              
                              _buildModernDropdown(),
                              const SizedBox(height: 20),
                              
                              _buildModernTextField(
                                controller: _educationController,
                                label: "Education",
                                icon: Icons.school_rounded,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // File pickers
                              _buildModernFilePicker(
                                icon: Icons.image_rounded,
                                label: "Profile Image",
                                fileName: _profileImage != null
                                    ? "${_profileImage!.path.split('/').last} (${_getFileSize(_profileImage)})"
                                    : "No image selected",
                                onPressed: _showImagePickerSheet,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              _buildModernFilePicker(
                                icon: Icons.description_rounded,
                                label: "Resume",
                                fileName: _resumeFile != null
                                    ? "${_resumeFile!.path.split('/').last} (${_getFileSize(_resumeFile)})"
                                    : "No resume selected",
                                onPressed: pickResumeFile,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                                ),
                              ),
                              const SizedBox(height: 32),
                              
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

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Gradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: (v) => v!.isEmpty ? "Enter $label" : null,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.headingText,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildModernDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
        style: TextStyle(
          fontSize: 16,
          color: AppColors.headingText,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: "Gender",
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFfa709a), Color(0xFFfee140)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.transgender_rounded, color: Colors.white, size: 20),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
        color: Colors.grey[50],
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.headingText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fileName,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Choose",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
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

  Widget _buildModernSaveButton() {
    return Container(
      width: double.infinity,
      height: 56,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _saveProfile,
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              "Save Changes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}








//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// class UpdateProfileSheet extends StatefulWidget {
//   final String fullName;
//   final String email;
//   final String gender;
//   final String education;
//
//   const UpdateProfileSheet({
//     super.key,
//     required this.fullName,
//     required this.email,
//     required this.gender,
//     required this.education,
//   });
//
//   @override
//   State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
// }
//
// class _UpdateProfileSheetState extends State<UpdateProfileSheet> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _educationController;
//   String? _selectedGender;
//
//   File? _profileImage;
//   File? _resumeFile;
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.fullName);
//     _emailController = TextEditingController(text: widget.email);
//     _educationController = TextEditingController(text: widget.education);
//     _selectedGender =
//         widget.gender[0].toUpperCase() + widget.gender.substring(1);
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _educationController.dispose();
//     super.dispose();
//   }
//
//   Future<void> pickProfileImage() async {
//     final XFile? image = await _picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 800,
//       maxHeight: 800,
//       imageQuality: 70,
//     );
//     if (image != null) {
//       setState(() => _profileImage = File(image.path));
//     }
//   }
//
//   Future<void> pickResumeFile() async {
//     final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       setState(() => _resumeFile = File(file.path));
//     }
//   }
//
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final provider = Provider.of<ProfileProvider>(context, listen: false);
//       bool success = await provider.updateProfile(
//         fullName: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         gender: _selectedGender ?? "male",
//         education: _educationController.text.trim(),
//         profileImage: _profileImage,
//         resumeFile: _resumeFile,
//       );
//
//       if (success) {
//         if (mounted) {
//           Navigator.pop(context);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Profile updated successfully ✅")),
//           );
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Failed to update profile ❌")),
//           );
//         }
//       }
//     }
//   }
//
//   Widget _filePickerButton({
//     required String label,
//     required IconData icon,
//     required Color color,
//     File? file,
//     required VoidCallback onPressed,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: ListTile(
//         leading: Icon(icon, color: color, size: 28),
//         title: Text(
//           file != null ? file.path.split('/').last : label,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(fontSize: 14),
//         ),
//         trailing: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color,
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           ),
//           child: const Text("Choose"),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 50,
//                 height: 5,
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               const Text(
//                 "Update Profile",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: "Full Name",
//                   prefixIcon: Icon(Icons.person),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v!.isEmpty ? "Enter full name" : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   prefixIcon: Icon(Icons.email),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v!.isEmpty ? "Enter email" : null,
//               ),
//               const SizedBox(height: 12),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ["Male", "Female", "Other"]
//                     .map((g) => DropdownMenuItem(
//                   value: g,
//                   child: Text(g),
//                 ))
//                     .toList(),
//                 onChanged: (val) =>
//                     setState(() => _selectedGender = val),
//                 decoration: const InputDecoration(
//                   labelText: "Gender",
//                   prefixIcon: Icon(Icons.transgender),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v == null ? "Select gender" : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _educationController,
//                 decoration: const InputDecoration(
//                   labelText: "Education",
//                   prefixIcon: Icon(Icons.school),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) => v!.isEmpty ? "Enter education" : null,
//               ),
//               const SizedBox(height: 12),
//               _filePickerButton(
//                 label: "Choose Profile Image",
//                 icon: Icons.image,
//                 color: Colors.blue.shade300,
//                 file: _profileImage,
//                 onPressed: pickProfileImage,
//               ),
//               _filePickerButton(
//                 label: "Choose Resume",
//                 icon: Icons.description,
//                 color: Colors.green.shade300,
//                 file: _resumeFile,
//                 onPressed: pickResumeFile,
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveProfile,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: const Text(
//                     "Save Changes",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// class UpdateProfileSheet extends StatefulWidget {
//   final String fullName;
//   final String email;
//   final String gender;
//   final String education;
//
//   const UpdateProfileSheet({
//     super.key,
//     required this.fullName,
//     required this.email,
//     required this.gender,
//     required this.education,
//   });
//
//   @override
//   State<UpdateProfileSheet> createState() => _UpdateProfileSheetState();
// }
//
// class _UpdateProfileSheetState extends State<UpdateProfileSheet> {
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _educationController;
//   String? _selectedGender;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.fullName);
//     _emailController = TextEditingController(text: widget.email);
//     _educationController = TextEditingController(text: widget.education);
//
//     // ✅ Gender ko properly normalize karke set karenge
//     String g = widget.gender.trim().toLowerCase();
//     if (g == "male") {
//       _selectedGender = "Male";
//     } else if (g == "female") {
//       _selectedGender = "Female";
//     } else if (g == "other") {
//       _selectedGender = "Other";
//     } else {
//       _selectedGender = null; // agar match na ho
//     }
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _educationController.dispose();
//     super.dispose();
//   }
//
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final provider = Provider.of<ProfileProvider>(context, listen: false);
//
//       bool success = await provider.updateProfile({
//         "fullName": _nameController.text.trim(),
//         "email": _emailController.text.trim(),
//         "gender": _selectedGender,
//         "education": _educationController.text.trim(),
//       });
//
//       if (success) {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Profile updated successfully ✅")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Failed to update profile ❌")),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ✅ Small drag handle
//               Container(
//                 width: 40,
//                 height: 5,
//                 margin: const EdgeInsets.only(bottom: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//
//               Text(
//                 "Update Profile",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: "Full Name",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter full name" : null,
//               ),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter email" : null,
//               ),
//               const SizedBox(height: 12),
//
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ["Male", "Female", "Other"]
//                     .map((g) =>
//                     DropdownMenuItem(value: g, child: Text(g)))
//                     .toList(),
//                 onChanged: (val) => setState(() => _selectedGender = val),
//                 decoration: const InputDecoration(
//                   labelText: "Gender",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: _educationController,
//                 decoration: const InputDecoration(
//                   labelText: "Education",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                 v!.isEmpty ? "Enter education" : null,
//               ),
//               const SizedBox(height: 20),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _saveProfile,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue.shade300,
//                     padding:
//                     const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   child: const Text(
//                     "Save",
//                     style:
//                     TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// class UpdateProfileScreen extends StatefulWidget {
//   final String fullName;
//   final String email;
//   final String gender;
//   final String education;
//
//   const UpdateProfileScreen({
//     super.key,
//     required this.fullName,
//     required this.email,
//     required this.gender,
//     required this.education,
//   });
//
//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _educationController;
//   String? _selectedGender;
//
//   final List<String> genderOptions = ["Male", "Female", "Other"];
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.fullName);
//     _emailController = TextEditingController(text: widget.email);
//     _educationController = TextEditingController(text: widget.education);
//
//     // ✅ Match gender safely (case-insensitive)
//     _selectedGender = genderOptions.firstWhere(
//           (g) => g.toLowerCase() == widget.gender.toLowerCase(),
//       orElse: () => "Male", // default agar match na ho
//     );
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _educationController.dispose();
//     super.dispose();
//   }
//
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       final provider = Provider.of<ProfileProvider>(context, listen: false);
//
//       bool success = await provider.updateProfile({
//         "fullName": _nameController.text.trim(),
//         "email": _emailController.text.trim(),
//         "gender": _selectedGender,
//         "education": _educationController.text.trim(),
//       });
//
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Profile updated successfully ✅")),
//         );
//         Navigator.pop(context); // back to ProfileScreen
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Failed to update profile ❌")),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Update Profile"),
//         backgroundColor: Colors.blue,
//       ),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: "Full Name"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Enter full name" : null,
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: "Email"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Enter email" : null,
//               ),
//               const SizedBox(height: 12),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: genderOptions
//                     .map((gender) => DropdownMenuItem(
//                   value: gender,
//                   child: Text(gender),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() => _selectedGender = value);
//                 },
//                 decoration: const InputDecoration(labelText: "Gender"),
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _educationController,
//                 decoration: const InputDecoration(
//                     labelText: "Education Level"),
//                 validator: (value) =>
//                 value!.isEmpty ? "Enter education level" : null,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveProfile,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: const Text(
//                   "Save",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/ProfileProvider.dart';
//
// class UpdateProfileScreen extends StatefulWidget {
//   final String fullName;
//   final String email;
//   final String gender;
//   final String education;
//
//   const UpdateProfileScreen({
//     super.key,
//     required this.fullName,
//     required this.email,
//     required this.gender,
//     required this.education,
//   });
//
//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _genderController;
//   late TextEditingController _educationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.fullName);
//     _emailController = TextEditingController(text: widget.email);
//     _genderController = TextEditingController(text: widget.gender);
//     _educationController = TextEditingController(text: widget.education);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProfileProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Update Profile"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: "Full Name"),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: _genderController,
//               decoration: const InputDecoration(labelText: "Gender"),
//             ),
//             TextField(
//               controller: _educationController,
//               decoration: const InputDecoration(labelText: "Education"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final success = await provider.updateProfile(
//                   fullName: _nameController.text,
//                   email: _emailController.text,
//                   gender: _genderController.text,
//                   education: _educationController.text,
//                 );
//
//                 if (success) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Profile Updated Successfully")),
//                   );
//                   Navigator.pop(context); // back to ProfileScreen
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Update Failed")),
//                   );
//                 }
//               },
//               child: provider.isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text("Save"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
