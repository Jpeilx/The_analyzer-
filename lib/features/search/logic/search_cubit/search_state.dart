part of 'search_cubit.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class MakeSearchLoadingState extends SearchStates {}

class MakeSearchErrorState extends SearchStates {
  String message;
  MakeSearchErrorState(this.message);
}

class MakeSearchSuccessState extends SearchStates {}
