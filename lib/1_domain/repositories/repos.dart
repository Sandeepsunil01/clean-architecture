import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepos {
  Future<Either<AdviceEntity, Failure>> getAdviceFromDataSource();
}
