import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/firebase/firebase_service.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/arrow_back_icon_button.dart';
import 'package:stepify/core/utils/widget/custom_auth_label.dart';
import 'package:stepify/core/utils/widget/custom_auth_title.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';
import 'package:stepify/feature/auth/email_verification/controller/email_verification_controller.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    _sendVerificationEmail();
    _startInterval();
  }

  // Starts the timer and updates every second
  void _startInterval() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds < 60) {
        setState(() {
          seconds++;
        });
      } else {
        timer.cancel();
      }

      _checkEmailVerification(timer);
    });
  }

  // Function to check if the email is verified
  Future<void> _checkEmailVerification(Timer timer) async {
    bool isVerified = await FirebaseService.isEmailVerified();
    if (isVerified) {
      timer.cancel();
      context.go('/home');
    }
  }

  // Function to resend the verification email
  Future<void> _sendVerificationEmail() async {
    await EmailVerificationController.sendVerificationEmail();
    setState(() {
      seconds = 0;
    });
    _startInterval();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 90.h),
            ArrowBackIconButton(onPressed: () => context.pop()),
            const SizedBox(height: 20),
            const CustomAuthTitle(
              title: 'Check Your Email',
            ),
            const SizedBox(height: 10),
            const CustomAuthLabel(
              label:
                  "We’ve sent a verification link to your email address. Please check your inbox and activate your account to continue.",
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: seconds < 60
                  ? "Didn't receive the link? Resend after 60 seconds"
                  : "Didn't receive the link? Resend",
              onPressed: seconds >= 60
                  ? _sendVerificationEmail
                  : null, // Only allow resend after 60 seconds
              color: ColorsManager.primaryColor,
              textColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
