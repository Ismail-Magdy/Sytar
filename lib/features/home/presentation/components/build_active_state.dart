import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/features/home/data/models/home_dashboard_model.dart';
import 'package:sytar/features/home/data/models/upcoming_task_model.dart';
import 'package:sytar/features/home/presentation/widgets/focus_today_card.dart';
import 'package:sytar/features/home/presentation/widgets/gpa_summary_card.dart';
import 'package:sytar/features/home/presentation/widgets/today_task_item.dart';

class BuildActiveState extends StatelessWidget {
  final HomeDashboardModel data;

  const BuildActiveState({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // 1. فحص الداتا (هل اليوزر ضاف مواد أو تاسكات؟)
    final bool hasSubjects = data.subjectsProgress.isNotEmpty;
    final bool hasTasks = data.upcomingTasks.isNotEmpty;

    // هل محتاجين نعرض كارت الإعداد (Gamification)؟
    final bool showSetupCard = !hasSubjects || !hasTasks;

    // 2. كارت التركيز الذكي
    final String focusTaskTitle = hasTasks
        ? data.upcomingTasks.first.title
        : "خطط لترمك وضيف أول مهامك!";
    final String focusButtonText = hasTasks ? "ابدأ المذاكره" : "إضافة تاسك ➕";

    // 3. فلترة محتاجين أتنشن
    final DateTime now = DateTime.now();
    final List<UpcomingTaskModel> urgentTasks = data.upcomingTasks.where((
      task,
    ) {
      final difference = task.deadline.difference(now).inHours;
      return difference <= 48;
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(20),

          // --- لمسة الـ Gamification ---
          if (showSetupCard) ...[
            _buildSetupProgressCard(hasSubjects, hasTasks),
            verticalSpace(24),
          ],

          // --- كارت التركيز ---
          FocusTodayCard(
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
          verticalSpace(24),

          // --- كارت الـ GPA ---
          GpaSummaryCard(currentGpa: data.currentGpa),
          verticalSpace(24),

          // --- قسم تاسكات انهارده ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "تاسكات انهارده",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (hasTasks)
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "المزيد",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
            ],
          ),
          verticalSpace(16),

          !hasTasks
              ? Center(
                  child: Text(
                    "مفيش مهام متسجلة، ضيف مهامك عشان تتابعها هنا.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.upcomingTasks.length > 3
                      ? 3
                      : data.upcomingTasks.length,
                  itemBuilder: (context, index) {
                    return TodayTaskItem(
                      title: data.upcomingTasks[index].title,
                      onTap: () {},
                    );
                  },
                ),

          verticalSpace(24),

          // --- قسم محتاجين أتنشن ---
          Text(
            "محتاجين أتنشن",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          verticalSpace(16),

          // اللوجيك الذكي لصندوق الأتنشن
          if (!hasTasks)
            _buildEmptyStateMessage(
              "ابدأ خطط لترمك عشان تتابع زنقتك هنا!",
              Icons.event_note_rounded,
              Colors.blue,
            )
          else if (urgentTasks.isEmpty)
            _buildEmptyStateMessage(
              "مفيش ضغط، أنت مسيطر!",
              Icons.check_circle_outline_rounded,
              Colors.green,
            )
          else
            _buildAttentionContainer(urgentTasks),
        ],
      ),
    );
  }

  // ==========================================
  // ويدجت صندوق "الأتنشن"
  // ==========================================
  Widget _buildAttentionContainer(List<UpcomingTaskModel> urgentTasks) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16.r),
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
    if (difference.isNegative) return "متأخر ⚠️";
    if (difference.inHours <= 24) return "النهارده 🚨";
    return "فاضل يومين ⏰";
  }

  // ==========================================
  // رسائل الحالات الفاضية (Smart Empty States)
  // ==========================================
  Widget _buildEmptyStateMessage(
    String message,
    IconData icon,
    MaterialColor color,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.sp),
          verticalSpace(8),
          Text(
            message,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: color[700],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // لمسة الـ Gamification (إعداد الترم)
  // ==========================================
  Widget _buildSetupProgressCard(bool hasSubjects, bool hasTasks) {
    int completedSteps = (hasSubjects ? 1 : 0) + (hasTasks ? 1 : 0);
    double progress = completedSteps / 2;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "تجهيز الترم 🚀",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent[700],
                ),
              ),
              Text(
                "$completedSteps/2",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.blueAccent.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            borderRadius: BorderRadius.circular(10.r),
            minHeight: 8.h,
          ),
          verticalSpace(16),
          _buildSetupStep("إضافة أول مادة في الجدول", hasSubjects),
          verticalSpace(8),
          _buildSetupStep("إضافة أول تاسك أو تسليم", hasTasks),
        ],
      ),
    );
  }

  Widget _buildSetupStep(String title, bool isDone) {
    return Row(
      children: [
        Icon(
          isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
          color: isDone ? Colors.green : Colors.grey[500],
          size: 20.sp,
        ),
        horizontalSpace(8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isDone ? Colors.grey[700] : Colors.black87,
            decoration: isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
