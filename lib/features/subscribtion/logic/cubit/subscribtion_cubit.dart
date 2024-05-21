import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/features/subscribtion/data/repository/base_sub_rebo.dart';
import 'package:the_analyzer/features/subscribtion/logic/cubit/subscribtion_state.dart';

class SubscribtionCubit extends Cubit<SubscribtionStates> {
  BaseSubRebo subRebo;
  SubscribtionCubit(this.subRebo) : super(SubscribtionInitalState());

  Future<void> createSub() async {
    emit(CreateSubLoadingState());
    var response = await subRebo.createSub();
    response.fold((failure) {
      emit(CreateSubErrortate(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (plotingTabelData) {
    
      emit(CreateSubSuccesState());
    });
  }
}
