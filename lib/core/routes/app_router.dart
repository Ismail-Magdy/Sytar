import 'package:flutter/material.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/widgets/unknown_route_screen.dart';
import 'package:sytar/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:sytar/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// Splash Screen
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// OnBoarding Screen
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      /// Default Case (Unknown Route)
      default:
        return MaterialPageRoute(builder: (_) => const UnknownRouteScreen());
    }
  }
}
