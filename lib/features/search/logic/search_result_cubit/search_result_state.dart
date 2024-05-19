part of 'search_result_cubit.dart';

abstract class SearchResultStates {}

class SearchResultInitialState extends SearchResultStates {}

class GetPercentageDataLoadingState extends SearchResultStates {}

class GetPercentageDataSuccessState extends SearchResultStates {}

class GetPercentageDataErrorState extends SearchResultStates {
  final String message;
  GetPercentageDataErrorState(this.message);
}

class GetPlotingTableDataLoadingState extends SearchResultStates {}

class GetPlotingTableDataSuccessState extends SearchResultStates {}

class GetPlotingTableDataErrorState extends SearchResultStates {
  final String message;
  GetPlotingTableDataErrorState(this.message);
}

class GetTweetsSampleDataLoadingState extends SearchResultStates {}

class GetTweetsSampleDataSuccessState extends SearchResultStates {}

class GetTweetsSampleDataErrorState extends SearchResultStates {
  final String message;
  GetTweetsSampleDataErrorState(this.message);
}

class GetPositaveWorrdsImagesLoadingState extends SearchResultStates {}

class GetPositaveWorrdsImagesSuccessState extends SearchResultStates {}

class GetPositaveWorrdsImagesErrorState extends SearchResultStates {
  final String message;
  GetPositaveWorrdsImagesErrorState(this.message);
}

class GetNegativeWorrdsImagesLoadingState extends SearchResultStates {}

class GetNegativeWorrdsImagesSuccessState extends SearchResultStates {}

class GetNegativeWorrdsImagesErrorState extends SearchResultStates {
  final String message;
  GetNegativeWorrdsImagesErrorState(this.message);
}
