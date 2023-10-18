import 'package:flutter/material.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _error;
  bool _success = false;

  bool get loading => _loading;
  bool get isSuccess => _success;
  String? get error => _error;
  bool get hasError => _error != null;

  void showLoading() => _loading = true;

  void success() => _success = true;

  void hideLoading() => _loading = false;

  void setError(String? error) => _error = error;

  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _success = false;
  }
}
