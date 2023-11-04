import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:clean_architecture/1_domain/usercases/advice_usercases.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/adviser_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group('Adviser Cubit', () {
    MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();
    blocTest(
      'Returns nothing when no method was called ',
      build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
      expect: () => const <AdviserCubitState>[],
    );

    blocTest(
      '[AdviserStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
      build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
      setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
        (invocation) => Future.value(
          const Right<Failure, AdviceEntity>(
            AdviceEntity(advice: 'advice', id: 1),
          ),
        ),
      ),
      act: (cubit) => cubit.adviceRequested(),
      expect: () => const <AdviserCubitState>[
        AdviserCubitStateLoading(),
        AdviserCubitStateLoaded(advice: 'advice')
      ],
    );

    blocTest(
      '[AdviserStateLoading, AdviserStateError] returns ServerFailureMessage when adviceRequested() is called',
      build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
      setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
        (invocation) => Future.value(
          Left<Failure, AdviceEntity>(
            ServerFailure(),
          ),
        ),
      ),
      act: (cubit) => cubit.adviceRequested(),
      expect: () => const <AdviserCubitState>[
        AdviserCubitStateLoading(),
        AdviserCubitStateError(errorMessage: serverFailureMessage)
      ],
    );

    blocTest(
      '[AdviserStateLoading, AdviserStateError] returns CacheFailureMessage when adviceRequested() is called',
      build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
      setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
        (invocation) => Future.value(
          Left<Failure, AdviceEntity>(
            CacheFailure(),
          ),
        ),
      ),
      act: (cubit) => cubit.adviceRequested(),
      expect: () => const <AdviserCubitState>[
        AdviserCubitStateLoading(),
        AdviserCubitStateError(errorMessage: cacheFailureMessage)
      ],
    );

    blocTest(
      '[AdviserStateLoading, AdviserStateError] returns GeneralFailureMessage when adviceRequested() is called',
      build: () => AdviserCubit(adviceUseCases: mockAdviceUseCases),
      setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
        (invocation) => Future.value(
          Left<Failure, AdviceEntity>(GeneralFailure()),
        ),
      ),
      act: (cubit) => cubit.adviceRequested(),
      expect: () => const <AdviserCubitState>[
        AdviserCubitStateLoading(),
        AdviserCubitStateError(errorMessage: generalFailureMessage)
      ],
    );
  });
}
