import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flutter/material.dart';

class ArtworkDetailsPage extends StatelessWidget {
  final Artwork artwork;

  const ArtworkDetailsPage({required this.artwork});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Artwork Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artwork.name!,
              style: textTheme.titleLarge,
            ),
            SizedBox(height: 16.0),
            Text(
              artwork.description ?? 'No description available',
              style: textTheme.bodyLarge,
            ),
            SizedBox(height: 16.0),
            Text(
              'Owner: ${artwork.owner}',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: ${artwork.description}',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 16.0),
            Text(
              'Comments: ${artwork.comments}',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}