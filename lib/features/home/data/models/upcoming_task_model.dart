class UpcomingTaskModel {
  final String id;
  final String title;
  final String subjectName;
  final DateTime deadline;
  final String priority;

  UpcomingTaskModel({
    required this.id,
    required this.title,
    required this.subjectName,
    required this.deadline,
    required this.priority,
  });

  factory UpcomingTaskModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return UpcomingTaskModel(
      id: documentId,
      title: json["title"] ?? "",
      subjectName: json["subject_name"] ?? "",
      deadline: json["deadline"].toDate(),
      priority: json["priority"] ?? "low",
    );
  }
}
