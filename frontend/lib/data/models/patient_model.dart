class PatientModel {
  final int id;
  final String email, password1, password2;
  final String name, surname, role;
  final String phone_number, patronymic, gender;
  final DateTime birthday;

  PatientModel(this.id, [this.email, this.password1, this.password2,
  	this.name, this.surname, this.role, this.phone_number,
  	this.patronymic, this.gender, this.birthday]);

  factory PatientModel.fromJson(Map json) {
    final id = json['id'];
    return PatientModel(id);
  }
}
