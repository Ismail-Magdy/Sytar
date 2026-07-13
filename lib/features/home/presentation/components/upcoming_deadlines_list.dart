import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/spacing.dart";
import "../../data/models/upcoming_task_model.dart";

class UpcomingDeadlinesList extends StatelessWidget {
  final List<UpcomingTaskModel> tasks;

  const UpcomingDeadlinesList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "أقرب التسليمات",
          style: TextStyle(fontSize: 18.sp, fontWeight: .bold),
        ),
        //
        verticalSpace(12),
        //
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: .horizontal,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Container(
                width: 220.w,
                margin: .only(left: 12.w),
                padding: .all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  children: [
                    //
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: TextStyle(fontSize: 14.sp, fontWeight: .bold),
                    ),
                    //
                    verticalSpace(4),
                    //
                    Text(
                      task.subjectName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    //
                  ],
                ),
              );
            },
          ),
        ),
        //
      ],
    );
  }
}
