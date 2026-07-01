import "dart:ui";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class CustomGlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const CustomGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        // Apply blur effect
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            // Semi-transparent background
            color: Colors.blueAccent.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              // Light border for the glass edge effect
              color: Colors.blueAccent.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
