import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_app_bar.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subjects/manager/subject_details/subject_details_cubit.dart';
import 'package:sytar/features/subjects/manager/subject_details/subject_details_state.dart';
import 'package:sytar/features/subjects/presentation/widgets/subject_details/subject_details_header.dart';
import 'package:sytar/features/subjects/presentation/widgets/subject_details/subject_details_info_cards.dart';
import 'package:sytar/features/subjects/presentation/widgets/subject_details/update_breakdown_bottom_sheet.dart';
import 'package:sytar/features/subjects/presentation/widgets/subject_details/midterm_month_bottom_sheet.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        text: "تفاصيل المادة",
        color: subjectColor,
        backgroundColor: subjectColor.withValues(alpha: 0.07),
      ),
      body: BlocConsumer<SubjectDetailsCubit, SubjectDetailsState>(
        listener: (context, state) {
          if (state is SubjectDetailsUpdateSuccess) {
            setState(() {
              currentSubject = state.updatedSubject;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تم التحديث بنجاح 🚀"),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is SubjectDetailsUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
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
                    SubjectDetailsHeader(
                      subject: currentSubject,
                      subjectColor: subjectColor,
                    ),
                    verticalSpace(24),
                    SubjectDetailsInfoCards(
                      subjectColor: subjectColor,
                      valueCreditHours: "${currentSubject.creditHours}",
                      valueTotalMarks: "${currentSubject.totalMarks}",
                      valueTargetGrade: currentSubject.targetGrade ?? "?",
                    ),
                    verticalSpace(32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "مساعد سيطر",
                        style: TextStyle(
                          fontSize: 18.sp,
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
                          fontSize: 18.sp,
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
                    child: CircularProgressIndicator(color: subjectColor),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // ==================== [ Smart UX Section ] ====================

  Widget _buildSmartAssistantSection() {
    // 1. حالة الغموض (الدكتور مش محدد تقسيمة الدرجات)
    if (!currentSubject.isBreakdownKnown) {
      final mysteriousMarks =
          currentSubject.totalMarks - currentSubject.finalExamTotal;
      final drName = currentSubject.instructorName ?? "المادة";

      return _buildInteractiveCard(
        lottiePath: 'assets/lottie/detective.json',
        message:
            "الفاينل من ${currentSubject.finalExamTotal}.. الأبلكيشن حسبها وبيقولك إن في $mysteriousMarks درجة دكتور $drName بيلعب بيهم في الخباثة، ركز في الشيتات والغياب!",
        buttonText: "تحديث التقسيمة",
        onTap: () {
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
                child: UpdateBreakdownBottomSheet(
                  subject: currentSubject,
                  subjectColor: subjectColor,
                ),
              );
            },
          );
        },
      );
    }

    // 2. حالة التنبيه الذكي للميدتيرم (لو لسه متحددش شهره)
    if (currentSubject.midtermMonth == null) {
      return _buildInteractiveCard(
        lottiePath: 'assets/lottie/calendar.json',
        message:
            "عشان أقدر أفكرك وتسيطر على المادة.. الميدتيرم غالباً بيبقى في شهر كام؟",
        buttonText: "تحديد ميعاد الميدتيرم",
        onTap: () {
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
                child: MidtermMonthBottomSheet(
                  subject: currentSubject,
                  subjectColor: subjectColor,
                ),
              );
            },
          );
        },
      );
    }

    // 3. حالة الـ Gamification (لو دخل درجة الميدتيرم)
    if (currentSubject.obtainedMidterm1 != null &&
        currentSubject.midterm1Total != null) {
      final percentage =
          (currentSubject.obtainedMidterm1! / currentSubject.midterm1Total!) *
          100;
      final isGoodGrade = percentage >= 75;

      return _buildInteractiveCard(
        lottiePath: isGoodGrade
            ? 'assets/lottie/fireworks.json'
            : 'assets/lottie/cheer_up.json',
        message: isGoodGrade
            ? "عاش يا بطل! درجتك في الميدتيرم ممتازة، كمل على نفس المستوى وهنجيب الـ ${currentSubject.targetGrade ?? 'A+'} في شوال!"
            : "ولا يهمك! دي مجرد البداية.. لسه فاضل درجات نقدر نعوض فيهم ونجيب الـ ${currentSubject.targetGrade ?? 'التقدير اللي عايزينه'} 🎯",
        buttonText: "إضافة درجة جديدة",
        onTap: () {
          // TODO: إضافة درجات الكويزات أو العملي
        },
      );
    }

    // 4. الحالة الافتراضية (لو كله متظبط بس لسه مدخلش درجات)
    return _buildInteractiveCard(
      lottiePath: 'assets/lottie/rocket.json',
      message:
          "التقسيمة جاهزة ومواعيد الامتحانات متسجلة.. شد حيلك وأول ما تمتحن حاجة ضيف نتيجتها هنا عشان نتابع الـ GPA أول بأول.",
      buttonText: "تسجيل درجة جديدة",
      onTap: () {},
    );
  }

  Widget _buildInteractiveCard({
    String? lottiePath,
    required String message,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            if (lottiePath != null) ...[
              Icon(
                Icons.smart_toy_rounded,
                size: 50.sp,
                color: AppColors.primaryColor,
              ),
              verticalSpace(16),
            ],
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(20),
            SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================

  Widget _buildTasksPlaceholder() {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            "assets/lottie/no_tasks.json",
            width: 300.w,
            height: 180.h,
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
