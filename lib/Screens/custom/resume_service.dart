import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ProfileProvider.dart';
import 'bottom_sheet_helper.dart';

class ResumeService {
  static Future<String?> pickAndUploadResume(BuildContext context) async {
    try {
      // Step 1: Pick the resume file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      
      if (result != null && result.files.isNotEmpty && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final fileName = result.files.single.name;
        
        // Check file size before upload
        final fileSize = file.lengthSync() / (1024 * 1024);
        if (fileSize > 5) {
          BottomSheetHelper.show(
            context: context,
            title: "File Too Large",
            content: "Resume file is ${fileSize.toStringAsFixed(1)}MB. Maximum allowed size is 5MB.",
          );
          return null;
        }
        
        // Step 2: Upload to API
        final provider = Provider.of<ProfileProvider>(context, listen: false);
        
        // Show loading indicator
        BottomSheetHelper.show(
          context: context,
          title: "Uploading Resume",
          content: "Please wait while we upload your resume...",
        );
        
        try {
          bool success = await provider.uploadResume(file);
          
          // Close loading dialog
          if (context.mounted) Navigator.pop(context);
          
          if (success) {
            BottomSheetHelper.show(
              context: context,
              title: "Resume Uploaded Successfully",
              content: "Your resume '$fileName' has been uploaded successfully!",
            );
            return file.path;
          } else {
            BottomSheetHelper.show(
              context: context,
              title: "Upload Failed",
              content: "Failed to upload resume. Please try again.",
            );
            return null;
          }
        } catch (e) {
          // Close loading dialog
          if (context.mounted) Navigator.pop(context);
          
          BottomSheetHelper.show(
            context: context,
            title: "Upload Error",
            content: e.toString().replaceAll('Exception: ', ''),
          );
          return null;
        }
      } else {
        BottomSheetHelper.show(
          context: context,
          title: "No File Selected",
          content: "Please select a PDF, DOC, or DOCX file.",
        );
        return null;
      }
    } catch (e) {
      BottomSheetHelper.show(
        context: context,
        title: "Error",
        content: "Something went wrong: $e",
      );
      return null;
    }
  }

  // Keep the old method for backward compatibility (deprecated)
  @deprecated
  static Future<String?> pickResume(BuildContext context) async {
    return pickAndUploadResume(context);
  }
}








// import 'package:file_picker/file_picker.dart';
//
// import 'package:flutter/material.dart';
//
// import 'bottom_sheet_helper.dart';
//
// class ResumeService {
//   static Future<String?> pickResume(BuildContext context) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//
//     if (result != null && result.files.isNotEmpty) {
//       final fileName = result.files.single.name;
//       BottomSheetHelper.show(
//         context: context,
//         title: "Resume Uploaded",
//         content: "Selected file: $fileName",
//       );
//       return fileName;
//     }
//     return null;
//   }
// }
