import 'package:flutter/material.dart';

class PhotoBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Upload Photo",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  // Camera ka function yaha call karna hoga
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.blue),
                title: const Text("Select Photo"),
                onTap: () {
                  Navigator.pop(context);
                  // Gallery ka function yaha call karna hoga
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
