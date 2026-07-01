import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/widgets/error_screen.dart"; // Adjust path
import "package:sytar/core/helpers/spacing.dart"; // Adjust path
import "package:sytar/features/home/data/models/home_dashboard_model.dart";
import "package:sytar/features/home/manager/home_cubit.dart";
import "package:sytar/features/home/manager/home_state.dart";

// Import all custom widgets
import "../widgets/home_empty_state.dart";
import "../widgets/home_greeting_widget.dart";
import "../widgets/gpa_summary_card.dart";
import "../widgets/upcoming_deadlines_list.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Floating action button for quick additions
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open bottom sheet to add task/subject
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return ErrorScreen(errorText: state.error);
            } else if (state is HomeSuccess) {
              final data = state.dashboardData;
              final bool isDataEmpty =
                  data.upcomingTasks.isEmpty && data.subjectsProgress.isEmpty;

              // Display empty state if no subjects or tasks
              if (isDataEmpty) {
                return HomeEmptyState(userName: data.userName);
              }
              // Display active dashboard
              else {
                return _buildActiveState(data);
              }
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildActiveState(HomeDashboardModel data) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeGreetingWidget(
            userName: data.userName,
            academicStatus: data.academicStatus,
          ),
          verticalSpace(24),
          GpaSummaryCard(currentGpa: data.currentGpa),
          verticalSpace(24),
          UpcomingDeadlinesList(tasks: data.upcomingTasks),
          verticalSpace(24),
          // TODO: Add SubjectsOverviewList here when ready
        ],
      ),
    );
  }
}
