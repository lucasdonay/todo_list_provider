import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/exception/auth_exceptions.dart';

import './user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;

    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      print('GOOGLE USER : ${googleUser}');

      if (googleUser != null) {
        final loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        print('LOGIN METHODS: ${loginMethods}');
        if (loginMethods.contains('email')) {
          throw AuthExceptions(
              message:
                  'Você já utilizou o e-mail para o cadastro, caso tenha esquecido sua senha por favor clique em esqueceu sua senha ');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseProvider = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          var userCredential =
              await _firebaseAuth.signInWithCredential(firebaseProvider);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'sign_in_failed') {
        throw AuthExceptions(message: 'Login falhou');
      }

      if (e.code == 'account-exists-with-different-credential') {
        throw AuthExceptions(
          message: '''
        Login inválido você se registrou no Todolist com os seguintes provedores: ${loginMethods?.join(',')}
        ''',
        );
      }
    }
  }

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

  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthExceptions(
            message:
                "Cadastro realizado com o Goolge, não pode ser resetado a senha");
      } else {
        throw AuthExceptions(message: "E-mail não cadastrado");
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthExceptions(message: "Erro ao resetar senha");
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
