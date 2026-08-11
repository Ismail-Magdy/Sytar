import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';

class SubjectRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SubjectRepo(this._firestore, this._auth);

  Future<void> addSubject(SubjectModel subject) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('subjects')
          .add(subject.toJson());
    } catch (e) {
      throw Exception("Failed to add subject: $e");
    }
  }

  //
  Future<List<SubjectModel>> getSubjectsForCurrentSemester(
    String level,
    String semester,
  ) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('subjects')
          .where('level', isEqualTo: level)
          .where('semester', isEqualTo: semester)
          .get();

      return snapshot.docs
          .map((doc) => SubjectModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch subjects: $e");
    }
  }
}
