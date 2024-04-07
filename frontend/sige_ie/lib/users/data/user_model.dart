class UserModel {
  String username;
  String firstname;
  String email;

  UserModel(
      {required this.username, required this.firstname, required this.email});

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'].toString(),
        firstname = json['first_name'].toString(),
        email = json['email'].toString();
}
