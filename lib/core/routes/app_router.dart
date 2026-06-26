import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/widgets/unknown_route_screen.dart';
import 'package:sytar/features/auth/forgot_password/manager/forgot_password_bloc.dart';
import 'package:sytar/features/auth/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:sytar/features/auth/login/manager/login_bloc.dart';
import 'package:sytar/features/auth/login/presentation/screens/login_screen.dart';
import 'package:sytar/features/auth/sign_up/manager/signup_bloc.dart';
import 'package:sytar/features/auth/sign_up/presentation/screens/signup_screen.dart';
import 'package:sytar/features/auth/welcome/presentation/welcome_auth_screen.dart';
import 'package:sytar/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:sytar/features/root/screens/root_screen.dart';
import 'package:sytar/features/setup_profile/manager/setup_profile_bloc.dart';
import 'package:sytar/features/setup_profile/presentation/screens/setup_profile_screen.dart';
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

      /// Login Screen
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginBloc>(),
            child: const LoginScreen(),
          ),
        );

      /// Signup Screen
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupBloc>(),
            child: const SignupScreen(),
          ),
        );

      /// Forgot Password Screen
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordBloc>(),
            child: const ForgotPasswordScreen(),
          ),
        );

      /// setup Profile Screen
      case Routes.setupProfileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SetupProfileBloc>(),
            child: const SetupProfileScreen(),
          ),
        );

      /// Root Screen
      case Routes.rootScreen:
        return MaterialPageRoute(builder: (_) => const RootScreen());

      /// Default Case (Unknown Route)
      default:
        return MaterialPageRoute(builder: (_) => const UnknownRouteScreen());
    }
  }
}
