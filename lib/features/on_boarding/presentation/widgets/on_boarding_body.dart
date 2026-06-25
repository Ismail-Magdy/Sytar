import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/routes/routes.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/features/on_boarding/data/models/on_boarding_model.dart";

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < onBoardingData.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 1500),
        curve:
            Curves.fastLinearToSlowEaseIn, // حركة انتقال ناعمة جداً بين الصفحات
      );
    } else {
      context.pushReplacementNamed(Routes.authScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemCount: onBoardingData.length,
      itemBuilder: (context, index) {
        return _buildPageItem(onBoardingData[index], index);
      },
    );
  }

  Widget _buildPageItem(OnBoardingModel model, int index) {
    // هنتأكد إن الصفحة دي هي اللي ظاهرة قدام اليوزر عشان نشغل الأنيميشن بتاعها
    bool isActive = _currentIndex == index;

    return Column(
      children: [
        // النصف العلوي (أبيض - النصوص والزرار والمؤشر)
        Expanded(
          flex: 5,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Row(
                children: [
                  _buildVerticalIndicator(),
                  horizontalSpace(20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // أنيميشن العنوان (Slide from right + Fade)
                        TweenAnimationBuilder<double>(
                          key: ValueKey("title_$index$_currentIndex"),
                          duration: const Duration(milliseconds: 600),
                          tween: Tween<double>(
                            begin: isActive ? 0.0 : 1.0,
                            end: 1.0,
                          ),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(50 * (1 - value), 0),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Text(
                            model.title,
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        verticalSpace(12),

                        // أنيميشن الوصف (Slide from bottom + Fade)
                        TweenAnimationBuilder<double>(
                          key: ValueKey("desc_$index$_currentIndex"),
                          duration: const Duration(milliseconds: 800),
                          tween: Tween<double>(
                            begin: isActive ? 0.0 : 1.0,
                            end: 1.0,
                          ),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: Text(
                            model.description,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                              height: 1.6,
                            ),
                          ),
                        ),
                        verticalSpace(30),

                        // أنيميشن الزرار (Elastic Pop)
                        TweenAnimationBuilder<double>(
                          key: ValueKey("btn_$index$_currentIndex"),
                          duration: const Duration(milliseconds: 1000),
                          tween: Tween<double>(
                            begin: isActive ? 0.0 : 1.0,
                            end: 1.0,
                          ),
                          curve: Curves.elasticOut,
                          builder: (context, value, child) {
                            return Transform.scale(scale: value, child: child);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 130.w,
                              child: CustomButton(
                                text: index == onBoardingData.length - 1
                                    ? "ابدأ الآن"
                                    : "التالي",
                                onPressed: _nextPage,
                                borderRadius: 20,
                                height: 45.h,
                                elevation: 3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // النصف السفلي (أزرق مقطوع بزاوية - الصورة)
        Expanded(
          flex: 6,
          child: ClipPath(
            clipper: DiagonalClipper(),
            child: Container(
              width: double.infinity,
              color: AppColors.primaryColor,
              padding: EdgeInsets.only(top: 60.h, bottom: 20.h),

              // أنيميشن الصورة (Elastic Zoom In)
              child: TweenAnimationBuilder<double>(
                key: ValueKey("img_$index$_currentIndex"),
                duration: const Duration(milliseconds: 1200),
                tween: Tween<double>(begin: isActive ? 0.4 : 1.0, end: 1.0),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Image.asset(model.imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onBoardingData.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack, // المؤشر بيكبر بحركة ارتدادية
          margin: EdgeInsets.symmetric(vertical: 4.h),
          height: _currentIndex == index ? 35.h : 12.h,
          width: 6.w,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? AppColors.primaryColor
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.15);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
