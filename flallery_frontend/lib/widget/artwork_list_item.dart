import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/pages/artwork_details_page.dart';
import 'package:flutter/material.dart';
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
        child: GridTile(
          child: Image.network(
            "http://localhost:8080/download/${artwork.imgUrl}",
            fit: BoxFit.contain,
          ),
          footer: GridTileBar(
            backgroundColor: Color.fromARGB(115, 110, 109, 109),
            title: Text(
              artwork.name!,
              style: textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              artwork.owner!,
              style: textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}