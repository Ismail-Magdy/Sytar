import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        //
        Padding(
          padding: .symmetric(horizontal: 16.w),
          child: Text(
            "أو",
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey.shade700,
              fontWeight: .w600,
            ),
          ),
        ),
        //
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        //
      ],
    );
  }
}
