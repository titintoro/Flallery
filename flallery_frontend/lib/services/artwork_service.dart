import 'package:file_picker/file_picker.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/models/artwork_category_Response.dart';
import 'package:flallery_frontend/models/artwork_create_request.dart';
import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/models/comment_create_request.dart';
import 'package:flallery_frontend/models/comment_response.dart';
import 'package:flallery_frontend/repositories/artwork_repository.dart';
import 'package:flallery_frontend/services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@Order(2)
@singleton
class ArtworkService {
  late ArtworkRepository _artworkRepository;
  late LocalStorageService _localStorageService;

  ArtworkService() {
    _artworkRepository = getIt<ArtworkRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  Future<ArtworkResponse> getAllArtworks(page) async {
    String? token = _localStorageService.getFromDisk("user_token");
    ArtworkResponse artworks = await _artworkRepository.fetchArtwork(page);
    return artworks;
  }

  Future<List<Artwork>> getUserArtworks() async {
    String? token = _localStorageService.getFromDisk("user_token");
    List<Artwork> artworks = await _artworkRepository.fetchUserArtworks();
    return artworks;
  }

  Future<void> deleteArtwork(String id) async {
    String? token = _localStorageService.getFromDisk("user_token");

    if (token != null) {
      return _artworkRepository.deleteArtwork(id);
    }
    throw Exception("");
  }

  Future<Artwork> createArtwork(
      ArtworkCreateRequest artwork, PlatformFile file) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      return _artworkRepository.createArtwork(artwork, file, token);
    } throw Exception("");
  }

  Future<CommentResponse> createComment(
      CommentCreateRequest comment, String idArtwork) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      return _artworkRepository.createComment(comment, idArtwork);
    } throw Exception("");
  }

  Future<List<ArtworkCategoryNameResponse>> getCategoryNames() async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      List<ArtworkCategoryNameResponse> artworkCategories =
          await _artworkRepository.fetchCategories();
      return artworkCategories;
    }
    throw Exception("");
  }
}
