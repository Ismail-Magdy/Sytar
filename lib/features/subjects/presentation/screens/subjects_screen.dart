import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/subjects/manager/subjects/subjects_cubit.dart';
import 'package:sytar/features/subjects/manager/subjects/subjects_state.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 24.w,
                right: 24.w,
                bottom: 16.h,
              ),
              child: Text(
                "المواد الدراسية",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),

            // Body (BlocBuilder)
            Expanded(
              child: BlocBuilder<SubjectsCubit, SubjectsState>(
                bloc: getIt<SubjectsCubit>()..fetchCurrentSemesterSubjects(),
                builder: (context, state) {
                  if (state is SubjectsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (state is SubjectsError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    );
                  } else if (state is SubjectsSuccess) {
                    if (state.subjects.isEmpty) {
                      return _buildEmptyState();
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ).copyWith(bottom: 120.h),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.subjects.length,
                      separatorBuilder: (context, index) => verticalSpace(16),
                      itemBuilder: (context, index) {
                        final subject = state.subjects[index];
                        final subjectColor = Color(
                          int.parse(subject.colorCode, radix: 16),
                        );

                        return Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // لون المادة كشريط جانبي
                              Container(
                                width: 4.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: subjectColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              horizontalSpace(16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subject.subjectName,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    verticalSpace(4),
                                    Text(
                                      "مفيش مهام قادمة", // TODO: هنجيب عدد المهام بعدين
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16.sp,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_rounded,
            size: 60.sp,
            color: Colors.grey[300],
          ),
          verticalSpace(16),
          Text(
            "مفيش مواد متسجلة للترم ده",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
