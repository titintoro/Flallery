import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/models/artwork_list_response.dart';
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
}
