// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sytar/core/helpers/spacing.dart';
// import 'package:sytar/core/themes/app_colors.dart';


// class OfflineModeWidget extends StatelessWidget {
//   const OfflineModeWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: .symmetric(horizontal: 32.w),
//             child: Column(
//               mainAxisAlignment: .start,
//               children: [
//                 //
//                 verticalSpace(30),
//                 // Offline SVG Icon
//                 SvgPicture.asset(
//                   "assets/svgs/offline.svg",
//                   height: 55.h,
//                   colorFilter: const .mode(AppColors.primaryColor, .srcIn),
//                 ),
//                 //
//                 verticalSpace(180),
//                 // Offline Illustration
//                 ClipRRect(
//                   borderRadius: .only(
//                     topLeft: .circular(15.r),
//                     topRight: .circular(15.r),
//                   ),
//                   child: Image.asset(
//                     "assets/images/offline.png",
//                     fit: .contain,
//                   ),
//                 ),
//                 //
//                 verticalSpace(5),
//                 //
//                 // Title
//                 Text(
//                   "You're Offline",
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: .bold,
//                     color: Colors.black87,
//                     fontFamily: "BrunoAceSC",
//                   ),
//                 ),
//                 //
//                 verticalSpace(12),
//                 //
//                 // Subtitle
//                 Text(
//                   "No internet connection found.\n"
//                   "Please check your WiFi or mobile data.",
//                   textAlign: .center,
//                   style: TextStyle(
//                     fontFamily: "BrunoAceSC",
//                     fontSize: 14.sp,
//                     color: AppColors.primaryColor,
//                     height: 1.6,
//                   ),
//                 ),
//                 //
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// //