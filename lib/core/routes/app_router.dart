import 'package:flutter/material.dart';
import 'package:sytar/core/widgets/unknown_route_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// OnBoarding Screen
      // case Routes.onBoardingScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const OnBoardingScreen(),
      //   );

      /// Default Case (Unknown Route)
      default:
        return MaterialPageRoute(builder: (_) => const UnknownRouteScreen());
    }
  }
}
