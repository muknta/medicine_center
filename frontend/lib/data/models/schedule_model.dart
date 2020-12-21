class ScheduleModel {
  ScheduleModel({
    this.id,
    this.doctorId,
    this.weekDay,
    this.startTime,
    this.finishTime,
    this.hospital,
    this.room,
  });

  String id;
  String doctorId;
  String weekDay;
  DateTime startTime;
  DateTime finishTime;
  dynamic hospital;
  int room;

  factory ScheduleModel.fromJson(json) {
    print('in from json');
    final id = json["_id"];
    final doctorId = json["doctor_id"];
    final weekDay = json["weekDay"];
    final room = int.tryParse(json["room"]);
    print('$id, $doctorId, $weekDay $room');
    return ScheduleModel(
        id: id,
        doctorId: doctorId,
        weekDay: weekDay,
        startTime: DateTime.parse(json["startTime"]),
        finishTime: DateTime.parse(json["finishTime"]),
        hospital: json["hospital"],
        room: room);
  }

  // Map<String, dynamic> toJson() => {
  //       "_id": id,
  //       "doctor_id": doctorId,
  //       "weekDay": weekDay,
  //       "startTime": startTime.toIso8601String(),
  //       "finishTime": finishTime.toIso8601String(),
  //       "hospital": hospital,
  //       "room": room,
  //     };
}
