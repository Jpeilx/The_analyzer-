import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/features/search_vip/data/repository/base_search_results_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  static SearchCubit get(context) => BlocProvider.of(context);
  BaseSearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(SearchInitialState());
  bool isVIP = false ; 
  void changeToVIP(){
    isVIP = true ; 
    emit(ChangeFromVIP()) ;
  }


  Future<void> searchAboutProduct({required String searchData}) async {
    emit(MakeSearchLoadingState());
    var response = await searchRepo.searchAboutProduct(searchData: searchData);
    response.fold((failure) {
      emit(MakeSearchErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (plotingTabelData) {
      Future.delayed(Duration(seconds:60 )).then((value) {
        emit(MakeSearchSuccessState());
      },);
      
    });
  }
}
