import 'package:dartz/dartz.dart';
import 'package:the_analyzer/core/network/errors/failure.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/core/network/remote/dio_helper/dio_helper.dart';
import 'package:the_analyzer/core/network/remote/end_points.dart';
import 'package:the_analyzer/features/search_vip/data/models/ploting_tabel_model/ploting_tabel_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/presentage_model/presentage_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/tweets_sample_model/tweets_sample_model.dart';
import 'package:the_analyzer/features/search_vip/data/repository/base_search_results_repo.dart';

class SearchRepo extends BaseSearchRepo {
  @override
  Future<Either<Failure, bool>> searchAboutProduct(
      {required String searchData}) async {
    try {
      var response = await DioHelper.postdata(
          endPoint: EndPoints.searchAboutProduct, data: {"topic": searchData});

      return Right(true);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, PresentageModel>> getDataPersentage() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getDataPercentage);

      PresentageModel presentageModel =
          PresentageModel.fromJson(response.data[0]);
      return Right(presentageModel);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, PlotingTabelModel>> getPlotingTableData() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getDataPlotingTable);
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
  Future<Either<Failure, TweetsSampleModel>> getTweetsSample() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getTweetsSample);

      TweetsSampleModel tweetsSampleModel =
          TweetsSampleModel.fromJson(response.data[0]);
      return Right(tweetsSampleModel);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, String>> getPositiveWordsImage() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getPositveWordsImages);

      return Right(response.data["imageUrl"]);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, String>> geyNagitaveWordsImage() async {
    try {
      var response =
          await DioHelper.getdata(endPoint: EndPoints.getNegativeWordsImages);
      return Right(response.data["imageUrl"]);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
