import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.actions,
    this.color,
    this.backgroundColor,
  });
  final String text;
  final List<Widget>? actions;
  final Color? color;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: color ?? AppColors.primaryColor,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.primaryColor,
          fontWeight: .bold,
          fontSize: 18.sp,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}
