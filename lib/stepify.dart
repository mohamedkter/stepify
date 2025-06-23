import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/routes/router.dart';
import 'package:stepify/core/themes/colors.dart';

class Stepify extends StatelessWidget {
  const Stepify({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        title: 'Stepfiy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorsManager.primaryColor),
          useMaterial3: true,
          primaryColor: ColorsManager.primaryColor,
          scaffoldBackgroundColor: ColorsManager.backgroundColor,
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              backgroundColor: ColorsManager.secondaryColor,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: ColorsManager.secondaryColor,
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 32,
              height: 34 / 32,
              fontWeight: FontWeight.bold,
              color: ColorsManager.textColor,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 26,
              height: 20 / 26,
              fontWeight: FontWeight.w600,
              color: ColorsManager.textColor,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: ColorsManager.textColor,
            ),
            bodySmall: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: ColorsManager.textColor,
            ),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
