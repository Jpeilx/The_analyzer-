  import 'package:dartz/dartz.dart';
import 'package:the_analyzer/core/network/errors/failure.dart';

abstract class  BaseSubRebo  {
  Future<Either<Failure, String >> createSub();
}