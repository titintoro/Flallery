import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flutter/material.dart';

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
}

