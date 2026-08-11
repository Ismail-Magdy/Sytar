class SubjectModel {
  final String id;
  final String subjectName;
  final String level;
  final String semester;
  final String colorCode;

  SubjectModel({
    required this.id,
    required this.subjectName,
    required this.level,
    required this.semester,
    required this.colorCode,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json, String documentId) {
    return SubjectModel(
      id: documentId,
      subjectName: json["subject_name"] ?? '',
      level: json['level'] ?? '',
      semester: json['semester'] ?? '',
      colorCode: json['color_code'] ?? '0xFF002045',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_name': subjectName,
      'level': level,
      'semester': semester,
      'color_code': colorCode,
    };
  }
}
