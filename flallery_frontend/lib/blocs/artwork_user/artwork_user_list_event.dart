part of 'artwork_user_list_bloc.dart';

abstract class ArtworkUserListEvent extends Equatable {
  const ArtworkUserListEvent();

  @override
  List<Object> get props => [];
}

class ArtworkUserFetched extends ArtworkUserListEvent {}

class ArtworkUserDeleted extends ArtworkUserListEvent {
  final String id;

  ArtworkUserDeleted({required this.id});

  @override
  List<Object> get props => [id];
}
