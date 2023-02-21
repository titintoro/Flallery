import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flallery_frontend/repositories/artwork_repository.dart';
import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:get_it/get_it.dart';
//import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';



part 'artwork_list_event.dart';
part 'artwork_list_state.dart';

//const _artworkLimit = 20;
const throttleDuration = Duration(milliseconds: 100);


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  ArtworkBloc(/*{required this.httpClient}*/) : super(const ArtworkState()) {
  //ArtworkBloc({required this.repo}) : super(const ArtworkState()) {
    repo = GetIt.I.get<ArtworkRepository>();
    on<ArtworkFetched>(
      _onArtworkFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  
  late ArtworkRepository repo;


  Future<void> _onArtworkFetched(
    ArtworkFetched event,
    Emitter<ArtworkState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ArtworkStatus.initial) {
        //final artworks = await _fetchArtworks();
        final artworks = await repo.fetchArtworks();
        return emit(
          state.copyWith(
            status: ArtworkStatus.success,
            artworkList: artworks,
            hasReachedMax: false,
          ),
        );
      }
      //final artworks = await _fetchArtworks(state.artworks.length);
      final artworks = await repo.fetchArtworks(state.artworkList.length);
      artworks.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ArtworkStatus.success,
                artworkList: List.of(state.artworkList)..addAll(artworks),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ArtworkStatus.failure));
    }
  }
  
}