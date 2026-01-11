class UserModel {
  final int id;
  final String title;
  final double price;
  final String image;

  UserModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
