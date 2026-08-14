import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_app_bar_without_leading.dart';
import 'package:sytar/core/widgets/error_screen.dart';
import 'package:sytar/features/subjects/manager/subjects/subjects_cubit.dart';
import 'package:sytar/features/subjects/manager/subjects/subjects_state.dart';
import 'package:sytar/features/subjects/presentation/widgets/subjects/subjects_floating_action_button.dart';
import 'package:sytar/features/subjects/presentation/widgets/subjects/subjects_empty_state.dart';
import 'package:sytar/features/subjects/presentation/widgets/subjects/subjects_loading_widget.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      //
      floatingActionButton: Padding(
        padding: .only(bottom: 90.h),
        child: const SubjectsFloatingActionButton(),
      ),

      floatingActionButtonLocation: .endFloat,
      //
      appBar: CustomAppBarWithNoLeading(text: "المواد الدراسية"),
      //
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // Body
            Expanded(
              child: BlocBuilder<SubjectsCubit, SubjectsState>(
                bloc: getIt<SubjectsCubit>()..fetchCurrentSemesterSubjects(),
                builder: (context, state) {
                  // Subjects Loading
                  if (state is SubjectsLoading) {
                    return const SubjectsLoadingWidget();
                  }
                  // Subjects Error
                  else if (state is SubjectsError) {
                    return ErrorScreen();
                  }
                  // Subjects Success
                  else if (state is SubjectsSuccess) {
                    if (state.subjects.isEmpty) {
                      return const SubjectsEmptyState();
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ).copyWith(bottom: 165.h),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.subjects.length,
                      separatorBuilder: (context, index) => verticalSpace(16),
                      itemBuilder: (context, index) {
                        //
                        final subject = state.subjects[index];
                        final subjectColor = Color(
                          int.parse(subject.colorCode, radix: 16),
                        );

                        return GestureDetector(
                          onTap: () => context.pushNamed(
                            Routes.subjectDetailsScreen,
                            arguments: subject,
                          ),
                          child: Container(
                            padding: .all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: .circular(16.r),
                              border: .all(
                                color: Colors.grey.withValues(alpha: 0.2),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                //
                                Container(
                                  width: 4.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: subjectColor,
                                    borderRadius: .circular(4.r),
                                  ),
                                ),
                                //
                                horizontalSpace(16),
                                //
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      //
                                      Text(
                                        subject.subjectName,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      //
                                      verticalSpace(4),
                                      //
                                      Text(
                                        // TODO : Change depends on Status
                                        "مفيش مهام قادمة",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      //
                                    ],
                                  ),
                                ),
                                //
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16.sp,
                                  color: Colors.grey[400],
                                ),
                                //
                              ],
                            ),
                            //
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
// 243