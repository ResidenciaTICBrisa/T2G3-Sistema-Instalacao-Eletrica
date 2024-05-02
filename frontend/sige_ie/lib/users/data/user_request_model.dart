class UserRequestModel {
  String username;
  String firstname;
  String password;
  String email;

  UserRequestModel(
      {required this.username,
      required this.firstname,
      required this.password,
      required this.email});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'first_name': firstname,
      'password': password,
      'email': email,
    };
  }
}
