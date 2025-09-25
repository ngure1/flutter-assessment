import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/images/gallery/provider/gallery_search_provider.dart';
import 'package:provider/provider.dart';

class GallerySearchTextField extends StatefulWidget {
  const GallerySearchTextField({super.key});

  @override
  State<GallerySearchTextField> createState() => _GallerySearchTextFieldState();
}

class _GallerySearchTextFieldState extends State<GallerySearchTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GallerySearchProvider>(
      builder: (context, searchProvider, _) {
        return TextField(
          controller: _controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1.5),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: 'Start typing to find the latest images',
            hintStyle: TextStyle(fontSize: 14),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (query) {
            searchProvider.updateQuery(query);
          },
        );
      },
    );
  }
}
