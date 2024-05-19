import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/features/search/data/repository/base_search_results_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  static SearchCubit get(context) => BlocProvider.of(context);
  BaseSearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(SearchInitialState());

  Future<void> searchAboutProduct({required String searchData}) async {
    emit(MakeSearchLoadingState());
    var response = await searchRepo.searchAboutProduct(searchData: searchData);
    response.fold((failure) {
      emit(MakeSearchErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (plotingTabelData) {
      Future.delayed(Duration(seconds: 20)).then((value) {
        emit(MakeSearchSuccessState());
      },);
      
    });
  }
}
