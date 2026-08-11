import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/features/home/data/models/upcoming_task_model.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/tasks/data/repos/task_repo.dart';
import 'package:sytar/features/tasks/manager/add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final TaskRepo _taskRepo;
  List<SubjectModel> subjects = [];

  AddTaskCubit(this._taskRepo) : super(AddTaskInitial());

  Future<void> getSubjects() async {
    emit(AddTaskSubjectsLoading());
    try {
      subjects = await _taskRepo.getSubjects();
      emit(AddTaskSubjectsLoaded(subjects));
    } catch (e) {
      emit(AddTaskSubjectsError(e.toString()));
    }
  }

  Future<void> addTask({
    required String title,
    required String subjectName,
    required DateTime deadline,
    required String priority,
  }) async {
    emit(AddTaskLoading());
    try {
      final task = UpcomingTaskModel(
        id: '',
        title: title,
        subjectName: subjectName,
        deadline: deadline,
        priority: priority,
        status: 'pending',
      );
      await _taskRepo.addTask(task);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskError(e.toString()));
    }
  }
}
