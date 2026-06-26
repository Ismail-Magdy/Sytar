import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/shared_prefrences_helper.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/routes/routes.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/features/on_boarding/data/models/on_boarding_model.dart";
import "package:sytar/features/on_boarding/presentation/widgets/custom_vertical_indicator.dart";
import "package:sytar/features/on_boarding/presentation/widgets/diagonal_clipper.dart";

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

  //
  void _nextPage() async {
    if (_currentIndex < onBoardingData.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    } else {
      await SharedPrefHelper.setData('isOnboardingViewed', true);
      if (mounted) {
        context.pushReplacementNamed(Routes.welcomeAuthScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    return PageView.builder(
      controller: _pageController,
      scrollDirection: .vertical,
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
    bool isActive = _currentIndex == index;

    return Column(
      children: [
        // Top Half => Texts ,Indicator, Button
        Expanded(
          flex: 5,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: .symmetric(horizontal: 24.w, vertical: 20.h),
              child: Row(
                children: [
                  //
                  Expanded(
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .start,
                      children: [
                        // Title Animation (Slide from right + Fade)
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
                              fontWeight: .bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        //
                        verticalSpace(12),
                        //
                        // Description Animation (Slide from bottom + Fade)
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
                              color: Colors.grey.shade700,
                              height: 1.6,
                            ),
                          ),
                        ),
                        //
                        verticalSpace(30),
                        //
                        // Button Animation (Elastic Pop)
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
                            alignment: .centerRight,
                            child: SizedBox(
                              width: 130.w,
                              child: CustomButton(
                                text: index == onBoardingData.length - 1
                                    ? "ابدأ الآن"
                                    : "التالي",
                                onPressed: _nextPage,
                                borderRadius: 15,
                                height: 45.h,
                                elevation: 3,
                              ),
                            ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                  //
                  CustomVerticalIndicator(
                    currentIndex: _currentIndex,
                    onBoardingDataLength: onBoardingData.length,
                  ),
                  //
                ],
              ),
            ),
          ),
        ),
        //
        // Bottom Half
        Expanded(
          flex: 6,
          child: ClipPath(
            clipper: DiagonalClipper(),
            child: Container(
              width: .infinity,
              color: AppColors.primaryColor,
              padding: .only(top: 60.h, bottom: 20.h),
              // Image Animation
              child: TweenAnimationBuilder<double>(
                key: ValueKey("img_$index$_currentIndex"),
                duration: const Duration(milliseconds: 1200),
                tween: Tween<double>(begin: isActive ? 0.4 : 1.0, end: 1.0),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Image.asset(model.imagePath, fit: .contain),
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
