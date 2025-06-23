import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/auth/signup/controller/firebase_signup_controller.dart';
import 'package:stepify/feature/auth/signup/models/signup_user_model.dart';
import 'package:stepify/feature/auth/signup/ui/signup_cubit/signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());

  Future<void> signup(String name,String email, String password) async {
    emit(SignupLoadingState());
    try {
        if (email.isEmpty || password.isEmpty) {
          emit(SignupErrorState("Email and password cannot be empty"));
        } else {
         await FirebaseSignupController.signup(
            SignupUserModel(
            email: email,
            password: password,
            name: name,)
          );
          emit(SignupSuccessState("Signup successful"));
        }
    } catch (e) {
      emit(SignupErrorState("An error occurred during signup"));
    }
  }
}