import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/profile/models/user_model.dart';
import 'package:flutter_assessment/features/profile/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final _service = UserService();

  bool _isLoading = false;
  bool _hasError = false;
  int? _id;
  String? _errorMessage;
  bool _isPasswordMatch = true;
  final _formKey = GlobalKey<FormState>();

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  int? get id => _id;
  bool get isPasswordMatch => _isPasswordMatch;
  GlobalKey<FormState> get formKey => _formKey;

  void checkPasswordMatch({String? password, String? confirmPassword}) {
    if (password != confirmPassword) {
      _isPasswordMatch = false;
      notifyListeners();
    } else {
      _isPasswordMatch = true;
      notifyListeners();
    }
  }

  bool validateForm() {
    return _formKey.currentState!.validate();
  }

  Future<void> submitUserData({required UserModel data}) async {
    if (_isLoading || !_isPasswordMatch) return;
    _setLoading(true);

    final result = await _service.submitUserData(body: data);

    if (result.isSuccess && result.data != null) {
      _id = result.data;
      _clearError();
    } else {
      _setError(result.error ?? "Unknown error occurred");
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
