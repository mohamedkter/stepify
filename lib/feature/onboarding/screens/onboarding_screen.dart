import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/cache/cache_helper.dart';
import 'package:stepify/core/cache/chache_keys.dart';
import 'package:stepify/core/routes/routes.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    String onboardingImage = "assets/images/Onboard.png";
    void toSignin() {
      context.go(Routes.signIn);
    }

    void onBoardingVisited() {
      CacheHelper.saveData(key: CacheKeys.onBoardingVisited, value: true);
    }

    return Scaffold(
        backgroundColor: ColorsManager.primaryColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      onboardingImage,
                    ),
                  )),
            ),
            Positioned(
                bottom: 40.h,
                left: 20.w,
                right: 20.w,
                child: CustomButton(
                  onPressed: () {
                    onBoardingVisited();
                    toSignin();
                  },
                  color: Theme.of(context).scaffoldBackgroundColor,
                  text: "Next",
                  textColor: Theme.of(context).textTheme.bodyMedium!.color ??
                      Colors.black,
                ))
          ],
        ));
  }
}
