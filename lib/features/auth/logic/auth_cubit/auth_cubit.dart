import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/features/auth/data/models/login_model.dart';
import 'package:the_analyzer/features/auth/data/repository/base_auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final BaseAuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool showPassowrd = true;
  changeShowPassword() {
    showPassowrd = !showPassowrd;
    emit(AuthInitial());
  }

  bool emailError = false;
  changeStatusEmail(bool status) {
    emailError = status;
    emit(AuthInitial());
  }

  bool passwordError = false;
  changeStatusPassword(bool status) {
    passwordError = status;
    emit(AuthInitial());
  }

  bool usernameError = false;
  changeStatusUsername(bool status) {
    usernameError = status;
    emit(AuthInitial());
  }

  bool passwordConfirmationpError = false;
  changeStatusConfirmationPassword(bool status) {
    passwordConfirmationpError = status;
    emit(AuthInitial());
  }

  void forgetPassword({required String email}) {}

  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    var response = await authRepo.login(email: email, password: password);

    response.fold((failure) {
      emit(LoginErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (loginData) {
    
      emit(LoginSuccessState());
    });
  }

  Future<void> userRegister(
      {required String email,
      required String username,
      required String password,
      required String confirmPassword}) async {
    emit(RegisterLoadingState());
    var response = await authRepo.signUp(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        userName: username);
    response.fold((failure) {
      emit(RegisterErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (message) {
      emit(RegisterSuccessState(message));
    });
  }

  // Future<void> verifyUserAccount({

  //   required String email,
  //   required String code,
  // }) async {
  //   emit(VerifyAccoutLoadingState());
  //   var response =
  //       await authRepo.verifyAccout(email: email, code: code);
  //   response.fold((failure) {
  //     emit(VerifyAccoutErrorState(
  //         NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
  //   }, (message) {
  //     emit(VerifyAccoutSuccessState(message));
  //   });
  // }

  // Future<void> forgetPassword({

  //   required String email,
  // }) async {
  //   emit(ForgetPasswordLoadingState());
  //   var response = await authRepo.forgetPassword( email: email);
  //   response.fold((failure) {
  //     emit(ForgetPasswordErrorState(
  //         NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
  //   }, (message) {
  //     emit(ForgetPasswordSuccessState(message));
  //   });
  // }

  // Future<void> resetPassword({

  //   required  String email,
  //   required String password,
  //   required String confirmPassword,
  // }) async {
  //   emit(ResetPasswordLoadingState());
  //   var response = await authRepo.resetPassword(

  //       email: email,
  //       password: password,
  //       confirmPassword: confirmPassword);
  //   response.fold((failure) {
  //     emit(ResetPasswordErrorState(
  //         NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
  //   }, (message) {
  //     emit(ResetPasswordSuccessState(message));
  //   });
  // }
}
