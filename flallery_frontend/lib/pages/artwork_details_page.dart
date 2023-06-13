import 'dart:convert';

import 'package:flallery_frontend/blocs/comment_create/comment_create_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/rest/rest.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'artwork_create_page.dart';

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

  void _openCommentModal(String id) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => CommentCreateBloc(id),
          child: Builder(
            builder: (context) {
              final commentCreateBloc = context.read<CommentCreateBloc>();
              return Theme(
                data: Theme.of(context).copyWith(
                    inputDecorationTheme: InputDecorationTheme(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: FormBlocListener<CommentCreateBloc, String, String>(
                      onSubmitting: (context, state) =>
                          CreateArtworkDialog.show(context),
                      onSubmissionFailed: (context, state) =>
                          CreateArtworkDialog.hide(context),
                      onSuccess: (context, state) {
                        CreateArtworkDialog.hide(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                      onFailure: (context, state) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ha habido un fallo'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        CreateArtworkDialog.hide(context);
                      },
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add a Comment',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextFieldBlocBuilder(
                                textFieldBloc: commentCreateBloc.comment),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                commentCreateBloc.submit();
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.network(
                        "${ApiConstants.baseUrl}/download/${widget.artwork.imgUrl}")),
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
                      onPressed: () {
                        _openCommentModal(widget.artwork.uuid!);
                      },
                      tooltip: 'Comment',
                      child: Icon(Icons.comment_rounded),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Likes: $_likeCount',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Comments: ',
                  style: textTheme.titleMedium,
                ),
                Center(
                  child: SizedBox(
                    height: 200.0,
                    child: CommentPage(widget.artwork, textTheme),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CommentPage extends StatelessWidget {
  final Artwork artwork;
  final TextTheme textTheme;
  CommentPage(this.artwork, this.textTheme);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artwork.comments!.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          '${artwork.comments?[index].writer}: ${artwork.comments?[index].text}' ??
              'No comments',
          style: textTheme.bodySmall,
        );
      },
    );
  }
}
