import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/advice_model.dart';

abstract class AdviceRemoteDataSource {
  /// requests a random device from api
  /// returns [AdiveModel] if successful
  /// throws a server excepeption if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final Client client = http.Client();
  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.flutter-community.com/api/v1/advice"),
      headers: {"content-type": "application/json"},
    );

    final responseBody = json.decode(response.body);
    return AdviceModel.fromJson(responseBody);
  }
}
