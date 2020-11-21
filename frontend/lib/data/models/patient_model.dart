import 'package:intl/intl.dart';

class PatientModel {
  PatientModel({
    this.id,
    this.userId,
    this.email,
    this.conditions,
    this.role,
    this.name,
    this.surname,
    this.patronymic,
    this.phoneNumber,
    this.gender,
    this.profession,
    this.address,
    this.birthday,
  });

  String id;
  String userId;
  String conditions;
  String email;
  String role;
  String name;
  String surname;
  String patronymic;
  String phoneNumber;
  String gender;
  String profession;
  String address;
  DateTime birthday;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["_id"],
        userId: json["user_id"],
        conditions: json["conditions"],
        email: json["email"],
        role: json["role"],
        name: json["name"],
        surname: json["surname"],
        patronymic: json["patronymic"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        profession: json["profession"],
        address: json["address"],
        birthday: DateFormat("yyyy-MM-dd").parse(json["birthday"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "conditions": conditions,
        "email": email,
        "role": role,
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "phone_number": phoneNumber,
        "gender": gender,
        "profession": profession,
        "address": address,
        "birthday": birthday.toIso8601String(),
      };
}
