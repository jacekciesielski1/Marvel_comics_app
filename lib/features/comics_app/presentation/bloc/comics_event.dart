part of 'comics_bloc.dart';

abstract class ComicsEvent extends Equatable {
  const ComicsEvent();
}

//event fo when user search for comics
class GetConcreteComics extends ComicsEvent {
  final String title;

  const GetConcreteComics({required this.title});

  @override
  List<Object?> get props => [title];
}
