class PasswordRequestModel {
  String password;
  String confirmPassword;

  PasswordRequestModel({required this.password, required this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {'password': password, 'confirm_password': confirmPassword};
  }
}
