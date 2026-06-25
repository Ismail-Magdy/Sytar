import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sytar/core/helpers/extensions.dart"; // عشان الـ pushReplacementNamed
import "package:sytar/core/routes/routes.dart";

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _linesScaleAnimation;
  late Animation<double> _linesRotationAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _navigateToNextScreen();
  }

  void _initAnimations() {
    // المتحكم الرئيسي في الوقت (2.5 ثانية للأنيميشن كله)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. حركة الخطوط: بتكبر من 0 لـ 1 في أول 60% من الوقت
    _linesScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    // 2. دوران الخطوط: بتلف لفة كاملة وتكمل بنعومة
    _linesRotationAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    // 3. ظهور اللوجو: بيبدأ يظهر بعد ما الخطوط تاخد شكلها (من 50% لـ 100% من الوقت)
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // 4. حجم اللوجو: بيعمل زووم بسيط وهو بيظهر
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutBack),
      ),
    );

    // تشغيل الأنيميشن
    _animationController.forward();
  }

  void _navigateToNextScreen() {
    // هنستنى 3.5 ثانية (عشان الأنيميشن ياخد وقته واليوزر يشوفه) وبعدين ننقل
    Timer(const Duration(milliseconds: 3500), () {
      // مؤقتاً هنروح للـ OnBoarding، قدام هنحط هنا لوجيك الـ SharedPrefs
      context.pushReplacementNamed(Routes.onBoardingScreen);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // أنيميشن الخطوط (لف وزووم)
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _linesScaleAnimation.value,
                child: Transform.rotate(
                  angle: _linesRotationAnimation.value * 3.14159265359, // Pi
                  child: SvgPicture.asset(
                    "assets/svgs/lines.svg",
                    width: 200.w,
                    height: 200.h,
                  ),
                ),
              );
            },
          ),

          // أنيميشن اللوجو (Fade و Zoom)
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _logoOpacityAnimation.value,
                child: Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: SvgPicture.asset(
                    "assets/svgs/logo.svg",
                    width: 120.w,
                    height: 120.h,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
