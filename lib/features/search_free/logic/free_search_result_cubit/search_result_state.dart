

abstract class FreeSearchResultStates {}

class SearchFreeResultInitialState extends FreeSearchResultStates {}

class GetPercentageDataFreeLoadingState extends FreeSearchResultStates {}

class GetPercentageDataFreeSuccessState extends FreeSearchResultStates {}

class GetPercentageDataFreeErrorState extends FreeSearchResultStates {
  final String message;
  GetPercentageDataFreeErrorState(this.message);
}

class GetPlotingTableDataFreeLoadingState extends FreeSearchResultStates {}

class GetPlotingTableDataFreeSuccessState extends FreeSearchResultStates {}

class GetPlotingTableDataFreeErrorState extends FreeSearchResultStates {
  final String message;
  GetPlotingTableDataFreeErrorState(this.message);
}

class GetTweetsSampleDataFreeLoadingState extends FreeSearchResultStates {}

class GetTweetsSampleDataFreeSuccessState extends FreeSearchResultStates {}

class GetTweetsSampleDataFreeErrorState extends FreeSearchResultStates {
  final String message;
  GetTweetsSampleDataFreeErrorState(this.message);
}

class GetFreePositaveWorrdsImagesLoadingState extends FreeSearchResultStates {}

class GetFreePositaveWorrdsImagesSuccessState extends FreeSearchResultStates {}

class GetFreePositaveWorrdsImagesErrorState extends FreeSearchResultStates {
  final String message;
  GetFreePositaveWorrdsImagesErrorState(this.message);
}

class GetFreeNegativeWorrdsImagesLoadingState extends FreeSearchResultStates {}

class GetFreeNegativeWorrdsImagesSuccessState extends FreeSearchResultStates {}

class GetFreeNegativeWorrdsImagesErrorState extends FreeSearchResultStates {
  final String message;
  GetFreeNegativeWorrdsImagesErrorState(this.message);
}
