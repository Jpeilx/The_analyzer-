part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
    LoginSuccessState();
}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState(this.message);
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String? message;
  RegisterSuccessState(this.message);
}

class RegisterErrorState extends AuthState {
  final String message;
  RegisterErrorState(this.message);
}

class VerifyAccoutLoadingState extends AuthState {}

class VerifyAccoutSuccessState extends AuthState {
  final String? message;
  VerifyAccoutSuccessState(this.message);
}

class VerifyAccoutErrorState extends AuthState {
  final String message;
  VerifyAccoutErrorState(this.message);
}

class ForgetPasswordLoadingState extends AuthState {}

class ForgetPasswordSuccessState extends AuthState {
  final String? message;
  ForgetPasswordSuccessState(this.message);
}

class ForgetPasswordErrorState extends AuthState {
  final String message;
  ForgetPasswordErrorState(this.message);
}

class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {
  final String? message;
  ResetPasswordSuccessState(this.message);
}

class ResetPasswordErrorState extends AuthState {
  final String message;
  ResetPasswordErrorState(this.message);
}
