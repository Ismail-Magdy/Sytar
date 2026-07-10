import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class HomeGreetingWidget extends StatelessWidget {
  final String userName;
  final String academicStatus;

  const HomeGreetingWidget({
    super.key,
    required this.userName,
    required this.academicStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "صباح الخير يا $userName",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          academicStatus,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
