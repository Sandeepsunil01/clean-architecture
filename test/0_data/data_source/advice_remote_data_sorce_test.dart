import 'dart:convert';

import 'package:clean_architecture/0_data/data_sources/advice_remote_datasource.dart';
import 'package:clean_architecture/0_data/exceptions/exceptions.dart';
import 'package:clean_architecture/0_data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advice_remote_data_sorce_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('Advice Remote Data Source', () {
    group('Should return advice model', () {
      final mockClient = MockClient();
      test('When Client reponse was 200', () async {
        final adviceRemoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = {'advice': 'test_advice', 'advice_id': 2};
        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {"content-type": "application/json"},
        )).thenAnswer((realInvocation) =>
            Future.value(Response(json.encode(responseBody), 200)));
        final result =
            await adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi();
        expect(result, const AdviceModel(advice: 'test_advice', id: 2));
      });
    });

    group('Should Throw Error', () {
      final mockClient = MockClient();
      test('server exception when status code is not 200', () {
        final adviceRemoteSourceDataUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {"content-type": "application/json"},
        )).thenAnswer(
            (realInvocation) => Future.value(Response(json.encode(''), 201)));

        expect(() => adviceRemoteSourceDataUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<ServerExceptions>()));
      });

      test('A type error when client response was 200 with invalid data', () {
        final adviceRemoteSourceDataUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = {'advice': 'test_advice'};

        when(mockClient.get(
          Uri.parse('https://api.flutter-community.com/api/v1/advice'),
          headers: {"content-type": "application/json"},
        )).thenAnswer((realInvocation) =>
            Future.value(Response(json.encode(responseBody), 200)));

        expect(() => adviceRemoteSourceDataUnderTest.getRandomAdviceFromApi(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
