import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/services/artwork_service.dart';
import 'package:meta/meta.dart';

part 'artwork_user_list_event.dart';
part 'artwork_user_list_state.dart';

class ArtworkUserListBloc
    extends Bloc<ArtworkUserListEvent, ArtworkUserListState> {
  final ArtworkService _artworkService;

  ArtworkUserListBloc(ArtworkService artworkService)
      : assert(artworkService != null),
        _artworkService = artworkService,
        super(ArtworkUserListInitial()) {
    on<ArtworkUserFetched>(
      _onArtworkUserFetched,
    );
    on<ArtworkUserDeleted>(
      _onArtworkUserDeleted,
    );
  }

  Future<void> _onArtworkUserFetched(
    ArtworkUserFetched event,
    Emitter<ArtworkUserListState> emit,
  ) async {
    try {
      List<Artwork> result = await _artworkService.getUserArtworks();
      emit(ArtworkUserListSuccess(artworkList: result));
    } catch (e) {
      emit(ArtworkUserListFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onArtworkUserDeleted(
    ArtworkUserDeleted event,
    Emitter<ArtworkUserListState> emit,
  ) async {
    try {
      await _artworkService.deleteArtwork(event.id);
      List<Artwork> result = await _artworkService.getUserArtworks();
      emit(ArtworkUserListSuccess(artworkList: result));
    } catch (e) {
      emit(ArtworkUserListFailure(errorMessage: e.toString()));
    }
  }
}
