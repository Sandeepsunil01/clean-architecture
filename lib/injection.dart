import 'package:clean_architecture/0_data/data_sources/advice_remote_datasource.dart';
import 'package:clean_architecture/0_data/respositories/advice_repo_implementation.dart';
import 'package:clean_architecture/1_domain/repositories/repos.dart';
import 'package:clean_architecture/1_domain/usercases/advice_usercases.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/adviser_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.I;

Future<void> init() async {
  // Application Layer
  // Factory = every tme a new instance of that class
  serviceLocator
      .registerFactory(() => AdviserCubit(adviceUseCases: serviceLocator()));

  // Register Singleton
  // Inorder to register a singleton then we use the below registerlazysingleton method
  // serviceLocator.registerLazySingleton(() => )

  // Domain Layer
  serviceLocator
      .registerFactory(() => AdviceUseCases(adviceRepos: serviceLocator()));

  // Data Layer
  serviceLocator.registerFactory<AdviceRepos>(
      () => AdviceRepoImplementaion(adviceRemoteDataSource: serviceLocator()));
  serviceLocator.registerFactory<AdviceRemoteDataSource>(
      () => AdviceRemoteDataSourceImpl(client: serviceLocator()));

  // Externs
  serviceLocator.registerFactory(() => http.Client());
}
