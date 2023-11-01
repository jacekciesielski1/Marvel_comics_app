import 'dart:convert';
import '/core/error/exceptions.dart';
import '/features/comics_app/data/models/comics_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//i wrote local data source just for educational purposes
//i don't see a purpose for implementing it for now but i wanted to keep it in the project

/// Gets the cached [ComicsModel] which was gotten the last time
/// the user had an internet connection.
///
/// Throws [CacheException] if no cached data is present.
abstract class ComicsLocalDataSource {
  Future<ComicsModel> getLastComics();
  Future<void> cacheComics(ComicsModel comicsToCache);
}

const cachedComics = "CACHED_COMICS";

class ComicsLocalDataSourceImpl implements ComicsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ComicsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ComicsModel> getLastComics() {
    final jsonString = sharedPreferences.getString(cachedComics);
    if (jsonString != null) {
      return Future.value(ComicsModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheComics(ComicsModel comicsToCache) {
    return sharedPreferences.setString(
        cachedComics, json.encode(comicsToCache.toJson()));
  }
}
