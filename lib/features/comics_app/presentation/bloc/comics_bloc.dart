import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '/core/error/failures.dart';
import '../../domain/entities/comics.dart';
import '../../domain/usecases/get_comics.dart';
part 'comics_event.dart';
part 'comics_state.dart';

Map<Failure, String> failuresMap = {
  ServerFailure(): "Server Failure",
  NoSearchResults(): "No search results",
  ConnectionFailure(): "Check your internet connection",
  CacheFailure(): "Cache Failure"
};

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  final GetComics getComics;

  ComicsBloc(this.getComics) : super(Empty()) {
    on<GetConcreteComics>(_getConcreteComicsHandler);
  }

  Future<void> _getConcreteComicsHandler(
      GetConcreteComics event, Emitter<ComicsState> emit) async {
    emit(Loading());
    final comicsEither = await getComics.call(Params(title: event.title));
    comicsEither?.fold((failure) {
      emit(Error(message: failuresMap[failure] ?? "error"));
    }, (comics) {
      emit(Loaded(comics: comics!));
    });
  }
}
