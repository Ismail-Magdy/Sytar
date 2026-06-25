import 'package:flutter/material.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/widgets/unknown_route_screen.dart';
import 'package:sytar/features/auth/login/presentation/screens/login_screen.dart';
import 'package:sytar/features/auth/sign_up/presentation/screens/signup_screen.dart';
import 'package:sytar/features/auth/welcome/presentation/welcome_auth_screen.dart';
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

      /// Welcome AuthScreen
      case Routes.welcomeAuthScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeAuthScreen());

      /// login Screen
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      /// signup Screen
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      /// Default Case (Unknown Route)
      default:
        return MaterialPageRoute(builder: (_) => const UnknownRouteScreen());
    }
  }
}
