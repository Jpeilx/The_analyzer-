import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/features/search_vip/data/models/ploting_tabel_model/ploting_tabel_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/presentage_model/presentage_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/tweets_sample_model/tweets_sample_model.dart';
import 'package:the_analyzer/features/search_vip/data/repository/base_search_results_repo.dart';

part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultStates> {
  BaseSearchRepo searchResultsRepo;
  SearchResultCubit(this.searchResultsRepo) : super(SearchResultInitialState());
  static SearchResultCubit get(context) => BlocProvider.of(context);

  PresentageModel? presentageData;
  Future<void> getPercetageData() async {
    emit(GetPercentageDataLoadingState());
    var response = await searchResultsRepo.getDataPersentage();
    response.fold((failure) {
      emit(GetPercentageDataErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (presentageData) {
      this.presentageData = presentageData;
      emit(GetPercentageDataSuccessState());
    });
  }

  PlotingTabelModel? plotingTabelData;
  Future<void> getPlotingTableData() async {
    emit(GetPlotingTableDataLoadingState());
    var response = await searchResultsRepo.getPlotingTableData();
    response.fold((failure) {
      emit(GetPlotingTableDataErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (plotingTabelData) {
      print(plotingTabelData);
      this.plotingTabelData = plotingTabelData;
      emit(GetPlotingTableDataSuccessState());
    });
  }

  TweetsSampleModel? tweetsSampleData;
  Future<void> getTweetsSampleData() async {
    emit(GetTweetsSampleDataLoadingState());
    var response = await searchResultsRepo.getTweetsSample();
    response.fold((failure) {
      emit(GetTweetsSampleDataErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (tweetsSampleData) {
      this.tweetsSampleData = tweetsSampleData;
      emit(GetTweetsSampleDataSuccessState());
    });
  }

  String? positiveImageUrl;
  Future<void> getPositiveWordsImage() async {
    emit(GetPositaveWorrdsImagesLoadingState());
    var response = await searchResultsRepo.getPositiveWordsImage();
    response.fold((failure) {
      emit(GetPositaveWorrdsImagesErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (positiveImageUrl) {
      this.positiveImageUrl = positiveImageUrl;
      emit(GetPositaveWorrdsImagesSuccessState());
    });
  }

  String? negativeImageUrl;
  Future<void> getNegativeWordsImage() async {
    emit(GetNegativeWorrdsImagesLoadingState());
    var response = await searchResultsRepo.geyNagitaveWordsImage();
    response.fold((failure) {
      emit(GetNegativeWorrdsImagesErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (negativeImageUrl) {
      this.negativeImageUrl = negativeImageUrl;
      emit(GetNegativeWorrdsImagesSuccessState());
    });
  }
}
