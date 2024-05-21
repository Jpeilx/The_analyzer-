import 'package:dartz/dartz.dart';
import 'package:the_analyzer/core/network/errors/failure.dart';
import 'package:the_analyzer/features/search_vip/data/models/ploting_tabel_model/ploting_tabel_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/presentage_model/presentage_model.dart';
import 'package:the_analyzer/features/search_vip/data/models/tweets_sample_model/tweets_sample_model.dart';

abstract class BaseSearchFreeRepo {
  
  Future<Either<Failure, PresentageModel>> getFreeDataPersentage();
  Future<Either<Failure, PlotingTabelModel>> getFreePlotingTableData();
  Future<Either<Failure, TweetsSampleModel>> getFreeTweetsSample();
  Future<Either<Failure, String>> getFreeNagitaveWordsImage();
  Future<Either<Failure, String>> getFreePositiveWordsImage();
}
