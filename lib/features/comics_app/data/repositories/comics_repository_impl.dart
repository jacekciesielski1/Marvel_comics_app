import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/features/comics_app/domain/entities/comics.dart';
import '/features/comics_app/domain/repositories/comics_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/comics_local_data_source.dart';
import '../datasources/comics_remote_data_source.dart';

class ComicsRepositoryImpl implements ComicsRepository {
  final ComicsRemoteDataSource remoteDataSource;
  final ComicsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ComicsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure?, Comics?>>? getComics(String title) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteComics = await remoteDataSource.getComics(title);
        // localDataSource.cacheComics(remoteComics);
        if (remoteComics.data.results.isEmpty) {
          return Left(NoSearchResults());
        } else {
          return Right(remoteComics);
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // try {
      //   final localComics = await localDataSource.getLastComics();
      //   return Right(localComics);
      // } on CacheException {
      return Left(ConnectionFailure());
    }
  }
}
