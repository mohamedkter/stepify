import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/arrow_back_icon_button.dart';
import 'package:stepify/core/utils/widget/custom_auth_password_input_field.dart';
import 'package:stepify/core/utils/widget/custom_auth_text_input_field.dart';
import 'package:stepify/core/utils/widget/custom_auth_label.dart';
import 'package:stepify/core/utils/widget/custom_auth_title.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';
import 'package:stepify/core/utils/widget/loading.dart';
import 'package:stepify/core/utils/widget/routing_line.dart';
import 'package:stepify/feature/auth/signin/ui/widgets/signin_with_google_button.dart';
import 'package:stepify/feature/auth/signup/models/signup_user_model.dart';
import 'package:stepify/feature/auth/signup/ui/signup_cubit/signup_cubit.dart';
import 'package:stepify/feature/auth/signup/ui/signup_cubit/signup_states.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the SignupUserModel to hold user data
    SignupUserModel user;
    // TextEditingController for the name field
    final TextEditingController nameController = TextEditingController();
    // TextEditingController for the email field
    final TextEditingController emailController = TextEditingController();
    // TextEditingController for the password field
    final TextEditingController passwordController = TextEditingController();

    // Function to navigate to the Sign In screen
    void goToSignIn() {
      context.pop();
    }

    // Function to handle the sign-up process
    void signUp() {
      user = SignupUserModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      context.read<SignupCubit>().signup(user.name, user.email, user.password);
    }

    return Scaffold(
      body: BlocBuilder<SignupCubit, SignupStates>(
        builder: (context, state) {
          if (state is SignupLoadingState) {
            return const Loading(); // Show loading animation while signing up
          } else if (state is SignupErrorState) {
            // Show error message if sign-up fails
            return Center(
              child: Text(
                "${state.error}",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (state is SignupSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.push(
                  '/emailVerification'); // Navigate to email verification screen
            });
            return const SizedBox();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 90.h),
                  ArrowBackIconButton(onPressed: () => context.go('/')),
                  const SizedBox(height: 20),
                  const CustomAuthTitle(
                    title: 'Register Account',
                  ),
                  const SizedBox(height: 10),
                  const CustomAuthLabel(
                    label: 'Fill your details Or continue with social media',
                  ),
                  const SizedBox(height: 20),
                  CustomAuthTextInputField(
                    hintText: 'xxxxxxxx',
                    label: 'Your Name',
                    controller: nameController,
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
                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: signUp,
                    color: ColorsManager.primaryColor,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  const SizedBox(height: 20),
                  const SignInWithGoogleButton(),
                  SizedBox(height: 40.h),
                  RoutingLine(
                    buttonText: "Log In",
                    labelText: "Already Have Account?",
                    onPressed: goToSignIn,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
