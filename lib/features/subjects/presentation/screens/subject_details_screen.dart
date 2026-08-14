import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_app_bar.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subjects/presentation/widgets/subject_details/subject_details_header.dart';
import 'package:sytar/features/subjects/presentation/widgets/subject_details/subject_details_info_cards.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final SubjectModel subject;

  const SubjectDetailsScreen({super.key, required this.subject});

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  late Color subjectColor;

  @override
  void initState() {
    super.initState();
    subjectColor = Color(int.parse(widget.subject.colorCode, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      //
      appBar: CustomAppBar(
        text: "تفاصيل المادة",
        color: subjectColor,
        backgroundColor: subjectColor.withValues(alpha: 0.07),
      ),
      //
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            //
            SubjectDetailsHeader(
              subject: widget.subject,
              subjectColor: subjectColor,
            ),
            //
            verticalSpace(24),
            //
            SubjectDetailsInfoCards(
              subjectColor: subjectColor,
              valueCreditHours: "${widget.subject.creditHours}",
              valueTotalMarks: "${widget.subject.totalMarks}",
              valueTargetGrade: widget.subject.targetGrade ?? "?",
            ),
            //
            verticalSpace(32),
            //
            Padding(
              padding: .symmetric(horizontal: 24.w),
              child: Text(
                "مساعد سيطر",
                style: TextStyle(
                  fontSize: 18.sp,
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
              padding: .symmetric(horizontal: 24.w),
              child: Text(
                "مهام المادة",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            //
            verticalSpace(16),
            //
            _buildTasksPlaceholder(),
            //
            verticalSpace(40),
            //
          ],
        ),
      ),
    );
  }

  // ==================== [ Smart UX Section ] ====================

  Widget _buildSmartAssistantSection() {
    // 1. حالة الغموض (الدكتور مش محدد تقسيمة الدرجات)
    if (!widget.subject.isBreakdownKnown) {
      final mysteriousMarks =
          widget.subject.totalMarks - widget.subject.finalExamTotal;
      final drName = widget.subject.instructorName ?? "المادة";

      return _buildInteractiveCard(
        lottiePath: 'assets/lottie/detective.json', // ضيف أنيميشن محقق هنا
        message:
            "الفاينل من ${widget.subject.finalExamTotal}.. الأبلكيشن حسبها وبيقولك إن في $mysteriousMarks درجة دكتور $drName بيلعب بيهم في الخباثة، ركز في الشيتات والغياب!",
        buttonText: "تحديث التقسيمة",
        onTap: () {
          // TODO: نفتح BottomSheet لتعديل التقسيمة
        },
      );
    }

    // 2. حالة التنبيه الذكي للميدتيرم (لو لسه متحددش شهره)
    if (widget.subject.midtermMonth == null) {
      return _buildInteractiveCard(
        lottiePath: 'assets/lottie/calendar.json', // ضيف أنيميشن نتيجة/تقويم
        message:
            "عشان أقدر أفكرك وتسيطر على المادة.. الميدتيرم غالباً بيبقى في شهر كام؟",
        buttonText: "تحديد ميعاد الميدتيرم",
        onTap: () {
          // TODO: نفتح BottomSheet نختار منه الشهر
        },
      );
    }

    // 3. حالة الـ Gamification (لو دخل درجة الميدتيرم)
    if (widget.subject.obtainedMidterm1 != null &&
        widget.subject.midterm1Total != null) {
      final percentage =
          (widget.subject.obtainedMidterm1! / widget.subject.midterm1Total!) *
          100;
      final isGoodGrade = percentage >= 75;

      return _buildInteractiveCard(
        lottiePath: isGoodGrade
            ? 'assets/lottie/fireworks.json'
            : 'assets/lottie/cheer_up.json',
        message: isGoodGrade
            ? "عاش يا بطل! درجتك في الميدتيرم ممتازة، كمل على نفس المستوى وهنجيب الـ ${widget.subject.targetGrade ?? 'A+'} في شوال!"
            : "ولا يهمك! دي مجرد البداية.. لسه فاضل درجات نقدر نعوض فيهم ونجيب الـ ${widget.subject.targetGrade ?? 'التقدير اللي عايزينه'} 🎯",
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
              // مؤقتاً استخدمنا Icon لحد ما تنزل الـ Lottie Files
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
                    color: Colors.white,
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
          //
          Lottie.asset(
            "assets/lottie/no_tasks.json",
            width: 300.w,
            height: 180.h,
            fit: .contain,
          ),
          //
          verticalSpace(12),
          //
          Text(
            "مفيش مهام متسجلة للمادة دي لسه",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          ),
          //
        ],
      ),
    );
  }
}
//390