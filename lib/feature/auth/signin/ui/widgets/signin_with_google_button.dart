import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(335.w, 50.h),
            elevation: 0,
            backgroundColor: ColorsManager.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/google.png"),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(width: 10),
              Text(
                "Sign In with Google",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
              ),
            ],
          )),
    );
  }
}
