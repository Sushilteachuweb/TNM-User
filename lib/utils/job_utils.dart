import 'package:flutter/material.dart';

class JobUtils {
  /// Format date to human readable format
  static String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;
      
      if (difference == 0) return "Today";
      if (difference == 1) return "Yesterday";
      if (difference < 7) return "$difference days ago";
      if (difference < 30) return "${(difference / 7).floor()} weeks ago";
      return "${(difference / 30).floor()} months ago";
    } catch (e) {
      return dateStr;
    }
  }

  /// Format salary range
  static String formatSalary(int minSalary, int maxSalary, String salaryType) {
    if (minSalary <= 0 && maxSalary <= 0) return "Negotiable";
    
    String range = "";
    if (minSalary > 0 && maxSalary > 0) {
      range = "₹${_formatNumber(minSalary)} - ₹${_formatNumber(maxSalary)}";
    } else if (minSalary > 0) {
      range = "₹${_formatNumber(minSalary)}+";
    } else if (maxSalary > 0) {
      range = "Up to ₹${_formatNumber(maxSalary)}";
    }
    
    if (salaryType.isNotEmpty) {
      range += " / ${salaryType.toLowerCase()}";
    } else {
      range += " / month";
    }
    
    return range;
  }

  /// Format numbers with K, L notation
  static String _formatNumber(int number) {
    if (number >= 10000000) {
      return "${(number / 10000000).toStringAsFixed(1)}Cr";
    } else if (number >= 100000) {
      return "${(number / 100000).toStringAsFixed(1)}L";
    } else if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return number.toString();
  }

  /// Get job type color
  static Color getJobTypeColor(String jobType) {
    switch (jobType.toLowerCase()) {
      case 'full time':
      case 'full-time':
        return Colors.green;
      case 'part time':
      case 'part-time':
        return Colors.orange;
      case 'contract':
        return Colors.blue;
      case 'internship':
        return Colors.purple;
      case 'freelance':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  /// Get experience level color
  static Color getExperienceColor(String experience) {
    final exp = experience.toLowerCase();
    if (exp.contains('fresher') || exp.contains('0') || exp.contains('entry')) {
      return Colors.green;
    } else if (exp.contains('1') || exp.contains('2') || exp.contains('junior')) {
      return Colors.blue;
    } else if (exp.contains('senior') || exp.contains('lead')) {
      return Colors.orange;
    }
    return Colors.grey;
  }

  /// Validate if field has meaningful content
  static bool hasContent(String? value) {
    if (value == null || value.isEmpty) return false;
    final cleaned = value.toLowerCase().trim();
    return cleaned != "not specified" && 
           cleaned != "n/a" && 
           cleaned != "null" && 
           cleaned != "undefined";
  }

  /// Get urgency indicator
  static bool isUrgent(String jobType, String description, String title) {
    final text = "$jobType $description $title".toLowerCase();
    return text.contains('urgent') || 
           text.contains('immediate') || 
           text.contains('asap') ||
           text.contains('hiring now');
  }
}