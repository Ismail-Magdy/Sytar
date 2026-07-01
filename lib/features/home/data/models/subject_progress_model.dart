class SubjectProgressModel {
  final String id;
  final String name;
  final double progressPercentage;

  SubjectProgressModel({
    required this.id,
    required this.name,
    required this.progressPercentage,
  });

  factory SubjectProgressModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return SubjectProgressModel(
      id: documentId,
      name: json["name"] ?? "",
      progressPercentage: (json["progress_percentage"] ?? 0.0).toDouble(),
    );
  }
}
