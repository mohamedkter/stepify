import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/firebase/firebase_service.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/arrow_back_icon_button.dart';
import 'package:stepify/core/utils/widget/custom_auth_password_input_field.dart';
import 'package:stepify/core/utils/widget/custom_auth_text_input_field.dart';
import 'package:stepify/core/utils/widget/custom_auth_label.dart';
import 'package:stepify/core/utils/widget/custom_auth_title.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';
import 'package:stepify/core/utils/widget/loading.dart';
import 'package:stepify/core/utils/widget/routing_line.dart';
import 'package:stepify/feature/auth/signin/ui/signin_cubit/signin_cubit.dart';
import 'package:stepify/feature/auth/signin/ui/signin_cubit/signin_states.dart';
import 'package:stepify/feature/auth/signin/ui/widgets/recovery_password_button.dart';
import 'package:stepify/feature/auth/signin/ui/widgets/signin_with_google_button.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController for the email field
    final TextEditingController emailController = TextEditingController();

    // TextEditingController for the password field
    final TextEditingController passwordController = TextEditingController();

    // Function to navigate to the Sign Up screen
    void goToSignUp() {
      context.push('/signup');
    }

    Future<void> checkEmailVerification() async {
      bool isVerified = await FirebaseService.isEmailVerified();
      if (isVerified) {
        context.go('/home');
      } else {
        context.push('/emailVerification');
      }
    }

    // Function to handle the Sign In button press
    void signIn() async {
      context.read<SigninCubit>().signIn(
            emailController.text,
            passwordController.text,
          );
    }

    return Scaffold(
      body: BlocBuilder<SigninCubit, SignInStates>(
        builder: (context, state) {
          if (state is SignInLoadingState) {
            return const Loading();
          } else if (state is SignInErrorState) {
            return Center(
              child: Text(
                "${state.error}",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (state is SignInInitialState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 90.h),
                  ArrowBackIconButton(onPressed: () => context.go('/')),
                  const SizedBox(height: 20),
                  const CustomAuthTitle(
                    title: 'Hello Again!',
                  ),
                  const SizedBox(height: 10),
                  const CustomAuthLabel(
                    label: 'Fill your details Or continue with social media',
                  ),
                  const SizedBox(height: 20),
                  CustomAuthTextInputField(
                    hintText: 'xyz@gmail.com',
                    label: 'Email Address',
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomAuthPasswordInputField(
                    hintText: '********',
                    label: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  const RecoveryPasswordButton(),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Sign In',
                    onPressed: signIn,
                    color: ColorsManager.primaryColor,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  const SizedBox(height: 20),
                  const SignInWithGoogleButton(),
                  SizedBox(height: 50.h),
                  RoutingLine(
                    buttonText: "New User?",
                    labelText: "Create Account",
                    onPressed: goToSignUp,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              checkEmailVerification();
            });
            return const SizedBox();
          }
        },
      ),
    );
  }
}
