class UserModel {
  final String uId;
  final String name;
  final String email;

  UserModel({required this.uId, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {"uId": uId, "name": name, "email": email};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json["uId"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }
}
