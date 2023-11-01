import 'package:clean_architecture/0_data/respositories/advice_repo_implementation.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:clean_architecture/1_domain/usercases/advice_usercases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'usercases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImplementaion>()])
void main() {
  group('Advice Usecases', () {
    test(
        'Should Return Advice Entity when AdviceRepoImplementation returns a Advice Model',
        () async {
      final mockAdviceRepositoryImplementation = MockAdviceRepoImplementaion();
      final adviceUseCaseUnderTest =
          AdviceUseCases(adviceRepos: mockAdviceRepositoryImplementation);
      when(mockAdviceRepositoryImplementation.getAdviceFromDataSource())
          .thenAnswer((realInvocation) =>
              Future.value(const Right(AdviceEntity(advice: "test", id: 1))));
      final result = await adviceUseCaseUnderTest.getAdvice();
      expect(result.isLeft(), false);
      expect(result.isRight(), true);
      expect(
          result,
          const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: 'test', id: 1)));
      verify(mockAdviceRepositoryImplementation.getAdviceFromDataSource())
          .called(1);
      // when you want to check if a method was not called tyeh use verifyNever(mock.methodCall) insted of verify(mock.methodCall).called(0)
      verifyNoMoreInteractions(mockAdviceRepositoryImplementation);
    });

    group('Returns Left with Failures', () {
      test('Should Return Left with ServerFailure', () async {
        final mockAdviceRepositoryImplementation =
            MockAdviceRepoImplementaion();
        final adviceUseCaseUnderTest =
            AdviceUseCases(adviceRepos: mockAdviceRepositoryImplementation);
        when(mockAdviceRepositoryImplementation.getAdviceFromDataSource())
            .thenAnswer(
                (realInvocation) => Future.value(Left(ServerFailure())));
        final result = await adviceUseCaseUnderTest.getAdvice();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
        verify(mockAdviceRepositoryImplementation.getAdviceFromDataSource())
            .called(1);
        verifyNoMoreInteractions(mockAdviceRepositoryImplementation);
      });

      test('Should Retunr Left with General Failure', () async {
        final mockAdviceRepositoryImplementation =
            MockAdviceRepoImplementaion();
        final adviceUserCaseUnderTest =
            AdviceUseCases(adviceRepos: mockAdviceRepositoryImplementation);
        when(mockAdviceRepositoryImplementation.getAdviceFromDataSource())
            .thenAnswer(
                (realInvocation) => Future.value(Left(GeneralFailure())));
        final result = await adviceUserCaseUnderTest.getAdvice();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
        verify(mockAdviceRepositoryImplementation.getAdviceFromDataSource())
            .called(1);
        verifyNoMoreInteractions(mockAdviceRepositoryImplementation);
      });
    });
  });
}
