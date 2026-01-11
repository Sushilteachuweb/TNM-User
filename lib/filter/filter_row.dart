import 'package:flutter/material.dart';
import 'select_city_sheet.dart';
import 'sort_by_sheet.dart';
import 'type_sheet.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildFilterButton(context, "Filter", Icons.filter_list, () {
            // Optional: global filter screen
          }),
          const SizedBox(width: 8),
          _buildFilterButton(context, "Select city", Icons.location_city, () {
            showModalBottomSheet(
              context: context,
              builder: (_) => const SelectCitySheet(),
            );
          }),
          const SizedBox(width: 8),
          _buildFilterButton(context, "Sort by", Icons.sort, () {
            showModalBottomSheet(
              context: context,
              builder: (_) => const SortBySheet(),
            );
          }),
          const SizedBox(width: 12),
          _buildFilterButton(context, "Type Jobs", Icons.work, () {
            showModalBottomSheet(
              context: context,
              builder: (_) => const TypeSheet(),
            );
          }),
        ],
      ),
    );
  }
  Widget _buildFilterButton(
      BuildContext context,
      String text,
      IconData icon,
      VoidCallback onTap,
      ) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
