class UserModel {
  final String firstName;
  final String imageUrl;
  final int age;
  final String city;

  UserModel({
    required this.firstName,
    required this.imageUrl,
    required this.age,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['name']['first'] ?? '',
      imageUrl: json['picture']['large'] ?? '',
      age: json['dob']['age'] ?? 0,
      city: json['location']['city'] ?? '',
    );
  }
}

