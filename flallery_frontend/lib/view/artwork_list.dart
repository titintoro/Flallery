import 'package:flallery_frontend/blocs/artwork_list/artwork_list_bloc.dart';
import 'package:flallery_frontend/widget/artwork_list_item.dart';
import 'package:flallery_frontend/widget/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtworksList extends StatefulWidget {
  const ArtworksList({Key? key}) : super(key: key);

  @override
  State<ArtworksList> createState() => _ArtworksListState();
}

class _ArtworksListState extends State<ArtworksList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtworkBloc, ArtworkState>(
      builder: (context, state) {
        switch (state.status) {
          case ArtworkStatus.failure:
            return const Center(child: Text('Failed to fetch artworks'));
          case ArtworkStatus.success:
            if (state.artworkList.isEmpty) {
              return const Center(child: Text('No artworks'));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of items per row
              ),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.artworkList.length
                    ? const BottomLoader()
                    : ArtworkListItem(artwork: state.artworkList[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.artworkList.length
                  : state.artworkList.length + 1,
              controller: _scrollController,
            );
          case ArtworkStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ArtworkBloc>().add(ArtworkFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}