import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/exception/auth_exceptions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      var error = null;
      var sucess = false;
      notifyListeners();
      final user = await _userService.register(email, password);

      if (user != null) {
        //sucesso

        sucess = true;
      } else {
        // error
        sucess = false;
        error = 'Erro ao registrar o usuario';
      }
    } on AuthExceptions catch (e) {
      var error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
