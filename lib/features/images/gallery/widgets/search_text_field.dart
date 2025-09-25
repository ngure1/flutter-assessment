import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/components/form_input_field.dart';
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
        return FormInputField(
          controller: _controller,
          prefixIcon: Icon(Icons.search),
          hintText: 'Start typing to find the latest images',
          onChanged: (query) {
            searchProvider.updateQuery(query);
          },
        );
      },
    );
  }
}
