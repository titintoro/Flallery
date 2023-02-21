import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flutter/material.dart';
/*
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
} */


class ArtworkDetailsPage extends StatefulWidget {
  final Artwork artwork;

  const ArtworkDetailsPage({required this.artwork});

  @override
  _ArtworkDetailsPageState createState() => _ArtworkDetailsPageState();
}

class _ArtworkDetailsPageState extends State<ArtworkDetailsPage> {
  int _likeCount = 0;

  void _likeArtwork() {
    setState(() {
      _likeCount++;
    });
  }

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
              widget.artwork.name!,
              style: textTheme.titleLarge,
            ),
            SizedBox(height: 16.0),
            Text(
              widget.artwork.description ?? 'No description available',
              style: textTheme.bodyLarge,
            ),
            SizedBox(height: 16.0),
            Text(
              'Owner: ${widget.artwork.owner}',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: ${widget.artwork.description}',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 16.0),
            Text(
              'Comments: ${widget.artwork.comments}',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: _likeArtwork,
                  tooltip: 'Like',
                  child: Icon(Icons.thumb_up),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  tooltip: 'Comment',
                  child: Icon(Icons.comment),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Likes: $_likeCount',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
