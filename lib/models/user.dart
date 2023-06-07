class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final bool isDriver;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isDriver,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      isDriver: json['isDriver'] ?? false,
    );
  }
  static UserModel empty() {
    return UserModel(
      uid: '',
      email: '',
      firstName: '',
      lastName: '',
      isDriver: false,
    );
  }
}


