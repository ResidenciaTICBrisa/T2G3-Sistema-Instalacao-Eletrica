class UsernameRequestModel {
  String username;

  UsernameRequestModel({required this.username});

  Map<String, dynamic> toJson() {
    return {'username': username};
  }
}
