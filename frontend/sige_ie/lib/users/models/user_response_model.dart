class UserResponseModel {
  String id;
  String username;
  String firstname;
  String email;

  UserResponseModel(
      {required this.id,
      required this.username,
      required this.firstname,
      required this.email});

  UserResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        username = json['username'].toString(),
        firstname = json['first_name'].toString(),
        email = json['email'].toString();
}
