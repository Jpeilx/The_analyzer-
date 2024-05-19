import 'package:dartz/dartz.dart';
import 'package:the_analyzer/core/network/errors/failure.dart';
import 'package:the_analyzer/core/network/errors/network_exceptions.dart';
import 'package:the_analyzer/core/network/remote/dio_helper/dio_helper.dart';
import 'package:the_analyzer/core/network/remote/end_points.dart';
import 'package:the_analyzer/features/auth/data/models/login_model.dart';
import 'package:the_analyzer/features/auth/data/repository/base_auth_repo.dart';

class AuthRepe extends BaseAuthRepo {
  @override
  Future<Either<Failure, String>> signUp(
      {required String email,
      required String userName,
      required String password,
      required String confirmPassword}) async {
    try {
      var response =
          await DioHelper.postdata(endPoint: EndPoints.register, data: {
        "email": email,
        "password": password,
        "userName": userName,
        "cPassword": confirmPassword
      });
  print(response.data);
 
     return Right(response.data["message"]);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password}) async {
    try {
      var response = await DioHelper.postdata(endPoint: EndPoints.login, data: {
        "email": email,
        "password": password,
      });
      LoginModel loginData = LoginModel.fromJson(response.data) ;

      return Right(loginData);
    } catch (error) {
      print(error);
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
