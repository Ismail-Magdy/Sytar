import '../data/models/home_dashboard_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeDashboardModel dashboardData;
  HomeSuccess(this.dashboardData);
}

class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}
