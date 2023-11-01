import 'dart:convert';
import 'package:marvel_comics/core/error/exceptions.dart';
import 'package:marvel_comics/features/comics_app/data/datasources/comics_local_data_source.dart';
import 'package:marvel_comics/features/comics_app/data/models/comics_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ComicsLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        ComicsLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getLastComics", () {
    final tComicsModel =
        ComicsModel.fromJson(json.decode(fixture("marvel.json")));
    test(
        "should return Comics from SharedPreferences when there is one in the cache",
        () async {
      //arrange
      when(mockSharedPreferences.getString("Deadpool"))
          .thenReturn(fixture("marvel.json"));
      //act
      final result = await dataSource.getLastComics();
      //assert
      verify(mockSharedPreferences.getString("CACHED_COMICS"));
      expect(result, equals(tComicsModel));
    });
    test("should throw a CacheException when there is no Cache value",
        () async {
      //arrange
      when(mockSharedPreferences.getString("Deadpool")).thenReturn(null);
      //act
      final call = dataSource.getLastComics;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheComics", () {
    final tComicsModel = ComicsModel.fromJson(
        json.decode(fixture("marvel.json"))); //idk how to do it
    test("should call Shared Preferences to cache the data", () async {
      //act
      dataSource.cacheComics(tComicsModel);
      //assert
      final expectedJsonString = json.encode(tComicsModel.toJson());
      verify(
          mockSharedPreferences.setString("CACHED_COMICS", expectedJsonString));
    });
  });
}
