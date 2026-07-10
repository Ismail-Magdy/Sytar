import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:lottie/lottie.dart";
import "../helpers/spacing.dart";

class OfflineModeWidget extends StatelessWidget {
  const OfflineModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: .symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                // Lottie Animation
                Lottie.asset(
                  "assets/lottie/offline_mode.json",
                  height: 250.h,
                  fit: .contain,
                ),
                //
                verticalSpace(30),
                //
                Text(
                  "لا يوجد اتصال بالإنترنت",
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: .bold,
                    color: Colors.black,
                  ),
                ),
                //
                verticalSpace(12),
                //
                Text(
                  "يبدو أنك غير متصل بالشبكة.\nيرجى التحقق من اتصالك والمحاولة مرة أخرى",
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: .w500,
                    color: Colors.grey[600],
                    height: 1.5.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
