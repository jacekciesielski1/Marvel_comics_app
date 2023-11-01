import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_comics/features/comics_app/data/models/comics_model.dart';
import 'package:marvel_comics/features/comics_app/domain/entities/comics.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
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

  test(
    "should be a subclass of Comics entity",
    () async {
      expect(tComicsModel, isA<Comics>());
    },
  );

  group(
    "fromJson",
    () {
      test(
        "should return a valid model when JSON comics issue number is an integer",
        //arrange
        () async {
          final Map<String, dynamic> jsonMap =
              json.decode(fixture("marvel.json"));
          //act
          final result = ComicsModel.fromJson(jsonMap);
          //assert
          expect(result, tComicsModel);
        },
      );

      test(
        "should return a valid model when JSON comics issue number is an double",
        //arrange
        () async {
          final Map<String, dynamic> jsonMap =
              json.decode(fixture("marvel_double.json"));
          //act
          final result = ComicsModel.fromJson(jsonMap);
          //assert
          expect(result, equals(tComicsModel));
        },
      );
    },
  );
}
