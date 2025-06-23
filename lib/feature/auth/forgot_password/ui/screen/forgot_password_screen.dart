import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/arrow_back_icon_button.dart';
import 'package:stepify/core/utils/widget/custom_auth_text_input_field.dart';
import 'package:stepify/core/utils/widget/custom_auth_label.dart';
import 'package:stepify/core/utils/widget/custom_auth_title.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController for the email field
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 90.h),
            ArrowBackIconButton(onPressed: () => context.go('/signin')),
            const SizedBox(height: 20),
            const CustomAuthTitle(
              title: 'Forgot Password',
            ),
            const SizedBox(height: 10),
            const CustomAuthLabel(
              label: 'Enter your email address to reset your password',
            ),
            const SizedBox(height: 20),
            CustomAuthTextInputField(
              hintText: 'xyz@gmail.com',
              label: 'Email Address',
              controller: emailController,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Reset Password',
              onPressed: () {},
              color: ColorsManager.primaryColor,
              textColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
