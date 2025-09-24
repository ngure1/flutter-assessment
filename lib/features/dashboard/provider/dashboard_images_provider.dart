import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/dashboard/models/dashboard_model.dart';
import 'package:flutter_assessment/features/dashboard/services/dashboard_images_data_service.dart';

class DashboardImagesProvider extends ChangeNotifier {
  final _service = DashboardImagesDataService();
  // State variables
  List<DashboardImagesModel> _images = [];
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  int _currentPage = 1;
  int _totalImages = 0;
  bool _hasNextPage = false;

  // Getters
  List<DashboardImagesModel> get images => List.unmodifiable(_images);
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  int get totalImages => _totalImages;
  bool get hasNextPage => _hasNextPage;

  Future<void> fetchImages() async {
    if (_isLoading) return;

    _setLoading(true);

    final result = await _service.fetchImages(page: 1);

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

    final result = await _service.fetchImages(page: _currentPage + 1);

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
}
