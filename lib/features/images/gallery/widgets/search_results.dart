import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/constants/constants.dart';
import 'package:flutter_assessment/features/images/widgets/image_card.dart';
import 'package:flutter_assessment/features/images/gallery/provider/gallery_search_provider.dart';
import 'package:provider/provider.dart';

class GallerySearchResultsList extends StatefulWidget {
  const GallerySearchResultsList({super.key});

  @override
  State<GallerySearchResultsList> createState() =>
      _GallerySearchResultsListState();
}

class _GallerySearchResultsListState extends State<GallerySearchResultsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = Provider.of<GallerySearchProvider>(context, listen: false);

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        provider.hasNextPage &&
        !provider.isLoading) {
      provider.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Consumer<GallerySearchProvider>(
        builder: (context, state, _) {
          if (state.isLoading && state.images.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.hasError && state.images.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.errorMessage}'),
                  ElevatedButton(
                    onPressed: () => state.fetchImages(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state.images.isEmpty && !state.hasQuery) {
            return Text(
              "Start searching to find images",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blueGrey,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width >= ScreenSize.desktop
                        ? 4
                        : width >= ScreenSize.tablet
                        ? 2
                        : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount:
                      state.images.length +
                      (state.isLoading && state.images.isNotEmpty ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.images.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ImageCard(dashboardImageData: state.images[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
