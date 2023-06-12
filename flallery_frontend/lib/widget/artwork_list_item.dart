import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/pages/artwork_details_page.dart';
import 'package:flutter/material.dart';

import '../rest/rest_client.dart';
/*
class ArtworkListItem extends StatelessWidget {
  const ArtworkListItem({super.key, required this.artwork});

  final Artwork artwork;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${artwork.name}', style: textTheme.bodySmall),
        title: Text(artwork.description!),
        isThreeLine: true,
        subtitle: Text(artwork.owner!),
        dense: true,
      ),
    );
  }
}*/

class ArtworkListItem extends StatelessWidget {
  const ArtworkListItem({Key? key, required this.artwork}) : super(key: key);

  final Artwork artwork;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtworkDetailsPage(artwork: artwork),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: GridTile(
            child: Image.network(
              "${ApiConstants.baseUrl}/download/${artwork.imgUrl}",
              fit: BoxFit.fitHeight,
            ),
            footer: GridTileBar(
              backgroundColor: Color.fromARGB(220, 80, 79, 79),
              title: Text(
                artwork.name!,
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                artwork.owner!,
                style: TextStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}