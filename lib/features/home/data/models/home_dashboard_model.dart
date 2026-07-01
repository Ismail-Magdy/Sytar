import 'upcoming_task_model.dart';
import 'subject_progress_model.dart';

class HomeDashboardModel {
  final String userName;
  final String academicStatus;
  final double currentGpa;
  final List<UpcomingTaskModel> upcomingTasks;
  final List<SubjectProgressModel> subjectsProgress;

  HomeDashboardModel({
    required this.userName,
    required this.academicStatus,
    required this.currentGpa,
    required this.upcomingTasks,
    required this.subjectsProgress,
  });
}
