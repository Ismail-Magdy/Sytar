import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  String? _currentSelectedLevel;
  String? _currentSelectedSemester;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> getDashboardData() async {
    emit(HomeLoading());
    try {
      final dashboardData = await _homeRepo.getHomeDashboardData(
        selectedLevel: _currentSelectedLevel,
        selectedSemester: _currentSelectedSemester,
      );

      _currentSelectedLevel = dashboardData.currentLevel;
      _currentSelectedSemester = dashboardData.currentSemester;

      emit(HomeSuccess(dashboardData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void changeLevel(String newLevel) {
    if (_currentSelectedLevel != newLevel) {
      _currentSelectedLevel = newLevel;
      getDashboardData();
    }
  }

  void changeSemester(String newSemester) {
    if (_currentSelectedSemester != newSemester) {
      _currentSelectedSemester = newSemester;
      getDashboardData();
    }
  }
}
