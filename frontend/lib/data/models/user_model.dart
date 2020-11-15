class UserModel {
  final int id;
  final String name;
  final String surname;

  UserModel(this.id, [this.name, this.surname]);

  factory UserModel.fromJson(Map json) {
    final id = json['id'];
    return UserModel(id);
  }
}
