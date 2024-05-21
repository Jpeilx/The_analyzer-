import 'package:dartz/dartz.dart';
import 'package:the_analyzer/core/network/errors/failure.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/core/network/remote/dio_helper/dio_helper.dart';
import 'package:the_analyzer/core/network/remote/end_points.dart';
import 'package:the_analyzer/features/search_free/data/repository/base_search_results_repo.dart';
import 'package:the_analyzer/features/search_vip/data/models/ploting_tabel_model/ploting_tabel_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/presentage_model/presentage_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/tweets_sample_model/tweets_sample_model.dart';

class SearchFreeRepo extends BaseSearchFreeRepo {
 

  @override
  Future<Either<Failure, PresentageModel>> getFreeDataPersentage() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getFreeDataPercentage);

      PresentageModel presentageModel =
          PresentageModel.fromJson(response.data[0]);
      return Right(presentageModel);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, PlotingTabelModel>> getFreePlotingTableData() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getFreeDataPlotingTable);
      print(response.data);
      PlotingTabelModel plotingTabelModel =
          PlotingTabelModel.fromJson(response.data[0]);
      return Right(plotingTabelModel);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, TweetsSampleModel>> getFreeTweetsSample() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getFreeTweetsSample);

      TweetsSampleModel tweetsSampleModel =
          TweetsSampleModel.fromJson(response.data[0]);
      return Right(tweetsSampleModel);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, String>> getFreeNagitaveWordsImage() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getFreeNegativeWordsImages);

      return Right(response.data["imageUrl"]);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, String>> getFreePositiveWordsImage() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getFreeNegativeWordsImages);
      return Right(response.data["imageUrl"]);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
