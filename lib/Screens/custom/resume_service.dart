import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet_helper.dart';

class ResumeService {
  static Future<String?> pickResume(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.single;
        final fileName = file.name;
        final filePath = file.path;
        BottomSheetHelper.show(
          context: context,
          title: "Resume Uploaded",
          content: "Selected file: $fileName",
        );
        return filePath;
      } else {
        BottomSheetHelper.show(
          context: context,
          title: "No File Selected",
          content: "Please select a PDF file.",
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
