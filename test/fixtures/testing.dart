import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marvel_comics/features/comics_app/data/datasources/comics_remote_data_source.dart';
import 'package:marvel_comics/features/comics_app/data/models/comics_model.dart';

import 'fixture_reader.dart';

void main() async {
  final Map<String, dynamic> jsonMap =
      json.decode(fixture("marvel_double.json"));
  //act
  final result = ComicsModel.fromJson(jsonMap);

  print(result.data.results[0].issueNumber);

  final response =
      await ComicsRemoteDataSourceImpl(client: http.Client()).getComics("Hulk");
  print(response.data.results[0].title);
}
