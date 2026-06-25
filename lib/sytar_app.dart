import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/routes/app_router.dart";

class SytarApp extends StatelessWidget {
  const SytarApp({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  final AppRouter appRouter;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(366, 815),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MaterialApp(
          builder: (context, widget) {
            return Directionality(textDirection: .rtl, child: widget!);
          },
          theme: ThemeData(useMaterial3: true, fontFamily: "Tajawal"),
          initialRoute: initialRoute,
          onGenerateRoute: appRouter.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
