import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl extends UserService {
  //instancia a userRepository
  UserRepository _userRepository;

  // construtor pra associar a instancia
  UserServiceImpl({required UserRepository}) : _userRepository = UserRepository;

  // impl do service
  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);
}
