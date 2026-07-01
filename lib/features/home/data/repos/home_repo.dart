import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/home_dashboard_model.dart';
import '../models/upcoming_task_model.dart';
import '../models/subject_progress_model.dart';

class HomeRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  HomeRepo(this._firestore, this._auth);

  Future<HomeDashboardModel> getHomeDashboardData() async {
    try {
      final String userId = _auth.currentUser!.uid;

      //
      final userDoc = await _firestore.collection("users").doc(userId).get();
      final userData = userDoc.data() ?? {};

      //
      final tasksSnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("tasks")
          .where("status", isNotEqualTo: "completed")
          .orderBy("deadline")
          .limit(5)
          .get();

      List<UpcomingTaskModel> tasks = tasksSnapshot.docs
          .map((doc) => UpcomingTaskModel.fromJson(doc.data(), doc.id))
          .toList();

      //
      final subjectsSnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("subjects")
          .get();

      List<SubjectProgressModel> subjects = subjectsSnapshot.docs
          .map((doc) => SubjectProgressModel.fromJson(doc.data(), doc.id))
          .toList();

      //
      return HomeDashboardModel(
        userName: userData["name"] ?? "يا بطل",
        academicStatus: _calculateAcademicStatus(tasks),
        currentGpa: (userData["current_gpa"] ?? 0.0).toDouble(),
        upcomingTasks: tasks,
        subjectsProgress: subjects,
      );
    } catch (e) {
      //
      throw Exception(e.toString());
    }
  }

  //
  String _calculateAcademicStatus(List<UpcomingTaskModel> tasks) {
    if (tasks.isEmpty) return "بداية ترم جديدة، جاهز تسيطر؟";
    if (tasks.length > 3) return "عندك ضغط تسليمات الأسبوع ده، ركز";
    return "أداؤك مستقر، استمر يا بطل";
  }
}
