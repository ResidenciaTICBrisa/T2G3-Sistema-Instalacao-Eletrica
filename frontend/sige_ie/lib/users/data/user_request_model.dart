class UserRequestModel {
  String username;
  String name;
  String password;
  String email;

  UserRequestModel(
      {required this.username,
      required this.name,
      required this.password,
      required this.email});

  Map<String, dynamic> toJson() {
    return {
      'username': name,
      'name': name,
      'password': password,
      'email': email,
    };
  }
}
