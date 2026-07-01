import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/widgets/custom_glass_card.dart";

class GpaSummaryCard extends StatelessWidget {
  final double currentGpa;

  const GpaSummaryCard({super.key, required this.currentGpa});

  @override
  Widget build(BuildContext context) {
    return CustomGlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "المعدل التراكمي (GPA)",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                currentGpa.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          // Circular Progress for GPA (Assuming out of 4.0)
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 65.w,
                height: 65.w,
                child: CircularProgressIndicator(
                  value: currentGpa / 4.0,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blueAccent,
                ),
              ),
              Text(
                "${((currentGpa / 4.0) * 100).toInt()}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
