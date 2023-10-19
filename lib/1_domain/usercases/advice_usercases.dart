import 'package:clean_architecture/0_data/respositories/advice_repo_implementation.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:dartz/dartz.dart';

// This is Functional Programing
class AdviceUseCases {
  final adviceRepo = AdviceRepoImplementaion();

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
    // Add Business Logic Here
  }
}
