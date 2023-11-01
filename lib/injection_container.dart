import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '/core/network/network_info.dart';
import '/features/comics_app/data/datasources/comics_local_data_source.dart';
import '/features/comics_app/data/datasources/comics_remote_data_source.dart';
import '/features/comics_app/data/repositories/comics_repository_impl.dart';
import '/features/comics_app/domain/repositories/comics_repository.dart';
import '/features/comics_app/domain/usecases/get_comics.dart';
import '/features/comics_app/presentation/bloc/comics_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
// FEATURES- Comics
  sl.registerFactory<ComicsBloc>(() => ComicsBloc(sl()));
// Use cases
  sl.registerLazySingleton<GetComics>(() => GetComics(sl()));
//repository
  sl.registerLazySingleton<ComicsRepository>(() => ComicsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
//Data sources
  sl.registerLazySingleton<ComicsRemoteDataSource>(
      () => ComicsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ComicsLocalDataSource>(
      () => ComicsLocalDataSourceImpl(sharedPreferences: sl()));
//CORE
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//EXTERNAL
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
