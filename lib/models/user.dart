class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final bool isDriver;
  final String profilePictureUrl; // New field

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isDriver,
    required this.profilePictureUrl, // New field
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      isDriver: json['isDriver'] ?? false,
      profilePictureUrl: json['profilePictureUrl'] ?? '', // New field
    );
  }

  static UserModel empty() {
    return UserModel(
      uid: '',
      email: '',
      firstName: '',
      lastName: '',
      isDriver: false,
      profilePictureUrl: '', // New field
    );
  }
}
