import 'package:flallery_frontend/blocs/artwork_list/artwork_list_bloc.dart';
import 'package:flallery_frontend/config/locator.dart';
import 'package:flallery_frontend/services/artwork_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtworkUserListPage extends StatefulWidget {
  const ArtworkUserListPage({super.key});

  @override
  State<ArtworkUserListPage> createState() => _ArtworkUserListPageState();
}

class _ArtworkUserListPageState extends State<ArtworkUserListPage> {
  @override
  Widget build(BuildContext context) {
    ArtworkService _artworkService = getIt<ArtworkService>();
    return BlocProvider(create: (context) => ArtworkBloc(_artworkService)..add(ArtworkUserFetched()),
    child: ArtworkUserListSF,
    );
  }
}
