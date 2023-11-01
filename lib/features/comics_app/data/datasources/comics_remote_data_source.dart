import 'dart:convert';
import '/core/error/exceptions.dart';
import '/features/comics_app/data/models/comics_model.dart';
import 'package:http/http.dart' as http;

abstract class ComicsRemoteDataSource {
  /// Calls the marvel api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ComicsModel> getComics(String title);
}

//map of queries used in api call
Map<String, String> getComicQueryMap(String title) {
  return <String, String>{
    "titleStartsWith": title,
    "ts": "1",
    "apikey": "080a502746c8a60aeab043387a56eef0",
    "hash": "6edc18ab1a954d230c1f03c590d469d2",
    "limit": "50",
    "offset": "0",
    "orderBy": "onsaleDate",
  };
}

class ComicsRemoteDataSourceImpl implements ComicsRemoteDataSource {
  final http.Client client;

  ComicsRemoteDataSourceImpl({required this.client});

  @override
  Future<ComicsModel> getComics(String title) async {
    final response = await client.get(Uri.https(
        "gateway.marvel.com", "/v1/public/comics", getComicQueryMap(title)));
    if (response.statusCode == 200) {
      return ComicsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
