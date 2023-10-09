import 'package:firebase_auth/firebase_auth.dart';
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
}
