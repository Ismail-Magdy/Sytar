import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sytar/features/home/data/models/upcoming_task_model.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';

class TaskRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  TaskRepo(this._firestore, this._auth);

  Future<void> addTask(UpcomingTaskModel task) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(task.toJson());
    } catch (e) {
      throw Exception("Failed to add task: $e");
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception("User not logged in");

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('subjects')
          .get();

      return snapshot.docs
          .map((doc) => SubjectModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch subjects: $e");
    }
  }
}
