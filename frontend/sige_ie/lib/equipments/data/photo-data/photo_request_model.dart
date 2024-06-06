class PhotoRequestModel {
  String photo;
  String description;

  PhotoRequestModel({
    required this.photo,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'photo': photo,
      'description': description,
    };
  }
}
