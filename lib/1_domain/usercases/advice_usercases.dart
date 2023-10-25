import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:clean_architecture/1_domain/repositories/repos.dart';
import 'package:dartz/dartz.dart';

// This is Functional Programing
class AdviceUseCases {
  AdviceUseCases({required this.adviceRepos});
  final AdviceRepos adviceRepos;

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepos.getAdviceFromDataSource();
    // Add Business Logic Here
  }
}
