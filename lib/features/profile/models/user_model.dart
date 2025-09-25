class UserModel {
  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    // required this.confirmPassword,
    required this.category,
  });

  final String fullName;
  final String email;
  final String password;
  // final String confirmPassword;
  final String category; //todo: modify this to an enum

  Map<String, String> toJson() {
    return {
      "full_name": fullName,
      "email": email,
      "password": password,
      // "confirm_password": user.confirmPassword,
      "favourite_category": category,
    };
  }
}

class ProfileResponse {
  ProfileResponse({required this.id});
  final int id;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(id: json["id"]);
  }
}
