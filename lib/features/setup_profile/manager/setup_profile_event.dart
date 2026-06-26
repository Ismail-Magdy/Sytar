import 'package:equatable/equatable.dart';

abstract class SetupProfileEvent extends Equatable {
  const SetupProfileEvent();

  @override
  List<Object> get props => [];
}

class SaveProfileDataRequested extends SetupProfileEvent {
  final String university;
  final String faculty;
  final String department;
  final String currentLevel;
  final String currentSemester;
  final double totalHours;
  final double completedHours;
  final double currentGpa;
  final double gpaScale;

  const SaveProfileDataRequested({
    required this.university,
    required this.faculty,
    required this.department,
    required this.currentLevel,
    required this.currentSemester,
    required this.totalHours,
    required this.completedHours,
    required this.currentGpa,
    required this.gpaScale,
  });

  @override
  List<Object> get props => [
    university,
    faculty,
    department,
    currentLevel,
    currentSemester,
    totalHours,
    completedHours,
    currentGpa,
    gpaScale,
  ];
}
