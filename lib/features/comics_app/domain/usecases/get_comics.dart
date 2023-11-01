import 'package:equatable/equatable.dart';
import '/core/usecases/usecase.dart';
import '/features/comics_app/domain/entities/comics.dart';
import '/features/comics_app/domain/repositories/comics_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class GetComics implements UseCase<Comics, Params> {
  final ComicsRepository repository;

  GetComics(this.repository);

  @override
  Future<Either<Failure?, Comics?>?> call(Params params) async {
    return await repository.getComics(params.title);
  }
}

class Params extends Equatable {
  final String title;

  const Params({required this.title});

  @override
  List<Object?> get props => [title];
}
