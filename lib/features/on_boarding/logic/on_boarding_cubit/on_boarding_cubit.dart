import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/constant/assets_data.dart';
import 'package:the_analyzer/features/on_boarding/model/onboarding_model.dart';
part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  List<OnBoardingModel> listDataOnBoarding = const [
    OnBoardingModel(
      imagePath: AssetsData.onboarding1Image,
      title: 'Garden Design',
      desc:
          'Lorem ipsum dolor sit amet consectetur. Aliquet consequat habitant pharetra maecenas egestas iaculis. Nec volutpat nunc quis at. Quam.',
    ),
    OnBoardingModel(
      imagePath: AssetsData.onboarding2Image,
      title: 'Garden Design1',
      desc:
          'Lorem ipsum dolor sit amet consectetur. Aliquet consequat habitant pharetra maecenas egestas iaculis. Nec volutpat nunc quis at. Quam.',
    ),
    OnBoardingModel(
      imagePath: AssetsData.onboarding3Image,
      title: 'Garden Design2',
      desc:
          'Lorem ipsum dolor sit amet consectetur. Aliquet consequat habitant pharetra maecenas egestas iaculis. Nec volutpat nunc quis at. Quam.',
    ),
  ];

  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  int indexListOnBoarding = 0;
  changeIndexPageView(int index) {
    indexListOnBoarding = index;
    emit(OnBoardingInitial());
  }

  int indexSelectedButton = 0;
  changeSelectButton(int index) {
    indexSelectedButton = index;
    emit(OnBoardingInitial());
  }
}
