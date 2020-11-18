class PatientModel {
  PatientModel({
    this.id,
    this.userId,
    this.profession,
    this.conditions,
    this.email,
    this.role,
    this.name,
    this.surname,
    this.phoneNumber,
    this.patronymic,
    this.gender,
    this.birthday,
  });

  String id;
  String userId;
  String profession;
  String conditions;
  String email;
  String role;
  String name;
  String surname;
  String phoneNumber;
  String patronymic;
  String gender;
  DateTime birthday;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["_id"],
        userId: json["user_id"],
        profession: json["profession"],
        conditions: json["conditions"],
        email: json["email"],
        role: json["role"],
        name: json["name"],
        surname: json["surname"],
        phoneNumber: json["phone_number"],
        patronymic: json["patronymic"],
        gender: json["gender"],
        // birthday: DateTime.parse(json["birthday"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "profession": profession,
        "conditions": conditions,
        "email": email,
        "role": role,
        "name": name,
        "surname": surname,
        "phone_number": phoneNumber,
        "patronymic": patronymic,
        "gender": gender,
        "birthday": birthday.toIso8601String(),
      };
}
