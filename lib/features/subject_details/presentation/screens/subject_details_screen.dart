import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_app_bar.dart';
import 'package:sytar/core/widgets/custom_feedback_dialog.dart';
import 'package:sytar/features/subject_details/presentation/widgets/components/expandable_mark_chip.dart';
import 'package:sytar/features/subject_details/presentation/widgets/components/subject_details_compact_interactive_card.dart';
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
        borderRadius: .vertical(top: .circular(30.r)),
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
                  crossAxisAlignment: .start,
                  children: [
                    //
                    SubjectDetailsHeader(subject: currentSubject),
                    //
                    SubjectDetailsInfoCards(
                      valueCreditHours: "${currentSubject.creditHours}",
                      valueTotalMarks: "${currentSubject.totalMarks}",
                      valueTargetGrade: currentSubject.targetGrade ?? "?",
                    ),
                    //
                    verticalSpace(24),
                    //
                    if (currentSubject.midtermMonth != null) ...[
                      _buildExamDateCard(),
                      verticalSpace(24),
                    ],
                    //
                    _buildMarksBreakdownSection(),
                    //
                    verticalSpace(24),
                    //
                    Padding(
                      padding: .symmetric(horizontal: 24.w),
                      child: Text(
                        "مساعد سيطر",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: .bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    //
                    verticalSpace(12),
                    //
                    _buildSmartAssistantSection(),
                    //
                    verticalSpace(32),
                    //
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

  /// Exam Date Card (MIDTERM)
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "شهر الميدتيرم التقريبي: ",
              style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey),
            ),
            Text(
              monthName,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// توزيع الدرجات باستخدام الكومبوننت التفاعلي الجديد
  Widget _buildMarksBreakdownSection() {
    final currentBreakdownSum =
        currentSubject.finalExamTotal +
        (currentSubject.midterm1Total ?? 0) +
        (currentSubject.midterm2Total ?? 0) +
        (currentSubject.courseworkTotal ?? 0);

    if (!currentSubject.isBreakdownKnown ||
        currentBreakdownSum < currentSubject.totalMarks) {
      return Padding(
        padding: .symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "توزيع الدرجات",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: AppColors.primaryColor,
              ),
            ),
            verticalSpace(12),
            InkWell(
              onTap: () => _openBottomSheet(
                UpdateBreakdownBottomSheet(subject: currentSubject),
              ),
              borderRadius: .circular(16.r),
              child: Container(
                width: .infinity,
                padding: .symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withValues(alpha: 0.05),
                  borderRadius: .circular(16.r),
                  border: .all(
                    color: AppColors.secondaryColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(
                      Icons.pie_chart_outline_rounded,
                      color: AppColors.primaryColor,
                      size: 32.sp,
                    ),
                    verticalSpace(8),
                    Text(
                      "إضافة توزيعة أعمال السنة",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
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
      padding: .symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "توزيع الدرجات",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: .bold,
              color: AppColors.primaryColor,
            ),
          ),
          verticalSpace(12),
          SingleChildScrollView(
            scrollDirection: .horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: .none,
            child: Row(
              crossAxisAlignment: .start,
              children: [
                if (currentSubject.finalExamTotal > 0) ...[
                  ExpandableMarkChip(
                    title: "الفاينل",
                    total: currentSubject.finalExamTotal,
                    obtained: currentSubject.obtainedFinal,
                    onAddGradeTap: () => _openBottomSheet(
                      AddGradesBottomSheet(subject: currentSubject),
                    ),
                  ),
                ],
                if (currentSubject.midterm1Total != null &&
                    currentSubject.midterm1Total! > 0) ...[
                  horizontalSpace(8),
                  ExpandableMarkChip(
                    title: "ميد أول",
                    total: currentSubject.midterm1Total!,
                    obtained: currentSubject.obtainedMidterm1,
                    onAddGradeTap: () => _openBottomSheet(
                      AddGradesBottomSheet(subject: currentSubject),
                    ),
                  ),
                ],
                if (currentSubject.midterm2Total != null &&
                    currentSubject.midterm2Total! > 0) ...[
                  horizontalSpace(8),
                  ExpandableMarkChip(
                    title: "ميد تاني",
                    total: currentSubject.midterm2Total!,
                    obtained: currentSubject.obtainedMidterm2,
                    onAddGradeTap: () => _openBottomSheet(
                      AddGradesBottomSheet(subject: currentSubject),
                    ),
                  ),
                ],
                if (currentSubject.courseworkTotal != null &&
                    currentSubject.courseworkTotal! > 0) ...[
                  horizontalSpace(8),
                  ExpandableMarkChip(
                    title: "أعمال سنة",
                    total: currentSubject.courseworkTotal!,
                    obtained: currentSubject.obtainedCoursework,
                    onAddGradeTap: () => _openBottomSheet(
                      AddGradesBottomSheet(subject: currentSubject),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  Smart UX Section
  Widget _buildSmartAssistantSection() {
    final currentBreakdownSum =
        currentSubject.finalExamTotal +
        (currentSubject.midterm1Total ?? 0) +
        (currentSubject.midterm2Total ?? 0) +
        (currentSubject.courseworkTotal ?? 0);

    if (!currentSubject.isBreakdownKnown ||
        currentBreakdownSum < currentSubject.totalMarks) {
      final mysteriousMarks = currentSubject.totalMarks - currentBreakdownSum;
      return SubjectDetailsCompactInteractiveCard(
        icon: Icons.search_rounded,
        iconColor: AppColors.secondaryColor,
        title: "درجات مفقودة",
        message:
            "في $mysteriousMarks درجة مش متوزعين، خلينا نحددهم عشان نقدر نسجل الدرجات",
        buttonText: "توزيع الدرجات",
        onTap: () => _openBottomSheet(
          UpdateBreakdownBottomSheet(subject: currentSubject),
        ),
      );
    }

    if (currentSubject.midtermMonth == null) {
      return SubjectDetailsCompactInteractiveCard(
        icon: Icons.calendar_month_rounded,
        iconColor: AppColors.secondaryColor,
        title: "مواعيد الإمتحانات",
        message: "إمتحانات الميدتيرم غالباً بتبقى في شهر كام؟",
        buttonText: "تحديد الميعاد",
        onTap: () =>
            _openBottomSheet(MidtermMonthBottomSheet(subject: currentSubject)),
      );
    }

    // الحالة الافتراضية
    return SubjectDetailsCompactInteractiveCard(
      icon: Icons.add_task_rounded,
      iconColor: AppColors.primaryColor,
      title: "تسجيل الدرجات",
      message:
          "التقسيمة جاهزة، أول ما تمتحن حاجة ضيف نتيجتها هنا عشان نتابع مستواك",
      buttonText: "تسجيل الدرجات",
      onTap: () =>
          _openBottomSheet(AddGradesBottomSheet(subject: currentSubject)),
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
