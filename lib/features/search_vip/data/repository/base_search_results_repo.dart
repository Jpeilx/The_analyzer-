import 'package:dartz/dartz.dart';
import 'package:the_analyzer/core/network/errors/failure.dart';
import 'package:the_analyzer/features/search_vip/data/models/ploting_tabel_model/ploting_tabel_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/presentage_model/presentage_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/tweets_sample_model/tweets_sample_model.dart';

abstract class BaseSearchRepo {
  Future<Either<Failure, bool>> searchAboutProduct(
      {required String searchData});
  Future<Either<Failure, PresentageModel>> getDataPersentage();
  Future<Either<Failure, PlotingTabelModel>> getPlotingTableData();
  Future<Either<Failure, TweetsSampleModel>> getTweetsSample();
  Future<Either<Failure, String>> geyNagitaveWordsImage();
  Future<Either<Failure, String>> getPositiveWordsImage();
}
