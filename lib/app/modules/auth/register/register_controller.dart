import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/exception/auth_exceptions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  var error = null;
  var success = false;

  Future<void> registerUser(String email, String password) async {
    try {
      notifyListeners();
      final user = await _userService.register(email, password);

      if (user != null) {
        //sucesso

        success = true;
      } else {
        // error
        success = false;
        error = 'Erro ao registrar o usuario';
      }
    } on AuthExceptions catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
