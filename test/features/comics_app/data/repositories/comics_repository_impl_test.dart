import 'package:dartz/dartz.dart';
import 'package:marvel_comics/core/error/exceptions.dart';
import 'package:marvel_comics/core/network/network_info.dart';
import 'package:marvel_comics/features/comics_app/data/datasources/comics_local_data_source.dart';
import 'package:marvel_comics/features/comics_app/data/datasources/comics_remote_data_source.dart';
import 'package:marvel_comics/features/comics_app/data/models/comics_model.dart';
import 'package:marvel_comics/features/comics_app/data/repositories/comics_repository_impl.dart';
import 'package:marvel_comics/features/comics_app/domain/entities/comics.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_comics/core/error/failures.dart';

class MockRemoteDataSource extends Mock implements ComicsRemoteDataSource {}

class MockLocalDataSource extends Mock implements ComicsLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ComicsRepositoryImpl? repository;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp(
    () {
      mockRemoteDataSource = MockRemoteDataSource();
      mockLocalDataSource = MockLocalDataSource();
      mockNetworkInfo = MockNetworkInfo();
      repository = ComicsRepositoryImpl(
          remoteDataSource: mockRemoteDataSource!,
          localDataSource: mockLocalDataSource!,
          networkInfo: mockNetworkInfo!);
    },
  );

  void runTestsOnline(Function body) {
    group(
      "device is online",
      () {
        setUp(
          () {
            //arrange
            when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
          },
        );
        body();
      },
    );
  }

  void runTestsOffline(Function body) {
    group(
      "device is offline",
      () {
        setUp(
          () {
            //arrange
            when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
          },
        );
        body();
      },
    );
  }

  group(
    "getComics",
    () {
      const tComicsTitle = "Deadpool";
      final tComicsModel = ComicsModel(
          code: 200,
          status: "test",
          copyright: "test",
          attributionText: "test",
          attributionHtml: "test",
          etag: "test",
          data: Data(offset: 200, limit: 200, total: 200, count: 200, results: [
            Result(
                id: 200,
                digitalId: 200,
                title: "test",
                issueNumber: 234,
                variantDescription: "test",
                modified: "test",
                isbn: "test",
                upc: "test",
                diamondCode: "test",
                ean: "test",
                issn: "test",
                format: "test",
                pageCount: 234234,
                textObjects: [],
                resourceUri: "test",
                urls: [],
                series: Series(resourceUri: "test", name: "test"),
                variants: [],
                collections: [],
                collectedIssues: [],
                dates: [],
                prices: [],
                thumbnail: Thumbnail(path: "test", extension: "test"),
                images: [],
                creators: Characters(
                    available: 234,
                    collectionUri: "test",
                    items: [],
                    returned: 234),
                characters: Characters(
                    available: 234,
                    collectionUri: "test",
                    items: [],
                    returned: 345),
                stories: Characters(
                    available: 234,
                    collectionUri: "test",
                    items: [],
                    returned: 345),
                events: Characters(
                    available: 234,
                    collectionUri: "test",
                    items: [],
                    returned: 345))
          ]));
      final Comics tComics = tComicsModel;
      test(
        "should check if the device is connected to the internet",
        () async {
          //arrange
          when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
          //act
          repository!.getComics(tComicsTitle);
          //assert
          verify(mockNetworkInfo!.isConnected);
        },
      );

      runTestsOnline(
        () {
          test(
              "should return remote data when call to remote data source is successful",
              () async {
            //arrange
            when(mockRemoteDataSource!.getComics("test"))
                .thenAnswer((_) async => tComicsModel);
            //act
            final result = await repository!.getComics(tComicsTitle);
            //assert
            verify(mockRemoteDataSource!.getComics(tComicsTitle));
            expect(result, equals(Right(tComics)));
          });
          test(
              "should cache the data locally when call to remote data source is successful",
              () async {
            //arrange
            when(mockRemoteDataSource!.getComics("test"))
                .thenAnswer((_) async => tComicsModel);
            //act
            await repository!.getComics(tComicsTitle);
            //assert
            verify(mockRemoteDataSource!.getComics(tComicsTitle));
            verify(mockLocalDataSource!.cacheComics(tComicsModel));
          });
          test(
              "should return server failure when call to remote data source is unsuccessful",
              () async {
            //arrange
            when(mockRemoteDataSource!.getComics("test"))
                .thenThrow(ServerException());
            //act
            final result = await repository!.getComics(tComicsTitle);
            //assert
            verify(mockRemoteDataSource!.getComics(tComicsTitle));
            verifyZeroInteractions(mockLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
        },
      );

      runTestsOffline(
        () {
          test(
              "should return last locally cached data when the cached data is present",
              () async {
            //arrange
            when(mockLocalDataSource!.getLastComics())
                .thenAnswer((_) async => tComicsModel);
            //act
            final result = await repository!.getComics(tComicsTitle);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getLastComics());
            expect(result, equals(Right(tComics)));
          });
          test(
              "should return CacheFailure when there is no cached data present",
              () async {
            //arrange
            when(mockLocalDataSource!.getLastComics())
                .thenThrow(CacheException());
            //act
            final result = await repository!.getComics(tComicsTitle);
            //assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource!.getLastComics());
            expect(result, equals(const Left(CacheFailure)));
          });
        },
      );
    },
  );
}
