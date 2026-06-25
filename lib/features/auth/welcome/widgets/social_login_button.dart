import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sytar/core/helpers/spacing.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(.infinity, 50.h),
        side: BorderSide(color: Colors.grey.shade400, width: 1),
        shape: RoundedRectangleBorder(borderRadius: .circular(14.r)),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          //
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: .w600,
              color: Colors.black87,
            ),
          ),
          //
          horizontalSpace(12),
          //
          SvgPicture.asset(iconPath, height: 24.h, width: 24.w),

          //
        ],
      ),
    );
  }
}
