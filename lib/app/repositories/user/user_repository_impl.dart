import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/exception/auth_exceptions.dart';

import './user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'email-already-exists') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthExceptions(
            message: 'Email ja utilizado favor escolher outro',
          );
        } else {
          throw AuthExceptions(
            message: 'Voce se cadastrou com o google',
          );
        }
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredencial.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthExceptions(
        message: e.message ?? 'Erro ao realizar o login',
      );
    } on FirebaseAuthException catch (e, s) {
      print(e);

      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthExceptions(
          message: 'email ou senha invalidas',
        );
      }
      print(s);
      throw AuthExceptions(
        message: e.message ?? 'Erro ao realizar o login',
      );
    }
  }
}
