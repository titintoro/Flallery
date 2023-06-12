import 'package:flallery_frontend/blocs/artwork_list/artwork_list_bloc.dart';
import 'package:flallery_frontend/blocs/artwork_user/artwork_user_list_bloc.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/models/artwork_list_response.dart';
import 'package:flallery_frontend/services/artwork_service.dart';
import 'package:flallery_frontend/widget/artwork_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/artwork_details_page.dart';
import '../rest/rest_client.dart';

class ArtworkUserListPage extends StatefulWidget {
  const ArtworkUserListPage({super.key});

  @override
  State<ArtworkUserListPage> createState() => _ArtworkUserListPageState();
}

class _ArtworkUserListPageState extends State<ArtworkUserListPage> {
  @override
  Widget build(BuildContext context) {
    ArtworkService _artworkService = getIt<ArtworkService>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tus Artworks'),
          backgroundColor: Colors.blueGrey,
        ),
        body: BlocProvider(
          create: (context) =>
              ArtworkUserListBloc(_artworkService)..add(ArtworkUserFetched()),
          child: ArtworkUserListSF(),
        ));
  }
}

class ArtworkUserListSF extends StatefulWidget {
  const ArtworkUserListSF({super.key});

  @override
  State<ArtworkUserListSF> createState() => _ArtworkUserListSFState();
}

class _ArtworkUserListSFState extends State<ArtworkUserListSF> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtworkUserListBloc, ArtworkUserListState>(
      builder: (context, state) {
        if (state is ArtworkUserListSuccess) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Number of items per row
            ),
            itemBuilder: (context, index) {
              return ArtworkUserList(
                artwork: state.artworkList[index],
                superContext: context,
              );
            },
            itemCount: state.artworkList.length,
          );
        } else if (state is ArtworkUserListFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ArtworkUserList extends StatefulWidget {
  final BuildContext superContext;
  final Artwork artwork;

  const ArtworkUserList(
      {super.key, required this.artwork, required this.superContext});

  @override
  State<ArtworkUserList> createState() => _ArtworkUserListState();
}

class _ArtworkUserListState extends State<ArtworkUserList> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtworkDetailsPage(artwork: widget.artwork),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: GridTile(
            child: Image.network(
              "${ApiConstants.baseUrl}/download/${widget.artwork.imgUrl}",
              fit: BoxFit.fitHeight,
            ),
            footer: GridTileBar(
              backgroundColor: Color.fromARGB(220, 80, 79, 79),
              title: Text(
                widget.artwork.name!,
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.artwork.owner!,
                    style: TextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "¿Quieres eliminar ${widget.artwork.name} permanentemente?"),
                            content: Text("Recuerda que no podrás recuperarlo"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancelar"),
                              ),
                              TextButton(
                                  onPressed: () {
                                    widget.superContext
                                        .read<ArtworkUserListBloc>()
                                        .add(
                                          ArtworkUserDeleted(
                                              id: widget.artwork.uuid!),
                                        );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Borrar"))
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
