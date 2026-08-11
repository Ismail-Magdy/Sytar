import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/subject_model.dart';

class SubjectRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SubjectRepo(this._firestore, this._auth);

  ///
  Future<void> addSubject({
    required String subjectName,
    required String colorCode,
    required int creditHours,
    String? subjectCode,
    String? instructorName,
    String? targetGrade,
    int? totalMarks,
  }) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data() ?? {};

      final String currentLevel = userData['currentLevel'] ?? "المستوى الأول";
      final String currentSemester =
          userData['currentSemester'] ?? "الترم الأول";

      final subject = SubjectModel(
        id: "",
        subjectName: subjectName,
        level: currentLevel,
        semester: currentSemester,
        colorCode: colorCode,
        // القيم الجديدة
        creditHours: creditHours,
        subjectCode: subjectCode,
        instructorName: instructorName,
        targetGrade: targetGrade,
        totalMarks: totalMarks,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('subjects')
          .add(subject.toJson());
    } catch (e) {
      throw Exception("Failed to add subject: $e");
    }
  }

  ///
  Future<List<SubjectModel>> getSubjectsForCurrentSemester() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      //
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data() ?? {};

      final String currentLevel = userData['currentLevel'] ?? "المستوى الأول";
      final String currentSemester =
          userData['currentSemester'] ?? "الترم الأول";

      //
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('subjects')
          .where('level', isEqualTo: currentLevel)
          .where('semester', isEqualTo: currentSemester)
          .get();

      return snapshot.docs
          .map((doc) => SubjectModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch subjects: $e");
    }
  }
}
