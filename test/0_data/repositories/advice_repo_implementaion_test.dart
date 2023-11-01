import 'dart:io';

import 'package:clean_architecture/0_data/data_sources/advice_remote_datasource.dart';
import 'package:clean_architecture/0_data/exceptions/exceptions.dart';
import 'package:clean_architecture/0_data/models/advice_model.dart';
import 'package:clean_architecture/0_data/respositories/advice_repo_implementation.dart';
import 'package:clean_architecture/1_domain/entities/advice_entity.dart';
import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advice_repo_implementaion_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group("Advice Repository Impelemenation", () {
    test('Advice Remote Datasource returns a AdviceModel', () async {
      final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
      final adviceRepositoryImplementationUnderTest = AdviceRepoImplementaion(
          adviceRemoteDataSource: mockAdviceRemoteDataSource);
      when(mockAdviceRemoteDataSource.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) =>
              Future.value(const AdviceModel(advice: 'test', id: 1)));
      final result = await adviceRepositoryImplementationUnderTest
          .getAdviceFromDataSource();
      expect(result.isLeft(), false);
      expect(result.isRight(), true);
      expect(
          result,
          const Right<Failure, AdviceModel>(
              AdviceModel(advice: 'test', id: 1)));
      verify(mockAdviceRemoteDataSource.getRandomAdviceFromApi()).called(1);
      verifyNoMoreInteractions(mockAdviceRemoteDataSource);
    });

    group('Advice Repositories Excpetion Implementation', () {
      test(
          'Advice Remote Datasource returns a Server failure when server exception occurs',
          () async {
        final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
        final adviceRepositoryImplementationUnderTest = AdviceRepoImplementaion(
            adviceRemoteDataSource: mockAdviceRemoteDataSource);
        when(mockAdviceRemoteDataSource.getRandomAdviceFromApi())
            .thenThrow(ServerExceptions());
        final result = await adviceRepositoryImplementationUnderTest
            .getAdviceFromDataSource();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });

      test(
          'Advice Remote Datasource returns a General failure when any other exception occurs',
          () async {
        final mockAdviceRemoteDataSource = MockAdviceRemoteDataSourceImpl();
        final adviceRepositoryImplementationUnderTest = AdviceRepoImplementaion(
            adviceRemoteDataSource: mockAdviceRemoteDataSource);
        when(mockAdviceRemoteDataSource.getRandomAdviceFromApi())
            .thenThrow(const SocketException('test'));
        final result = await adviceRepositoryImplementationUnderTest
            .getAdviceFromDataSource();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
      });
    });
  });
}
