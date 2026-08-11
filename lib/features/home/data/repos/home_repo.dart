import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/home_dashboard_model.dart';
import '../models/upcoming_task_model.dart';
import '../models/subject_progress_model.dart';

class HomeRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  HomeRepo(this._firestore, this._auth);

  Future<HomeDashboardModel> getHomeDashboardData({
    String? selectedLevel,
    String? selectedSemester,
  }) async {
    try {
      final String userId = _auth.currentUser!.uid;

      final userDoc = await _firestore.collection("users").doc(userId).get();
      final userData = userDoc.data() ?? {};

      String levelToFetch =
          selectedLevel ?? userData["currentLevel"] ?? "المستوى الأول";
      String semesterToFetch =
          selectedSemester ?? userData["currentSemester"] ?? "الترم الأول";

      List<String> availableLevels = List<String>.from(
        userData["availableLevels"] ?? [levelToFetch],
      );
      List<String> availableSemesters = List<String>.from(
        userData['availableSemesters'] ?? [semesterToFetch],
      );

      //
      List<UpcomingTaskModel> tasks = [];
      try {
        final tasksSnapshot = await _firestore
            .collection("users")
            .doc(userId)
            .collection("tasks")
            .where("level", isEqualTo: levelToFetch)
            .where("semester", isEqualTo: semesterToFetch)
            .where("status", isNotEqualTo: "completed")
            .orderBy('status')
            .orderBy('deadline')
            .limit(5)
            .get();

        tasks = tasksSnapshot.docs
            .map((doc) => UpcomingTaskModel.fromJson(doc.data(), doc.id))
            .toList();
      } catch (e) {}

      //
      final subjectsSnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("subjects")
          .where("level", isEqualTo: levelToFetch)
          .where("semester", isEqualTo: semesterToFetch)
          .get();

      List<SubjectProgressModel> subjects = subjectsSnapshot.docs
          .map((doc) => SubjectProgressModel.fromJson(doc.data(), doc.id))
          .toList();

      return HomeDashboardModel(
        userName: userData["name"] ?? "يا بطل",
        academicStatus: _calculateAcademicStatus(tasks),
        currentGpa: (userData["currentGpa"] ?? 0.0).toDouble(),
        currentLevel: levelToFetch,
        currentSemester: semesterToFetch,
        availableLevels: availableLevels,
        availableSemesters: availableSemesters,
        upcomingTasks: tasks,
        subjectsProgress: subjects,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String _calculateAcademicStatus(List<UpcomingTaskModel> tasks) {
    if (tasks.isEmpty) return "بداية ترم جديدة، جاهز تسيطر؟";
    if (tasks.length > 3) return "عندك ضغط تسليمات الأسبوع ده، ركز";
    return "أداؤك مستقر، استمر يا بطل";
  }
}
