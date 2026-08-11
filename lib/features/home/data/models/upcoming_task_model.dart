class UpcomingTaskModel {
  final String id;
  final String title;
  final String subjectName;
  final DateTime deadline;
  final String priority;
  final String status;

  UpcomingTaskModel({
    required this.id,
    required this.title,
    required this.subjectName,
    required this.deadline,
    required this.priority,
    required this.status,
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
      status: json["status"] ?? "pending",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "subject_name": subjectName,
      "deadline": deadline,
      "priority": priority,
      "status": status,
    };
  }
}
