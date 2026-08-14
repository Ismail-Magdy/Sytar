import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  final String id;
  final String subjectName;
  final String level;
  final String semester;
  final String colorCode;
  final int creditHours;

  // الدرجة النهائية إجبارية
  final int totalMarks;

  final String? subjectCode;
  final String? instructorName;
  final String? targetGrade;
  final String? notes;

  // التفاعلية وغموض الدكاترة
  final bool isBreakdownKnown;
  final int finalExamTotal;

  final int? midterm1Total;
  final int? midterm2Total;
  final int? courseworkTotal;

  final int? obtainedFinal;
  final int? obtainedMidterm1;
  final int? obtainedMidterm2;
  final int? obtainedCoursework;

  final int? midtermMonth;
  final DateTime? exactMidtermDate;

  SubjectModel({
    required this.id,
    required this.subjectName,
    required this.level,
    required this.semester,
    required this.colorCode,
    required this.creditHours,
    required this.totalMarks,
    this.subjectCode,
    this.instructorName,
    this.targetGrade,
    this.notes,
    this.isBreakdownKnown = true,
    this.finalExamTotal = 0,
    this.midterm1Total,
    this.midterm2Total,
    this.courseworkTotal,
    this.obtainedFinal,
    this.obtainedMidterm1,
    this.obtainedMidterm2,
    this.obtainedCoursework,
    this.midtermMonth,
    this.exactMidtermDate,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json, String documentId) {
    return SubjectModel(
      id: documentId,
      subjectName: json["subject_name"] ?? '',
      level: json['level'] ?? '',
      semester: json['semester'] ?? '',
      colorCode: json['color_code'] ?? '0xFF002045',
      creditHours: json['credit_hours'] ?? 3,
      totalMarks:
          json['total_marks'] ??
          100, // أديناها قيمة افتراضية عشان لو في داتا قديمة
      subjectCode: json['subject_code'],
      instructorName: json['instructor_name'],
      targetGrade: json['target_grade'],
      notes: json['notes'],

      // قراءة الحقول الجديدة
      isBreakdownKnown: json['is_breakdown_known'] ?? true,
      finalExamTotal: json['final_exam_total'] ?? 0,
      midterm1Total: json['midterm1_total'],
      midterm2Total: json['midterm2_total'],
      courseworkTotal: json['coursework_total'],
      obtainedFinal: json['obtained_final'],
      obtainedMidterm1: json['obtained_midterm1'],
      obtainedMidterm2: json['obtained_midterm2'],
      obtainedCoursework: json['obtained_coursework'],
      midtermMonth: json['midterm_month'],
      // تحويل التاريخ من Timestamp الخاص بفايربيز لـ DateTime
      exactMidtermDate: json['exact_midterm_date'] != null
          ? (json['exact_midterm_date'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_name': subjectName,
      'level': level,
      'semester': semester,
      'color_code': colorCode,
      'credit_hours': creditHours,
      'total_marks': totalMarks, // شيلنا الـ if لأنها إجبارية

      if (subjectCode != null && subjectCode!.isNotEmpty)
        'subject_code': subjectCode,
      if (instructorName != null && instructorName!.isNotEmpty)
        'instructor_name': instructorName,
      if (targetGrade != null) 'target_grade': targetGrade,

      // حفظ الحقول الجديدة
      if (notes != null && notes!.isNotEmpty) 'notes': notes,
      'is_breakdown_known': isBreakdownKnown,
      'final_exam_total': finalExamTotal,
      if (midterm1Total != null) 'midterm1_total': midterm1Total,
      if (midterm2Total != null) 'midterm2_total': midterm2Total,
      if (courseworkTotal != null) 'coursework_total': courseworkTotal,
      if (obtainedFinal != null) 'obtained_final': obtainedFinal,
      if (obtainedMidterm1 != null) 'obtained_midterm1': obtainedMidterm1,
      if (obtainedMidterm2 != null) 'obtained_midterm2': obtainedMidterm2,
      if (obtainedCoursework != null) 'obtained_coursework': obtainedCoursework,
      if (midtermMonth != null) 'midterm_month': midtermMonth,
      if (exactMidtermDate != null) 'exact_midterm_date': exactMidtermDate,
    };
  }
}
