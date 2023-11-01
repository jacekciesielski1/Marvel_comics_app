import 'package:dartz/dartz.dart';
import 'package:marvel_comics/features/comics_app/data/models/comics_model.dart';
import 'package:marvel_comics/features/comics_app/domain/entities/comics.dart';
import 'package:marvel_comics/features/comics_app/domain/repositories/comics_repository.dart';
import 'package:marvel_comics/features/comics_app/domain/usecases/get_comics.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockComicsRepository extends Mock implements ComicsRepository {}

void main() {
  GetComics? usecase;
  MockComicsRepository? mockComicsRepository;

  setUp(() {
    mockComicsRepository = MockComicsRepository();
    usecase = GetComics(mockComicsRepository!);
  });

  const tTitle = "Deadpool";
  final tComics = ComicsModel(
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
    "should get comics for title from the repository",
    () async {
      //arrange
      when(mockComicsRepository?.getComics("test"))
          .thenAnswer((_) async => Right(tComics));
// act
      final result = await usecase!(const Params(title: tTitle));
//assert
      expect(result, Right(tComics));
      verify(mockComicsRepository!.getComics(tTitle));
      verifyNoMoreInteractions(mockComicsRepository);
    },
  );
}
