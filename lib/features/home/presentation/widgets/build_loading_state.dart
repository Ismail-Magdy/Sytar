import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sytar/features/home/data/models/home_dashboard_model.dart';
import 'package:sytar/features/home/data/models/upcoming_task_model.dart';
import 'package:sytar/features/home/presentation/components/home_header.dart';
import 'package:sytar/features/home/presentation/components/build_active_state.dart';

class BuildLoadingState extends StatefulWidget {
  const BuildLoadingState({super.key});

  @override
  State<BuildLoadingState> createState() => _BuildLoadingStateState();
}

class _BuildLoadingStateState extends State<BuildLoadingState> {
  // Skeleton
  final dummyData = HomeDashboardModel(
    userName: "Loading Name",
    academicStatus: "جاري تحميل البيانات...",
    currentGpa: 3.5,
    currentLevel: "المستوى...",
    currentSemester: "الترم...",
    availableLevels: ["المستوى..."],
    availableSemesters: ["الترم..."],
    upcomingTasks: [
      UpcomingTaskModel(
        id: "1",
        title: "تسليم مشروع البرمجة",
        subjectName: "علوم حاسب",
        deadline: DateTime.now(),
        priority: "high",
      ),
      UpcomingTaskModel(
        id: "2",
        title: "شيت الماث",
        subjectName: "رياضيات",
        deadline: DateTime.now(),
        priority: "medium",
      ),
    ],
    subjectsProgress: [],
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: .symmetric(horizontal: 20.w, vertical: 10.h),
            child: HomeHeader(userName: dummyData.userName),
          ),
          Expanded(child: BuildActiveState(data: dummyData)),
        ],
      ),
    );
  }
}
