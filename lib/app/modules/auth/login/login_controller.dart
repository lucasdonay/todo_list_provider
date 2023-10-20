// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/exception/auth_exceptions.dart';

import 'package:todo_list_provider/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuario ou senha Invalidas');
      }
    } on AuthExceptions catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      await _userService.forgotPassword(email);
      infoMessage = null;
      notifyListeners();
      infoMessage = 'Reset de senha enviado para o seu email';
    } on AuthExceptions catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao resetar a senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
