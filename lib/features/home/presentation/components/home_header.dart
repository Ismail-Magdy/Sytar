import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sytar/core/themes/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String userName;

  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat("EEEE، d MMMM", "ar").format(.now());

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        //
        Column(
          crossAxisAlignment: .start,
          children: [
            //
            Text(
              "أهلا يا ${userName.split(" ").first}",
              textAlign: .center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: .w800,
                color: AppColors.primaryColor,
              ),
            ),
            //
            Text(
              todayDate,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: .w500,
                color: AppColors.secondaryColor,
              ),
            ),
            //
          ],
        ),
        //
        // Notification icon
        GestureDetector(
          onTap: () {
            // TODO: Navigate to notifications screen
          },
          child: Icon(
            CupertinoIcons.bell_solid,
            size: 23.sp,
            color: AppColors.primaryColor,
          ),
        ),
        //
      ],
    );
  }
}
