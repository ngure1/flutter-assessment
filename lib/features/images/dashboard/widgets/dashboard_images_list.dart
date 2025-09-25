import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/constants/constants.dart';
import 'package:flutter_assessment/features/images/dashboard/provider/dashboard_images_provider.dart';
import 'package:flutter_assessment/features/images/widgets/image_card.dart';
import 'package:provider/provider.dart';

class DashboardImagesList extends StatefulWidget {
  const DashboardImagesList({super.key});

  @override
  State<DashboardImagesList> createState() => _DashboardImagesListState();
}

class _DashboardImagesListState extends State<DashboardImagesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var provider = Provider.of<DashboardImagesProvider>(
        context,
        listen: false,
      );
      if (provider.images.isEmpty) {
        provider.fetchImages();
      }
    });
  }

  void _onScroll() {
    final provider = Provider.of<DashboardImagesProvider>(
      context,
      listen: false,
    );

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

    return Consumer<DashboardImagesProvider>(
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

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width >= ScreenSize.desktop
                      ? 4
                      : width >= ScreenSize.tablet
                      ? 3
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
