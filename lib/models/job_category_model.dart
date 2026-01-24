class JobCategoryModel {
  final String id;
  final String image;
  final String jobCategory;
  final List<String> subcategories;

  JobCategoryModel({
    required this.id,
    required this.image,
    required this.jobCategory,
    required this.subcategories,
  });

  factory JobCategoryModel.fromJson(Map<String, dynamic> json) {
    return JobCategoryModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      jobCategory: json['jobCategory'] ?? '',
      subcategories: List<String>.from(json['subcategories'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'jobCategory': jobCategory,
      'subcategories': subcategories,
    };
  }
}