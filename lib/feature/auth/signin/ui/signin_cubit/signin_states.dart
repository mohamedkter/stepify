abstract class SignInStates {}
class SignInInitialState extends SignInStates {}
class SignInLoadingState extends SignInStates {}
class SignInSuccessState extends SignInStates {
  final String message;
  SignInSuccessState(this.message);
}
class SignInErrorState extends SignInStates {
  final String error;
  SignInErrorState(this.error);
} 