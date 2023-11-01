part of 'comics_bloc.dart';

@immutable
abstract class ComicsState extends Equatable {
  const ComicsState();
}

// initial state
class Empty extends ComicsState {
  @override
  List<Object> get props => [];
}

class Loading extends ComicsState {
  @override
  List<Object> get props => [];
}

class Loaded extends ComicsState {
  final Comics comics;

  const Loaded({required this.comics});

  @override
  List<Object> get props => [comics];
}

class Error extends ComicsState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
