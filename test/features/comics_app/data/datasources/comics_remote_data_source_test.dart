import 'dart:convert';
import 'package:marvel_comics/core/error/exceptions.dart';
import 'package:marvel_comics/features/comics_app/data/datasources/comics_remote_data_source.dart';
import 'package:marvel_comics/features/comics_app/data/models/comics_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ComicsRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(
    () {
      mockHttpClient = MockHttpClient();
      dataSource = ComicsRemoteDataSourceImpl(client: mockHttpClient);
    },
  );

  group("getComics", () {
    const tTitle = "Deadpool";
    final tComicsModel =
        ComicsModel.fromJson(json.decode(fixture("marvel.json")));
    final Map<String, String> comicQuery = {
      "ts": "1",
      "apikey": "080a502746c8a60aeab043387a56eef0",
      "hash": "6edc18ab1a954d230c1f03c590d469d2",
      "limit": "50",
      "offset": "0",
      "orderBy": "onsaleDate",
    };
    test(
        "should perform GET request on URL with comics title and constant queries set",
        () {
      //arrange
      when(mockHttpClient.get(Uri(), headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response(fixture("marvel.json"), 200));
      //act
      dataSource.getComics(tTitle);
      //assert
      verify(mockHttpClient.get(
          Uri.https("gateway.marvel.com", "/v1/public/comics", comicQuery)));
    });
    test("should return Comics when response code is 200(success)", () async {
      //arrange
      when(mockHttpClient.get(Uri(), headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response(fixture("marvel.json"), 200));
      //act
      final result = dataSource.getComics(tTitle);
      //assert
      expect(result, tComicsModel);
    });

    test("should throw ServerException when response code is 404 or other",
        () async {
      //assert
      when(mockHttpClient.get(Uri(), headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("Something went wrong"), 404));
      //act
      final call = dataSource.getComics;
      //assert
      expect(() => call(tTitle), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
