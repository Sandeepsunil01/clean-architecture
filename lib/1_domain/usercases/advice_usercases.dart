import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:dartz/dartz.dart';

// This is Functional Programing
class AdviceUseCases {
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    // Call a repository to get data (failure or data)
    // Proceed with business logic (manipulate the data)
    await Future.delayed(const Duration(seconds: 3), () {});
    // return right(const AdviceEntity(advice: 'test advice to test blog', id: 0));
    return left(CacheFailure());
  }
}
