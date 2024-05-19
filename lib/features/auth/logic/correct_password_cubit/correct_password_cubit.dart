import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'correct_password_state.dart';

class CorrectPasswordCubit extends Cubit<CorrectPasswordState> {
  CorrectPasswordCubit() : super(CorrectPasswordInitial());

  static CorrectPasswordCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int correctPassword = 0;
  changeCorrectPassword(int status) {
    correctPassword = status;
    emit(CorrectPasswordInitial());
  }

  String? textPassword;

  changeTextPassword(String text) {
    textPassword = text;
    emit(CorrectPasswordInitial());
  }

  bool showPassowrd = true;
  changeShowPassword() {
    showPassowrd = !showPassowrd;
    emit(ToggleBetweenShowHidePassword());
  }
}
