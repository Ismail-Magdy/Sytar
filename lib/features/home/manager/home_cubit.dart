import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> getDashboardData() async {
    emit(HomeLoading());
    try {
      final dashboardData = await _homeRepo.getHomeDashboardData();
      emit(HomeSuccess(dashboardData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
