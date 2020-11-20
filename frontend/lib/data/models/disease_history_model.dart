class DiseaseHistoryModel {
  DiseaseHistoryModel({
    this.id,
    this.authorId,
    this.patientId,
    this.title,
    this.dateUpdated,
    this.dateCreated,
    this.diagnosis,
    this.status,
    this.content,
    this.fileName,
  });

  String id;
  String authorId;
  String patientId;
  String title;
  DateTime dateUpdated;
  DateTime dateCreated;
  String diagnosis;
  String status;
  String content;
  String fileName;

  factory DiseaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      DiseaseHistoryModel(
        id: json["_id"],
        authorId: json["author_id"],
        patientId: json["patient_id"],
        title: json["title"],
        dateUpdated: DateTime.parse(json["date_updated"]),
        dateCreated: DateTime.parse(json["date_created"]),
        diagnosis: json["diagnosis"],
        status: json["status"],
        content: json["content"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author_id": authorId,
        "patient_id": patientId,
        "title": title,
        "date_updated": dateUpdated.toIso8601String(),
        "date_created": dateCreated.toIso8601String(),
        "diagnosis": diagnosis,
        "status": status,
        "content": content,
      };
}
