import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/features/search_free/data/repository/base_search_results_repo.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_state.dart';
import 'package:the_analyzer/features/search_vip/data/models/ploting_tabel_model/ploting_tabel_model.dart';

import 'package:the_analyzer/features/search_vip/data/models/presentage_model/presentage_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/tweets_sample_model/tweets_sample_model.dart';



class FreeSearchResultCubit extends Cubit<FreeSearchResultStates> {
  BaseSearchFreeRepo searchResultsRepo;
  FreeSearchResultCubit(this.searchResultsRepo) : super(SearchFreeResultInitialState());
  static FreeSearchResultCubit get(context) => BlocProvider.of(context);

  PresentageModel? presentageDataFree;
  Future<void> getPercetageDataFree() async {
    emit(GetPercentageDataFreeLoadingState());
    var response = await searchResultsRepo.getFreeDataPersentage();
    response.fold((failure) {
      emit(GetPercentageDataFreeErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (presentageDataFree) {
      this.presentageDataFree = presentageDataFree;
      emit(GetPercentageDataFreeSuccessState());
    });
  }

  PlotingTabelModel? plotingTabelDataFree;
  Future<void> getPlotingTableDataFree() async {
    emit(GetPlotingTableDataFreeLoadingState());
    var response = await searchResultsRepo.getFreePlotingTableData();
    response.fold((failure) {
      emit(GetPlotingTableDataFreeErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (plotingTabelDataFree) {
      print(plotingTabelDataFree);
      this.plotingTabelDataFree = plotingTabelDataFree;
      emit(GetPlotingTableDataFreeSuccessState());
    });
  }

  TweetsSampleModel? tweetsSampleDataFree;
  Future<void> getTweetsSampleDataFree() async {
    emit(GetTweetsSampleDataFreeLoadingState());
    var response = await searchResultsRepo.getFreeTweetsSample();
    response.fold((failure) {
      emit(GetTweetsSampleDataFreeErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (tweetsSampleDataFree) {
      this.tweetsSampleDataFree = tweetsSampleDataFree;
      emit(GetTweetsSampleDataFreeSuccessState());
    });
  }

  String? positiveImageUrl;
  Future<void> getPositiveWordsImage() async {
    emit(GetFreePositaveWorrdsImagesLoadingState());
    var response = await searchResultsRepo.getFreePositiveWordsImage();
    response.fold((failure) {
      emit(GetFreePositaveWorrdsImagesErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (positiveImageUrl) {
      print(positiveImageUrl);
      this.positiveImageUrl = positiveImageUrl;
      emit(GetFreePositaveWorrdsImagesSuccessState());
    });
  }

  String? negativeImageUrl;
  Future<void> getNegativeWordsImage() async {
    emit(GetFreeNegativeWorrdsImagesLoadingState());
    var response = await searchResultsRepo.getFreeNagitaveWordsImage();
    response.fold((failure) {
      emit(GetFreeNegativeWorrdsImagesErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (negativeImageUrl) {
      print(negativeImageUrl) ;
      this.negativeImageUrl = negativeImageUrl;
      emit(GetFreeNegativeWorrdsImagesSuccessState());
    });
  }
}
