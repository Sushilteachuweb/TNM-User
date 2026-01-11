import 'package:flutter/material.dart';

class SelectCitySheet extends StatelessWidget {
  const SelectCitySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = ["Noida", "Delhi", "Gurgaon", "Mumbai", "Bangalore"];

    return Container(
      padding: const EdgeInsets.all(16),
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select City",
              style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cities[index]),
                  onTap: () {
                    Navigator.pop(context, cities[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
