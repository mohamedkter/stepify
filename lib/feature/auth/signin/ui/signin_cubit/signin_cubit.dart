import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/auth/signin/controller/firebase_signin_controller.dart';
import 'package:stepify/feature/auth/signin/ui/signin_cubit/signin_states.dart';

class SigninCubit extends Cubit<SignInStates> {
  SigninCubit() : super(SignInInitialState());

  Future<void> signIn(String email, String password) async {
    emit(SignInLoadingState());
    try {
      if (email.isEmpty || password.isEmpty) {
        emit(SignInErrorState("Email and password cannot be empty"));
      } else {
  
      await  FirebaseSigninController.signInWithEmail(email, password);
        emit(SignInSuccessState("Signin successful"));
      }
    } catch (e) {
      emit(SignInErrorState("An error occurred during signin"));
    }
  }
}