import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/home/data/models/home_dashboard_model.dart';
import 'package:sytar/features/home/data/models/upcoming_task_model.dart';
import 'package:sytar/features/home/presentation/components/home_focus_today_card.dart';
import 'package:sytar/features/home/presentation/components/home_gpa_summary_card.dart';
import 'package:sytar/features/home/presentation/components/home_today_task_item.dart';
import 'package:sytar/features/home/presentation/widgets/home_empty_state_message.dart';
import 'package:sytar/features/home/presentation/widgets/home_setup_progress_card.dart';

class HomeActiveState extends StatelessWidget {
  final HomeDashboardModel data;

  const HomeActiveState({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // If there are no subjects and no tasks, show the setup card
    final bool hasSubjects = data.subjectsProgress.isNotEmpty;
    final bool hasTasks = data.upcomingTasks.isNotEmpty;

    // Determine if we should show the setup card
    final bool showSetupCard = !hasSubjects || !hasTasks;

    // Determine the focus task title and button text
    final String focusTaskTitle = hasTasks
        ? data.upcomingTasks.first.title
        : "خطط لترمك وضيف أول مهامك";
    final String focusButtonText = hasTasks ? "إبدأ المذاكرة" : "إضافة تاسك";

    // Determine urgent tasks (tasks with deadlines within 48 hours)
    final DateTime now = DateTime.now();
    final List<UpcomingTaskModel> urgentTasks = data.upcomingTasks.where((
      task,
    ) {
      final difference = task.deadline.difference(now).inHours;
      return difference <= 48;
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 120.h),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //
          verticalSpace(20),
          // Gamification
          if (showSetupCard) ...[
            _buildSetupProgressCard(hasSubjects, hasTasks),
            //
            verticalSpace(24),
            //
          ],
          //
          // Focus Today Card
          HomeFocusTodayCard(
            taskTitle: focusTaskTitle,
            buttonText: focusButtonText,
            onStartPressed: () {
              if (hasTasks) {
                // TODO: بدأ المذاكرة
              } else {
                // TODO: Navigate to Add Task Screen
              }
            },
          ),
          //
          verticalSpace(40),
          //
          // GPA Card
          GpaSummaryCard(currentGpa: data.currentGpa),
          //
          verticalSpace(5),
          //
          Divider(color: AppColors.darkGrey),
          //
          verticalSpace(15),
          //
          // قسم تاسكات النهاردة
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .end,
            children: [
              //
              Text(
                "تاسكات النهاردة",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
              //
              if (hasTasks)
                //
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "المزيد",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: .w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              //
            ],
          ),
          //
          verticalSpace(16),
          //
          !hasTasks
              //
              ? Center(
                  child: Text(
                    "مفيش تاسكات متسجلة، ضيف تاسكاتك عشان تتابعها هنا",
                    style: TextStyle(color: AppColors.darkGrey),
                  ),
                )
              //
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.upcomingTasks.length > 3
                      ? 3
                      : data.upcomingTasks.length,
                  itemBuilder: (context, index) {
                    return HomeTodayTaskItem(
                      title: data.upcomingTasks[index].title,
                      onTap: () {},
                    );
                  },
                ),
          //
          verticalSpace(5),
          //
          Divider(color: AppColors.darkGrey),
          //
          verticalSpace(20),
          //
          // قسم محتاجين أتنشن
          Text(
            "محتاجين أتنشن",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: .bold,
              color: AppColors.primaryColor,
            ),
          ),
          //
          verticalSpace(16),
          //
          // اللوجيك الذكي لصندوق الأتنشن
          if (!hasTasks)
            //
            HomeEmptyStateMessage(
              message: "إبدأ خطط لترمك عشان تتابع زنقتك هنا",
              icon: Icons.event_note_rounded,
              color: AppColors.secondaryColor,
            )
          //
          else if (urgentTasks.isEmpty)
            //
            HomeEmptyStateMessage(
              message: "مفيش ضغط، أنت مسيطر",
              icon: Icons.check_circle_outline_rounded,
              color: AppColors.success,
            )
          //
          else
            _buildAttentionContainer(urgentTasks),
        ],
      ),
    );
  }

  /// ويدجت صندوق "الأتنشن"
  Widget _buildAttentionContainer(List<UpcomingTaskModel> urgentTasks) {
    return Container(
      width: .infinity,
      padding: .all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: .circular(16.r),
      ),
      child: Column(
        children: urgentTasks.map((task) => _buildAttentionItem(task)).toList(),
      ),
    );
  }

  Widget _buildAttentionItem(UpcomingTaskModel task) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 3), blurRadius: 0),
        ],
      ),
      child: Column(
        children: [
          Text(
            task.subjectName,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          verticalSpace(4),
          Text(
            _formatTimeLeft(task.deadline),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFD32F2F),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeLeft(DateTime deadline) {
    final difference = deadline.difference(DateTime.now());
    if (difference.isNegative) return "متأخر";
    if (difference.inHours <= 24) return "النهاردة";
    return "فاضل يومين";
  }

  /// Gamification
  Widget _buildSetupProgressCard(bool hasSubjects, bool hasTasks) {
    int completedSteps = (hasSubjects ? 1 : 0) + (hasTasks ? 1 : 0);
    double progress = completedSteps / 2;

    return HomeSetupProgressCard(
      hasSubjects: hasSubjects,
      hasTasks: hasTasks,
      completedSteps: completedSteps,
      progress: progress,
    );
  }
}
// 359