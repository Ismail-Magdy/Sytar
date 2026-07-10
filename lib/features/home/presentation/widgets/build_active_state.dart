import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/features/home/data/models/home_dashboard_model.dart';
import 'package:sytar/features/home/presentation/components/gpa_summary_card.dart';
import 'package:sytar/features/home/presentation/components/home_greeting_widget.dart';
import 'package:sytar/features/home/presentation/components/upcoming_deadlines_list.dart';

class BuildActiveState extends StatelessWidget {
  const BuildActiveState({super.key, required this.data});
  final HomeDashboardModel data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: .all(20.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //
          HomeGreetingWidget(
            userName: data.userName,
            academicStatus: data.academicStatus,
          ),
          //
          verticalSpace(24),
          //
          GpaSummaryCard(currentGpa: data.currentGpa),
          //
          verticalSpace(24),
          //
          UpcomingDeadlinesList(tasks: data.upcomingTasks),
          //
          verticalSpace(24),
          //
          // TODO: Add SubjectsOverviewList here when ready
        ],
      ),
    );
  }
}
