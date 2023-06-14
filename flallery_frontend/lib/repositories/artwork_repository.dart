import 'package:file_picker/file_picker.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/models/artwork_category_Response.dart';
import 'package:flallery_frontend/models/artwork_create_request.dart';
import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/models/comment_create_request.dart';
import 'package:flallery_frontend/models/comment_response.dart';
import 'package:flallery_frontend/rest/rest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:injectable/injectable.dart';

const _artworkLimit = 20;

@Order(-1)
@singleton
class ArtworkRepository {
  late RestAuthenticatedClient _client;

  ArtworkRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<ArtworkResponse> fetchArtwork(int index) async {
    String url = "/artwork?page=$index";

    var jsonResponse = await _client.get(url);
    return ArtworkResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<List<Artwork>> fetchUserArtworks() async {
    String url = "/user/artwork";

    var jsonResponse = await _client.get(url);
    var list = (jsonDecode(jsonResponse) as List)
        .map((e) => Artwork.fromJson(e))
        .toList();
    return list;
  }

  Future<Artwork> createArtwork(
      ArtworkCreateRequest artwork, PlatformFile file, String token) async {
    String url = "/artwork";

    var jsonResponse = await _client.postMultipart(url, artwork, file, token);
    return Artwork.fromJson(jsonDecode(jsonResponse));
  }


    Future<CommentResponse> createComment(
      CommentCreateRequest comment, String idArtwork) async {
    String url = "/artwork/${idArtwork}/comment";

    var jsonResponse = await _client.post(url, comment);
    return CommentResponse.fromJson(jsonDecode(jsonResponse));
  }


  Future<void> deleteArtwork(String id) async {
    String url = "/artwork/${id}";

    await _client.delete(url);
  }

  Future<List<ArtworkCategoryNameResponse>> fetchCategories() async {
    String url = "/categoryNames/";

    var jsonResponse = await _client.get(url);
    var list = (jsonDecode(jsonResponse) as List)
        .map((e) => ArtworkCategoryNameResponse.fromJson(e))
        .toList();
    return list;
  }
}
