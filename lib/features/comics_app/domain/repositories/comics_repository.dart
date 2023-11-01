import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/features/comics_app/domain/entities/comics.dart';

abstract class ComicsRepository {
  Future<Either<Failure?, Comics?>>? getComics(String title);
}
