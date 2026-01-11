import 'package:flutter/material.dart';

class TypeSheet extends StatelessWidget {
  const TypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final types = ["Full-Time", "Part-Time", "Internship", "Remote"];

    return Container(
      padding: const EdgeInsets.all(16),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Job Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          ...types.map((type) => ListTile(
            title: Text(type),
            onTap: () {
              Navigator.pop(context, type);
            },
          )),
        ],
      ),
    );
  }
}
