class DoctorModel {
  DoctorModel({
    this.id,
    this.userId,
    this.hospitalId,
    this.rating,
    this.positing,
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
  String hospitalId;
  String rating;
  String positing;
  String email;
  String role;
  String name;
  String surname;
  String phoneNumber;
  String patronymic;
  String gender;
  DateTime birthday;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["_id"],
        userId: json["user_id"],
        hospitalId: json["hospital_id"],
        rating: json["rating"],
        positing: json["positing"],
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
        "hospital_id": hospitalId,
        "rating": rating,
        "positing": positing,
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
