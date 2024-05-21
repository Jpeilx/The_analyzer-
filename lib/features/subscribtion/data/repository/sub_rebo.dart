import 'package:dartz/dartz.dart';
import 'package:the_analyzer/core/network/errors/failure.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/core/network/remote/dio_helper/dio_helper.dart';
import 'package:the_analyzer/core/network/remote/end_points.dart';
import 'package:the_analyzer/features/subscribtion/data/repository/base_sub_rebo.dart';

class SubRebo extends BaseSubRebo {
  @override
  Future<Either<Failure, String>> createSub() async {
    try {
      var response = await DioHelper.postdata(
          endPoint: EndPoints.createSub,
          data: {"priceId": "price_1PC53QRvtrOwC3vgPChOXpyl"});

      return Right(response.data["url"]);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
