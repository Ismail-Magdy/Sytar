import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/helpers/shared_prefrences_helper.dart';
import 'package:sytar/core/routes/app_router.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/firebase_options.dart';
import 'package:sytar/sytar_app.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  //
  await SystemChrome.setPreferredOrientations([.portraitUp]);
  //
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  await initGetIt();
  //
  await ScreenUtil.ensureScreenSize();
  //
  bool isOnboardingViewed = await SharedPrefHelper.getBool(
    "isOnboardingViewed",
  );
  //
  bool isProfileSetupCompleted = await SharedPrefHelper.getBool(
    "isProfileSetupCompleted",
  );
  //
  bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  //
  String initialRoute;

  //
  if (!isOnboardingViewed) {
    initialRoute = Routes.onBoardingScreen;
  } else if (!isLoggedIn) {
    initialRoute = Routes.loginScreen;
  } else if (!isProfileSetupCompleted) {
    initialRoute = Routes.setupProfileScreen;
  } else {
    initialRoute = Routes.rootScreen;
  }

  runApp(SytarApp(appRouter: AppRouter(), initialRoute: initialRoute));
}
