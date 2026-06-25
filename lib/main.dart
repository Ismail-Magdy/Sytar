import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/routes/app_router.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/firebase_options.dart';
import 'package:sytar/sytar_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initGetIt();

  await ScreenUtil.ensureScreenSize();

  String initialRoute = Routes.splashScreen;
  runApp(SytarApp(appRouter: AppRouter(), initialRoute: initialRoute));
}
