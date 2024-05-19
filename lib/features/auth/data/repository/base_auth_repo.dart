import 'package:dartz/dartz.dart';
import 'package:the_analyzer/features/auth/data/models/login_model.dart';

import '../../../../core/network/errors/failure.dart';

abstract class BaseAuthRepo {
  Future<Either<Failure, String>> signUp(
      {required String email,
      required String userName,
      required String password,
      required String confirmPassword});
  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password});
}
