part of 'correct_password_cubit.dart';

@immutable
abstract class CorrectPasswordState {}

class CorrectPasswordInitial extends CorrectPasswordState {}

class ToggleBetweenShowHidePassword extends CorrectPasswordState {}
