import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:stepify/core/cache/cache_helper.dart';
import 'package:stepify/core/cache/chache_keys.dart';
import 'package:stepify/core/routes/routes.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _onNextPressed(BuildContext context) {
    CacheHelper.saveData(key: CacheKeys.onBoardingVisited, value: true);
    context.go(Routes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Onboard.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 40.h,
            left: 20.w,
            right: 20.w,
            child: CustomButton(
              onPressed: () => _onNextPressed(context),
              color: Theme.of(context).scaffoldBackgroundColor,
              text: "Next",
              textColor: Theme.of(context).textTheme.bodyMedium?.color ??
                  Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
