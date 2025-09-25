import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/images/models/image_model.dart';
import 'package:flutter_assessment/features/images/services/images_data_service.dart';

class GallerySearchProvider extends ChangeNotifier {
  final _service = RetrieveImagesDataService();
  Timer? _debounceTimer;

  // State variables
  List<ImagesModel> _images = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  int _currentPage = 1;
  int _totalImages = 0;
  bool _hasNextPage = false;
  String _query = "";

  // Getters
  List<ImagesModel> get images => List.unmodifiable(_images);
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  int get totalImages => _totalImages;
  bool get hasNextPage => _hasNextPage;
  String get query => _query;
  bool get hasQuery => _query.trim().isNotEmpty;
  bool get isEmpty => _images.isEmpty && !_isLoading && !_hasError;

  void updateQuery(String newQuery) {
    _query = newQuery.trim();
    _debounceTimer?.cancel();
    if (_query.isEmpty) {
      _clearResults();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_query.isNotEmpty) {
        fetchImages();
      }
    });

    notifyListeners();
  }

  void _clearResults() {
    _images.clear();
    _currentPage = 1;
    _totalImages = 0;
    _hasNextPage = false;
    _clearError();
    notifyListeners();
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _query = "";
    _clearResults();
  }

  Future<void> fetchImages() async {
    if (_isLoading) return;

    _setLoading(true);

    final result = await _service.fetchImages(page: 1, query: _query);

    if (result.isSuccess && result.data != null) {
      _images = result.data!.hits;
      _currentPage = 1;
      _totalImages = result.data!.totalHits;
      _hasNextPage = _images.length < _totalImages;
      _clearError();
    } else {
      _setError(result.error ?? 'Unknown error occurred');
    }

    _setLoading(false);
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasNextPage) return;

    _setLoading(true);

    final result = await _service.fetchImages(
      page: _currentPage + 1,
      query: _query,
    );

    if (result.isSuccess && result.data != null) {
      _images.addAll(result.data!.hits);
      _currentPage++;
      _hasNextPage = _images.length < _totalImages;
      _clearError();
    } else {
      _setError(result.error ?? 'Unknown error occurred');
    }

    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _hasError = true;
    _errorMessage = error;
  }

  void _clearError() {
    _hasError = false;
    _errorMessage = null;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
