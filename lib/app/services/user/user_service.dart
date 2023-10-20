import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  @override
  Future<User?> register(String email, String password);
  Future<User?> login(String email, String password);
  Future<User?> forgotPassword(String email);
}
