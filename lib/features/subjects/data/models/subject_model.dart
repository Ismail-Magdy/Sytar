class SubjectModel {
  final String id;
  final String subjectName;
  final String level;
  final String semester;
  final String colorCode;

  // الحقول الجديدة
  final int creditHours;
  final String? subjectCode;
  final String? instructorName;
  final String? targetGrade;
  final int? totalMarks;

  SubjectModel({
    required this.id,
    required this.subjectName,
    required this.level,
    required this.semester,
    required this.colorCode,
    required this.creditHours,
    this.subjectCode,
    this.instructorName,
    this.targetGrade,
    this.totalMarks,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json, String documentId) {
    return SubjectModel(
      id: documentId,
      subjectName: json["subject_name"] ?? '',
      level: json['level'] ?? '',
      semester: json['semester'] ?? '',
      colorCode: json['color_code'] ?? '0xFF002045',
      // قراءة الحقول الجديدة
      creditHours: json['credit_hours'] ?? 3, // 3 كقيمة افتراضية
      subjectCode: json['subject_code'],
      instructorName: json['instructor_name'],
      targetGrade: json['target_grade'],
      totalMarks: json['total_marks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_name': subjectName,
      'level': level,
      'semester': semester,
      'color_code': colorCode,
      // حفظ الحقول الجديدة
      'credit_hours': creditHours,
      if (subjectCode != null && subjectCode!.isNotEmpty)
        'subject_code': subjectCode,
      if (instructorName != null && instructorName!.isNotEmpty)
        'instructor_name': instructorName,
      if (targetGrade != null) 'target_grade': targetGrade,
      if (totalMarks != null) 'total_marks': totalMarks,
    };
  }
}
