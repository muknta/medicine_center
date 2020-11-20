class HospitalModel {
  HospitalModel({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
  });

  String id;
  String name;
  String address;
  String phoneNumber;

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone_number": phoneNumber,
      };
}
