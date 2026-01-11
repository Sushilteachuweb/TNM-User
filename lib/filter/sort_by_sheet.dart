import 'package:flutter/material.dart';

class SortBySheet extends StatelessWidget {
  const SortBySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final options = ["Newest First", "Oldest First", "Highest Salary", "Lowest Salary"];

    return Container(
      padding: const EdgeInsets.all(16),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Sort By", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          ... options.map((option) => ListTile(
            title: Text(option),
            onTap: () {
              Navigator.pop(context, option);
            },
          )),
        ],
      ),
    );
  }
}
