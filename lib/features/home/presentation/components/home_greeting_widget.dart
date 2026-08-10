import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/spacing.dart";

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
      crossAxisAlignment: .start,
      children: [
        //
        Text(
          "صباح الخير يا $userName",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        //
        verticalSpace(6),
        //
        Text(
          academicStatus,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
        ),
        //
      ],
    );
  }
}
