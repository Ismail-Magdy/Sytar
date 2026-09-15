import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  final String id;
  final String subjectName;
  final String level;
  final String semester;
  final String colorCode;
  final int creditHours;
  final int totalMarks;
  final String? subjectCode;
  final String? instructorName;
  final String? targetGrade;
  final String? notes;
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
  final DateTime? midterm1Date;
  final DateTime? midterm2Date;
  final DateTime? courseworkDate;
  final DateTime? finalDate;
  final String? finalCalculatedGrade;
  final bool isGradeOverridden;

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
    this.midterm1Date,
    this.midterm2Date,
    this.courseworkDate,
    this.finalDate,
    this.finalCalculatedGrade,
    this.isGradeOverridden = false,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json, String documentId) {
    return SubjectModel(
      id: documentId,
      subjectName: json["subject_name"] ?? "",
      level: json["level"] ?? "",
      semester: json["semester"] ?? "",
      colorCode: json["color_code"] ?? "0xFF002045",
      creditHours: json["credit_hours"] ?? 3,
      totalMarks: json["total_marks"] ?? 100,
      subjectCode: json["subject_code"],
      instructorName: json["instructor_name"],
      targetGrade: json["target_grade"],
      notes: json["notes"],
      isBreakdownKnown: json["is_breakdown_known"] ?? true,
      finalExamTotal: json["final_exam_total"] ?? 0,
      midterm1Total: json["midterm1_total"],
      midterm2Total: json["midterm2_total"],
      courseworkTotal: json["coursework_total"],
      obtainedFinal: json["obtained_final"],
      obtainedMidterm1: json["obtained_midterm1"],
      obtainedMidterm2: json["obtained_midterm2"],
      obtainedCoursework: json["obtained_coursework"],
      midtermMonth: json["midterm_month"],
      exactMidtermDate: json["exact_midterm_date"] != null
          ? (json["exact_midterm_date"] as Timestamp).toDate()
          : null,
      midterm1Date: json["midterm1_date"] != null
          ? (json["midterm1_date"] as Timestamp).toDate()
          : null,
      midterm2Date: json["midterm2_date"] != null
          ? (json["midterm2_date"] as Timestamp).toDate()
          : null,
      courseworkDate: json["coursework_date"] != null
          ? (json["coursework_date"] as Timestamp).toDate()
          : null,
      finalDate: json["final_date"] != null
          ? (json["final_date"] as Timestamp).toDate()
          : null,
      finalCalculatedGrade: json["final_calculated_grade"],
      isGradeOverridden: json["is_grade_overridden"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subject_name": subjectName,
      "level": level,
      "semester": semester,
      "color_code": colorCode,
      "credit_hours": creditHours,
      "total_marks": totalMarks,
      "subject_code": subjectCode,
      "instructor_name": instructorName,
      "target_grade": targetGrade,
      "notes": notes,
      "is_breakdown_known": isBreakdownKnown,
      "final_exam_total": finalExamTotal,
      "midterm1_total": midterm1Total,
      "midterm2_total": midterm2Total,
      "coursework_total": courseworkTotal,
      "obtained_final": obtainedFinal,
      "obtained_midterm1": obtainedMidterm1,
      "obtained_midterm2": obtainedMidterm2,
      "obtained_coursework": obtainedCoursework,
      "midterm_month": midtermMonth,
      "exact_midterm_date": exactMidtermDate,
      "midterm1_date": midterm1Date,
      "midterm2_date": midterm2Date,
      "coursework_date": courseworkDate,
      "final_date": finalDate,
      "final_calculated_grade": finalCalculatedGrade,
      "is_grade_overridden": isGradeOverridden,
    };
  }

  SubjectModel copyWith({
    String? subjectName,
    String? level,
    String? semester,
    String? colorCode,
    int? creditHours,
    int? totalMarks,
    String? subjectCode,
    String? instructorName,
    String? targetGrade,
    String? notes,
    bool? isBreakdownKnown,
    int? finalExamTotal,
    int? midterm1Total,
    int? midterm2Total,
    int? courseworkTotal,
    int? obtainedFinal,
    int? obtainedMidterm1,
    int? obtainedMidterm2,
    int? obtainedCoursework,
    int? midtermMonth,
    DateTime? exactMidtermDate,
    DateTime? midterm1Date,
    DateTime? midterm2Date,
    DateTime? courseworkDate,
    DateTime? finalDate,
    String? finalCalculatedGrade,
    bool? isGradeOverridden,
  }) {
    return SubjectModel(
      id: id,
      subjectName: subjectName ?? this.subjectName,
      level: level ?? this.level,
      semester: semester ?? this.semester,
      colorCode: colorCode ?? this.colorCode,
      creditHours: creditHours ?? this.creditHours,
      totalMarks: totalMarks ?? this.totalMarks,
      subjectCode: subjectCode ?? this.subjectCode,
      instructorName: instructorName ?? this.instructorName,
      targetGrade: targetGrade ?? this.targetGrade,
      notes: notes ?? this.notes,
      isBreakdownKnown: isBreakdownKnown ?? this.isBreakdownKnown,
      finalExamTotal: finalExamTotal ?? this.finalExamTotal,
      midterm1Total: midterm1Total ?? this.midterm1Total,
      midterm2Total: midterm2Total ?? this.midterm2Total,
      courseworkTotal: courseworkTotal ?? this.courseworkTotal,
      obtainedFinal: obtainedFinal ?? this.obtainedFinal,
      obtainedMidterm1: obtainedMidterm1 ?? this.obtainedMidterm1,
      obtainedMidterm2: obtainedMidterm2 ?? this.obtainedMidterm2,
      obtainedCoursework: obtainedCoursework ?? this.obtainedCoursework,
      midtermMonth: midtermMonth ?? this.midtermMonth,
      exactMidtermDate: exactMidtermDate ?? this.exactMidtermDate,
      midterm1Date: midterm1Date ?? this.midterm1Date,
      midterm2Date: midterm2Date ?? this.midterm2Date,
      courseworkDate: courseworkDate ?? this.courseworkDate,
      finalDate: finalDate ?? this.finalDate,
      finalCalculatedGrade: finalCalculatedGrade ?? this.finalCalculatedGrade,
      isGradeOverridden: isGradeOverridden ?? this.isGradeOverridden,
    );
  }
}
