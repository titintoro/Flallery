import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:injectable/injectable.dart';


const _artworkLimit = 20;


@singleton
class ArtworkRepository {

  final httpClient = http.Client();

  Future<List<Artwork>> fetchArtworks([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/artworks',
        <String, String>{'_start': '$startIndex', '_limit': '$_artworkLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;

      return List<Artwork>.from(
        //list.map((p) => Artwork.fromJson(p))
        body.map((p) => Artwork.fromJson(p))
      );
      
    }
    throw Exception('error fetching artworks');
  }



}