import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_app_bar.dart';
import 'package:sytar/core/widgets/custom_feedback_dialog.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subject_details/manager/subject_details_cubit.dart';
import 'package:sytar/features/subject_details/manager/subject_details_state.dart';
import 'package:sytar/features/subject_details/presentation/widgets/widgets/add_grades_bottom_sheet.dart';
import 'package:sytar/features/subject_details/presentation/widgets/widgets/midterm_month_bottom_sheet.dart';
import 'package:sytar/features/subject_details/presentation/widgets/widgets/subject_details_header.dart';
import 'package:sytar/features/subject_details/presentation/widgets/widgets/subject_details_info_cards.dart';
import 'package:sytar/features/subject_details/presentation/widgets/widgets/update_breakdown_bottom_sheet.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final SubjectModel subject;

  const SubjectDetailsScreen({super.key, required this.subject});

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  late Color subjectColor;
  late SubjectModel currentSubject;

  @override
  void initState() {
    super.initState();
    currentSubject = widget.subject;
    subjectColor = Color(int.parse(currentSubject.colorCode, radix: 16));
  }

  void _openBottomSheet(Widget bottomSheetWidget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SubjectDetailsCubit>(),
          child: bottomSheetWidget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      //
      appBar: CustomAppBar(text: "تفاصيل المادة"),
      //
      body: BlocConsumer<SubjectDetailsCubit, SubjectDetailsState>(
        listener: (context, state) {
          if (state is SubjectDetailsUpdateSuccess) {
            setState(() {
              currentSubject = state.updatedSubject;
            });
            showFeedbackDialog(
              context,
              icon: Icons.check_circle_rounded,
              color: AppColors.success,
              title: "عاش",
              message: "تم تحديث بيانات المادة بنجاح",
            );
          } else if (state is SubjectDetailsUpdateError) {
            showFeedbackDialog(
              context,
              icon: Icons.error_rounded,
              color: AppColors.error,
              title: "عفواً",
              message: state.error,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is SubjectDetailsUpdateLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubjectDetailsHeader(subject: currentSubject),
                    SubjectDetailsInfoCards(
                      valueCreditHours: "${currentSubject.creditHours}",
                      valueTotalMarks: "${currentSubject.totalMarks}",
                      valueTargetGrade: currentSubject.targetGrade ?? "?",
                    ),
                    verticalSpace(24),

                    if (currentSubject.midtermMonth != null) ...[
                      _buildExamDateCard(),
                      verticalSpace(24),
                    ],

                    _buildMarksBreakdownSection(),
                    verticalSpace(24),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "مساعد سيطر",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    verticalSpace(12),
                    _buildSmartAssistantSection(),
                    verticalSpace(32),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "مهام المادة",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    verticalSpace(16),
                    _buildTasksPlaceholder(),
                    verticalSpace(40),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: AppColors.white.withValues(alpha: 0.6),
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: subjectColor,
                      radius: 16.r,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExamDateCard() {
    final List<String> months = [
      "يناير",
      "فبراير",
      "مارس",
      "أبريل",
      "مايو",
      "يونيو",
      "يوليو",
      "أغسطس",
      "سبتمبر",
      "أكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];
    final monthName = months[currentSubject.midtermMonth! - 1];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.secondaryColor.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: AppColors.secondaryColor,
              size: 24.sp,
            ),
            horizontalSpace(12),
            Text(
              "شهر الميدتيرم التقريبي: ",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
            Text(
              monthName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: subjectColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarksBreakdownSection() {
    // بنحسب المجموع الفعلي للدرجات اللي اليوزر مسجلها
    final currentBreakdownSum =
        currentSubject.finalExamTotal +
        (currentSubject.midterm1Total ?? 0) +
        (currentSubject.midterm2Total ?? 0) +
        (currentSubject.courseworkTotal ?? 0);

    // لو التقسيمة مش معروفة، أو المجموع مش بيكمل الدرجة الكلية بتاعت المادة!
    if (!currentSubject.isBreakdownKnown ||
        currentBreakdownSum < currentSubject.totalMarks) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "توزيع الدرجات",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            verticalSpace(12),
            InkWell(
              onTap: () => _openBottomSheet(
                UpdateBreakdownBottomSheet(
                  subject: currentSubject,
                  subjectColor: subjectColor,
                ),
              ),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: subjectColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: subjectColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pie_chart_outline_rounded,
                      color: subjectColor,
                      size: 32.sp,
                    ),
                    verticalSpace(8),
                    Text(
                      "إضافة توزيعة أعمال السنة",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: subjectColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "توزيع الدرجات",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          verticalSpace(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                if (currentSubject.finalExamTotal > 0) ...[
                  _buildMarkChip(
                    "الفاينل",
                    currentSubject.finalExamTotal,
                    currentSubject.obtainedFinal,
                  ),
                ],
                if (currentSubject.midterm1Total != null &&
                    currentSubject.midterm1Total! > 0) ...[
                  horizontalSpace(8),
                  _buildMarkChip(
                    "ميد 1",
                    currentSubject.midterm1Total!,
                    currentSubject.obtainedMidterm1,
                  ),
                ],
                if (currentSubject.midterm2Total != null &&
                    currentSubject.midterm2Total! > 0) ...[
                  horizontalSpace(8),
                  _buildMarkChip(
                    "ميد 2",
                    currentSubject.midterm2Total!,
                    currentSubject.obtainedMidterm2,
                  ),
                ],
                if (currentSubject.courseworkTotal != null &&
                    currentSubject.courseworkTotal! > 0) ...[
                  horizontalSpace(8),
                  _buildMarkChip(
                    "أعمال سنة",
                    currentSubject.courseworkTotal!,
                    currentSubject.obtainedCoursework,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkChip(String title, int total, int? obtained) {
    final bool hasGrade = obtained != null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.secondaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
          verticalSpace(4),
          Text(
            hasGrade ? "$obtained / $total" : "$total",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: hasGrade ? subjectColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  //  Smart UX Section
  Widget _buildSmartAssistantSection() {
    // 1. لو المجموع لسه ناقص، هنجبره يكمل توزيع الدرجات من هنا كمان عشان ميعرفش يسجل درجات على الفاضي
    final currentBreakdownSum =
        currentSubject.finalExamTotal +
        (currentSubject.midterm1Total ?? 0) +
        (currentSubject.midterm2Total ?? 0) +
        (currentSubject.courseworkTotal ?? 0);

    if (!currentSubject.isBreakdownKnown ||
        currentBreakdownSum < currentSubject.totalMarks) {
      final mysteriousMarks = currentSubject.totalMarks - currentBreakdownSum;
      return _buildCompactInteractiveCard(
        icon: Icons.search_rounded,
        iconColor: Colors.orange,
        title: "درجات مفقودة",
        message:
            "في $mysteriousMarks درجة مش متوزعين، خلينا نحددهم عشان نقدر نسجل الدرجات.",
        buttonText: "توزيع الدرجات",
        onTap: () => _openBottomSheet(
          UpdateBreakdownBottomSheet(
            subject: currentSubject,
            subjectColor: subjectColor,
          ),
        ),
      );
    }

    // 2. حالة المواعيد
    if (currentSubject.midtermMonth == null) {
      return _buildCompactInteractiveCard(
        icon: Icons.calendar_month_rounded,
        iconColor: AppColors.secondaryColor,
        title: "مواعيد الإمتحانات",
        message: "إمتحانات الميدتيرم غالباً بتبقى في شهر كام؟",
        buttonText: "تحديد الميعاد",
        onTap: () =>
            _openBottomSheet(MidtermMonthBottomSheet(subject: currentSubject)),
      );
    }

    // 3. حالة التحفيز وتسجيل الدرجات
    if (currentSubject.obtainedMidterm1 != null &&
        currentSubject.midterm1Total != null &&
        currentSubject.midterm1Total! > 0) {
      final percentage =
          (currentSubject.obtainedMidterm1! / currentSubject.midterm1Total!) *
          100;
      final isGoodGrade = percentage >= 75;

      return _buildCompactInteractiveCard(
        icon: isGoodGrade
            ? Icons.celebration_rounded
            : Icons.trending_up_rounded,
        iconColor: isGoodGrade ? AppColors.success : Colors.orange,
        title: isGoodGrade ? "عاش يا بطل! 🎯" : "مجرد البداية 🎯",
        message: isGoodGrade
            ? "كمل على نفس المستوى وهنجيب التقدير."
            : "لسه فاضل درجات نعوض فيها.",
        buttonText: "تحديث الدرجات",
        onTap: () => _openBottomSheet(
          AddGradesBottomSheet(
            subject: currentSubject,
            subjectColor: subjectColor,
          ),
        ),
      );
    }

    // 4. الحالة الافتراضية
    return _buildCompactInteractiveCard(
      icon: Icons.add_task_rounded,
      iconColor: AppColors.primaryColor,
      title: "تسجيل الدرجات",
      message:
          "التقسيمة جاهزة، أول ما تمتحن حاجة ضيف نتيجتها هنا عشان نتابع مستواك.",
      buttonText: "تسجيل الدرجات",
      onTap: () => _openBottomSheet(
        AddGradesBottomSheet(
          subject: currentSubject,
          subjectColor: subjectColor,
        ),
      ),
    );
  }

  Widget _buildCompactInteractiveCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            horizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    message,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            horizontalSpace(8),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksPlaceholder() {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            "assets/lottie/no_tasks.json",
            width: 250.w,
            height: 150.h,
            fit: BoxFit.contain,
          ),
          verticalSpace(12),
          Text(
            "مفيش مهام متسجلة للمادة دي لسه",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
