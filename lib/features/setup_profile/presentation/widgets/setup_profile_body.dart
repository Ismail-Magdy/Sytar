import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_button.dart';
import 'package:sytar/core/widgets/custom_feedback_dialog.dart';
import 'package:sytar/features/setup_profile/manager/setup_profile_bloc.dart';
import 'package:sytar/features/setup_profile/manager/setup_profile_event.dart';
import 'package:sytar/features/setup_profile/manager/setup_profile_state.dart';
import 'package:sytar/features/setup_profile/presentation/widgets/step_one_widget.dart';
import 'package:sytar/features/setup_profile/presentation/widgets/step_two_widget.dart';

class SetupProfileBody extends StatefulWidget {
  const SetupProfileBody({super.key});

  @override
  State<SetupProfileBody> createState() => _SetupProfileBodyState();
}

class _SetupProfileBodyState extends State<SetupProfileBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 2;

  // State variables for Step One & Two
  int _studyYears = 5;
  double _selectedScale = 4.0;

  // Controllers First Step (Pre-filled smart defaults)
  final TextEditingController _uniController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  // Controllers Second Step
  final TextEditingController _totalHoursController = TextEditingController();
  final TextEditingController _completedHoursController =
      TextEditingController();
  final TextEditingController _gpaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pageController.dispose();
    _uniController.dispose();
    _facultyController.dispose();
    _deptController.dispose();
    _levelController.dispose();
    _totalHoursController.dispose();
    _completedHoursController.dispose();
    _gpaController.dispose();
    _semesterController.dispose();
    super.dispose();
  }

  ///
  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      if (_uniController.text.trim().isNotEmpty &&
          _facultyController.text.trim().isNotEmpty &&
          _deptController.text.trim().isNotEmpty &&
          _levelController.text.trim().isNotEmpty &&
          _semesterController.text.trim().isNotEmpty) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        showFeedbackDialog(
          context,
          icon: Icons.info_outline_rounded,
          color: Colors.orange,
          title: "بيانات ناقصة",
          message: "يرجى إكمال جميع البيانات الأساسية للانتقال للخطوة التالية",
        );
      }
    }
  }

  ///
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: .symmetric(horizontal: 24.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              //
              Row(
                children: [
                  if (_currentPage > 0)
                    GestureDetector(
                      onTap: _previousPage,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primaryColor,
                        size: 22.sp,
                      ),
                    )
                  else
                    horizontalSpace(24),
                  //
                  Expanded(
                    child: Text(
                      "إعداد الملف الأكاديمي",
                      textAlign: .center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: .bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  //
                  horizontalSpace(24),
                  //
                ],
              ),
              //
              verticalSpace(24),
              //
              Container(
                height: 6.h,
                width: .infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: .circular(10.r),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: (_currentPage + 1) / _totalPages,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: .circular(10.r),
                      ),
                    ),
                  ),
                ),
              ),
              //
              verticalSpace(32),
              //
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    //
                    StepOneWidget(
                      uniController: _uniController,
                      facultyController: _facultyController,
                      deptController: _deptController,
                      levelController: _levelController,
                      semesterController: _semesterController,
                      studyYears: _studyYears,
                      onStudyYearsChanged: (years) {
                        setState(() {
                          _studyYears = years;
                        });
                      },
                    ),
                    //
                    StepTwoWidget(
                      totalHoursController: _totalHoursController,
                      completedHoursController: _completedHoursController,
                      gpaController: _gpaController,
                      selectedScale: _selectedScale,
                      onScaleChanged: (scale) {
                        setState(() {
                          _selectedScale = scale;
                        });
                      },
                    ),
                    //
                  ],
                ),
              ),
              //
              verticalSpace(20),
              //
              if (_currentPage == 0)
                CustomButton(
                  text: "التالي",
                  onPressed: _nextPage,
                  borderRadius: 14,
                )
              //
              else
                BlocConsumer<SetupProfileBloc, SetupProfileState>(
                  listener: (context, state) {
                    if (state is SetupProfileSuccess) {
                      showFeedbackDialog(
                        context,
                        icon: Icons.rocket_launch_rounded,
                        color: AppColors.success,
                        title: "عاش",
                        message: "تم تجهيز ملفك الأكاديمي بنجاح، جاهز للسيطرة؟",
                        onFinish: () =>
                            context.pushReplacementNamed(Routes.rootScreen),
                      );
                    } else if (state is SetupProfileFailure) {
                      showFeedbackDialog(
                        context,
                        icon: Icons.error_outline_rounded,
                        color: AppColors.error,
                        title: "عفواً",
                        message: state.errMessage,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SetupProfileLoading) {
                      return Container(
                        height: 50.h,
                        width: .infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.7),
                          borderRadius: .circular(14.r),
                        ),
                        child: const Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                            radius: 14,
                          ),
                        ),
                      );
                    }
                    //
                    return CustomButton(
                      text: "حفظ وبدء السيطرة",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SetupProfileBloc>().add(
                            SaveProfileDataRequested(
                              university: _uniController.text,
                              faculty: _facultyController.text,
                              department: _deptController.text,
                              currentLevel: _levelController.text,
                              currentSemester: _semesterController.text,
                              totalHours:
                                  double.tryParse(_totalHoursController.text) ??
                                  0,
                              completedHours:
                                  double.tryParse(
                                    _completedHoursController.text,
                                  ) ??
                                  0,
                              currentGpa:
                                  double.tryParse(_gpaController.text) ?? 0,
                              gpaScale: _selectedScale,
                            ),
                          );
                        }
                      },
                      borderRadius: 14,
                    );
                  },
                ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
