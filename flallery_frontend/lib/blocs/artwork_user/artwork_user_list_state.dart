part of 'artwork_user_list_bloc.dart';

abstract class ArtworkUserListState extends Equatable {
  const ArtworkUserListState();

  @override
  List<Object> get props => [];
}

class ArtworkUserListInitial extends ArtworkUserListState {}

class ArtworkUserListSuccess extends ArtworkUserListState {
  final List<Artwork> artworkList;

  const ArtworkUserListSuccess({required this.artworkList});

  @override
  List<Object> get props => [artworkList];
}


class ArtworkUserListFailure extends ArtworkUserListState {
  final String errorMessage;

  const ArtworkUserListFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ArtworkUserListDelete extends ArtworkUserListState{
  
}