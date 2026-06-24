import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

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
                // Offline Illustration
                ClipRRect(
                  borderRadius: .only(
                    topLeft: .circular(15.r),
                    topRight: .circular(15.r),
                  ),
                  child: Image.asset(
                    "assets/images/offline.png",
                    height: 250.h,
                    fit: .contain,
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
