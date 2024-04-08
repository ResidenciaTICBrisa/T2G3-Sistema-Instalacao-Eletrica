class UserModel {
  String id;
  String username;
  String firstname;
  String email;

  UserModel(
      {required this.id, required this.username, required this.firstname, required this.email});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        username = json['username'].toString(),
        firstname = json['first_name'].toString(),
        email = json['email'].toString();
}
