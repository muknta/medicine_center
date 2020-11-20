class UserModel {
  final int id;
  String role;

  UserModel(this.id, this.role);

  factory UserModel.fromJson(Map json) {
    final id = json['id'];
    final role = json['role'];
    return UserModel(id, role);
  }
}
